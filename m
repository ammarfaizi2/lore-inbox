Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274821AbTGaRMU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 13:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274825AbTGaRMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 13:12:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:16335 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274821AbTGaRL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 13:11:57 -0400
Date: Thu, 31 Jul 2003 10:11:44 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] reorganize USB submenu's
Message-Id: <20030731101144.32a3f0d7.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.3claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The USB configuration menu's in 2.6 are a mismash of sub-menu's and comments.
This patch tries to rationalize it so it comes out looking more like the current
filesystems menus.

I think it is easier to navigate, there should be no functional change from this.
Though some elements may appear/disappear differently based on earlier choices.

diff -Nru a/drivers/usb/Kconfig b/drivers/usb/Kconfig
--- a/drivers/usb/Kconfig	Thu Jul 31 10:07:11 2003
+++ b/drivers/usb/Kconfig	Thu Jul 31 10:07:11 2003
@@ -44,18 +44,15 @@
 
 source "drivers/usb/class/Kconfig"
 
-source "drivers/usb/storage/Kconfig"
-
 source "drivers/usb/input/Kconfig"
 
+source "drivers/usb/storage/Kconfig"
+
 source "drivers/usb/image/Kconfig"
 
 source "drivers/usb/media/Kconfig"
 
 source "drivers/usb/net/Kconfig"
-
-comment "USB port drivers"
-	depends on USB
 
 config USB_USS720
 	tristate "USS720 parport driver"
diff -Nru a/drivers/usb/class/Kconfig b/drivers/usb/class/Kconfig
--- a/drivers/usb/class/Kconfig	Thu Jul 31 10:07:11 2003
+++ b/drivers/usb/class/Kconfig	Thu Jul 31 10:07:11 2003
@@ -1,9 +1,6 @@
 #
 # USB Class driver configuration
 #
-comment "USB Device Class drivers"
-	depends on USB
-
 config USB_AUDIO
 	tristate "USB Audio support"
 	depends on USB && SOUND
diff -Nru a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
--- a/drivers/usb/core/Kconfig	Thu Jul 31 10:07:11 2003
+++ b/drivers/usb/core/Kconfig	Thu Jul 31 10:07:11 2003
@@ -9,9 +9,6 @@
 	  of debug messages to the system log. Select this if you are having a
 	  problem with USB support and want to see more of what is going on.
 
-comment "Miscellaneous USB options"
-	depends on USB
-
 config USB_DEVICEFS
 	bool "USB device filesystem"
 	depends on USB
diff -Nru a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
--- a/drivers/usb/gadget/Kconfig	Thu Jul 31 10:07:11 2003
+++ b/drivers/usb/gadget/Kconfig	Thu Jul 31 10:07:11 2003
@@ -6,9 +6,12 @@
 # for 2.5 kbuild, drivers/usb/gadget/Kconfig
 # source this at the end of drivers/usb/Kconfig
 #
-menuconfig USB_GADGET
+menu "USB Gadgets"
+	depends on USB!=n
+
+config USB_GADGET
 	tristate "Support for USB Gadgets"
-	depends on EXPERIMENTAL
+	depends on USB && EXPERIMENTAL
 	help
 	   USB is a master/slave protocol, organized with one master
 	   host (such as a PC) controlling up to 127 peripheral devices.
@@ -149,4 +152,4 @@
 
 endchoice
 
-# endmenuconfig
+endmenu
diff -Nru a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
--- a/drivers/usb/host/Kconfig	Thu Jul 31 10:07:11 2003
+++ b/drivers/usb/host/Kconfig	Thu Jul 31 10:07:11 2003
@@ -1,8 +1,6 @@
 #
 # USB Host Controller Drivers
 #
-comment "USB Host Controller Drivers"
-	depends on USB
 
 config USB_EHCI_HCD
 	tristate "EHCI HCD (USB 2.0) support"
diff -Nru a/drivers/usb/image/Kconfig b/drivers/usb/image/Kconfig
--- a/drivers/usb/image/Kconfig	Thu Jul 31 10:07:11 2003
+++ b/drivers/usb/image/Kconfig	Thu Jul 31 10:07:11 2003
@@ -1,7 +1,7 @@
 #
 # USB Imageing devices configuration
 #
-comment "USB Imaging devices"
+menu "USB Imaging devices"
 	depends on USB
 
 config USB_MDC800
@@ -53,3 +53,4 @@
 	  The scanner will be accessible as a SCSI device.
 	  This can be compiled as a module, called hpusbscsi.
 
+endmenu
diff -Nru a/drivers/usb/input/Kconfig b/drivers/usb/input/Kconfig
--- a/drivers/usb/input/Kconfig	Thu Jul 31 10:07:11 2003
+++ b/drivers/usb/input/Kconfig	Thu Jul 31 10:07:11 2003
@@ -1,8 +1,10 @@
 #
 # USB Input driver configuration
 #
-comment "USB Human Interface Devices (HID)"
-	depends on USB
+menu "USB Input devices"
+
+comment "Input core support is needed for USB HID input layer or HIDBP support"
+	depends on USB && INPUT=n
 
 config USB_HID
 	tristate "USB Human Interface Device (full HID) support"
@@ -90,12 +92,10 @@
 
 	  If unsure, say Y.
 
-menu "USB HID Boot Protocol drivers"
-	depends on USB!=n && USB_HID!=y
 
 config USB_KBD
 	tristate "USB HIDBP Keyboard (simple Boot) support"
-	depends on USB && INPUT
+	depends on USB && INPUT && USB_HIDINPUT=n
 	---help---
 	  Say Y here only if you are absolutely sure that you don't want
 	  to use the generic HID driver for your USB keyboard and prefer
@@ -113,7 +113,7 @@
 
 config USB_MOUSE
 	tristate "USB HIDBP Mouse (simple Boot) support"
-	depends on USB && INPUT
+	depends on USB && INPUT && USB_HIDINPUT=n
 	---help---
 	  Say Y here only if you are absolutely sure that you don't want
 	  to use the generic HID driver for your USB keyboard and prefer
@@ -129,8 +129,6 @@
 
 	  If even remotely unsure, say N.
 
-endmenu
-
 config USB_AIPTEK
 	tristate "Aiptek 6000U/8000U tablet support"
 	depends on USB && INPUT
@@ -205,3 +203,4 @@
 	  The module will be called xpad.  If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.
 
+endmenu
diff -Nru a/drivers/usb/media/Kconfig b/drivers/usb/media/Kconfig
--- a/drivers/usb/media/Kconfig	Thu Jul 31 10:07:11 2003
+++ b/drivers/usb/media/Kconfig	Thu Jul 31 10:07:11 2003
@@ -1,8 +1,7 @@
 #
 # USB Multimedia device configuration
 #
-comment "USB Multimedia devices"
-	depends on USB
+menu "USB Multimedia devices"
 
 config USB_DABUSB
 	tristate "DABUSB driver"
@@ -194,3 +193,4 @@
 	  The module will be called stv680. If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.
 
+endmenu
diff -Nru a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
--- a/drivers/usb/misc/Kconfig	Thu Jul 31 10:07:11 2003
+++ b/drivers/usb/misc/Kconfig	Thu Jul 31 10:07:11 2003
@@ -1,8 +1,8 @@
 #
 # USB Miscellaneous driver configuration
 #
-comment "USB Miscellaneous drivers"
-	depends on USB
+menu "USB Miscellaneous drivers"
+	depends on USB!=n
 
 config USB_EMI26
 	tristate "EMI 2|6 USB Audio interface support"
@@ -117,4 +117,4 @@
 
 	  See <http://www.linux-usb.org/usbtest> for more information,
 	  including sample test device firmware and "how to use it".
-
+endmenu
diff -Nru a/drivers/usb/net/Kconfig b/drivers/usb/net/Kconfig
--- a/drivers/usb/net/Kconfig	Thu Jul 31 10:07:11 2003
+++ b/drivers/usb/net/Kconfig	Thu Jul 31 10:07:11 2003
@@ -1,8 +1,7 @@
 #
 # USB Network devices configuration
 #
-comment "USB Network adaptors"
-	depends on USB
+menu "USB Network devices"
 
 comment "Networking support is needed for USB Networking device support"
 	depends on USB && !NET
@@ -266,3 +265,4 @@
 	  IEEE 802 "local assignment" bit is set in the address, a "usbX"
 	  name is used instead.
 
+endmenu
diff -Nru a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
--- a/drivers/usb/serial/Kconfig	Thu Jul 31 10:07:11 2003
+++ b/drivers/usb/serial/Kconfig	Thu Jul 31 10:07:11 2003
@@ -2,7 +2,7 @@
 # USB Serial device configuration
 #
 
-menu "USB Serial Converter support"
+menu "USB Serial drivers"
 	depends on USB!=n
 
 config USB_SERIAL
diff -Nru a/drivers/usb/storage/Kconfig b/drivers/usb/storage/Kconfig
--- a/drivers/usb/storage/Kconfig	Thu Jul 31 10:07:11 2003
+++ b/drivers/usb/storage/Kconfig	Thu Jul 31 10:07:11 2003
@@ -1,6 +1,8 @@
 #
 # USB Storage driver configuration
 #
+menu "USB Mass Storage"
+
 comment "SCSI support is needed for USB Storage"
 	depends on USB && SCSI=n
 
@@ -91,4 +93,4 @@
 	help
 	  Say Y here to include additional code to support the Lexar Jumpshot
 	  USB CompactFlash reader.
-
+endmenu


