Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263758AbUDFKzu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 06:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263760AbUDFKzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 06:55:50 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:6411 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263758AbUDFKzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 06:55:23 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Greg Kroah-Hartman <greg@kroah.com>
Subject: Re: 2.6.4: disabling SCSI support not possible
Date: Tue, 6 Apr 2004 12:46:53 +0200
User-Agent: KMail/1.6.1
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Bill Davidsen <davidsen@tmr.com>
References: <406D65FE.9090001@broadnet-mediascape.de> <c4slos$6tq$1@gatekeeper.tmr.com> <20040406094258.A15945@flint.arm.linux.org.uk>
In-Reply-To: <20040406094258.A15945@flint.arm.linux.org.uk>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dqocA39UjCuupFC"
Message-Id: <200404061246.53847@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_dqocA39UjCuupFC
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 06 April 2004 10:42, Russell King wrote:

Hi,

> > Intuitive isn't the issue, if you can't figure out why you can't turn
> > off SCSI, you leave it on, which you need to make USB storage work. If
> > you're trying to make a small kernel you presumably would have turned
> > off USB if you didn't want it. The other way, if you can turn on USB w/o
> > SCSI, it won't work, and people thing Linux is broken.

> When I hit it, I was trying to build a kernel for test purposes, so I
> didn't want all the drivers turned on.  I found I couldn't turn off
> SCSI and continued anyway turning other things off.  However, USB appears
> _after_ SCSI, you can not go through the configuration logically to turn
> off features.  Moreover, you do not get any suggestion when attempting
> to turn SCSI off that you need to turn off USB.

may I propose the following two patches?

01_menu-Kconfig-cleanups-08-usb-menu-indent-fix.patch
	Fix up indents in the USB Input menu

02_menu-Kconfig-cleanups-09-USB-vs-SCSI-fix.patch
	Fix SCSI dependency for USB-Storage support.
	- Rip out "select SCSI"
	- Make a comment when SCSI is not selected

ciao, Marc

--Boundary-00=_dqocA39UjCuupFC
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="01_menu-Kconfig-cleanups-08-usb-menu-indent-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="01_menu-Kconfig-cleanups-08-usb-menu-indent-fix.patch"

diff -Naurp linux-2.6.4-rc1/drivers/usb/input/Kconfig linux-2.6.4-rc1-modified/drivers/usb/input/Kconfig
--- linux-2.6.4-rc1/drivers/usb/input/Kconfig	2004-03-07 20:51:35.000000000 +0100
+++ linux-2.6.4-rc1-modified/drivers/usb/input/Kconfig	2004-03-07 21:00:15.000000000 +0100
@@ -29,7 +29,7 @@ comment "Input core support is needed fo
 config USB_HIDINPUT
 	bool "HID input layer support"
 	default y
-	depends on INPUT && USB_HID
+	depends on INPUT && USB && USB_HID
 	help
 	  Say Y here if you want to use a USB keyboard, mouse or joystick,
 	  or any other HID input device. You also need "Input core support", 
@@ -39,7 +39,7 @@ config USB_HIDINPUT
 
 config HID_FF
 	bool "Force feedback support (EXPERIMENTAL)"
-	depends on USB_HIDINPUT && EXPERIMENTAL
+	depends on USB && USB_HIDINPUT && EXPERIMENTAL
 	help
 	  Say Y here is you want force feedback support for a few HID devices.
 	  See below for a list of supported devices.
@@ -51,7 +51,7 @@ config HID_FF
 
 config HID_PID
 	bool "PID Devices (Microsoft Sidewinder Force Feedback 2)"
-	depends on HID_FF
+	depends on USB && HID_FF
 	help
 	  Say Y here if you have a PID-compliant joystick and wish to enable force
 	  feedback for it. The Microsoft Sidewinder Force Feedback 2 is one such
@@ -59,7 +59,7 @@ config HID_PID
 
 config LOGITECH_FF
 	bool "Logitech WingMan *3D support"
-	depends on HID_FF
+	depends on USB && HID_FF
 	help
 	  Say Y here if you have one of these devices:
 	  - Logitech WingMan Cordless RumblePad
@@ -70,7 +70,7 @@ config LOGITECH_FF
 
 config THRUSTMASTER_FF
 	bool "ThrustMaster FireStorm Dual Power 2 support (EXPERIMENTAL)"
-	depends on HID_FF && EXPERIMENTAL
+	depends on USB && HID_FF && EXPERIMENTAL
 	help
 	  Say Y here if you have a THRUSTMASTER FireStore Dual Power 2,
 	  and want to enable force feedback support for it.
@@ -79,7 +79,7 @@ config THRUSTMASTER_FF
 
 config USB_HIDDEV
 	bool "/dev/hiddev raw HID device support"
-	depends on USB_HID
+	depends on USB && USB_HID
 	help
 	  Say Y here if you want to support HID devices (from the USB
 	  specification standpoint) that aren't strictly user interface

--Boundary-00=_dqocA39UjCuupFC
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="02_menu-Kconfig-cleanups-09-USB-vs-SCSI-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="02_menu-Kconfig-cleanups-09-USB-vs-SCSI-fix.patch"

diff -Naurp linux-2.6.4-wolk2.4-fullkernel/drivers/usb/storage/Kconfig linux-2.6.4-wolk2.4-USB-stuff/drivers/usb/storage/Kconfig
--- linux-2.6.4-wolk2.4-fullkernel/drivers/usb/storage/Kconfig	2004-04-05 17:10:21.000000000 +0200
+++ linux-2.6.4-wolk2.4-USB-stuff/drivers/usb/storage/Kconfig	2004-04-06 12:30:55.000000000 +0200
@@ -2,10 +2,9 @@
 # USB Storage driver configuration
 #
 
-config USB_STORAGE
+menuconfig USB_STORAGE
 	tristate "USB Mass Storage support"
-	depends on USB
-	select SCSI
+	depends on USB && SCSI
 	---help---
 	  Say Y here if you want to connect USB mass storage devices to your
 	  computer's USB port. This is the driver you need for USB floppy drives,
@@ -89,3 +88,5 @@ config USB_STORAGE_JUMPSHOT
 	  Say Y here to include additional code to support the Lexar Jumpshot
 	  USB CompactFlash reader.
 
+comment "SCSI support is needed for USB Storage support"
+	depends on USB && !SCSI

--Boundary-00=_dqocA39UjCuupFC--
