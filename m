Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbTIVX4i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 19:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263087AbTIVXz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 19:55:58 -0400
Received: from mail.kroah.org ([65.200.24.183]:23457 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262799AbTIVXbS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:31:18 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1064273422761@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
In-Reply-To: <10642734221213@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 22 Sep 2003 16:30:22 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1315.1.12, 2003/09/22 11:42:40-07:00, greg@kroah.com

I2C: clean up the i2c chips Kconfig logic and help information


 drivers/i2c/chips/Kconfig |  111 +++++++++++++++++++---------------------------
 1 files changed, 46 insertions(+), 65 deletions(-)


diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	Mon Sep 22 16:14:08 2003
+++ b/drivers/i2c/chips/Kconfig	Mon Sep 22 16:14:08 2003
@@ -1,112 +1,93 @@
 #
-# Sensor device configuration
-# All depend on EXPERIMENTAL and I2C
+# I2C Sensor device configuration
 #
 
 menu "I2C Hardware Sensors Chip support"
 
+config I2C_SENSOR
+	tristate
+	default n
+
 config SENSORS_ADM1021
-	tristate "  Analog Devices ADM1021 and compatibles"
+	tristate "Analog Devices ADM1021 and compatibles"
 	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
 	help
 	  If you say yes here you get support for Analog Devices ADM1021 
 	  and ADM1023 sensor chips and clones: Maxim MAX1617 and MAX1617A,
 	  Genesys Logic GL523SM, National Semi LM84, TI THMC10,
-	  and the XEON processor built-in sensor. This can also 
-	  be built as a module which can be inserted and removed while the 
-	  kernel is running.
+	  and the XEON processor built-in sensor.
 
-	  The module will be called adm1021.
-	  
-	  You will also need the latest user-space utilties: you can find them
-	  in the lm_sensors package, which you can download at 
-	  http://www.lm-sensors.nu
+	  This driver can also be built as a module.  If so, the module
+	  will be called adm1021.
 
 config SENSORS_IT87
-	tristate "  National Semiconductors IT87 and compatibles"
+	tristate "National Semiconductors IT87 and compatibles"
 	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
 	help
-	  The module will be called it87.
+	  If you say yes here you get support for National Semiconductor IT87
+	  sensor chips and clones: IT8705F, IT8712F and SiS960.
 
-	  You will also need the latest user-space utilties: you can find them
-	  in the lm_sensors package, which you can download at 
-	  http://www.lm-sensors.nu
+	  This driver can also be built as a module.  If so, the module
+	  will be called it87.
 
 config SENSORS_LM75
-	tristate "  National Semiconductors LM75 and compatibles"
+	tristate "National Semiconductors LM75 and compatibles"
 	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
 	help
 	  If you say yes here you get support for National Semiconductor LM75
 	  sensor chips and clones: Dallas Semi DS75 and DS1775, TelCon
-	  TCN75, and National Semi LM77. This can also be built as a module
-	  which can be inserted and removed while the kernel is running.
-
-	  The module will be called lm75.
-
-	  You will also need the latest user-space utilties: you can find them
-	  in the lm_sensors package, which you can download at 
-	  http://www.lm-sensors.nu
-	  
-config SENSORS_LM85
-	tristate "  National Semiconductors LM85 and compatibles"
-	depends on I2C && EXPERIMENTAL
-	help
-	  If you say yes here you get support for National Semiconductor LM85
-	  sensor chips and clones: ADT7463 and ADM1027.
-	  This can also be built as a module which can be inserted and
-	  removed while the kernel is running.
+	  TCN75, and National Semi LM77.
 
-	  The module will be called lm85.
+	  This driver can also be built as a module.  If so, the module
+	  will be called lm75.
 
-	  You will also need the latest user-space utilties: you can find them
-	  in the lm_sensors package, which you can download at 
-	  http://www.lm-sensors.nu
-	  
 config SENSORS_LM78
-	tristate "  National Semiconductors LM78 and compatibles"
+	tristate "National Semiconductors LM78 and compatibles"
 	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
 	help
 	  If you say yes here you get support for National Semiconductor LM78,
 	  LM78-J and LM79.  This can also be built as a module which can be
 	  inserted and removed while the kernel is running.
 
-	  The module will be called lm78.
+	  This driver can also be built as a module.  If so, the module
+	  will be called lm78.
+
+config SENSORS_LM85
+	tristate "National Semiconductors LM85 and compatibles"
+	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for National Semiconductor LM85
+	  sensor chips and clones: ADT7463 and ADM1027.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called lm85.
 
-	  You will also need the latest user-space utilties: you can find them
-	  in the lm_sensors package, which you can download at 
-	  http://www.lm-sensors.nu
-	  
 config SENSORS_VIA686A
-	tristate "  VIA686A"
+	tristate "VIA686A"
 	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
 	help
-	  support for via686a
 	  If you say yes here you get support for the integrated sensors in
-	  Via 686A/B South Bridges. This can also be built as a module
-	  which can be inserted and removed while the kernel is running.
+	  Via 686A/B South Bridges.
 
-	  You will also need the latest user-space utilties: you can find them
-	  in the lm_sensors package, which you can download at
-	  http://www.lm-sensors.nu
+	  This driver can also be built as a module.  If so, the module
+	  will be called via686a.
 
 config SENSORS_W83781D
-	tristate "  Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F"
+	tristate "Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F"
 	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
 	help
 	  If you say yes here you get support for the Winbond W8378x series
 	  of sensor chips: the W83781D, W83782D, W83783S and W83682HF,
-	  and the similar Asus AS99127F. This
-	  can also be built as a module which can be inserted and removed
-	  while the kernel is running.
+	  and the similar Asus AS99127F.
 	  
-	  You will also need the latest user-space utilties: you can find them
-	  in the lm_sensors package, which you can download at
-	  http://www.lm-sensors.nu
-
-config I2C_SENSOR
-	tristate
-	default y if SENSORS_ADM1021=y || SENSORS_IT87=y || SENSORS_LM75=y || SENSORS_VIA686A=y || SENSORS_W83781D=y || SENSORS_LM85=y
-	default m if SENSORS_ADM1021=m || SENSORS_IT87=m || SENSORS_LM75=m || SENSORS_VIA686A=m || SENSORS_W83781D=m || SENSORS_LM85=m
-	default n
+	  This driver can also be built as a module.  If so, the module
+	  will be called w83781d.
 
 endmenu

