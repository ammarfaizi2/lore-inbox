Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbSKNTGj>; Thu, 14 Nov 2002 14:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262363AbSKNTGj>; Thu, 14 Nov 2002 14:06:39 -0500
Received: from paloma12.e0k.nbg-hannover.de ([62.181.130.12]:56303 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S261742AbSKNTGf> convert rfc822-to-8bit; Thu, 14 Nov 2002 14:06:35 -0500
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Subject: Re: sensors.conf for winbond/amd system
Date: Thu, 14 Nov 2002 20:13:28 +0100
User-Agent: KMail/1.4.7
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       lm78@stimpy.netroedge.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200211142013.28537.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here comes mine:

dual Athlon MP 1900+
MSI MS-6501 (aka K7D Master-L), AMD 768MPX
1 GB DDR 266, CL2, (2x 512 MB)

Linux 2.5.47-mm1

/home/nuetzel> sensors
w83627hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.71 V  (min =  +1.61 V, max =  +1.77 V)
VCore 2:   +2.49 V  (min =  +2.36 V, max =  +2.62 V)
+3.3V:     +3.34 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +4.94 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +12.16 V  (min = +10.79 V, max = +13.19 V)
-12V:     -12.65 V  (min = -13.21 V, max = -10.90 V)
-5V:       -5.10 V  (min =  -5.26 V, max =  -4.76 V)
V5SB:      +5.38 V  (min =  +4.72 V, max =  +5.24 V)
VBat:      +3.42 V  (min =  +2.40 V, max =  +3.60 V)
U160:     2376 RPM  (min = 1500 RPM, div = 4)
CPU 0:    4218 RPM  (min = 3000 RPM, div = 2)
CPU 1:    4192 RPM  (min = 3000 RPM, div = 2)
System:   +32.0°C   (limit = +40°C, hysteresis = +37°C) sensor = thermistor
CPU 1:    +43.0°C   (limit = +52°C, hysteresis = +47°C) sensor = 3904 
transistor
CPU 0:    +43.0°C   (limit = +52°C, hysteresis = +47°C) sensor = 3904 
transistor
vid:      +18.50 V
alarms:   Chassis intrusion detection
beep_enable:
          Sound alarm disabled

[-]
chip "w83782d-*" "w83783s-*" "w83627hf-*"

# Same as above for w83781d except that in5 and in6 are computed differently.
# Rather than an internal inverting op amp, the 82d/83s use standard positive
# inputs and the negative voltages are level shifted by a 3.6V reference.
# The math is convoluted, so we hope that your motherboard
# uses the recommended resistor values.

    label in0 "VCore 1"
    label in1 "VCore 2"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "-12V"
    label in6 "-5V"
    label in7 "V5SB"
    label in8 "VBat"
    label fan1 "U160"
    label fan2 "CPU 0"
    label fan3 "CPU 1"
    label temp1 "System"
    label temp2 "CPU 1"
    label temp3 "CPU 0"

    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
    compute in5 (5.14 * @) - 14.91  ,  (@ + 14.91) / 5.14
    compute in6 (3.14 * @) -  7.71  ,  (@ +  7.71) / 3.14
    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)

    set fan1_div 4
    set fan2_div 2
    set fan3_div 2
    set fan1_min 1500
    set fan2_min 3000
    set fan3_min 3000

    set temp1_over 40
    set temp1_hyst 37
    set temp2_over 52
    set temp2_hyst 47
    set temp3_over 52
    set temp3_hyst 47

# set limits to  5% for the critical voltages
# set limits to 10% for the non-critical voltages
# set limits to 20% for the battery voltage

    set in0_min 1.7*0.95
    set in0_max 1.7*1.05
    set in1_min 2.5*0.95
    set in1_max 2.5*1.05
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.90
    set in4_max 12 * 1.10
    set in5_max -12 * 0.90
    set in5_min -12 * 1.10
    set in6_max -5 * 0.95
    set in6_min -5 * 1.05
    set in7_min 5 * 0.95
    set in7_max 5 * 1.05
    set in8_min 3.0 * 0.80
    set in8_max 3.0 * 1.20

# set up sensor types (thermistor is default)
# 1 = PII/Celeron Diode; 2 = 3904 transistor;
# 3435 = thermistor with Beta = 3435
# If temperature changes very little, try 1 or 2.
   set sensor1 3435
   set sensor2 2
   set sensor3 2
[-]

Regards,
	Dieter

BTW Isn't it the right time for 2.5.x inclusion?
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel at hamburg.de (replace at with @)
