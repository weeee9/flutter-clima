import 'dart:math';

import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = "{you_api_key}";
const openWeatherMapHost = "api.openweathermap.org";
const openWeatherMapURL = "/data/2.5/weather";

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var uri = Uri.https(
      openWeatherMapHost,
      openWeatherMapURL,
      {
        "q": cityName,
        "appid": apiKey,
        "units": "metric",
      },
    );

    NetworkHelper networkHelper = NetworkHelper(uri);

    return networkHelper.getData();
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();

    await location.getCurrentLocation();

    var uri = Uri.https(
      openWeatherMapHost,
      openWeatherMapURL,
      {
        // Hsinchu, Taiwan
        // lat=24.80395&lon=120.9647&appid=3d12e3d797c78de6ebc899b922237dcd&units=metric
        "lat": location.latitude.toString(),
        "lon": location.longtitude.toString(),
        "appid": apiKey,
        "units": "metric",
      },
    );

    NetworkHelper networkHelper = NetworkHelper(uri);

    return networkHelper.getData();
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
