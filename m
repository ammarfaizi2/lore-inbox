Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVA3Pql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVA3Pql (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 10:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVA3Pql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 10:46:41 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:34995 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261714AbVA3Ppr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 10:45:47 -0500
Date: Sun, 30 Jan 2005 16:45:35 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] Kconfig: cleanup input menu
In-Reply-To: <200501292307.55193.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.61.0501301639171.30794@scrub.home>
References: <Pine.LNX.4.61.0501292320090.7662@scrub.home>
 <200501292127.29418.dtor_core@ameritech.net> <Pine.LNX.4.61.0501300409300.6118@scrub.home>
 <200501292307.55193.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 29 Jan 2005, Dmitry Torokhov wrote:

> Ok, what about making some submenus to manage number of options, like in
> the patch below?

I'd rather move it to the bottom and the menus had no dependencies.
Below is an alternative patch, which does a rather complete cleanup.

bye, Roman

---

 Kconfig             |   25 +++++++++++++------------
 gameport/Kconfig    |   48 ++++++++++++++++++++++--------------------------
 joystick/Kconfig    |   44 ++++++++++++++++++++------------------------
 keyboard/Kconfig    |   16 +++++++---------
 misc/Kconfig        |   15 ++++++++-------
 mouse/Kconfig       |   23 +++++++++++------------
 serio/Kconfig       |   29 ++++++++++++++---------------
 touchscreen/Kconfig |    9 +++++----
 8 files changed, 100 insertions(+), 109 deletions(-)

Index: linux-2.6.11/drivers/input/keyboard/Kconfig
===================================================================
--- linux-2.6.11.orig/drivers/input/keyboard/Kconfig	2005-01-30 15:43:04.069685134 +0100
+++ linux-2.6.11/drivers/input/keyboard/Kconfig	2005-01-30 16:33:35.137048741 +0100
@@ -1,20 +1,20 @@
 #
 # Input core configuration
 #
-config INPUT_KEYBOARD
+menuconfig INPUT_KEYBOARD
 	bool "Keyboards" if EMBEDDED || !X86
 	default y
-	depends on INPUT
 	help
 	  Say Y here, and a list of supported keyboards will be displayed.
 	  This option doesn't affect the kernel.
 
 	  If unsure, say Y.
 
+if INPUT_KEYBOARD
+
 config KEYBOARD_ATKBD
 	tristate "AT keyboard support" if !PC
 	default y
-	depends on INPUT && INPUT_KEYBOARD
 	select SERIO
 	select SERIO_LIBPS2
 	select SERIO_I8042 if PC
@@ -32,7 +32,6 @@ config KEYBOARD_ATKBD
 
 config KEYBOARD_SUNKBD
 	tristate "Sun Type 4 and Type 5 keyboard support"
-	depends on INPUT && INPUT_KEYBOARD
 	select SERIO
 	help
 	  Say Y here if you want to use a Sun Type 4 or Type 5 keyboard,
@@ -44,7 +43,6 @@ config KEYBOARD_SUNKBD
 
 config KEYBOARD_LKKBD
 	tristate "DECstation/VAXstation LK201/LK401 keyboard support"
-	depends on INPUT && INPUT_KEYBOARD
 	select SERIO
 	help
 	  Say Y here if you want to use a LK201 or LK401 style serial
@@ -57,7 +55,6 @@ config KEYBOARD_LKKBD
 
 config KEYBOARD_XTKBD
 	tristate "XT Keyboard support"
-	depends on INPUT && INPUT_KEYBOARD
 	select SERIO
 	help
 	  Say Y here if you want to use the old IBM PC/XT keyboard (or
@@ -70,7 +67,6 @@ config KEYBOARD_XTKBD
 
 config KEYBOARD_NEWTON
 	tristate "Newton keyboard"
-	depends on INPUT && INPUT_KEYBOARD
 	select SERIO
 	help
 	  Say Y here if you have a Newton keyboard on a serial port.
@@ -80,7 +76,7 @@ config KEYBOARD_NEWTON
 
 config KEYBOARD_MAPLE
 	tristate "Maple bus keyboard support"
-	depends on SH_DREAMCAST && INPUT && INPUT_KEYBOARD && MAPLE
+	depends on SH_DREAMCAST && MAPLE
 	help
 	  Say Y here if you have a DreamCast console running Linux and have
 	  a keyboard attached to its Maple bus.
@@ -90,10 +86,12 @@ config KEYBOARD_MAPLE
 
 config KEYBOARD_AMIGA
 	tristate "Amiga keyboard"
-	depends on AMIGA && INPUT && INPUT_KEYBOARD
+	depends on AMIGA
 	help
 	  Say Y here if you are running Linux on any AMIGA and have a keyboard
 	  attached.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called amikbd.
+
+endif
Index: linux-2.6.11/drivers/input/serio/Kconfig
===================================================================
--- linux-2.6.11.orig/drivers/input/serio/Kconfig	2005-01-30 15:43:04.069685134 +0100
+++ linux-2.6.11/drivers/input/serio/Kconfig	2005-01-30 16:29:01.445229130 +0100
@@ -2,11 +2,11 @@
 # Input core configuration
 #
 config SERIO
-	tristate "Serial i/o support" if EMBEDDED || !X86
+	tristate "Serial I/O support" if EMBEDDED || !X86
 	default y
 	---help---
 	  Say Yes here if you have any input device that uses serial I/O to
-	  communicate with the system. This includes the 
+	  communicate with the system. This includes the
 	  		* standard AT keyboard and PS/2 mouse *
 	  as well as serial mice, Sun keyboards, some joysticks and 6dof
 	  devices and more.
@@ -16,10 +16,11 @@ config SERIO
 	  To compile this driver as a module, choose M here: the
 	  module will be called serio.
 
+if SERIO
+
 config SERIO_I8042
 	tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
 	default y
-	select SERIO
 	depends on !PARISC && (!ARM || ARCH_SHARK || FOOTBRIDGE_HOST) && !M68K
 	---help---
 	  i8042 is the chip over which the standard AT keyboard and PS/2
@@ -34,7 +35,6 @@ config SERIO_I8042
 config SERIO_SERPORT
 	tristate "Serial port line discipline"
 	default y
-	depends on SERIO
 	---help---
 	  Say Y here if you plan to use an input device (mouse, joystick,
 	  tablet, 6dof) that communicates over the RS232 serial (COM) port.
@@ -48,7 +48,6 @@ config SERIO_SERPORT
 
 config SERIO_CT82C710
 	tristate "ct82c710 Aux port controller"
-	depends on SERIO
 	depends on !PARISC
 	---help---
 	  Say Y here if you have a Texas Instruments TravelMate notebook
@@ -62,11 +61,11 @@ config SERIO_CT82C710
 
 config SERIO_Q40KBD
 	tristate "Q40 keyboard controller"
-	depends on Q40 && SERIO
+	depends on Q40
 
 config SERIO_PARKBD
 	tristate "Parallel port keyboard adapter"
-	depends on SERIO && PARPORT
+	depends on PARPORT
 	---help---
 	  Say Y here if you built a simple parallel port adapter to attach
 	  an additional AT keyboard, XT keyboard or PS/2 mouse.
@@ -80,7 +79,7 @@ config SERIO_PARKBD
 
 config SERIO_RPCKBD
 	tristate "Acorn RiscPC keyboard controller"
-	depends on (ARCH_ACORN || ARCH_CLPS7500) && SERIO
+	depends on ARCH_ACORN || ARCH_CLPS7500
 	default y
 	help
 	  Say Y here if you have the Acorn RiscPC and want to use an AT
@@ -91,15 +90,15 @@ config SERIO_RPCKBD
 
 config SERIO_AMBAKMI
 	tristate "AMBA KMI keyboard controller"
-	depends on ARM_AMBA && SERIO
+	depends on ARM_AMBA
 
 config SERIO_SA1111
 	tristate "Intel SA1111 keyboard controller"
-	depends on SA1111 && SERIO
+	depends on SA1111
 
 config SERIO_GSCPS2
 	tristate "HP GSC PS/2 keyboard and PS/2 mouse controller"
-	depends on GSC && SERIO
+	depends on GSC
 	default y
 	help
 	  This driver provides support for the PS/2 ports on PA-RISC machines
@@ -113,7 +112,7 @@ config SERIO_GSCPS2
 
 config SERIO_PCIPS2
 	tristate "PCI PS/2 keyboard and PS/2 mouse controller"
-	depends on PCI && SERIO
+	depends on PCI
 	help
 	  Say Y here if you have a Mobility Docking station with PS/2
 	  keyboard and mice ports.
@@ -123,7 +122,7 @@ config SERIO_PCIPS2
 
 config SERIO_MACEPS2
 	tristate "SGI O2 MACE PS/2 controller"
-	depends on SGI_IP32 && SERIO
+	depends on SGI_IP32
 	help
 	  Say Y here if you have SGI O2 workstation and want to use its
 	  PS/2 ports.
@@ -133,7 +132,6 @@ config SERIO_MACEPS2
 
 config SERIO_LIBPS2
 	tristate "PS/2 driver library" if EMBEDDED
-	depends on SERIO
 	help
 	  Say Y here if you are using a driver for device connected
 	  to a PS/2 port, such as PS/2 mouse or standard AT keyboard.
@@ -143,7 +141,6 @@ config SERIO_LIBPS2
 
 config SERIO_RAW
 	tristate "Raw access to serio ports"
-	depends on SERIO
 	help
 	  Say Y here if you want to have raw access to serio ports, such as
 	  AUX ports on i8042 keyboard controller. Each serio port that is
@@ -156,3 +153,5 @@ config SERIO_RAW
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called serio_raw.
+
+endif
Index: linux-2.6.11/drivers/input/gameport/Kconfig
===================================================================
--- linux-2.6.11.orig/drivers/input/gameport/Kconfig	2005-01-30 15:43:04.068685306 +0100
+++ linux-2.6.11/drivers/input/gameport/Kconfig	2005-01-30 16:27:26.925528339 +0100
@@ -19,30 +19,10 @@ config GAMEPORT
 	  To compile this driver as a module, choose M here: the
 	  module will be called gameport.
 
-
-# Yes, SOUND_GAMEPORT looks a bit odd. Yes, it ends up being turned on
-# in every .config. Please don't touch it. It is here to handle an
-# unusual dependency between GAMEPORT and sound drivers.
-#
-# Some sound drivers call gameport functions. If GAMEPORT is
-# not selected, empty stubs are provided for the functions and all is
-# well.
-# If GAMEPORT is built in, everything is fine.
-# If GAMEPORT is a module, however, it would need to be loaded for the
-# sound driver to be able to link properly. Therefore, the sound
-# driver must be a module as well in that case. Since there's no way
-# to express that directly in Kconfig, we use SOUND_GAMEPORT to
-# express it. SOUND_GAMEPORT boils down to "if GAMEPORT is 'm',
-# anything that depends on SOUND_GAMEPORT must be 'm' as well. if
-# GAMEPORT is 'y' or 'n', it can be anything".
-config SOUND_GAMEPORT
-	tristate
-	default y if GAMEPORT!=m
-	default m if GAMEPORT=m
+if GAMEPORT
 
 config GAMEPORT_NS558
 	tristate "Classic ISA and PnP gameport support"
-	depends on GAMEPORT
 	help
 	  Say Y here if you have an ISA or PnP gameport.
 
@@ -53,7 +33,6 @@ config GAMEPORT_NS558
 
 config GAMEPORT_L4
 	tristate "PDPI Lightning 4 gamecard support"
-	depends on GAMEPORT
 	help
 	  Say Y here if you have a PDPI Lightning 4 gamecard.
 
@@ -62,7 +41,6 @@ config GAMEPORT_L4
 
 config GAMEPORT_EMU10K1
 	tristate "SB Live and Audigy gameport support"
-	depends on GAMEPORT
 	help
 	  Say Y here if you have a SoundBlaster Live! or SoundBlaster
 	  Audigy card and want to use its gameport.
@@ -72,7 +50,6 @@ config GAMEPORT_EMU10K1
 
 config GAMEPORT_VORTEX
 	tristate "Aureal Vortex, Vortex 2 gameport support"
-	depends on GAMEPORT
 	help
 	  Say Y here if you have an Aureal Vortex 1 or 2  card and want
 	  to use its gameport.
@@ -82,9 +59,28 @@ config GAMEPORT_VORTEX
 
 config GAMEPORT_FM801
 	tristate "ForteMedia FM801 gameport support"
-	depends on GAMEPORT
 
 config GAMEPORT_CS461X
 	tristate "Crystal SoundFusion gameport support"
-	depends on GAMEPORT
 
+endif
+
+# Yes, SOUND_GAMEPORT looks a bit odd. Yes, it ends up being turned on
+# in every .config. Please don't touch it. It is here to handle an
+# unusual dependency between GAMEPORT and sound drivers.
+#
+# Some sound drivers call gameport functions. If GAMEPORT is
+# not selected, empty stubs are provided for the functions and all is
+# well.
+# If GAMEPORT is built in, everything is fine.
+# If GAMEPORT is a module, however, it would need to be loaded for the
+# sound driver to be able to link properly. Therefore, the sound
+# driver must be a module as well in that case. Since there's no way
+# to express that directly in Kconfig, we use SOUND_GAMEPORT to
+# express it. SOUND_GAMEPORT boils down to "if GAMEPORT is 'm',
+# anything that depends on SOUND_GAMEPORT must be 'm' as well. if
+# GAMEPORT is 'y' or 'n', it can be anything".
+config SOUND_GAMEPORT
+	tristate
+	default m if GAMEPORT=m
+	default y
Index: linux-2.6.11/drivers/input/Kconfig
===================================================================
--- linux-2.6.11.orig/drivers/input/Kconfig	2005-01-30 15:43:04.068685306 +0100
+++ linux-2.6.11/drivers/input/Kconfig	2005-01-30 16:14:56.122968311 +0100
@@ -5,7 +5,7 @@
 menu "Input device support"
 
 config INPUT
-	tristate "Input devices (needed for keyboard, mouse, ...)" if EMBEDDED
+	tristate "Generic input layer (needed for keyboard, mouse, ...)" if EMBEDDED
 	default y
 	---help---
 	  Say Y here if you have any input device (mouse, keyboard, tablet,
@@ -22,12 +22,13 @@ config INPUT
 	  To compile this driver as a module, choose M here: the
 	  module will be called input.
 
+if INPUT
+
 comment "Userland interfaces"
 
 config INPUT_MOUSEDEV
 	tristate "Mouse interface" if EMBEDDED
 	default y
-	depends on INPUT
 	---help---
 	  Say Y here if you want your mouse to be accessible as char devices
 	  13:32+ - /dev/input/mouseX and 13:63 - /dev/input/mice as an
@@ -74,7 +75,6 @@ config INPUT_MOUSEDEV_SCREEN_Y
 
 config INPUT_JOYDEV
 	tristate "Joystick interface"
-	depends on INPUT
 	---help---
 	  Say Y here if you want your joystick or gamepad to be
 	  accessible as char device 13:0+ - /dev/input/jsX device.
@@ -88,7 +88,6 @@ config INPUT_JOYDEV
 
 config INPUT_TSDEV
 	tristate "Touchscreen interface"
-	depends on INPUT
 	---help---
 	  Say Y here if you have an application that only can understand the
 	  Compaq touchscreen protocol for absolute pointer data. This is
@@ -111,7 +110,6 @@ config INPUT_TSDEV_SCREEN_Y
 
 config INPUT_EVDEV
 	tristate "Event interface"
-	depends on INPUT
 	help
 	  Say Y here if you want your input device events be accessible
 	  under char device 13:64+ - /dev/input/eventX in a generic way.
@@ -121,7 +119,6 @@ config INPUT_EVDEV
 
 config INPUT_EVBUG
 	tristate "Event debugging"
-	depends on INPUT
 	---help---
 	  Say Y here if you have a problem with the input subsystem and
 	  want all events (keypresses, mouse movements), to be output to
@@ -134,12 +131,6 @@ config INPUT_EVBUG
 	  To compile this driver as a module, choose M here: the
 	  module will be called evbug.
 
-comment "Input I/O drivers"
-
-source "drivers/input/gameport/Kconfig"
-
-source "drivers/input/serio/Kconfig"
-
 comment "Input Device Drivers"
 
 source "drivers/input/keyboard/Kconfig"
@@ -152,5 +143,15 @@ source "drivers/input/touchscreen/Kconfi
 
 source "drivers/input/misc/Kconfig"
 
+endif
+
+menu "Hardware I/O ports"
+
+source "drivers/input/serio/Kconfig"
+
+source "drivers/input/gameport/Kconfig"
+
+endmenu
+
 endmenu
 
Index: linux-2.6.11/drivers/input/touchscreen/Kconfig
===================================================================
--- linux-2.6.11.orig/drivers/input/touchscreen/Kconfig	2005-01-30 15:43:04.069685134 +0100
+++ linux-2.6.11/drivers/input/touchscreen/Kconfig	2005-01-30 16:34:22.676853842 +0100
@@ -1,18 +1,19 @@
 #
 # Mouse driver configuration
 #
-config INPUT_TOUCHSCREEN
+menuconfig INPUT_TOUCHSCREEN
 	bool "Touchscreens"
-	depends on INPUT
 	help
 	  Say Y here, and a list of supported touchscreens will be displayed.
 	  This option doesn't affect the kernel.
 
 	  If unsure, say Y.
 
+if INPUT_TOUCHSCREEN
+
 config TOUCHSCREEN_BITSY
 	tristate "Compaq iPAQ H3600 (Bitsy) touchscreen input driver"
-	depends on SA1100_BITSY && INPUT && INPUT_TOUCHSCREEN
+	depends on SA1100_BITSY
 	select SERIO
 	help
 	  Say Y here if you have the h3600 (Bitsy) touchscreen.
@@ -24,7 +25,6 @@ config TOUCHSCREEN_BITSY
 
 config TOUCHSCREEN_GUNZE
 	tristate "Gunze AHL-51S touchscreen"
-	depends on INPUT && INPUT_TOUCHSCREEN
 	select SERIO
 	help
 	  Say Y here if you have the Gunze AHL-51 touchscreen connected to
@@ -35,3 +35,4 @@ config TOUCHSCREEN_GUNZE
 	  To compile this driver as a module, choose M here: the
 	  module will be called gunze.
 
+endif
Index: linux-2.6.11/drivers/input/mouse/Kconfig
===================================================================
--- linux-2.6.11.orig/drivers/input/mouse/Kconfig	2005-01-30 15:43:04.069685134 +0100
+++ linux-2.6.11/drivers/input/mouse/Kconfig	2005-01-30 16:33:49.343599850 +0100
@@ -1,20 +1,20 @@
 #
 # Mouse driver configuration
 #
-config INPUT_MOUSE
-	bool "Mice"
+menuconfig INPUT_MOUSE
+	bool "Mouse"
 	default y
-	depends on INPUT
 	help
 	  Say Y here, and a list of supported mice will be displayed.
 	  This option doesn't affect the kernel.
 
 	  If unsure, say Y.
 
+if INPUT_MOUSE
+
 config MOUSE_PS2
 	tristate "PS/2 mouse"
 	default y
-	depends on INPUT && INPUT_MOUSE
 	select SERIO
 	select SERIO_LIBPS2
 	select SERIO_I8042 if PC
@@ -39,7 +39,6 @@ config MOUSE_PS2
 
 config MOUSE_SERIAL
 	tristate "Serial mouse"
-	depends on INPUT && INPUT_MOUSE
 	select SERIO
 	---help---
 	  Say Y here if you have a serial (RS-232, COM port) mouse connected
@@ -53,7 +52,7 @@ config MOUSE_SERIAL
 
 config MOUSE_INPORT
 	tristate "InPort/MS/ATIXL busmouse"
-	depends on INPUT && INPUT_MOUSE && ISA
+	depends on ISA
 	help
 	  Say Y here if you have an InPort, Microsoft or ATI XL busmouse.
 	  They are rather rare these days.
@@ -69,7 +68,7 @@ config MOUSE_ATIXL
 
 config MOUSE_LOGIBM
 	tristate "Logitech busmouse"
-	depends on INPUT && INPUT_MOUSE && ISA
+	depends on ISA
 	help
 	  Say Y here if you have a Logitech busmouse.
 	  They are rather rare these days.
@@ -79,7 +78,7 @@ config MOUSE_LOGIBM
 
 config MOUSE_PC110PAD
 	tristate "IBM PC110 touchpad"
-	depends on INPUT && INPUT_MOUSE && ISA
+	depends on ISA
 	help
 	  Say Y if you have the IBM PC-110 micro-notebook and want its
 	  touchpad supported.
@@ -89,7 +88,7 @@ config MOUSE_PC110PAD
 
 config MOUSE_MAPLE
 	tristate "Maple bus mouse"
-	depends on SH_DREAMCAST && INPUT && INPUT_MOUSE && MAPLE
+	depends on SH_DREAMCAST && MAPLE
 	help
 	  Say Y if you have a DreamCast console and a mouse attached to
 	  its Maple bus.
@@ -99,7 +98,7 @@ config MOUSE_MAPLE
 
 config MOUSE_AMIGA
 	tristate "Amiga mouse"
-	depends on AMIGA && INPUT && INPUT_MOUSE
+	depends on AMIGA
 	help
 	  Say Y here if you have an Amiga and want its native mouse
 	  supported by the kernel.
@@ -109,7 +108,7 @@ config MOUSE_AMIGA
 
 config MOUSE_RISCPC
 	tristate "Acorn RiscPC mouse"
-	depends on ARCH_ACORN && INPUT && INPUT_MOUSE
+	depends on ARCH_ACORN
 	help
 	  Say Y here if you have the Acorn RiscPC computer and want its
 	  native mouse supported.
@@ -119,7 +118,6 @@ config MOUSE_RISCPC
 
 config MOUSE_VSXXXAA
 	tristate "DEC VSXXX-AA/GA mouse and VSXXX-AB tablet"
-	depends on INPUT && INPUT_MOUSE
 	select SERIO
 	help
 	  Say Y (or M) if you want to use a DEC VSXXX-AA (hockey
@@ -129,3 +127,4 @@ config MOUSE_VSXXXAA
 	  described in the source file). This driver also works with the
 	  digitizer (VSXXX-AB) DEC produced.
 
+endif
Index: linux-2.6.11/drivers/input/joystick/Kconfig
===================================================================
--- linux-2.6.11.orig/drivers/input/joystick/Kconfig	2005-01-30 15:43:04.068685306 +0100
+++ linux-2.6.11/drivers/input/joystick/Kconfig	2005-01-30 16:34:09.455133028 +0100
@@ -1,9 +1,8 @@
 #
 # Joystick driver configuration
 #
-config INPUT_JOYSTICK
+menuconfig INPUT_JOYSTICK
 	bool "Joysticks"
-	depends on INPUT
 	help
 	  If you have a joystick, 6dof controller, gamepad, steering wheel,
 	  weapon control system or something like that you can say Y here
@@ -13,9 +12,11 @@ config INPUT_JOYSTICK
 	  Please read the file <file:Documentation/input/joystick.txt> which
 	  contains more information.
 
+if INPUT_JOYSTICK
+
 config JOYSTICK_ANALOG
 	tristate "Classic PC analog joysticks and gamepads"
-	depends on INPUT && INPUT_JOYSTICK && GAMEPORT
+	select GAMEPORT
 	---help---
 	  Say Y here if you have a joystick that connects to the PC
 	  gameport. In addition to the usual PC analog joystick, this driver
@@ -32,7 +33,7 @@ config JOYSTICK_ANALOG
 
 config JOYSTICK_A3D
 	tristate "Assasin 3D and MadCatz Panther devices"
-	depends on INPUT && INPUT_JOYSTICK && GAMEPORT
+	select GAMEPORT
 	help
 	  Say Y here if you have an FPGaming or MadCatz controller using the
 	  A3D protocol over the PC gameport.
@@ -42,7 +43,7 @@ config JOYSTICK_A3D
 
 config JOYSTICK_ADI
 	tristate "Logitech ADI digital joysticks and gamepads"
-	depends on INPUT && INPUT_JOYSTICK && GAMEPORT
+	select GAMEPORT
 	help
 	  Say Y here if you have a Logitech controller using the ADI
 	  protocol over the PC gameport.
@@ -52,7 +53,7 @@ config JOYSTICK_ADI
 
 config JOYSTICK_COBRA
 	tristate "Creative Labs Blaster Cobra gamepad"
-	depends on INPUT && INPUT_JOYSTICK && GAMEPORT
+	select GAMEPORT
 	help
 	  Say Y here if you have a Creative Labs Blaster Cobra gamepad.
 
@@ -61,7 +62,7 @@ config JOYSTICK_COBRA
 
 config JOYSTICK_GF2K
 	tristate "Genius Flight2000 Digital joysticks and gamepads"
-	depends on INPUT && INPUT_JOYSTICK && GAMEPORT
+	select GAMEPORT
 	help
 	  Say Y here if you have a Genius Flight2000 or MaxFighter digitally
 	  communicating joystick or gamepad.
@@ -71,7 +72,7 @@ config JOYSTICK_GF2K
 
 config JOYSTICK_GRIP
 	tristate "Gravis GrIP joysticks and gamepads"
-	depends on INPUT && INPUT_JOYSTICK && GAMEPORT
+	select GAMEPORT
 	help
 	  Say Y here if you have a Gravis controller using the GrIP protocol
 	  over the PC gameport.
@@ -81,7 +82,7 @@ config JOYSTICK_GRIP
 
 config JOYSTICK_GRIP_MP
 	tristate "Gravis GrIP MultiPort"
-	depends on INPUT && INPUT_JOYSTICK && GAMEPORT
+	select GAMEPORT
 	help
 	  Say Y here if you have the original Gravis GrIP MultiPort, a hub
 	  that connects to the gameport and you connect gamepads to it.
@@ -91,7 +92,7 @@ config JOYSTICK_GRIP_MP
 
 config JOYSTICK_GUILLEMOT
 	tristate "Guillemot joysticks and gamepads"
-	depends on INPUT && INPUT_JOYSTICK && GAMEPORT
+	select GAMEPORT
 	help
 	  Say Y here if you have a Guillemot joystick using a digital
 	  protocol over the PC gameport.
@@ -101,7 +102,7 @@ config JOYSTICK_GUILLEMOT
 
 config JOYSTICK_INTERACT
 	tristate "InterAct digital joysticks and gamepads"
-	depends on INPUT && INPUT_JOYSTICK && GAMEPORT
+	select GAMEPORT
 	help
 	  Say Y here if you have an InterAct gameport or joystick
 	  communicating digitally over the gameport.
@@ -111,7 +112,7 @@ config JOYSTICK_INTERACT
 
 config JOYSTICK_SIDEWINDER
 	tristate "Microsoft SideWinder digital joysticks and gamepads"
-	depends on INPUT && INPUT_JOYSTICK && GAMEPORT
+	select GAMEPORT
 	help
 	  Say Y here if you have a Microsoft controller using the Digital
 	  Overdrive protocol over PC gameport.
@@ -121,7 +122,7 @@ config JOYSTICK_SIDEWINDER
 
 config JOYSTICK_TMDC
 	tristate "ThrustMaster DirectConnect joysticks and gamepads"
-	depends on INPUT && INPUT_JOYSTICK && GAMEPORT
+	select GAMEPORT
 	help
 	  Say Y here if you have a ThrustMaster controller using the
 	  DirectConnect (BSP) protocol over the PC gameport.
@@ -133,7 +134,6 @@ source "drivers/input/joystick/iforce/Kc
 
 config JOYSTICK_WARRIOR
 	tristate "Logitech WingMan Warrior joystick"
-	depends on INPUT && INPUT_JOYSTICK
 	select SERIO
 	help
 	  Say Y here if you have a Logitech WingMan Warrior joystick connected
@@ -144,7 +144,6 @@ config JOYSTICK_WARRIOR
 
 config JOYSTICK_MAGELLAN
 	tristate "LogiCad3d Magellan/SpaceMouse 6dof controllers"
-	depends on INPUT && INPUT_JOYSTICK
 	select SERIO
 	help
 	  Say Y here if you have a Magellan or Space Mouse 6DOF controller
@@ -155,7 +154,6 @@ config JOYSTICK_MAGELLAN
 
 config JOYSTICK_SPACEORB
 	tristate "SpaceTec SpaceOrb/Avenger 6dof controllers"
-	depends on INPUT && INPUT_JOYSTICK
 	select SERIO
 	help
 	  Say Y here if you have a SpaceOrb 360 or SpaceBall Avenger 6DOF
@@ -166,7 +164,6 @@ config JOYSTICK_SPACEORB
 
 config JOYSTICK_SPACEBALL
 	tristate "SpaceTec SpaceBall 6dof controllers"
-	depends on INPUT && INPUT_JOYSTICK
 	select SERIO
 	help
 	  Say Y here if you have a SpaceTec SpaceBall 2003/3003/4000 FLX
@@ -178,7 +175,6 @@ config JOYSTICK_SPACEBALL
 
 config JOYSTICK_STINGER
 	tristate "Gravis Stinger gamepad"
-	depends on INPUT && INPUT_JOYSTICK
 	select SERIO
 	help
 	  Say Y here if you have a Gravis Stinger connected to one of your
@@ -189,7 +185,6 @@ config JOYSTICK_STINGER
 
 config JOYSTICK_TWIDDLER
 	tristate "Twiddler as a joystick"
-	depends on INPUT && INPUT_JOYSTICK
 	select SERIO
 	help
 	  Say Y here if you have a Handykey Twiddler connected to your
@@ -200,7 +195,7 @@ config JOYSTICK_TWIDDLER
 
 config JOYSTICK_DB9
 	tristate "Multisystem, Sega Genesis, Saturn joysticks and gamepads"
-	depends on INPUT && INPUT_JOYSTICK && PARPORT
+	depends on PARPORT
 	---help---
 	  Say Y here if you have a Sega Master System gamepad, Sega Genesis
 	  gamepad, Sega Saturn gamepad, or a Multisystem -- Atari, Amiga,
@@ -213,7 +208,7 @@ config JOYSTICK_DB9
 
 config JOYSTICK_GAMECON
 	tristate "Multisystem, NES, SNES, N64, PSX joysticks and gamepads"
-	depends on INPUT && INPUT_JOYSTICK && PARPORT
+	depends on PARPORT
 	---help---
 	  Say Y here if you have a Nintendo Entertainment System gamepad,
 	  Super Nintendo Entertainment System gamepad, Nintendo 64 gamepad,
@@ -227,7 +222,7 @@ config JOYSTICK_GAMECON
 
 config JOYSTICK_TURBOGRAFX
 	tristate "Multisystem joysticks via TurboGraFX device"
-	depends on INPUT && INPUT_JOYSTICK && PARPORT
+	depends on PARPORT
 	help
 	  Say Y here if you have the TurboGraFX interface by Steffen Schwenke,
 	  and want to use it with Multisystem -- Atari, Amiga, Commodore,
@@ -239,7 +234,7 @@ config JOYSTICK_TURBOGRAFX
 
 config JOYSTICK_AMIGA
 	tristate "Amiga joysticks"
-	depends on AMIGA && INPUT && INPUT_JOYSTICK
+	depends on AMIGA
 	help
 	  Say Y here if you have an Amiga with a digital joystick connected
 	  to it.
@@ -249,7 +244,7 @@ config JOYSTICK_AMIGA
 
 config JOYSTICK_JOYDUMP
 	tristate "Gameport data dumper"
-	depends on INPUT && INPUT_JOYSTICK && GAMEPORT
+	select GAMEPORT
 	help
 	  Say Y here if you want to dump data from your joystick into the system
 	  log for debugging purposes. Say N if you are making a production
@@ -258,3 +253,4 @@ config JOYSTICK_JOYDUMP
 	  To compile this driver as a module, choose M here: the
 	  module will be called joydump.
 
+endif
Index: linux-2.6.11/drivers/input/misc/Kconfig
===================================================================
--- linux-2.6.11.orig/drivers/input/misc/Kconfig	2005-01-30 15:43:04.069685134 +0100
+++ linux-2.6.11/drivers/input/misc/Kconfig	2005-01-30 16:34:47.717537219 +0100
@@ -1,9 +1,8 @@
 #
 # Input misc drivers configuration
 #
-config INPUT_MISC
-	bool "Misc"
-	depends on INPUT
+menuconfig INPUT_MISC
+	bool "Miscellaneous devices"
 	help
 	  Say Y here, and a list of miscellaneous input drivers will be displayed.
 	  Everything that didn't fit into the other categories is here. This option
@@ -11,9 +10,11 @@ config INPUT_MISC
 
 	  If unsure, say Y.
 
+if INPUT_MISC
+
 config INPUT_PCSPKR
 	tristate "PC Speaker support"
-	depends on (ALPHA || X86 || X86_64 || MIPS || PPC_PREP || PPC_CHRP || PPC_PSERIES) && INPUT && INPUT_MISC
+	depends on ALPHA || X86 || X86_64 || MIPS || PPC_PREP || PPC_CHRP || PPC_PSERIES
 	help
 	  Say Y here if you want the standard PC Speaker to be used for
 	  bells and whistles.
@@ -25,7 +26,7 @@ config INPUT_PCSPKR
 
 config INPUT_SPARCSPKR
 	tristate "SPARC Speaker support"
-	depends on (SPARC32 || SPARC64) && INPUT && INPUT_MISC && PCI
+	depends on PCI && (SPARC32 || SPARC64)
 	help
 	  Say Y here if you want the standard Speaker on Sparc PCI systems
 	  to be used for bells and whistles.
@@ -37,11 +38,10 @@ config INPUT_SPARCSPKR
 
 config INPUT_M68K_BEEP
 	tristate "M68k Beeper support"
-	depends on M68K && INPUT && INPUT_MISC
+	depends on M68K
 
 config INPUT_UINPUT
 	tristate "User level driver support"
-	depends on INPUT && INPUT_MISC
 	help
 	  Say Y here if you want to support user level drivers for input
 	  subsystem accessible under char device 10:223 - /dev/input/uinput.
@@ -49,3 +49,4 @@ config INPUT_UINPUT
 	  To compile this driver as a module, choose M here: the
 	  module will be called uinput.
 
+endif
