Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264654AbTARLcG>; Sat, 18 Jan 2003 06:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbTARLcF>; Sat, 18 Jan 2003 06:32:05 -0500
Received: from tomts14-srv.bellnexxia.net ([209.226.175.35]:51148 "EHLO
	tomts14-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S264654AbTARLcE>; Sat, 18 Jan 2003 06:32:04 -0500
Date: Sat, 18 Jan 2003 06:40:39 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Roman Zippel <zippel@linux-m68k.org>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: questions about config files, I2C and hardware sensors (2.5.59)
In-Reply-To: <3E28B099.4E85C56D@linux-m68k.org>
Message-ID: <Pine.LNX.4.44.0301180638080.25212-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jan 2003, Roman Zippel wrote:

> Hi,
> 
> "Robert P. J. Day" wrote:
> 
> >   so the issues:
> > 
> > 1) trivial: comment is wrong, there is no dependency on
> >    EXPERIMENTAL
> 
> This has to be answered by the I2C maintainer.
> 
> > 2) since, in the sourcing Kconfig file, I2C_PROC *already* depends
> >    on I2C, is there any practical value in having the dependency
> >    "I2C && I2C_PROC".  wouldn't "depends on I2C_PROC" be sufficient?
> 
> Yes.
> 
> > 3) finally, given that the comment at the top is adamant that
> >    all of these options depend on I2C and I2C_PROC, wouldn't it
> >    be cleaner to just make the menu itself say:
> > 
> >    menu "I2C HW Sensors Mainboard Support"
> >         depends on I2C && I2C_PROC              (or just I2C_PROC)
> >         ...
> > 
> >    and let the internal options inherit this dependency?
> 
> Yes, the menu entry needs the dependencies as well.
> 
> bye, Roman

-------------------------------------------------------------------------
diff -urN linux-2.5.59/drivers/i2c/busses/Kconfig linux-new/drivers/i2c/busses/Kconfig
--- linux-2.5.59/drivers/i2c/busses/Kconfig	2003-01-17 07:13:08.000000000 -0500
+++ linux-new/drivers/i2c/busses/Kconfig	2003-01-17 07:14:58.000000000 -0500
@@ -1,13 +1,13 @@
 #
 # Sensor device configuration
-# All depend on EXPERIMENTAL, I2C and I2C_PROC.
+# All depend on I2C_PROC.
 #
 
 menu "I2C Hardware Sensors Mainboard support"
+	depends on I2C_PROC
 
 config I2C_AMD756
 	tristate "  AMD 756/766"
-	depends on I2C && I2C_PROC
 	help
 	  If you say yes to this option, support will be included for the AMD
 	  756/766/768 mainboard I2C interfaces.
@@ -24,7 +24,6 @@
 
 config I2C_AMD8111
 	tristate "  AMD 8111"
-	depends on I2C && I2C_PROC
 	help
 	  If you say yes to this option, support will be included for the AMD
 	  8111 mainboard I2C interfaces.
diff -urN linux-2.5.59/drivers/i2c/chips/Kconfig linux-new/drivers/i2c/chips/Kconfig
--- linux-2.5.59/drivers/i2c/chips/Kconfig	2003-01-17 07:13:08.000000000 -0500
+++ linux-new/drivers/i2c/chips/Kconfig	2003-01-17 07:14:58.000000000 -0500
@@ -1,13 +1,13 @@
 #
 # Sensor device configuration
-# All depend on EXPERIMENTAL, I2C and I2C_PROC.
+# All depend on I2C_PROC.
 #
 
 menu "I2C Hardware Sensors Chip support"
+	depends on I2C_PROC
 
 config SENSORS_ADM1021
 	tristate "  Analog Devices ADM1021 and compatibles"
-	depends on I2C && I2C_PROC
 	help
 	  If you say yes here you get support for Analog Devices ADM1021 
 	  and ADM1023 sensor chips and clones: Maxim MAX1617 and MAX1617A,
@@ -24,7 +24,6 @@
 
 config SENSORS_LM75
 	tristate "  National Semiconductors LM75 and compatibles"
-	depends on I2C && I2C_PROC
 	help
 	  If you say yes here you get support for National Semiconductor LM75
 	  sensor chips and clones: Dallas Semi DS75 and DS1775, TelCon

