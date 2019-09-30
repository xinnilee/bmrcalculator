import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 
void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<DropdownMenuItem<String>> listDrop = [];
  List<DropdownMenuItem<String>> listDropBMR = [];
  List<String> drop = ["Female","Male"];
  List<String> dropBMR = ["Mifflin-St Jeor (default)","Harris-Benedict"];
  String selected;
  String selected2;
  final TextEditingController _agecontroller = TextEditingController();
  final TextEditingController _hcontroller = TextEditingController();
  final TextEditingController _wcontroller = TextEditingController();
  String gendercontroller;
  String bmrcontroller;
  int age = 0;
  double weight = 0.0 , height = 0.0 , result = 0.0;
  int bmr;

  void loadDataGender(){
    listDrop = [];
    listDrop = drop.map((val) => new DropdownMenuItem<String>(
      child: new Text(val), value: val,)).toList();
  }

  void loadDataBMR(){
    listDropBMR = [];
    listDropBMR = dropBMR.map((val) => new DropdownMenuItem<String>(
      child: new Text(val), value: val,)).toList();
  }



  @override
  Widget build(BuildContext context) {
    loadDataGender();
    loadDataBMR();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Metric BMR Calculator'),
        ),
        resizeToAvoidBottomPadding: false,
        body: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text('Gender:',
                    style: TextStyle(
                      fontSize: 20.0,
                      height: 2.0
                    ),
                  ),
                  
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                    child: new DropdownButton(
                    value: selected,
                    items: listDrop,
                    hint: new Text("Female",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueGrey
                      ),
                    ),
                    iconSize: 40.0,
                    elevation: 16,
                    onChanged: (gender){
                      selected = gender;
                      setState(() {
                        gendercontroller = gender;
                      });
                    },
                    ),
                ),
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text('BMR Equation:',
                    style: TextStyle(
                      fontSize: 20.0,
                      height: 2.0
                    ),
                  ),
                ),    
                Padding(
                  padding: EdgeInsets.all(5),
                  child: new DropdownButton(
                    value: selected2,
                    items: listDropBMR,
                    hint: new Text("Mifflin-St Jeor (default)",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueGrey
                      ),
                    ),
                    iconSize: 40.0,
                    elevation: 16,
                    onChanged: (bmrequation){
                      selected2 = bmrequation;
                      setState(() {
                        bmrcontroller = bmrequation;
                      });
                    },
                  ),
                ),
              ],
            ),
            
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                  style: new TextStyle(
                    fontSize: 20.0,
                    height: 1.5,
                    color: Colors.black
                  ),
                  decoration: InputDecoration(
                    labelText: "Enter Age",
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 3.0,
                        style: BorderStyle.solid
                      ),
                    ), 
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: _agecontroller,
                ),
              ),

              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                  style: new TextStyle(
                    fontSize: 20.0,
                    height: 1.5,
                    color: Colors.black
                  ),
                  decoration: InputDecoration(
                    labelText: "Enter Height(cm)",
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 3.0,
                        style: BorderStyle.solid
                      ),
                    ), 
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: _hcontroller,
                ),
              ),

              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                  style: new TextStyle(
                    fontSize: 20.0,
                    height: 1.5,
                    color: Colors.black
                  ),
                  decoration: InputDecoration(
                    labelText: "Enter Weight(cm)",
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 3.0,
                        style: BorderStyle.solid
                      ),
                    ), 
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: _wcontroller,
                ),
              ),

              ],
            ),

            Padding(
               padding: EdgeInsets.all(20),
                child: RaisedButton(
                  color: Colors.blue[100],
                    child: Text('Calculate BMR',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black
                      ),
                    ),
                    onPressed: _onPress,
                ),
            ),

            Text("Your BMR is: $bmr",
              style: TextStyle(
                fontSize: 25,
                color: Colors.blueGrey[300]
              )
            ),

          ],
        ), 
      ),
    );
  }
                                         
  void _onPress() {
    setState(() {
      age = int.parse(_agecontroller.text);
      height = double.parse(_hcontroller.text);
      weight = double.parse(_wcontroller.text);

      if(gendercontroller == "Male"){
        if(bmrcontroller == "Mifflin-St Jeor (default)"){
          result = (10*weight)+(6.25*height)-(5*age)+5;
        }
        else if(bmrcontroller == "Harris-Benedict"){
          result = 66.47+(13.75*weight)+(5.003*height)-(6.755*age);
        }
      }

      else if(gendercontroller == "Female"){
        if(bmrcontroller == "Mifflin-St Jeor (default)"){
          result = (10*weight)+(6.25*height)-(5*age)-161;
        }
        else if(bmrcontroller == "Harris-Benedict"){
          result = 655.1+(9.563*weight)+(1.85*height)-(4.676*age);
        }
      }

      bmr = (result).round();

    });
  }
}