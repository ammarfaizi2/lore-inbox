Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVGDM0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVGDM0f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 08:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVGDM0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 08:26:35 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:39143 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261648AbVGDMYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 08:24:45 -0400
Date: Mon, 4 Jul 2005 14:24:13 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Bodo Eggert <7eggert@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH][Update] Kconfig changes 2b: s/menu/menuconfig/ USB menu
In-Reply-To: <Pine.LNX.4.58.0507041153020.3798@be1.lrz>
Message-ID: <Pine.LNX.4.58.0507041422380.11818@be1.lrz>
References: <Pine.LNX.4.58.0506301152460.11960@be1.lrz>
 <Pine.LNX.4.58.0507041134410.3798@be1.lrz> <Pine.LNX.4.58.0507041153020.3798@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 2b: The USB menu.

In many config submenus, the first menu option will enable the rest 
of the menu options. For these menus, It's appropriate to use the more 
convenient "menuconfig" keyword.

Patch for .13-rc1.

This patch includes the missing changes from the previous patch


--- rc1-a/drivers/usb/atm/Kconfig	2005-06-30 11:22:40.000000000 +0200
+++ rc1-b/drivers/usb/atm/Kconfig	2005-07-04 14:18:19.000000000 +0200
@@ -2,12 +2,9 @@
 # USB/ATM DSL configuration
 #
 
-menu "USB DSL modem support"
-	depends on USB
-
-config USB_ATM
+menuconfig USB_ATM
 	tristate "USB DSL modem support"
-	depends on USB && ATM
+	depends on ATM
 	select CRC32
 	default n
 	help
@@ -56,5 +53,3 @@ config USB_XUSBATM
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called xusbatm.
-
-endmenu
--- rc1-a/drivers/usb/mon/Kconfig	2005-06-30 11:22:41.000000000 +0200
+++ rc1-b/drivers/usb/mon/Kconfig	2005-07-04 14:16:55.000000000 +0200
@@ -4,7 +4,6 @@
 
 config USB_MON
 	bool "USB Monitor"
-	depends on USB!=n
 	default y
 	help
 	  If you say Y here, a component which captures the USB traffic
--- rc1-a/drivers/usb/core/Kconfig	2005-06-30 11:18:17.000000000 +0200
+++ rc1-b/drivers/usb/core/Kconfig	2005-07-04 14:14:40.000000000 +0200
@@ -3,18 +3,15 @@
 #
 config USB_DEBUG
 	bool "USB verbose debug messages"
-	depends on USB
 	help
 	  Say Y here if you want the USB core & hub drivers to produce a bunch
 	  of debug messages to the system log. Select this if you are having a
 	  problem with USB support and want to see more of what is going on.
 
 comment "Miscellaneous USB options"
-	depends on USB
 
 config USB_DEVICEFS
 	bool "USB device filesystem"
-	depends on USB
 	---help---
 	  If you say Y here (and to "/proc file system support" in the "File
 	  systems" section, above), you will get a file /proc/bus/usb/devices
@@ -38,7 +35,7 @@ config USB_DEVICEFS
 
 config USB_BANDWIDTH
 	bool "Enforce USB bandwidth allocation (EXPERIMENTAL)"
-	depends on USB && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	help
 	  If you say Y here, the USB subsystem enforces USB bandwidth
 	  allocation and will prevent some device opens from succeeding
@@ -51,7 +48,7 @@ config USB_BANDWIDTH
 
 config USB_DYNAMIC_MINORS
 	bool "Dynamic USB minor allocation (EXPERIMENTAL)"
-	depends on USB && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	help
 	  If you say Y here, the USB subsystem will use dynamic minor
 	  allocation for any device that uses the USB major number.
@@ -62,7 +59,7 @@ config USB_DYNAMIC_MINORS
 
 config USB_SUSPEND
 	bool "USB suspend/resume (EXPERIMENTAL)"
-	depends on USB && PM && EXPERIMENTAL
+	depends on PM && EXPERIMENTAL
 	help
 	  If you say Y here, you can use driver calls or the sysfs
 	  "power/state" file to suspend or resume individual USB
@@ -75,7 +72,7 @@ config USB_SUSPEND
 
 config USB_OTG
 	bool
-	depends on USB && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	select USB_SUSPEND
 	default n
 
--- rc1-a/drivers/usb/host/Kconfig	2005-06-30 11:22:40.000000000 +0200
+++ rc1-b/drivers/usb/host/Kconfig	2005-07-04 14:14:40.000000000 +0200
@@ -2,11 +2,10 @@
 # USB Host Controller Drivers
 #
 comment "USB Host Controller Drivers"
-	depends on USB
 
 config USB_EHCI_HCD
 	tristate "EHCI HCD (USB 2.0) support"
-	depends on USB && PCI
+	depends on PCI
 	---help---
 	  The Enhanced Host Controller Interface (EHCI) is standard for USB 2.0
 	  "high speed" (480 Mbit/sec, 60 Mbyte/sec) host controller hardware.
@@ -64,7 +63,7 @@ config USB_ISP116X_HCD
 
 config USB_OHCI_HCD
 	tristate "OHCI HCD support"
-	depends on USB && USB_ARCH_HAS_OHCI
+	depends on USB_ARCH_HAS_OHCI
 	select ISP1301_OMAP if MACH_OMAP_H2 || MACH_OMAP_H3
 	---help---
 	  The Open Host Controller Interface (OHCI) is a standard for accessing
@@ -110,7 +109,7 @@ config USB_OHCI_LITTLE_ENDIAN
 
 config USB_UHCI_HCD
 	tristate "UHCI HCD (most Intel and VIA) support"
-	depends on USB && PCI
+	depends on PCI
 	---help---
 	  The Universal Host Controller Interface is a standard by Intel for
 	  accessing the USB hardware in the PC (which is also called the USB
@@ -126,7 +125,6 @@ config USB_UHCI_HCD
 
 config USB_SL811_HCD
 	tristate "SL811HS HCD support"
-	depends on USB
 	default N
 	help
 	  The SL811HS is a single-port USB controller that supports either
--- rc1-a/drivers/usb/misc/Kconfig	2005-06-30 11:21:49.000000000 +0200
+++ rc1-b/drivers/usb/misc/Kconfig	2005-07-04 14:14:40.000000000 +0200
@@ -2,11 +2,9 @@
 # USB Miscellaneous driver configuration
 #
 comment "USB Miscellaneous drivers"
-	depends on USB
 
 config USB_EMI62
 	tristate "EMI 6|2m USB Audio interface support"
-	depends on USB
 	---help---
 	  This driver loads firmware to Emagic EMI 6|2m low latency USB
 	  Audio and Midi interface.
@@ -21,7 +19,6 @@ config USB_EMI62
 
 config USB_EMI26
 	tristate "EMI 2|6 USB Audio interface support"
-	depends on USB
 	---help---
 	  This driver loads firmware to Emagic EMI 2|6 low latency USB
 	  Audio interface.
@@ -34,7 +31,7 @@ config USB_EMI26
 
 config USB_AUERSWALD
 	tristate "USB Auerswald ISDN support (EXPERIMENTAL)"
-	depends on USB && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	help
 	  Say Y here if you want to connect an Auerswald USB ISDN Device
 	  to your computer's USB port.
@@ -44,7 +41,7 @@ config USB_AUERSWALD
 
 config USB_RIO500
 	tristate "USB Diamond Rio500 support (EXPERIMENTAL)"
-	depends on USB && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	help
 	  Say Y here if you want to connect a USB Rio500 mp3 player to your
 	  computer's USB port. Please read <file:Documentation/usb/rio.txt>
@@ -55,7 +52,7 @@ config USB_RIO500
 
 config USB_LEGOTOWER
 	tristate "USB Lego Infrared Tower support (EXPERIMENTAL)"
-	depends on USB && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	help
 	  Say Y here if you want to connect a USB Lego Infrared Tower to your
 	  computer's USB port.
@@ -68,7 +65,6 @@ config USB_LEGOTOWER
 
 config USB_LCD
 	tristate "USB LCD driver support"
-	depends on USB
 	help
 	  Say Y here if you want to connect an USBLCD to your computer's
 	  USB port. The USBLCD is a small USB interface board for
@@ -80,7 +76,6 @@ config USB_LCD
 
 config USB_LED
 	tristate "USB LED driver support"
-	depends on USB
 	help
 	  Say Y here if you want to connect an USBLED device to your 
 	  computer's USB port.
@@ -90,7 +85,6 @@ config USB_LED
 
 config USB_CYTHERM
 	tristate "Cypress USB thermometer driver support"
-	depends on USB
 	help
 	  Say Y here if you want to connect a Cypress USB thermometer
 	  device to your computer's USB port. This device is also known
@@ -103,7 +97,6 @@ config USB_CYTHERM
 
 config USB_PHIDGETKIT
 	tristate "USB PhidgetKit support"
-	depends on USB
 	help
 	  Say Y here if you want to connect a PhidgetKit USB device from
 	  Phidgets Inc.
@@ -113,7 +106,6 @@ config USB_PHIDGETKIT
 
 config USB_PHIDGETSERVO
 	tristate "USB PhidgetServo support"
-	depends on USB
 	help
 	  Say Y here if you want to connect an 1 or 4 Motor PhidgetServo 
 	  servo controller version 2.0 or 3.0.
@@ -125,7 +117,6 @@ config USB_PHIDGETSERVO
 
 config USB_IDMOUSE
 	tristate "Siemens ID USB Mouse Fingerprint sensor support"
-	depends on USB
 	help
 	  Say Y here if you want to use the fingerprint sensor on
 	  the Siemens ID Mouse. There is also a Siemens ID Mouse
@@ -141,7 +132,7 @@ source "drivers/usb/misc/sisusbvga/Kconf
 
 config USB_TEST
 	tristate "USB testing driver (DEVELOPMENT)"
-	depends on USB && USB_DEVICEFS && EXPERIMENTAL
+	depends on USB_DEVICEFS && EXPERIMENTAL
 	help
 	  This driver is for testing host controller software.  It is used
 	  with specialized device firmware for regression and stress testing,
--- rc1-a/drivers/usb/class/Kconfig	2005-06-30 11:19:37.000000000 +0200
+++ rc1-b/drivers/usb/class/Kconfig	2005-07-04 14:14:40.000000000 +0200
@@ -2,11 +2,10 @@
 # USB Class driver configuration
 #
 comment "USB Device Class drivers"
-	depends on USB
 
 config USB_AUDIO
 	tristate "USB Audio support"
-	depends on USB && SOUND
+	depends on SOUND
 	help
 	  Say Y here if you want to connect USB audio equipment such as
 	  speakers to your computer's USB port. You only need this if you use
@@ -16,11 +15,11 @@ config USB_AUDIO
 	  module will be called audio.
 
 comment "USB Bluetooth TTY can only be used with disabled Bluetooth subsystem"
-	depends on USB && BT
+	depends on BT
 
 config USB_BLUETOOTH_TTY
 	tristate "USB Bluetooth TTY support"
-	depends on USB && BT=n
+	depends on BT=n
 	---help---
 	  This driver implements a nonstandard tty interface to a Bluetooth
 	  device that can be used only by specialized Bluetooth HCI software.
@@ -40,7 +39,7 @@ config USB_BLUETOOTH_TTY
 
 config USB_MIDI
 	tristate "USB MIDI support"
-	depends on USB && SOUND
+	depends on SOUND
 	---help---
 	  Say Y here if you want to connect a USB MIDI device to your
 	  computer's USB port. This driver is for devices that comply with
@@ -61,7 +60,6 @@ config USB_MIDI
 
 config USB_ACM
 	tristate "USB Modem (CDC ACM) support"
-	depends on USB
 	---help---
 	  This driver supports USB modems and ISDN adapters which support the
 	  Communication Device Class Abstract Control Model interface.
@@ -76,7 +74,6 @@ config USB_ACM
 
 config USB_PRINTER
 	tristate "USB Printer support"
-	depends on USB
 	help
 	  Say Y here if you want to connect a USB printer to your computer's
 	  USB port.
--- rc1-a/drivers/usb/image/Kconfig	2005-06-30 11:21:49.000000000 +0200
+++ rc1-b/drivers/usb/image/Kconfig	2005-07-04 14:14:40.000000000 +0200
@@ -2,11 +2,10 @@
 # USB Imageing devices configuration
 #
 comment "USB Imaging devices"
-	depends on USB
 
 config USB_MDC800
 	tristate "USB Mustek MDC800 Digital Camera support (EXPERIMENTAL)"
-	depends on USB && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	---help---
 	  Say Y here if you want to connect this type of still camera to
 	  your computer's USB port. This driver can be used with gphoto 0.4.3
@@ -19,7 +18,7 @@ config USB_MDC800
 
 config USB_MICROTEK
 	tristate "Microtek X6USB scanner support"
-	depends on USB && SCSI
+	depends on SCSI
 	help
 	  Say Y here if you want support for the Microtek X6USB and
 	  possibly the Phantom 336CX, Phantom C6 and ScanMaker V6U(S)L.
--- rc1-a/drivers/usb/media/Kconfig	2005-06-30 11:21:49.000000000 +0200
+++ rc1-b/drivers/usb/media/Kconfig	2005-07-04 14:14:40.000000000 +0200
@@ -2,11 +2,9 @@
 # USB Multimedia device configuration
 #
 comment "USB Multimedia devices"
-	depends on USB
 
 config USB_DABUSB
 	tristate "DABUSB driver"
-	depends on USB
 	---help---
 	  A Digital Audio Broadcasting (DAB) Receiver for USB and Linux
 	  brought to you by the DAB-Team
@@ -19,11 +17,11 @@ config USB_DABUSB
 	  module will be called dabusb.
 
 comment "Video4Linux support is needed for USB Multimedia device support"
-	depends on USB && VIDEO_DEV=n
+	depends on VIDEO_DEV=n
 
 config USB_VICAM
 	tristate "USB 3com HomeConnect (aka vicam) support (EXPERIMENTAL)"
-	depends on USB && VIDEO_DEV && EXPERIMENTAL
+	depends on VIDEO_DEV && EXPERIMENTAL
 	---help---
 	  Say Y here if you have 3com homeconnect camera (vicam).
 
@@ -37,7 +35,7 @@ config USB_VICAM
 
 config USB_DSBR
 	tristate "D-Link USB FM radio support (EXPERIMENTAL)"
-	depends on USB && VIDEO_DEV && EXPERIMENTAL
+	depends on VIDEO_DEV && EXPERIMENTAL
 	---help---
 	  Say Y here if you want to connect this type of radio to your
 	  computer's USB port. Note that the audio is not digital, and
@@ -55,7 +53,7 @@ config USB_DSBR
 
 config USB_IBMCAM
 	tristate "USB IBM (Xirlink) C-it Camera support"
-	depends on USB && VIDEO_DEV
+	depends on VIDEO_DEV
 	---help---
 	  Say Y here if you want to connect a IBM "C-It" camera, also known as
 	  "Xirlink PC Camera" to your computer's USB port.  For more
@@ -76,7 +74,7 @@ config USB_IBMCAM
 
 config USB_KONICAWC
 	tristate "USB Konica Webcam support"
-	depends on USB && VIDEO_DEV
+	depends on VIDEO_DEV
 	---help---
 	  Say Y here if you want support for webcams based on a Konica
 	  chipset. This is known to work with the Intel YC76 webcam.
@@ -92,7 +90,7 @@ config USB_KONICAWC
 
 config USB_OV511
 	tristate "USB OV511 Camera support"
-	depends on USB && VIDEO_DEV
+	depends on VIDEO_DEV
 	---help---
 	  Say Y here if you want to connect this type of camera to your
 	  computer's USB port. See <file:Documentation/usb/ov511.txt> for more
@@ -108,7 +106,7 @@ config USB_OV511
 
 config USB_SE401
 	tristate "USB SE401 Camera support"
-	depends on USB && VIDEO_DEV
+	depends on VIDEO_DEV
 	---help---
 	  Say Y here if you want to connect this type of camera to your
 	  computer's USB port. See <file:Documentation/usb/se401.txt> for more
@@ -124,7 +122,7 @@ config USB_SE401
 
 config USB_SN9C102
 	tristate "USB SN9C10x PC Camera Controller support"
-	depends on USB && VIDEO_DEV
+	depends on VIDEO_DEV
 	---help---
 	  Say Y here if you want support for cameras based on SONiX SN9C101,
 	  SN9C102 or SN9C103 PC Camera Controllers.
@@ -139,7 +137,7 @@ config USB_SN9C102
 
 config USB_STV680
 	tristate "USB STV680 (Pencam) Camera support"
-	depends on USB && VIDEO_DEV
+	depends on VIDEO_DEV
 	---help---
 	  Say Y here if you want to connect this type of camera to your
 	  computer's USB port. This includes the Pencam line of cameras.
@@ -156,7 +154,7 @@ config USB_STV680
 
 config USB_W9968CF
 	tristate "USB W996[87]CF JPEG Dual Mode Camera support"
-	depends on USB && VIDEO_DEV && I2C && VIDEO_OVCAMCHIP
+	depends on VIDEO_DEV && I2C && VIDEO_OVCAMCHIP
 	---help---
 	  Say Y here if you want support for cameras based on OV681 or
 	  Winbond W9967CF/W9968CF JPEG USB Dual Mode Camera Chips.
@@ -178,7 +176,7 @@ config USB_W9968CF
 
 config USB_PWC
 	tristate "USB Philips Cameras"
-	depends on USB && VIDEO_DEV
+	depends on VIDEO_DEV
 	---help---
 	  Say Y or M here if you want to use one of these Philips & OEM
           webcams:
--- rc1-a/drivers/usb/storage/Kconfig	2005-06-30 11:21:50.000000000 +0200
+++ rc1-b/drivers/usb/storage/Kconfig	2005-07-04 14:14:40.000000000 +0200
@@ -3,11 +3,9 @@
 #
 
 comment "NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information"
-	depends on USB
 
 config USB_STORAGE
 	tristate "USB Mass Storage support"
-	depends on USB
 	select SCSI
 	---help---
 	  Say Y here if you want to connect USB mass storage devices to your
-- 
The complexity of a weapon is inversely proportional to the IQ of the
weapon's operator.
