Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265175AbUATAEy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265172AbUATADN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:03:13 -0500
Received: from mail.kroah.org ([65.200.24.183]:9900 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264537AbUASX7u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 18:59:50 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
In-Reply-To: <10745567662012@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 15:59:26 -0800
Message-Id: <10745567661358@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.98.24, 2004/01/19 12:57:20-08:00, khali@linux-fr.org

[PATCH] I2C: Autoselect i2c algos

I replaced all dependancies on algos with dependancies on
I2C + select algo. There are some cases outside of the i2c subdirectory.

Also note that I slightly altered the condition to display the PCILynx
comment. I think it's more logical that way. Without it, the user could
get the message he/she needs I2C, go to enable it, come back and still
not see the option.


 drivers/i2c/busses/Kconfig  |   42 ++++++++++++++++++++++++++++--------------
 drivers/ieee1394/Kconfig    |    7 ++++---
 drivers/media/video/Kconfig |    3 ++-
 drivers/video/Kconfig       |    3 ++-
 4 files changed, 36 insertions(+), 19 deletions(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Jan 19 15:28:33 2004
+++ b/drivers/i2c/busses/Kconfig	Mon Jan 19 15:28:33 2004
@@ -49,7 +49,8 @@
 
 config I2C_ELEKTOR
 	tristate "Elektor ISA card"
-	depends on I2C_ALGOPCF && ISA && BROKEN_ON_SMP
+	depends on I2C && ISA && BROKEN_ON_SMP
+	select I2C_ALGOPCF
 	help
 	  This supports the PCF8584 ISA bus I2C adapter.  Say Y if you own
 	  such an adapter.
@@ -59,7 +60,8 @@
 
 config I2C_ELV
 	tristate "ELV adapter"
-	depends on I2C_ALGOBIT
+	depends on I2C
+	select I2C_ALGOBIT
 	help
 	  This supports parallel-port I2C adapters called ELV.  Say Y if you
 	  own such an adapter.
@@ -86,7 +88,8 @@
 
 config I2C_I810
 	tristate "Intel 810/815"
-	depends on I2C_ALGOBIT && PCI && EXPERIMENTAL
+	depends on I2C && PCI && EXPERIMENTAL
+	select I2C_ALGOBIT
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  810/815 family of mainboard I2C interfaces.  Specifically, the 
@@ -119,7 +122,8 @@
 
 config I2C_ITE
 	tristate "ITE I2C Adapter"
-	depends on I2C_ALGOITE
+	depends on I2C
+	select I2C_ALGOITE
 	help
 	  This supports the ITE8172 I2C peripheral found on some MIPS
 	  systems. Say Y if you have one of these. You should also say Y for
@@ -150,7 +154,8 @@
 
 config I2C_PHILIPSPAR
 	tristate "Philips style parallel port adapter"
-	depends on I2C_ALGOBIT && PARPORT
+	depends on I2C && PARPORT
+	select I2C_ALGOBIT
 	help
 	  This supports parallel-port I2C adapters made by Philips.
 
@@ -159,7 +164,8 @@
 
 config I2C_PARPORT
 	tristate "Parallel port adapter"
-	depends on I2C_ALGOBIT && PARPORT
+	depends on I2C && PARPORT
+	select I2C_ALGOBIT
 	help
 	  This supports parallel port I2C adapters such as the ones made by
 	  Philips or Velleman, Analog Devices evaluation boards, and more.
@@ -179,7 +185,8 @@
 
 config I2C_PARPORT_LIGHT
 	tristate "Parallel port adapter (light)"
-	depends on I2C_ALGOBIT 
+	depends on I2C
+	select I2C_ALGOBIT
 	help
 	  This supports parallel port I2C adapters such as the ones made by
 	  Philips or Velleman, Analog Devices evaluation boards, and more.
@@ -219,7 +226,8 @@
 
 config I2C_PROSAVAGE
 	tristate "S3/VIA (Pro)Savage"
-	depends on I2C_ALGOBIT && PCI && EXPERIMENTAL
+	depends on I2C && PCI && EXPERIMENTAL
+	select I2C_ALGOBIT
 	help
 	  If you say yes to this option, support will be included for the
 	  I2C bus and DDC bus of the S3VIA embedded Savage4 and ProSavage8
@@ -233,11 +241,13 @@
 
 config I2C_RPXLITE
 	tristate "Embedded Planet RPX Lite/Classic support"
-	depends on (RPXLITE || RPXCLASSIC) && I2C_ALGO8XX
+	depends on (RPXLITE || RPXCLASSIC) && I2C
+	select I2C_ALGO8XX
 
 config I2C_SAVAGE4
 	tristate "S3 Savage 4"
-	depends on I2C_ALGOBIT && PCI && EXPERIMENTAL
+	depends on I2C && PCI && EXPERIMENTAL
+	select I2C_ALGOBIT
 	help
 	  If you say yes to this option, support will be included for the 
 	  S3 Savage 4 I2C interface.
@@ -247,7 +257,8 @@
 
 config SCx200_I2C
 	tristate "NatSemi SCx200 I2C using GPIO pins"
-	depends on SCx200_GPIO && I2C_ALGOBIT
+	depends on SCx200_GPIO && I2C
+	select I2C_ALGOBIT
 	help
 	  Enable the use of two GPIO pins of a SCx200 processor as an I2C bus.
 
@@ -322,7 +333,8 @@
 
 config I2C_VELLEMAN
 	tristate "Velleman K8000 adapter"
-	depends on I2C_ALGOBIT
+	depends on I2C
+	select I2C_ALGOBIT
 	help
 	  This supports the Velleman K8000 parallel-port I2C adapter.  Say Y
 	  if you own such an adapter.
@@ -332,7 +344,8 @@
 
 config I2C_VIA
 	tristate "VIA 82C586B"
-	depends on I2C_ALGOBIT && PCI && EXPERIMENTAL
+	depends on I2C && PCI && EXPERIMENTAL
+	select I2C_ALGOBIT
 	help
 
 	  If you say yes to this option, support will be included for the VIA
@@ -362,7 +375,8 @@
 
 config I2C_VOODOO3
 	tristate "Voodoo 3"
-	depends on I2C_ALGOBIT && PCI && EXPERIMENTAL
+	depends on I2C && PCI && EXPERIMENTAL
+	select I2C_ALGOBIT
 	help
 
 	  If you say yes to this option, support will be included for the
diff -Nru a/drivers/ieee1394/Kconfig b/drivers/ieee1394/Kconfig
--- a/drivers/ieee1394/Kconfig	Mon Jan 19 15:28:33 2004
+++ b/drivers/ieee1394/Kconfig	Mon Jan 19 15:28:33 2004
@@ -51,12 +51,13 @@
 comment "Device Drivers"
 	depends on IEEE1394
 
-comment "Texas Instruments PCILynx requires I2C bit-banging"
-	depends on IEEE1394 && (I2C=n || I2C_ALGOBIT=n)
+comment "Texas Instruments PCILynx requires I2C"
+	depends on IEEE1394 && I2C=n
 
 config IEEE1394_PCILYNX
 	tristate "Texas Instruments PCILynx support"
-	depends on PCI && IEEE1394 && I2C_ALGOBIT
+	depends on PCI && IEEE1394 && I2C
+	select I2C_ALGOBIT
 	help
 	  Say Y here if you have an IEEE-1394 controller with the Texas
 	  Instruments PCILynx chip.  Note: this driver is written for revision
diff -Nru a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
--- a/drivers/media/video/Kconfig	Mon Jan 19 15:28:33 2004
+++ b/drivers/media/video/Kconfig	Mon Jan 19 15:28:33 2004
@@ -9,7 +9,8 @@
 
 config VIDEO_BT848
 	tristate "BT848 Video For Linux"
-	depends on VIDEO_DEV && PCI && I2C_ALGOBIT && SOUND
+	depends on VIDEO_DEV && PCI && I2C && SOUND
+	select I2C_ALGOBIT
 	---help---
 	  Support for BT848 based frame grabber/overlay boards. This includes
 	  the Miro, Hauppauge and STB boards. Please read the material in
diff -Nru a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig	Mon Jan 19 15:28:33 2004
+++ b/drivers/video/Kconfig	Mon Jan 19 15:28:33 2004
@@ -579,7 +579,8 @@
 
 config FB_MATROX_I2C
 	tristate "Matrox I2C support"
-	depends on FB_MATROX && I2C_ALGOBIT
+	depends on FB_MATROX && I2C
+	select I2C_ALGOBIT
 	---help---
 	  This drivers creates I2C buses which are needed for accessing the
 	  DDC (I2C) bus present on all Matroxes, an I2C bus which

