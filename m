Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315162AbSFITcr>; Sun, 9 Jun 2002 15:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314929AbSFITcq>; Sun, 9 Jun 2002 15:32:46 -0400
Received: from mail215.mail.bellsouth.net ([205.152.58.155]:28273 "EHLO
	imf15bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S315162AbSFIT1r>; Sun, 9 Jun 2002 15:27:47 -0400
Message-ID: <3D03AC27.CD979639@bellsouth.net>
Date: Sun, 09 Jun 2002 15:27:35 -0400
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] 2.5.21 lm_sensor support 5/5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds lm_sensor support for 2.5.21
--- linux/MAINTAINERS.orig	2002-05-20 19:28:58.000000000 -0400
+++ linux/MAINTAINERS	2002-05-20 19:29:39.000000000 -0400
@@ -681,6 +681,15 @@
 W:	http://www.tk.uni-linz.ac.at/~simon/private/i2c
 S:	Maintained
 
+SENSORS DRIVERS
+P:      Frodo Looijaard
+M:      frodol@dds.nl
+P:      Philip Edelbrock
+M:      phil@netroedge.com
+L:      sensors@stimpy.netroedge.com
+W:      http://www.lm-sensors.nu/
+S:      Maintained
+
 i386 BOOT CODE
 P:	Riley H. Williams
 M:	rhw@memalpha.cx
--- /dev/null	Sat Sep 15 02:03:30 CEST 2001
+++ linux/drivers/i2c/busses/Config.help	2002-05-20 19:38:23.000000000 -0400
@@ -0,0 +1,112 @@
+I2C mainboard interfaces
+CONFIG_MAINBOARD
+  Many modern mainboards have some kind of I2C interface integrated. This
+  is often in the form of a SMBus, or System Management Bus, which is
+  basically the same as I2C but which uses only a subset of the I2C
+  protocol.
+
+  You will also want the latest user-space utilties: you can find them
+  in the lm_sensors package, which you can download at 
+  http://www.lm-sensors.nu
+
+Acer Labs ALI 1535
+CONFIG_I2C_ALI1535
+  If you say yes to this option, support will be included for the Acer
+  Labs ALI 1535 mainboard I2C interface. This can also be 
+  built as a module.
+
+Acer Labs ALI 1533 and 1543C
+CONFIG_I2C_ALI15X3
+  If you say yes to this option, support will be included for the Acer
+  Labs ALI 1533 and 1543C mainboard I2C interfaces. This can also be 
+  built as a module which can be inserted and removed while the kernel
+  is running.
+
+AMD 756/766
+CONFIG_I2C_AMD756
+  If you say yes to this option, support will be included for the AMD
+  756/766 mainboard I2C interfaces. This can also be 
+  built as a module which can be inserted and removed while the kernel
+  is running.
+
+Apple Hydra Mac I/O
+CONFIG_I2C_HYDRA
+  If you say yes to this option, support will be included for the 
+  Hydra mainboard I2C interface. This can also be built as a module 
+  which can be inserted and removed while the kernel is running.
+
+Intel I801
+CONFIG_I2C_I801
+  If you say yes to this option, support will be included for the 
+  Intel I801 mainboard I2C interfaces. "I810" mainboard sensor chips are
+  generally located on the I801's I2C bus. This can also be
+  built as a module which can be inserted and removed while the kernel
+  is running.
+
+Intel I810/I815
+CONFIG_I2C_I810
+  If you say yes to this option, support will be included for the 
+  Intel I810/I815 mainboard I2C interfaces. The I2C busses these chips
+  are generally used only for video devices. For "810" mainboard sensor
+  chips, use the I801 I2C driver instead. This can also be
+  built as a module which can be inserted and removed while the kernel
+  is running.
+
+Intel 82371AB PIIX4(E) / ServerWorks OSB4 and CSB5
+CONFIG_I2C_PIIX4
+  If you say yes to this option, support will be included for the 
+  Intel PIIX4 and PIIX4E and Serverworks OSB4/CSB5 mainboard
+  I2C interfaces. This can also be
+  built as a module which can be inserted and removed while the kernel
+  is running.
+
+Silicon Integrated Systems Corp. SiS5595
+CONFIG_I2C_SIS5595
+  If you say yes to this option, support will be included for the 
+  SiS5595 mainboard I2C interfaces. For integrated sensors on the
+  Sis5595, use CONFIG_SENSORS_SIS5595. This can also be
+  built as a module which can be inserted and removed while the kernel
+  is running.
+
+VIA Technologies, Inc. VT82C586B
+CONFIG_I2C_VIA
+  If you say yes to this option, support will be included for the VIA
+  Technologies I2C adapter found on some motherboards. This can also 
+  be built as a module which can be inserted and removed while the 
+  kernel is running.
+
+VIA Technologies, Inc. VT82C596, 596B, 686A/B
+CONFIG_I2C_VIAPRO
+  If you say yes to this option, support will be included for the VIA
+  Technologies I2C adapter on these chips. For integrated sensors on the
+  Via 686A/B, use CONFIG_SENSORS_VIA686A. This can also be
+  be built as a module which can be inserted and removed while the 
+  kernel is running.
+
+3DFX Banshee / Voodoo3
+CONFIG_I2C_VOODOO3
+  If you say yes to this option, support will be included for the 
+  3DFX Banshee and Voodoo3 I2C interfaces. The I2C busses on the these
+  chips are generally used only for video devices.
+  This can also be
+  built as a module which can be inserted and removed while the kernel
+  is running.
+
+DEC Tsunami 21272
+CONFIG_I2C_TSUNAMI
+  If you say yes to this option, support will be included for the DEC
+  Tsunami chipset I2C adapter. Requires the Alpha architecture;
+  do not enable otherwise. This can also be built as a module which
+  can be inserted and removed while the kernel is running.
+
+Pseudo ISA adapter (for hardware sensors modules)
+CONFIG_I2C_ISA
+  This provides support for accessing some hardware sensor chips over
+  the ISA bus rather than the I2C or SMBus. If you want to do this, 
+  say yes here. This feature can also be built as a module which can 
+  be inserted and removed while the kernel is running.
+
+  You will also need the latest user-space utilties: you can find them
+  in the lm_sensors package, which you can download at 
+  http://www.lm-sensors.nu
+
--- /dev/null	Sat Sep 15 02:03:30 CEST 2001
+++ linux/drivers/i2c/chips/Config.help	2002-05-20 19:38:23.000000000 -0400
@@ -0,0 +1,185 @@
+Sensors support
+CONFIG_SENSORS
+  Many modern mainboards have some kind of I2C interface integrated. This
+  is often in the form of a SMBus, or System Management Bus, which is
+  basically the same as I2C but which uses only a subset of the I2C
+  protocol.
+
+  You will also want the latest user-space utilties: you can find them
+  in the lm_sensors package, which you can download at 
+  http://www.lm-sensors.nu
+
+Analog Devices ADM1021 and compatibles
+CONFIG_SENSORS_ADM1021 
+  If you say yes here you get support for Analog Devices ADM1021 
+  and ADM1023 sensor chips and clones: Maxim MAX1617 and MAX1617A,
+  Genesys Logic GL523SM, National Semi LM84, TI THMC10,
+  and the XEON processor built-in sensor. This can also 
+  be built as a module which can be inserted and removed while the 
+  kernel is running.
+
+  You will also need the latest user-space utilties: you can find them
+  in the lm_sensors package, which you can download at 
+  http://www.lm-sensors.nu
+
+Analog Devices ADM1024
+CONFIG_SENSORS_ADM1024
+  If you say yes here you get support for Analog Devices ADM1024 sensor
+  chips.  This can also be built as a module which can be inserted and
+  removed while the kernel is running.
+
+  You will also need the latest user-space utilties: you can find them
+  in the lm_sensors package, which you can download at 
+  http://www.lm-sensors.nu
+
+Analog Devices ADM1025
+CONFIG_SENSORS_ADM1025
+  If you say yes here you get support for Analog Devices ADM1025 sensor
+  chips.  This can also be built as a module which can be inserted and
+  removed while the kernel is running.
+
+  You will also need the latest user-space utilties: you can find them
+  in the lm_sensors package, which you can download at 
+  http://www.lm-sensors.nu
+
+Analog Devices ADM9240 and compatibles
+CONFIG_SENSORS_ADM9240
+  If you say yes here you get support for Analog Devices ADM9240 
+  sensor chips and clones: the Dallas Semiconductor DS1780 and
+  the National Semiconductor LM81. This can also be built as a 
+  module which can be inserted and removed while the kernel is
+  running.
+
+  You will also need the latest user-space utilties: you can find them
+  in the lm_sensors package, which you can download at 
+  http://www.lm-sensors.nu
+
+Genesys Logic GL518SM
+CONFIG_SENSORS_GL518SM
+  If you say yes here you get support for Genesys Logic GL518SM sensor
+  chips.  This can also be built as a module which can be inserted and
+  removed while the kernel is running.
+
+  You will also need the latest user-space utilties: you can find them
+  in the lm_sensors package, which you can download at 
+  http://www.lm-sensors.nu
+
+Genesys Logic GL520SM
+CONFIG_SENSORS_GL520SM
+  If you say yes here you get support for Genesys Logic GL518SM sensor
+  chips.  This can also be built as a module which can be inserted and
+  removed while the kernel is running.
+
+  You will also need the latest user-space utilties: you can find them
+  in the lm_sensors package, which you can download at 
+  http://www.lm-sensors.nu
+
+Iside Technologies IT87 and compatibles
+CONFIG_SENSORS_IT87
+  If you say yes here you get support for Iside Technologies IT87
+  sensor chips and clones: 
+  TCN75, and National Semi LM77. This can also be built as a module which
+  can be inserted and removed while the kernel is running.
+
+  You will also need the latest user-space utilties: you can find them
+  in the lm_sensors package, which you can download at 
+  http://www.lm-sensors.nu
+
+National Semiconductor LM75 and compatibles
+CONFIG_SENSORS_LM75 
+  If you say yes here you get support for National Semiconductor LM75
+  sensor chips and clones: Dallas Semi DS75 and DS1775, TelCon
+  TCN75, and National Semi LM77. This can also be built as a module which
+  can be inserted and removed while the kernel is running.
+
+  You will also need the latest user-space utilties: you can find them
+  in the lm_sensors package, which you can download at 
+  http://www.lm-sensors.nu
+
+National Semiconductor LM78
+CONFIG_SENSORS_LM78
+  If you say yes here you get support for National Semiconductor LM78
+  sensor chips family: the LM78-J and LM79. Many clone chips will
+  also work at least somewhat with this driver. This can also be built
+  as a module which can be inserted and removed while the kernel is 
+  running.
+
+  You will also need the latest user-space utilties: you can find them
+  in the lm_sensors package, which you can download at 
+  http://www.lm-sensors.nu
+
+National Semiconductor LM80
+CONFIG_SENSORS_LM80
+  If you say yes here you get support for National Semiconductor LM80
+  sensor chips. This can also be built as a module which can be 
+  inserted and removed while the kernel is running.
+
+  You will also need the latest user-space utilties: you can find them
+  in the lm_sensors package, which you can download at 
+  http://www.lm-sensors.nu
+
+National Semiconductor LM87
+CONFIG_SENSORS_LM87
+  If you say yes here you get support for National Semiconductor LM87
+  sensor chips. This can also be built as a module which can be 
+  inserted and removed while the kernel is running.
+
+  You will also need the latest user-space utilties: you can find them
+  in the lm_sensors package, which you can download at 
+  http://www.lm-sensors.nu
+
+Silicon Integrated Systems Corp. SiS5595
+CONFIG_SENSORS_SIS5595
+  If you say yes here you get support for the integrated sensors in 
+  SiS5595 South Bridges. This can also be built as a module 
+  which can be inserted and removed while the kernel is running.
+
+  You will also need the latest user-space utilties: you can find them
+  in the lm_sensors package, which you can download at 
+  http://www.lm-sensors.nu
+
+Texas Instruments THMC50 / Analog Devices ADM1022
+CONFIG_SENSORS_THMC50
+  If you say yes here you get support for Texas Instruments THMC50
+  sensor chips and clones: the Analog Devices ADM1022.
+  This can also be built as a module which
+  can be inserted and removed while the kernel is running.
+
+  You will also need the latest user-space utilties: you can find them
+  in the lm_sensors package, which you can download at 
+  http://www.lm-sensors.nu
+
+Via VT82C686A/B
+CONFIG_SENSORS_VIA686A
+  If you say yes here you get support for the integrated sensors in 
+  Via 686A/B South Bridges. This can also be built as a module 
+  which can be inserted and removed while the kernel is running.
+
+  You will also need the latest user-space utilties: you can find them
+  in the lm_sensors package, which you can download at 
+  http://www.lm-sensors.nu
+
+Winbond W83781D, W83782D, W83783S, W83627HF, AS99127F
+CONFIG_SENSORS_W83781D
+  If you say yes here you get support for the Winbond W8378x series 
+  of sensor chips: the W83781D, W83782D, W83783S and W83682HF,
+  and the similar Asus AS99127F. This
+  can also be built as a module which can be inserted and removed
+  while the kernel is running.
+
+  You will also need the latest user-space utilties: you can find them
+  in the lm_sensors package, which you can download at 
+  http://www.lm-sensors.nu
+
+EEprom (DIMM) reader
+CONFIG_SENSORS_EEPROM
+  If you say yes here you get read-only access to the EEPROM data 
+  available on modern memory DIMMs, and which could theoretically
+  also be available on other devices. This can also be built as a 
+  module which can be inserted and removed while the kernel is 
+  running.
+
+  You will also need the latest user-space utilties: you can find them
+  in the lm_sensors package, which you can download at 
+  http://www.lm-sensors.nu
+

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
