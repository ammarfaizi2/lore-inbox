Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVA3EI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVA3EI0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 23:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVA3EI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 23:08:26 -0500
Received: from smtp817.mail.sc5.yahoo.com ([66.163.170.3]:5033 "HELO
	smtp817.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261644AbVA3EH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 23:07:58 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 6/8] Kconfig: cleanup input menu
Date: Sat, 29 Jan 2005 23:07:54 -0500
User-Agent: KMail/1.7.2
Cc: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0501292320090.7662@scrub.home> <200501292127.29418.dtor_core@ameritech.net> <Pine.LNX.4.61.0501300409300.6118@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0501300409300.6118@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501292307.55193.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 January 2005 22:22, Roman Zippel wrote:
> Hi,
> 
> On Sat, 29 Jan 2005, Dmitry Torokhov wrote:
> 
> > Well, with the current Kconfig I can de-select INPUT and still select
> > serio and serio_raw and access my AUX port via /dev/psaux. I don't know
> > if anyone would really do it, but why not?
> > 
> > Btw, what was the point of your patch?
> 
> See the subject. The current input Kconfig menu is already quite complex 
> for a lot of people, we don't have to confuse them further with a chaotic 
> menu structure. I only did the minimal fixes to get it into proper shape 
> with an acceptable compromise. Feel free to take it from here to also make 
> it technically correct.
> 

Ok, what about making some submenus to manage number of options, like in
the patch below?

-- 
Dmitry

===== drivers/input/Kconfig 1.8 vs edited =====
--- 1.8/drivers/input/Kconfig	2005-01-15 17:31:06 -05:00
+++ edited/drivers/input/Kconfig	2005-01-29 22:53:30 -05:00
@@ -4,8 +4,14 @@
 
 menu "Input device support"
 
+comment "Hardware I/O ports"
+
+source "drivers/input/serio/Kconfig"
+
+source "drivers/input/gameport/Kconfig"
+
 config INPUT
-	tristate "Input devices (needed for keyboard, mouse, ...)" if EMBEDDED
+	tristate "Generic input layer (needed for keyboard, mouse, ...)" if EMBEDDED
 	default y
 	---help---
 	  Say Y here if you have any input device (mouse, keyboard, tablet,
@@ -23,6 +29,7 @@
 	  module will be called input.
 
 comment "Userland interfaces"
+	depends on INPUT
 
 config INPUT_MOUSEDEV
 	tristate "Mouse interface" if EMBEDDED
@@ -134,13 +141,8 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called evbug.
 
-comment "Input I/O drivers"
-
-source "drivers/input/gameport/Kconfig"
-
-source "drivers/input/serio/Kconfig"
-
 comment "Input Device Drivers"
+	depends on INPUT
 
 source "drivers/input/keyboard/Kconfig"
 
===== drivers/input/gameport/Kconfig 1.5 vs edited =====
--- 1.5/drivers/input/gameport/Kconfig	2005-01-08 00:43:50 -05:00
+++ edited/drivers/input/gameport/Kconfig	2005-01-29 22:50:38 -05:00
@@ -1,6 +1,8 @@
 #
 # Gameport configuration
 #
+menu "Gameport support"
+
 config GAMEPORT
 	tristate "Gameport support"
 	---help---
@@ -88,3 +90,4 @@
 	tristate "Crystal SoundFusion gameport support"
 	depends on GAMEPORT
 
+endmenu
===== drivers/input/joystick/Kconfig 1.10 vs edited =====
--- 1.10/drivers/input/joystick/Kconfig	2005-01-27 02:13:43 -05:00
+++ edited/drivers/input/joystick/Kconfig	2005-01-29 22:59:51 -05:00
@@ -1,6 +1,8 @@
 #
 # Joystick driver configuration
 #
+menu "Joysticks"
+
 config INPUT_JOYSTICK
 	bool "Joysticks"
 	depends on INPUT
@@ -258,3 +260,4 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called joydump.
 
+endmenu
===== drivers/input/keyboard/Kconfig 1.15 vs edited =====
--- 1.15/drivers/input/keyboard/Kconfig	2004-09-22 01:48:17 -05:00
+++ edited/drivers/input/keyboard/Kconfig	2005-01-29 22:59:34 -05:00
@@ -1,6 +1,8 @@
 #
 # Input core configuration
 #
+menu "Keyboards"
+
 config INPUT_KEYBOARD
 	bool "Keyboards" if EMBEDDED || !X86
 	default y
@@ -97,3 +99,5 @@
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called amikbd.
+
+endmenu
===== drivers/input/misc/Kconfig 1.11 vs edited =====
--- 1.11/drivers/input/misc/Kconfig	2005-01-15 17:31:06 -05:00
+++ edited/drivers/input/misc/Kconfig	2005-01-29 23:04:17 -05:00
@@ -1,6 +1,8 @@
 #
 # Input misc drivers configuration
 #
+menu "Miscellaneous devices"
+
 config INPUT_MISC
 	bool "Misc"
 	depends on INPUT
@@ -49,3 +51,4 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called uinput.
 
+endmenu
===== drivers/input/mouse/Kconfig 1.21 vs edited =====
--- 1.21/drivers/input/mouse/Kconfig	2005-01-15 17:31:06 -05:00
+++ edited/drivers/input/mouse/Kconfig	2005-01-29 23:01:25 -05:00
@@ -1,6 +1,8 @@
 #
 # Mouse driver configuration
 #
+menu "Mice"
+
 config INPUT_MOUSE
 	bool "Mice"
 	default y
@@ -129,3 +131,4 @@
 	  described in the source file). This driver also works with the
 	  digitizer (VSXXX-AB) DEC produced.
 
+endmenu
===== drivers/input/serio/Kconfig 1.21 vs edited =====
--- 1.21/drivers/input/serio/Kconfig	2005-01-04 11:16:51 -05:00
+++ edited/drivers/input/serio/Kconfig	2005-01-29 22:48:56 -05:00
@@ -1,12 +1,14 @@
 #
 # Input core configuration
 #
+menu "PS/2 and serial port support"
+
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
@@ -19,8 +21,7 @@
 config SERIO_I8042
 	tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
 	default y
-	select SERIO
-	depends on !PARISC && (!ARM || ARCH_SHARK || FOOTBRIDGE_HOST) && !M68K
+	depends on SERIO && !PARISC && (!ARM || ARCH_SHARK || FOOTBRIDGE_HOST) && !M68K
 	---help---
 	  i8042 is the chip over which the standard AT keyboard and PS/2
 	  mouse are connected to the computer. If you use these devices,
@@ -156,3 +157,5 @@
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called serio_raw.
+
+endmenu
===== drivers/input/touchscreen/Kconfig 1.4 vs edited =====
--- 1.4/drivers/input/touchscreen/Kconfig	2003-09-24 22:34:24 -05:00
+++ edited/drivers/input/touchscreen/Kconfig	2005-01-29 23:00:16 -05:00
@@ -1,6 +1,8 @@
 #
 # Mouse driver configuration
 #
+menu "Touchscreens"
+
 config INPUT_TOUCHSCREEN
 	bool "Touchscreens"
 	depends on INPUT
@@ -35,3 +37,4 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called gunze.
 
+endmenu
