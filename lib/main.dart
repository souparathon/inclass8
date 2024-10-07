import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
//import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<String> _items = ['ghost', 'pumpkin', 'bat', 'skull', 'candy'];
  String _correctItem = 'pumpkin';
  String _message = '';
  bool _gameOver = false;

  @override
  void initState() {
    super.initState();
    _playBackgroundMusic();
  }

  void _playBackgroundMusic() async {
    await _audioPlayer.play('assets/spooky_music.mp3', isLocal: true);
  }

  void _playSound(String soundFile) async {
    await _audioPlayer.play('assets/$soundFile', isLocal: true);
  }

  void _onItemTap(String item) {
    setState(() {
      if (item == _correctItem) {
        _message = 'You Found It!';
        _gameOver = true;
        _playSound('success.mp3');
      } else {
        _message = 'Boo! Try Again!';
        _playSound('jump_scare.mp3');
      }
    });
  }

  Widget _buildItem(String item) {
    return GestureDetector(
      onTap: () => _onItemTap(item),
      child: Image.asset(
        'assets/$item.png',
        width: 100,
        height: 100,
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Halloween Game')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _message,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange),
            ),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: _items.map((item) => _buildItem(item)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
