Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbUCXP13 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 10:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263748AbUCXP13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 10:27:29 -0500
Received: from linux-bt.org ([217.160.111.169]:59555 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S263740AbUCXP1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 10:27:18 -0500
Subject: Renaming of the USB HID driver
From: Marcel Holtmann <marcel@holtmann.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-Kf/ZZKZDcKfl93g4+so1"
Message-Id: <1080142026.2309.37.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 24 Mar 2004 16:27:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Kf/ZZKZDcKfl93g4+so1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Linus,

the concept of the HID parser is not really USB related anymore. The
Bluetooth people uses it too and actually it is really generic stuff. My
plan is to write a generic HID device/parser implementation, so that the
USB and Bluetooth subsystems only have to provide a transport layer. To
achieve this goal I wanna first rename the current hid.ko kernel module
to usbhid.ko for a nicer and transparent transition in the future. Greg
and Vojtech agreed on this module name change.

 Documentation/input/ff.txt       |    2 -
 Documentation/input/input.txt    |   70 +++++++++++++++++++--------------------
 Documentation/input/joystick.txt |    4 +-
 drivers/usb/input/Kconfig        |    2 -
 drivers/usb/input/Makefile       |   16 ++++----
 5 files changed, 47 insertions(+), 47 deletions(-)

The attached patch also fixes all references to the hid module in the
documentation and removes the .o suffix from every module name.

Please apply before you release the 2.6.5 final.

Regards

Marcel


--=-Kf/ZZKZDcKfl93g4+so1
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== Documentation/input/joystick.txt 1.4 vs edited =====
--- 1.4/Documentation/input/joystick.txt	Wed Mar  3 01:34:21 2004
+++ edited/Documentation/input/joystick.txt	Tue Mar 23 14:15:59 2004
@@ -182,7 +182,7 @@
 
   For other joystick types (more/less axes, hats, and buttons) support
 you'll need to specify the types either on the kernel command line or on the
-module command line, when inserting analog.o into the kernel. The
+module command line, when inserting analog into the kernel. The
 parameters are:
 
 	analog.map=<type1>,<type2>,<type3>,....
@@ -503,7 +503,7 @@
 
 3.21 I-Force devices 
 ~~~~~~~~~~~~~~~~~~~~
-  All I-Force devices are supported by the iforce.o module. This includes:
+  All I-Force devices are supported by the iforce module. This includes:
 
 * AVB Mag Turbo Force
 * AVB Top Shot Pegasus
===== Documentation/input/ff.txt 1.4 vs edited =====
--- 1.4/Documentation/input/ff.txt	Tue Mar 11 19:20:18 2003
+++ edited/Documentation/input/ff.txt	Tue Mar 23 14:13:26 2004
@@ -20,7 +20,7 @@
 2. Instructions to the user
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Here are instructions on how to compile and use the driver. In fact, this
-driver is the normal iforce.o, input.o and evdev.o drivers written by Vojtech
+driver is the normal iforce, input and evdev drivers written by Vojtech
 Pavlik, plus additions to support force feedback.
 
 Before you start, let me WARN you that some devices shake violently during the
===== Documentation/input/input.txt 1.5 vs edited =====
--- 1.5/Documentation/input/input.txt	Tue Dec 30 09:45:02 2003
+++ edited/Documentation/input/input.txt	Tue Mar 23 14:15:14 2004
@@ -35,18 +35,18 @@
 most of the existing input system, which is why it lives in
 drivers/input/ instead of drivers/usb/.
 
-  The centre of the input drivers is the input.o module, which must be
+  The centre of the input drivers is the input module, which must be
 loaded before any other of the input modules - it serves as a way of
 communication between two groups of modules:
 
 1.1 Device drivers
 ~~~~~~~~~~~~~~~~~~
   These modules talk to the hardware (for example via USB), and provide
-events (keystrokes, mouse movements) to the input.o module.
+events (keystrokes, mouse movements) to the input module.
 
 1.2 Event handlers
 ~~~~~~~~~~~~~~~~~~
-  These modules get events from input.o and pass them where needed via
+  These modules get events from input and pass them where needed via
 various interfaces - keystrokes to the kernel, mouse movements via a
 simulated PS/2 interface to GPM and X and so on.
 
@@ -56,12 +56,12 @@
 you'll have to load the following modules (or have them built in to the
 kernel):
 
-	input.o
-	mousedev.o
-	keybdev.o
-	usbcore.o
-	usb-uhci.o or usb-ohci.o or uhci.o
-	hid.o
+	input
+	mousedev
+	keybdev
+	usbcore
+	uhci_hcd or ohci_hcd or ehci_hcd
+	usbhid
 
   After this, the USB keyboard will work straight away, and the USB mouse
 will be available as a character device on major 13, minor 63:
@@ -98,9 +98,9 @@
 however not useful without being handled, so you also will need to use some
 of the modules from section 3.2.
 
-3.1.1 hid.o
-~~~~~~~~~~~
-  hid.o is the largest and most complex driver of the whole suite. It
+3.1.1 usbhid
+~~~~~~~~~~~~
+  usbhid is the largest and most complex driver of the whole suite. It
 handles all HID devices, and because there is a very wide variety of them,
 and because the USB HID specification isn't simple, it needs to be this big.
 
@@ -115,7 +115,7 @@
 the hiddev interface was designed. See Documentation/usb/hiddev.txt
 for more information about it.
 
-  The usage of the hid.o module is very simple, it takes no parameters,
+  The usage of the usbhid module is very simple, it takes no parameters,
 detects everything automatically and when a HID device is inserted, it
 detects it appropriately.
 
@@ -123,30 +123,30 @@
 device that doesn't work well. In that case #define DEBUG at the beginning
 of hid-core.c and send me the syslog traces.
 
-3.1.2 usbmouse.o
-~~~~~~~~~~~~~~~~
+3.1.2 usbmouse
+~~~~~~~~~~~~~~
   For embedded systems, for mice with broken HID descriptors and just any
-other use when the big hid.o wouldn't be a good choice, there is the
-usbmouse.c driver. It handles USB mice only. It uses a simpler HIDBP
+other use when the big usbhid wouldn't be a good choice, there is the
+usbmouse driver. It handles USB mice only. It uses a simpler HIDBP
 protocol. This also means the mice must support this simpler protocol. Not
-all do. If you don't have any strong reason to use this module, use hid.o
+all do. If you don't have any strong reason to use this module, use usbhid
 instead.
 
-3.1.3 usbkbd.o
-~~~~~~~~~~~~~~
-  Much like usbmouse.c, this module talks to keyboards with a simplified
+3.1.3 usbkbd
+~~~~~~~~~~~~
+  Much like usbmouse, this module talks to keyboards with a simplified
 HIDBP protocol. It's smaller, but doesn't support any extra special keys.
-Use hid.o instead if there isn't any special reason to use this.
+Use usbhid instead if there isn't any special reason to use this.
 
-3.1.4 wacom.o
-~~~~~~~~~~~~~
+3.1.4 wacom
+~~~~~~~~~~~
   This is a driver for Wacom Graphire and Intuos tablets. Not for Wacom
 PenPartner, that one is handled by the HID driver. Although the Intuos and
 Graphire tablets claim that they are HID tablets as well, they are not and
 thus need this specific driver.
 
-3.1.5 iforce.o
-~~~~~~~~~~~~~~~
+3.1.5 iforce
+~~~~~~~~~~~~
   A driver for I-Force joysticks and wheels, both over USB and RS232. 
 It includes ForceFeedback support now, even though Immersion
 Corp. considers the protocol a trade secret and won't disclose a word
@@ -157,8 +157,8 @@
   Event handlers distrubite the events from the devices to userland and
 kernel, as needed.
 
-3.2.1 keybdev.o
-~~~~~~~~~~~~~~~
+3.2.1 keybdev
+~~~~~~~~~~~~~
   keybdev is currently a rather ugly hack that translates the input
 events into architecture-specific keyboard raw mode (Xlated AT Set2 on
 x86), and passes them into the handle_scancode function of the
@@ -170,13 +170,13 @@
 best if keyboard.c would itself be an event handler. This is done in
 the input patch, available on the webpage mentioned below. 
 
-3.2.2 mousedev.o
-~~~~~~~~~~~~~~~~
+3.2.2 mousedev
+~~~~~~~~~~~~~~
   mousedev is also a hack to make programs that use mouse input
 work. It takes events from either mice or digitizers/tablets and makes
 a PS/2-style (a la /dev/psaux) mouse device available to the
 userland. Ideally, the programs could use a more reasonable interface,
-for example evdev.o
+for example evdev
 
   Mousedev devices in /dev/input (as shown above) are:
 
@@ -207,8 +207,8 @@
 these. You'll need ImPS/2 if you want to make use of a wheel on a USB
 mouse and ExplorerPS/2 if you want to use extra (up to 5) buttons. 
 
-3.2.3 joydev.o
-~~~~~~~~~~~~~~
+3.2.3 joydev
+~~~~~~~~~~~~
   Joydev implements v0.x and v1.x Linux joystick api, much like
 drivers/char/joystick/joystick.c used to in earlier versions. See
 joystick-api.txt in the Documentation subdirectory for details.  As
@@ -223,8 +223,8 @@
 
 And so on up to js31.
 
-3.2.4 evdev.o
-~~~~~~~~~~~~~
+3.2.4 evdev
+~~~~~~~~~~~
   evdev is the generic input event interface. It passes the events
 generated in the kernel straight to the program, with timestamps. The
 API is still evolving, but should be useable now. It's described in
===== drivers/usb/input/Kconfig 1.13 vs edited =====
--- 1.13/drivers/usb/input/Kconfig	Fri Feb 27 00:32:51 2004
+++ edited/drivers/usb/input/Kconfig	Mon Mar 22 14:42:37 2004
@@ -21,7 +21,7 @@
 	  If unsure, say Y.
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called hid.
+	  module will be called usbhid.
 
 comment "Input core support is needed for USB HID input layer or HIDBP support"
 	depends on USB && INPUT=n
===== drivers/usb/input/Makefile 1.17 vs edited =====
--- 1.17/drivers/usb/input/Makefile	Fri Feb 27 13:51:51 2004
+++ edited/drivers/usb/input/Makefile	Mon Mar 22 14:32:15 2004
@@ -3,32 +3,32 @@
 #
 
 # Multipart objects.
-hid-objs	:= hid-core.o
+usbhid-objs	:= hid-core.o
 
 # Optional parts of multipart objects.
 
 ifeq ($(CONFIG_USB_HIDDEV),y)
-	hid-objs        += hiddev.o
+	usbhid-objs	+= hiddev.o
 endif
 ifeq ($(CONFIG_USB_HIDINPUT),y)
-	hid-objs        += hid-input.o
+	usbhid-objs	+= hid-input.o
 endif
 ifeq ($(CONFIG_HID_PID),y)
-	hid-objs	+= pid.o
+	usbhid-objs	+= pid.o
 endif
 ifeq ($(CONFIG_LOGITECH_FF),y)
-	hid-objs	+= hid-lgff.o
+	usbhid-objs	+= hid-lgff.o
 endif
 ifeq ($(CONFIG_THRUSTMASTER_FF),y)
-	hid-objs	+= hid-tmff.o
+	usbhid-objs	+= hid-tmff.o
 endif
 ifeq ($(CONFIG_HID_FF),y)
-	hid-objs	+= hid-ff.o
+	usbhid-objs	+= hid-ff.o
 endif
 
 obj-$(CONFIG_USB_AIPTEK)	+= aiptek.o
 obj-$(CONFIG_USB_ATI_REMOTE)	+= ati_remote.o
-obj-$(CONFIG_USB_HID)		+= hid.o
+obj-$(CONFIG_USB_HID)		+= usbhid.o
 obj-$(CONFIG_USB_KBD)		+= usbkbd.o
 obj-$(CONFIG_USB_KBTAB)		+= kbtab.o
 obj-$(CONFIG_USB_MOUSE)		+= usbmouse.o

--=-Kf/ZZKZDcKfl93g4+so1--

