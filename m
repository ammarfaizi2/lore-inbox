Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290763AbSAaAPP>; Wed, 30 Jan 2002 19:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290766AbSAaAPG>; Wed, 30 Jan 2002 19:15:06 -0500
Received: from www.transvirtual.com ([206.14.214.140]:24585 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S290763AbSAaAOj>; Wed, 30 Jan 2002 19:14:39 -0500
Date: Wed, 30 Jan 2002 16:13:40 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@oss.sgi.com,
        Linux ARM mailing list 
	<linux-arm-kernel@lists.arm.linux.org.uk>
Subject: [PATCH] Migration to input api for keyboards
Message-ID: <Pine.LNX.4.10.10201301553260.7609-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

   As some on you know the input api drivers for the PS/2 keyboard/mice
have gone into the dj tree for 2.5.X. I need people on other platforms
besides ix86 to test it out. I made the following patch that forces the
use of the new input drivers so people can test it. Shortly this patch
will be placed into the DJ tree but before I do this I want to make sure
it works for all platforms. Here is the patch to do this. Thank you.  

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/

diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/arch/arm/config.in linux/arch/arm/config.in
--- linux-2.5.2-dj7/arch/arm/config.in	Tue Jan 29 17:36:34 2002
+++ linux/arch/arm/config.in	Wed Jan 30 16:04:13 2002
@@ -611,11 +611,6 @@
    mainmenu_option next_comment
    comment 'Console drivers'
    # Select the keyboard type for this architecture.
-   if [ "$CONFIG_FOOTBRIDGE_HOST" = "y" -o \
-        "$CONFIG_ARCH_CLPS7500" = "y" -o   \
-        "$CONFIG_ARCH_SHARK" = "y" ]; then
-      define_bool CONFIG_PC_KEYB y
-   fi
    if [ "$CONFIG_ARCH_INTEGRATOR" = "y" ]; then
       define_bool CONFIG_KMI_KEYB y
       define_bool CONFIG_KMI_MOUSE y
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/arch/arm/def-configs/clps7500 linux/arch/arm/def-configs/clps7500
--- linux-2.5.2-dj7/arch/arm/def-configs/clps7500	Fri Nov 30 11:46:09 2001
+++ linux/arch/arm/def-configs/clps7500	Wed Jan 30 16:03:25 2002
@@ -319,7 +319,65 @@
 #
 # Input core support
 #
-# CONFIG_INPUT is not set
+CONFIG_INPUT=y
+CONFIG_INPUT_KEYBDEV=y
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_EVBUG is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+# CONFIG_GAMEPORT_NS558 is not set
+# CONFIG_GAMEPORT_L4 is not set
+# CONFIG_INPUT_EMU10K1 is not set
+# CONFIG_GAMEPORT_VORTEX is not set
+# CONFIG_GAMEPORT_FM801 is not set
+# CONFIG_GAMEPORT_CS461x is not set
+CONFIG_SERIO=y
+CONFIG_SERIO_I8042=y
+CONFIG_I8042_REG_BASE=60
+CONFIG_I8042_KBD_IRQ=1
+CONFIG_I8042_AUX_IRQ=12
+# CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_PARKBD is not set
+CONFIG_INPUT_KEYBOARD=y
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_PS2SERKBD is not set
+CONFIG_KEYBOARD_XTKBD=y
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=y
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_GUNZE is not set
+# CONFIG_MOUSE_INPORT is not set
+# CONFIG_MOUSE_LOGIBM is not set
+# CONFIG_MOUSE_PC110PAD is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_JOYSTICK_ANALOG is not set
+# CONFIG_JOYSTICK_A3D is not set
+# CONFIG_JOYSTICK_ADI is not set
+# CONFIG_JOYSTICK_COBRA is not set
+# CONFIG_JOYSTICK_GF2K is not set
+# CONFIG_JOYSTICK_GRIP is not set
+# CONFIG_JOYSTICK_GUILLEMOT is not set
+# CONFIG_JOYSTICK_INTERACT is not set
+# CONFIG_JOYSTICK_SIDEWINDER is not set
+# CONFIG_JOYSTICK_TMDC is not set
+# CONFIG_JOYSTICK_IFORCE_USB is not set
+# CONFIG_JOYSTICK_IFORCE_232 is not set
+# CONFIG_JOYSTICK_WARRIOR is not set
+# CONFIG_JOYSTICK_MAGELLAN is not set
+# CONFIG_JOYSTICK_SPACEORB is not set
+# CONFIG_JOYSTICK_SPACEBALL is not set
+# CONFIG_JOYSTICK_STINGER is not set
+# CONFIG_JOYSTICK_TWIDDLER is not set
+# CONFIG_JOYSTICK_DB9 is not set
+# CONFIG_JOYSTICK_GAMECON is not set
+# CONFIG_JOYSTICK_TURBOGRAFX is not set
 
 #
 # Character devices
@@ -463,7 +521,6 @@
 #
 # Console drivers
 #
-CONFIG_PC_KEYB=y
 CONFIG_PC_KEYMAP=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FB=y
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/arch/arm/def-configs/footbridge linux/arch/arm/def-configs/footbridge
--- linux-2.5.2-dj7/arch/arm/def-configs/footbridge	Fri Nov 30 11:46:09 2001
+++ linux/arch/arm/def-configs/footbridge	Wed Jan 30 15:40:04 2002
@@ -467,7 +467,65 @@
 #
 # Input core support
 #
-# CONFIG_INPUT is not set
+CONFIG_INPUT=y
+CONFIG_INPUT_KEYBDEV=y
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_EVBUG is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+# CONFIG_GAMEPORT_NS558 is not set
+# CONFIG_GAMEPORT_L4 is not set
+# CONFIG_INPUT_EMU10K1 is not set
+# CONFIG_GAMEPORT_VORTEX is not set
+# CONFIG_GAMEPORT_FM801 is not set
+# CONFIG_GAMEPORT_CS461x is not set
+CONFIG_SERIO=y
+CONFIG_SERIO_I8042=y
+CONFIG_I8042_REG_BASE=60
+CONFIG_I8042_KBD_IRQ=1
+CONFIG_I8042_AUX_IRQ=12
+# CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_PARKBD is not set
+CONFIG_INPUT_KEYBOARD=y
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_PS2SERKBD is not set
+CONFIG_KEYBOARD_XTKBD=y
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=y
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_GUNZE is not set
+# CONFIG_MOUSE_INPORT is not set
+# CONFIG_MOUSE_LOGIBM is not set
+# CONFIG_MOUSE_PC110PAD is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_JOYSTICK_ANALOG is not set
+# CONFIG_JOYSTICK_A3D is not set
+# CONFIG_JOYSTICK_ADI is not set
+# CONFIG_JOYSTICK_COBRA is not set
+# CONFIG_JOYSTICK_GF2K is not set
+# CONFIG_JOYSTICK_GRIP is not set
+# CONFIG_JOYSTICK_GUILLEMOT is not set
+# CONFIG_JOYSTICK_INTERACT is not set
+# CONFIG_JOYSTICK_SIDEWINDER is not set
+# CONFIG_JOYSTICK_TMDC is not set
+# CONFIG_JOYSTICK_IFORCE_USB is not set
+# CONFIG_JOYSTICK_IFORCE_232 is not set
+# CONFIG_JOYSTICK_WARRIOR is not set
+# CONFIG_JOYSTICK_MAGELLAN is not set
+# CONFIG_JOYSTICK_SPACEORB is not set
+# CONFIG_JOYSTICK_SPACEBALL is not set
+# CONFIG_JOYSTICK_STINGER is not set
+# CONFIG_JOYSTICK_TWIDDLER is not set
+# CONFIG_JOYSTICK_DB9 is not set
+# CONFIG_JOYSTICK_GAMECON is not set
+# CONFIG_JOYSTICK_TURBOGRAFX is not set
 
 #
 # Character devices
@@ -732,7 +790,6 @@
 #
 # Console drivers
 #
-CONFIG_PC_KEYB=y
 CONFIG_PC_KEYMAP=y
 CONFIG_VGA_CONSOLE=y
 CONFIG_FB=y
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/arch/arm/def-configs/shark linux/arch/arm/def-configs/shark
--- linux-2.5.2-dj7/arch/arm/def-configs/shark	Fri Nov 30 11:46:09 2001
+++ linux/arch/arm/def-configs/shark	Wed Jan 30 15:39:13 2002
@@ -493,11 +493,65 @@
 #
 # Input core support
 #
-# CONFIG_INPUT is not set
-# CONFIG_INPUT_KEYBDEV is not set
-# CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_INPUT=y
+CONFIG_INPUT_KEYBDEV=y
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_EVBUG is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+# CONFIG_GAMEPORT_NS558 is not set
+# CONFIG_GAMEPORT_L4 is not set
+# CONFIG_INPUT_EMU10K1 is not set
+# CONFIG_GAMEPORT_VORTEX is not set
+# CONFIG_GAMEPORT_FM801 is not set
+# CONFIG_GAMEPORT_CS461x is not set
+CONFIG_SERIO=y
+CONFIG_SERIO_I8042=y
+CONFIG_I8042_REG_BASE=60
+CONFIG_I8042_KBD_IRQ=1
+CONFIG_I8042_AUX_IRQ=12
+# CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_PARKBD is not set
+CONFIG_INPUT_KEYBOARD=y
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_PS2SERKBD is not set
+CONFIG_KEYBOARD_XTKBD=y
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=y
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_GUNZE is not set
+# CONFIG_MOUSE_INPORT is not set
+# CONFIG_MOUSE_LOGIBM is not set
+# CONFIG_MOUSE_PC110PAD is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_JOYSTICK_ANALOG is not set
+# CONFIG_JOYSTICK_A3D is not set
+# CONFIG_JOYSTICK_ADI is not set
+# CONFIG_JOYSTICK_COBRA is not set
+# CONFIG_JOYSTICK_GF2K is not set
+# CONFIG_JOYSTICK_GRIP is not set
+# CONFIG_JOYSTICK_GUILLEMOT is not set
+# CONFIG_JOYSTICK_INTERACT is not set
+# CONFIG_JOYSTICK_SIDEWINDER is not set
+# CONFIG_JOYSTICK_TMDC is not set
+# CONFIG_JOYSTICK_IFORCE_USB is not set
+# CONFIG_JOYSTICK_IFORCE_232 is not set
+# CONFIG_JOYSTICK_WARRIOR is not set
+# CONFIG_JOYSTICK_MAGELLAN is not set
+# CONFIG_JOYSTICK_SPACEORB is not set
+# CONFIG_JOYSTICK_SPACEBALL is not set
+# CONFIG_JOYSTICK_STINGER is not set
+# CONFIG_JOYSTICK_TWIDDLER is not set
+# CONFIG_JOYSTICK_DB9 is not set
+# CONFIG_JOYSTICK_GAMECON is not set
+# CONFIG_JOYSTICK_TURBOGRAFX is not set
 
 #
 # Character devices
@@ -744,7 +798,6 @@
 #
 # Console drivers
 #
-CONFIG_PC_KEYB=y
 CONFIG_PC_KEYMAP=y
 # CONFIG_VGA_CONSOLE is not set
 
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/arch/arm/defconfig linux/arch/arm/defconfig
--- linux-2.5.2-dj7/arch/arm/defconfig	Fri Nov 30 11:46:09 2001
+++ linux/arch/arm/defconfig	Wed Jan 30 15:41:42 2002
@@ -334,7 +334,65 @@
 #
 # Input core support
 #
-# CONFIG_INPUT is not set
+CONFIG_INPUT=y
+CONFIG_INPUT_KEYBDEV=y
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_EVBUG is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+# CONFIG_GAMEPORT_NS558 is not set
+# CONFIG_GAMEPORT_L4 is not set
+# CONFIG_INPUT_EMU10K1 is not set
+# CONFIG_GAMEPORT_VORTEX is not set
+# CONFIG_GAMEPORT_FM801 is not set
+# CONFIG_GAMEPORT_CS461x is not set
+CONFIG_SERIO=y
+CONFIG_SERIO_I8042=y
+CONFIG_I8042_REG_BASE=60
+CONFIG_I8042_KBD_IRQ=1
+CONFIG_I8042_AUX_IRQ=12
+# CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_PARKBD is not set
+CONFIG_INPUT_KEYBOARD=y
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_PS2SERKBD is not set
+CONFIG_KEYBOARD_XTKBD=y
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=y
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_GUNZE is not set
+# CONFIG_MOUSE_INPORT is not set
+# CONFIG_MOUSE_LOGIBM is not set
+# CONFIG_MOUSE_PC110PAD is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_JOYSTICK_ANALOG is not set
+# CONFIG_JOYSTICK_A3D is not set
+# CONFIG_JOYSTICK_ADI is not set
+# CONFIG_JOYSTICK_COBRA is not set
+# CONFIG_JOYSTICK_GF2K is not set
+# CONFIG_JOYSTICK_GRIP is not set
+# CONFIG_JOYSTICK_GUILLEMOT is not set
+# CONFIG_JOYSTICK_INTERACT is not set
+# CONFIG_JOYSTICK_SIDEWINDER is not set
+# CONFIG_JOYSTICK_TMDC is not set
+# CONFIG_JOYSTICK_IFORCE_USB is not set
+# CONFIG_JOYSTICK_IFORCE_232 is not set
+# CONFIG_JOYSTICK_WARRIOR is not set
+# CONFIG_JOYSTICK_MAGELLAN is not set
+# CONFIG_JOYSTICK_SPACEORB is not set
+# CONFIG_JOYSTICK_SPACEBALL is not set
+# CONFIG_JOYSTICK_STINGER is not set
+# CONFIG_JOYSTICK_TWIDDLER is not set
+# CONFIG_JOYSTICK_DB9 is not set
+# CONFIG_JOYSTICK_GAMECON is not set
+# CONFIG_JOYSTICK_TURBOGRAFX is not set
 
 #
 # Character devices
@@ -356,20 +414,6 @@
 # CONFIG_I2C is not set
 
 #
-# Mice
-#
-# CONFIG_BUSMOUSE is not set
-CONFIG_MOUSE=y
-CONFIG_PSMOUSE=y
-# CONFIG_82C710_MOUSE is not set
-# CONFIG_PC110_PAD is not set
-
-#
-# Joysticks
-#
-# CONFIG_JOYSTICK is not set
-
-#
 # Input core support is needed for joysticks
 #
 # CONFIG_QIC02_TAPE is not set
@@ -481,7 +525,6 @@
 # Console drivers
 #
 CONFIG_KMI_KEYB=y
-CONFIG_PC_KEYMAP=y
 CONFIG_VGA_CONSOLE=y
 # CONFIG_FB is not set
 
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/arch/mips/config.in linux/arch/mips/config.in
--- linux-2.5.2-dj7/arch/mips/config.in	Tue Jan 29 17:36:34 2002
+++ linux/arch/mips/config.in	Wed Jan 30 16:27:18 2002
@@ -49,8 +49,6 @@
        bool '    Enable Qtronix 990P Keyboard Support' CONFIG_QTRONIX_KEYBOARD
        if [ "$CONFIG_QTRONIX_KEYBOARD" = "y" ]; then
 	   define_bool CONFIG_IT8172_CIR y
-       else
-           bool '    Enable PS2 Keyboard Support ' CONFIG_PC_KEYB
        fi
        bool '    Enable Smart Card Reader 0 Support ' CONFIG_IT8172_SCR0
        bool '    Enable Smart Card Reader 1 Support ' CONFIG_IT8172_SCR1
@@ -81,7 +79,6 @@
 unset CONFIG_MIPS_JAZZ
 unset CONFIG_SWAP_IO_SPACE
 unset CONFIG_VIDEO_G364
-unset CONFIG_PC_KEYB
 
 define_bool CONFIG_MCA n
 define_bool CONFIG_SBUS n
@@ -112,7 +109,19 @@
    define_bool CONFIG_FB y
    define_bool CONFIG_FB_G364 y	
    define_bool CONFIG_MIPS_JAZZ y
-   define_bool CONFIG_PC_KEYB y
+   define_bool CONFIG_INPUT y
+   define_bool CONFIG_INPUT_KEYBDEV y
+   define_bool CONFIG_INPUT_MOUSEDEV y	
+   define_bool CONFIG_INPUT_MOUSEDEV_SCREEN_X 1024
+   define_bool CONFIG_INPUT_MOUSEDEV_SCREEN_Y 768
+   define_bool CONFIG_SERIO_I8042 y
+   define_bool CONFIG_I8042_REG_BASE 60
+   define_bool CONFIG_I8042_KBD_IRQ 1
+   define_bool CONFIG_I8042_AUX_IRQ 12
+   define_bool CONFIG_INPUT_KEYBOARD y
+   define_bool CONFIG_KEYBOARD_XTKBD y
+   define_bool CONFIG_INPUT_MOUSE y
+   define_bool CONFIG_MOUSE_PS2 y
    define_bool CONFIG_OLD_TIME_C y
 fi
 if [ "$CONFIG_ACER_PICA_61" = "y" ]; then
@@ -120,7 +129,19 @@
    define_bool CONFIG_I8259 y
    define_bool CONFIG_ISA y
    define_bool CONFIG_MIPS_JAZZ y
-   define_bool CONFIG_PC_KEYB y
+   define_bool CONFIG_INPUT y
+   define_bool CONFIG_INPUT_KEYBDEV y
+   define_bool CONFIG_INPUT_MOUSEDEV y
+   define_bool CONFIG_INPUT_MOUSEDEV_SCREEN_X 1024
+   define_bool CONFIG_INPUT_MOUSEDEV_SCREEN_Y 768
+   define_bool CONFIG_SERIO_I8042 y
+   define_bool CONFIG_I8042_REG_BASE 60
+   define_bool CONFIG_I8042_KBD_IRQ 1
+   define_bool CONFIG_I8042_AUX_IRQ 12
+   define_bool CONFIG_INPUT_KEYBOARD y
+   define_bool CONFIG_KEYBOARD_XTKBD y
+   define_bool CONFIG_INPUT_MOUSE y
+   define_bool CONFIG_MOUSE_PS2 y
    define_bool CONFIG_ROTTEN_IRQ y
    define_bool CONFIG_OLD_TIME_C y
 fi
@@ -145,7 +166,19 @@
 if [ "$CONFIG_SGI_IP22" = "y" ]; then
    define_bool CONFIG_ARC32 y
    define_bool CONFIG_BOARD_SCACHE y
-   define_bool CONFIG_PC_KEYB y
+   define_bool CONFIG_INPUT y
+   define_bool CONFIG_INPUT_KEYBDEV y
+   define_bool CONFIG_INPUT_MOUSEDEV y
+   define_bool CONFIG_INPUT_MOUSEDEV_SCREEN_X 1024
+   define_bool CONFIG_INPUT_MOUSEDEV_SCREEN_Y 768
+   define_bool CONFIG_SERIO_I8042 y
+   define_bool CONFIG_I8042_REG_BASE 60
+   define_bool CONFIG_I8042_KBD_IRQ 1
+   define_bool CONFIG_I8042_AUX_IRQ 12
+   define_bool CONFIG_INPUT_KEYBOARD y
+   define_bool CONFIG_KEYBOARD_XTKBD y
+   define_bool CONFIG_INPUT_MOUSE y
+   define_bool CONFIG_MOUSE_PS2 y
    define_bool CONFIG_SGI y
    define_bool CONFIG_NEW_IRQ y
    define_bool CONFIG_OLD_TIME_C y
@@ -154,7 +187,19 @@
    define_bool CONFIG_ARC32 y
    define_bool CONFIG_I8259 y
    define_bool CONFIG_ISA y
-   define_bool CONFIG_PC_KEYB y
+   define_bool CONFIG_INPUT y
+   define_bool CONFIG_INPUT_KEYBDEV y
+   define_bool CONFIG_INPUT_MOUSEDEV y
+   define_bool CONFIG_INPUT_MOUSEDEV_SCREEN_X 1024
+   define_bool CONFIG_INPUT_MOUSEDEV_SCREEN_Y 768
+   define_bool CONFIG_SERIO_I8042 y
+   define_bool CONFIG_I8042_REG_BASE 60
+   define_bool CONFIG_I8042_KBD_IRQ 1
+   define_bool CONFIG_I8042_AUX_IRQ 12
+   define_bool CONFIG_INPUT_KEYBOARD y
+   define_bool CONFIG_KEYBOARD_XTKBD y
+   define_bool CONFIG_INPUT_MOUSE y
+   define_bool CONFIG_MOUSE_PS2 y
    define_bool CONFIG_PCI y
    define_bool CONFIG_ROTTEN_IRQ y
    define_bool CONFIG_OLD_TIME_C y
@@ -163,7 +208,19 @@
    define_bool CONFIG_I8259 y
    define_bool CONFIG_ISA y
    define_bool CONFIG_PCI y
-   define_bool CONFIG_PC_KEYB y
+   define_bool CONFIG_INPUT y
+   define_bool CONFIG_INPUT_KEYBDEV y
+   define_bool CONFIG_INPUT_MOUSEDEV y
+   define_bool CONFIG_INPUT_MOUSEDEV_SCREEN_X 1024
+   define_bool CONFIG_INPUT_MOUSEDEV_SCREEN_Y 768
+   define_bool CONFIG_SERIO_I8042 y
+   define_bool CONFIG_I8042_REG_BASE 60
+   define_bool CONFIG_I8042_KBD_IRQ 1
+   define_bool CONFIG_I8042_AUX_IRQ 12
+   define_bool CONFIG_INPUT_KEYBOARD y
+   define_bool CONFIG_KEYBOARD_XTKBD y
+   define_bool CONFIG_INPUT_MOUSE y
+   define_bool CONFIG_MOUSE_PS2 y
    define_bool CONFIG_ROTTEN_IRQ y
    define_bool CONFIG_HAVE_STD_PC_SERIAL_PORT y
    define_bool CONFIG_OLD_TIME_C y
@@ -171,7 +228,19 @@
 if [ "$CONFIG_DDB5476"  = "y" ]; then
    define_bool CONFIG_ISA y
    define_bool CONFIG_PCI y
-   define_bool CONFIG_PC_KEYB y
+   define_bool CONFIG_INPUT y
+   define_bool CONFIG_INPUT_KEYBDEV y
+   define_bool CONFIG_INPUT_MOUSEDEV y
+   define_bool CONFIG_INPUT_MOUSEDEV_SCREEN_X 1024
+   define_bool CONFIG_INPUT_MOUSEDEV_SCREEN_Y 768
+   define_bool CONFIG_SERIO_I8042 y
+   define_bool CONFIG_I8042_REG_BASE 60
+   define_bool CONFIG_I8042_KBD_IRQ 1
+   define_bool CONFIG_I8042_AUX_IRQ 12
+   define_bool CONFIG_INPUT_KEYBOARD y
+   define_bool CONFIG_KEYBOARD_XTKBD y
+   define_bool CONFIG_INPUT_MOUSE y
+   define_bool CONFIG_MOUSE_PS2 y
    define_bool CONFIG_ROTTEN_IRQ y
    define_bool CONFIG_HAVE_STD_PC_SERIAL_PORT y
    define_bool CONFIG_NEW_TIME_C y
@@ -185,7 +254,19 @@
 if [ "$CONFIG_MIPS_ITE8172" = "y" ]; then
    define_bool CONFIG_PCI y
    define_bool CONFIG_IT8712 y
-   define_bool CONFIG_PC_KEYB y
+   define_bool CONFIG_INPUT y
+   define_bool CONFIG_INPUT_KEYBDEV y
+   define_bool CONFIG_INPUT_MOUSEDEV y
+   define_bool CONFIG_INPUT_MOUSEDEV_SCREEN_X 1024
+   define_bool CONFIG_INPUT_MOUSEDEV_SCREEN_Y 768
+   define_bool CONFIG_SERIO_I8042 y
+   define_bool CONFIG_I8042_REG_BASE 0x14000000 
+   define_bool CONFIG_I8042_KBD_IRQ 1
+   define_bool CONFIG_I8042_AUX_IRQ 12
+   define_bool CONFIG_INPUT_KEYBOARD y
+   define_bool CONFIG_KEYBOARD_XTKBD y
+   define_bool CONFIG_INPUT_MOUSE y
+   define_bool CONFIG_MOUSE_PS2 y
    define_bool CONFIG_NEW_PCI y
    define_bool CONFIG_PCI_AUTO y
 fi
@@ -197,7 +278,19 @@
    define_bool CONFIG_NEW_IRQ y
 fi
 if [ "$CONFIG_NINO" = "y" ]; then
-   define_bool CONFIG_PC_KEYB y
+   define_bool CONFIG_INPUT y
+   define_bool CONFIG_INPUT_KEYBDEV y
+   define_bool CONFIG_INPUT_MOUSEDEV y
+   define_bool CONFIG_INPUT_MOUSEDEV_SCREEN_X 1024
+   define_bool CONFIG_INPUT_MOUSEDEV_SCREEN_Y 768
+   define_bool CONFIG_SERIO_I8042 y
+   define_bool CONFIG_I8042_REG_BASE 60
+   define_bool CONFIG_I8042_KBD_IRQ 1
+   define_bool CONFIG_I8042_AUX_IRQ 12
+   define_bool CONFIG_INPUT_KEYBOARD y
+   define_bool CONFIG_KEYBOARD_XTKBD y
+   define_bool CONFIG_INPUT_MOUSE y
+   define_bool CONFIG_MOUSE_PS2 y
 fi
 
 if [ "$CONFIG_ISA" != "y" ]; then
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/arch/mips/defconfig linux/arch/mips/defconfig
--- linux-2.5.2-dj7/arch/mips/defconfig	Fri Nov 30 11:46:05 2001
+++ linux/arch/mips/defconfig	Wed Jan 30 16:33:16 2002
@@ -38,7 +38,6 @@
 # CONFIG_SBUS is not set
 CONFIG_ARC32=y
 CONFIG_BOARD_SCACHE=y
-CONFIG_PC_KEYB=y
 CONFIG_SGI=y
 CONFIG_NEW_IRQ=y
 CONFIG_OLD_TIME_C=y
@@ -361,17 +360,6 @@
 # CONFIG_MOUSE is not set
 
 #
-# Joysticks
-#
-# CONFIG_INPUT_GAMEPORT is not set
-
-#
-# Input core support is needed for gameports
-#
-
-#
-# Input core support is needed for joysticks
-#
 # CONFIG_QIC02_TAPE is not set
 
 #
@@ -629,11 +617,65 @@
 #
 # Input core support
 #
-# CONFIG_INPUT is not set
-# CONFIG_INPUT_KEYBDEV is not set
-# CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_INPUT=y
+CONFIG_INPUT_KEYBDEV=y
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_EVBUG is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+# CONFIG_GAMEPORT_NS558 is not set
+# CONFIG_GAMEPORT_L4 is not set
+# CONFIG_INPUT_EMU10K1 is not set
+# CONFIG_GAMEPORT_VORTEX is not set
+# CONFIG_GAMEPORT_FM801 is not set
+# CONFIG_GAMEPORT_CS461x is not set
+CONFIG_SERIO=y
+CONFIG_SERIO_I8042=y
+CONFIG_I8042_REG_BASE=60
+CONFIG_I8042_KBD_IRQ=1
+CONFIG_I8042_AUX_IRQ=12
+# CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_PARKBD is not set
+CONFIG_INPUT_KEYBOARD=y
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_PS2SERKBD is not set
+CONFIG_KEYBOARD_XTKBD=y
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=y
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_GUNZE is not set
+# CONFIG_MOUSE_INPORT is not set
+# CONFIG_MOUSE_LOGIBM is not set
+# CONFIG_MOUSE_PC110PAD is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_JOYSTICK_ANALOG is not set
+# CONFIG_JOYSTICK_A3D is not set
+# CONFIG_JOYSTICK_ADI is not set
+# CONFIG_JOYSTICK_COBRA is not set
+# CONFIG_JOYSTICK_GF2K is not set
+# CONFIG_JOYSTICK_GRIP is not set
+# CONFIG_JOYSTICK_GUILLEMOT is not set
+# CONFIG_JOYSTICK_INTERACT is not set
+# CONFIG_JOYSTICK_SIDEWINDER is not set
+# CONFIG_JOYSTICK_TMDC is not set
+# CONFIG_JOYSTICK_IFORCE_USB is not set
+# CONFIG_JOYSTICK_IFORCE_232 is not set
+# CONFIG_JOYSTICK_WARRIOR is not set
+# CONFIG_JOYSTICK_MAGELLAN is not set
+# CONFIG_JOYSTICK_SPACEORB is not set
+# CONFIG_JOYSTICK_SPACEBALL is not set
+# CONFIG_JOYSTICK_STINGER is not set
+# CONFIG_JOYSTICK_TWIDDLER is not set
+# CONFIG_JOYSTICK_DB9 is not set
+# CONFIG_JOYSTICK_GAMECON is not set
+# CONFIG_JOYSTICK_TURBOGRAFX is not set
 
 #
 # Kernel hacking
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/arch/mips/defconfig-ddb5476 linux/arch/mips/defconfig-ddb5476
--- linux-2.5.2-dj7/arch/mips/defconfig-ddb5476	Fri Nov 30 11:46:06 2001
+++ linux/arch/mips/defconfig-ddb5476	Wed Jan 30 16:34:28 2002
@@ -38,7 +38,6 @@
 # CONFIG_SBUS is not set
 CONFIG_ISA=y
 CONFIG_PCI=y
-CONFIG_PC_KEYB=y
 CONFIG_ROTTEN_IRQ=y
 CONFIG_HAVE_STD_PC_SERIAL_PORT=y
 CONFIG_NEW_TIME_C=y
@@ -410,17 +409,6 @@
 # CONFIG_PC110_PAD is not set
 
 #
-# Joysticks
-#
-# CONFIG_INPUT_GAMEPORT is not set
-
-#
-# Input core support is needed for gameports
-#
-
-#
-# Input core support is needed for joysticks
-#
 # CONFIG_QIC02_TAPE is not set
 
 #
@@ -667,11 +655,65 @@
 #
 # Input core support
 #
-# CONFIG_INPUT is not set
-# CONFIG_INPUT_KEYBDEV is not set
-# CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_INPUT=y
+CONFIG_INPUT_KEYBDEV=y
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_EVBUG is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+# CONFIG_GAMEPORT_NS558 is not set
+# CONFIG_GAMEPORT_L4 is not set
+# CONFIG_INPUT_EMU10K1 is not set
+# CONFIG_GAMEPORT_VORTEX is not set
+# CONFIG_GAMEPORT_FM801 is not set
+# CONFIG_GAMEPORT_CS461x is not set
+CONFIG_SERIO=y
+CONFIG_SERIO_I8042=y
+CONFIG_I8042_REG_BASE=60
+CONFIG_I8042_KBD_IRQ=1
+CONFIG_I8042_AUX_IRQ=12
+# CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_PARKBD is not set
+CONFIG_INPUT_KEYBOARD=y
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_PS2SERKBD is not set
+CONFIG_KEYBOARD_XTKBD=y
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=y
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_GUNZE is not set
+# CONFIG_MOUSE_INPORT is not set
+# CONFIG_MOUSE_LOGIBM is not set
+# CONFIG_MOUSE_PC110PAD is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_JOYSTICK_ANALOG is not set
+# CONFIG_JOYSTICK_A3D is not set
+# CONFIG_JOYSTICK_ADI is not set
+# CONFIG_JOYSTICK_COBRA is not set
+# CONFIG_JOYSTICK_GF2K is not set
+# CONFIG_JOYSTICK_GRIP is not set
+# CONFIG_JOYSTICK_GUILLEMOT is not set
+# CONFIG_JOYSTICK_INTERACT is not set
+# CONFIG_JOYSTICK_SIDEWINDER is not set
+# CONFIG_JOYSTICK_TMDC is not set
+# CONFIG_JOYSTICK_IFORCE_USB is not set
+# CONFIG_JOYSTICK_IFORCE_232 is not set
+# CONFIG_JOYSTICK_WARRIOR is not set
+# CONFIG_JOYSTICK_MAGELLAN is not set
+# CONFIG_JOYSTICK_SPACEORB is not set
+# CONFIG_JOYSTICK_SPACEBALL is not set
+# CONFIG_JOYSTICK_STINGER is not set
+# CONFIG_JOYSTICK_TWIDDLER is not set
+# CONFIG_JOYSTICK_DB9 is not set
+# CONFIG_JOYSTICK_GAMECON is not set
+# CONFIG_JOYSTICK_TURBOGRAFX is not set
 
 #
 # Kernel hacking
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/arch/mips/defconfig-ip22 linux/arch/mips/defconfig-ip22
--- linux-2.5.2-dj7/arch/mips/defconfig-ip22	Fri Nov 30 11:46:06 2001
+++ linux/arch/mips/defconfig-ip22	Wed Jan 30 16:29:02 2002
@@ -38,7 +38,6 @@
 # CONFIG_SBUS is not set
 CONFIG_ARC32=y
 CONFIG_BOARD_SCACHE=y
-CONFIG_PC_KEYB=y
 CONFIG_SGI=y
 CONFIG_NEW_IRQ=y
 CONFIG_OLD_TIME_C=y
@@ -361,15 +360,6 @@
 # CONFIG_MOUSE is not set
 
 #
-# Joysticks
-#
-# CONFIG_INPUT_GAMEPORT is not set
-
-#
-# Input core support is needed for gameports
-#
-
-#
 # Input core support is needed for joysticks
 #
 # CONFIG_QIC02_TAPE is not set
@@ -629,11 +619,65 @@
 #
 # Input core support
 #
-# CONFIG_INPUT is not set
-# CONFIG_INPUT_KEYBDEV is not set
-# CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_INPUT=y
+CONFIG_INPUT_KEYBDEV=y
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_EVBUG is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+# CONFIG_GAMEPORT_NS558 is not set
+# CONFIG_GAMEPORT_L4 is not set
+# CONFIG_INPUT_EMU10K1 is not set
+# CONFIG_GAMEPORT_VORTEX is not set
+# CONFIG_GAMEPORT_FM801 is not set
+# CONFIG_GAMEPORT_CS461x is not set
+CONFIG_SERIO=y
+CONFIG_SERIO_I8042=y
+CONFIG_I8042_REG_BASE=60
+CONFIG_I8042_KBD_IRQ=1
+CONFIG_I8042_AUX_IRQ=12
+# CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_PARKBD is not set
+CONFIG_INPUT_KEYBOARD=y
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_PS2SERKBD is not set
+CONFIG_KEYBOARD_XTKBD=y
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=y
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_GUNZE is not set
+# CONFIG_MOUSE_INPORT is not set
+# CONFIG_MOUSE_LOGIBM is not set
+# CONFIG_MOUSE_PC110PAD is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_JOYSTICK_ANALOG is not set
+# CONFIG_JOYSTICK_A3D is not set
+# CONFIG_JOYSTICK_ADI is not set
+# CONFIG_JOYSTICK_COBRA is not set
+# CONFIG_JOYSTICK_GF2K is not set
+# CONFIG_JOYSTICK_GRIP is not set
+# CONFIG_JOYSTICK_GUILLEMOT is not set
+# CONFIG_JOYSTICK_INTERACT is not set
+# CONFIG_JOYSTICK_SIDEWINDER is not set
+# CONFIG_JOYSTICK_TMDC is not set
+# CONFIG_JOYSTICK_IFORCE_USB is not set
+# CONFIG_JOYSTICK_IFORCE_232 is not set
+# CONFIG_JOYSTICK_WARRIOR is not set
+# CONFIG_JOYSTICK_MAGELLAN is not set
+# CONFIG_JOYSTICK_SPACEORB is not set
+# CONFIG_JOYSTICK_SPACEBALL is not set
+# CONFIG_JOYSTICK_STINGER is not set
+# CONFIG_JOYSTICK_TWIDDLER is not set
+# CONFIG_JOYSTICK_DB9 is not set
+# CONFIG_JOYSTICK_GAMECON is not set
+# CONFIG_JOYSTICK_TURBOGRAFX is not set
 
 #
 # Kernel hacking
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/arch/mips/defconfig-it8172 linux/arch/mips/defconfig-it8172
--- linux-2.5.2-dj7/arch/mips/defconfig-it8172	Fri Nov 30 11:46:06 2001
+++ linux/arch/mips/defconfig-it8172	Wed Jan 30 15:49:02 2002
@@ -43,7 +43,6 @@
 # CONFIG_SBUS is not set
 CONFIG_PCI=y
 CONFIG_IT8712=y
-CONFIG_PC_KEYB=y
 CONFIG_NEW_PCI=y
 CONFIG_PCI_AUTO=y
 # CONFIG_ISA is not set
@@ -488,15 +487,6 @@
 # CONFIG_MOUSE is not set
 
 #
-# Joysticks
-#
-# CONFIG_INPUT_GAMEPORT is not set
-
-#
-# Input core support is needed for gameports
-#
-
-#
 # Input core support is needed for joysticks
 #
 # CONFIG_QIC02_TAPE is not set
@@ -714,11 +704,65 @@
 #
 # Input core support
 #
-# CONFIG_INPUT is not set
-# CONFIG_INPUT_KEYBDEV is not set
-# CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_INPUT=y
+CONFIG_INPUT_KEYBDEV=y
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_EVBUG is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+# CONFIG_GAMEPORT_NS558 is not set
+# CONFIG_GAMEPORT_L4 is not set
+# CONFIG_INPUT_EMU10K1 is not set
+# CONFIG_GAMEPORT_VORTEX is not set
+# CONFIG_GAMEPORT_FM801 is not set
+# CONFIG_GAMEPORT_CS461x is not set
+CONFIG_SERIO=y
+CONFIG_SERIO_I8042=y
+CONFIG_I8042_REG_BASE=60
+CONFIG_I8042_KBD_IRQ=1
+CONFIG_I8042_AUX_IRQ=12
+# CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_PARKBD is not set
+CONFIG_INPUT_KEYBOARD=y
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_PS2SERKBD is not set
+CONFIG_KEYBOARD_XTKBD=y
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=y
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_GUNZE is not set
+# CONFIG_MOUSE_INPORT is not set
+# CONFIG_MOUSE_LOGIBM is not set
+# CONFIG_MOUSE_PC110PAD is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_JOYSTICK_ANALOG is not set
+# CONFIG_JOYSTICK_A3D is not set
+# CONFIG_JOYSTICK_ADI is not set
+# CONFIG_JOYSTICK_COBRA is not set
+# CONFIG_JOYSTICK_GF2K is not set
+# CONFIG_JOYSTICK_GRIP is not set
+# CONFIG_JOYSTICK_GUILLEMOT is not set
+# CONFIG_JOYSTICK_INTERACT is not set
+# CONFIG_JOYSTICK_SIDEWINDER is not set
+# CONFIG_JOYSTICK_TMDC is not set
+# CONFIG_JOYSTICK_IFORCE_USB is not set
+# CONFIG_JOYSTICK_IFORCE_232 is not set
+# CONFIG_JOYSTICK_WARRIOR is not set
+# CONFIG_JOYSTICK_MAGELLAN is not set
+# CONFIG_JOYSTICK_SPACEORB is not set
+# CONFIG_JOYSTICK_SPACEBALL is not set
+# CONFIG_JOYSTICK_STINGER is not set
+# CONFIG_JOYSTICK_TWIDDLER is not set
+# CONFIG_JOYSTICK_DB9 is not set
+# CONFIG_JOYSTICK_GAMECON is not set
+# CONFIG_JOYSTICK_TURBOGRAFX is not set
 
 #
 # Kernel hacking
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/arch/mips/defconfig-nino linux/arch/mips/defconfig-nino
--- linux-2.5.2-dj7/arch/mips/defconfig-nino	Fri Nov 30 11:46:06 2001
+++ linux/arch/mips/defconfig-nino	Wed Jan 30 16:30:05 2002
@@ -39,7 +39,6 @@
 # CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 # CONFIG_MCA is not set
 # CONFIG_SBUS is not set
-CONFIG_PC_KEYB=y
 # CONFIG_ISA is not set
 # CONFIG_EISA is not set
 # CONFIG_PCI is not set
@@ -199,17 +198,6 @@
 # CONFIG_MOUSE is not set
 
 #
-# Joysticks
-#
-# CONFIG_INPUT_GAMEPORT is not set
-
-#
-# Input core support is needed for gameports
-#
-
-#
-# Input core support is needed for joysticks
-#
 # CONFIG_QIC02_TAPE is not set
 
 #
@@ -401,11 +389,65 @@
 #
 # Input core support
 #
-# CONFIG_INPUT is not set
-# CONFIG_INPUT_KEYBDEV is not set
-# CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_INPUT=y
+CONFIG_INPUT_KEYBDEV=y
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_EVBUG is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+# CONFIG_GAMEPORT_NS558 is not set
+# CONFIG_GAMEPORT_L4 is not set
+# CONFIG_INPUT_EMU10K1 is not set
+# CONFIG_GAMEPORT_VORTEX is not set
+# CONFIG_GAMEPORT_FM801 is not set
+# CONFIG_GAMEPORT_CS461x is not set
+CONFIG_SERIO=y
+CONFIG_SERIO_I8042=y
+CONFIG_I8042_REG_BASE=60
+CONFIG_I8042_KBD_IRQ=1
+CONFIG_I8042_AUX_IRQ=12
+# CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_PARKBD is not set
+CONFIG_INPUT_KEYBOARD=y
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_PS2SERKBD is not set
+CONFIG_KEYBOARD_XTKBD=y
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=y
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_GUNZE is not set
+# CONFIG_MOUSE_INPORT is not set
+# CONFIG_MOUSE_LOGIBM is not set
+# CONFIG_MOUSE_PC110PAD is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_JOYSTICK_ANALOG is not set
+# CONFIG_JOYSTICK_A3D is not set
+# CONFIG_JOYSTICK_ADI is not set
+# CONFIG_JOYSTICK_COBRA is not set
+# CONFIG_JOYSTICK_GF2K is not set
+# CONFIG_JOYSTICK_GRIP is not set
+# CONFIG_JOYSTICK_GUILLEMOT is not set
+# CONFIG_JOYSTICK_INTERACT is not set
+# CONFIG_JOYSTICK_SIDEWINDER is not set
+# CONFIG_JOYSTICK_TMDC is not set
+# CONFIG_JOYSTICK_IFORCE_USB is not set
+# CONFIG_JOYSTICK_IFORCE_232 is not set
+# CONFIG_JOYSTICK_WARRIOR is not set
+# CONFIG_JOYSTICK_MAGELLAN is not set
+# CONFIG_JOYSTICK_SPACEORB is not set
+# CONFIG_JOYSTICK_SPACEBALL is not set
+# CONFIG_JOYSTICK_STINGER is not set
+# CONFIG_JOYSTICK_TWIDDLER is not set
+# CONFIG_JOYSTICK_DB9 is not set
+# CONFIG_JOYSTICK_GAMECON is not set
+# CONFIG_JOYSTICK_TURBOGRAFX is not set
 
 #
 # Kernel hacking
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/arch/mips/defconfig-rm200 linux/arch/mips/defconfig-rm200
--- linux-2.5.2-dj7/arch/mips/defconfig-rm200	Fri Nov 30 11:46:06 2001
+++ linux/arch/mips/defconfig-rm200	Wed Jan 30 16:31:07 2002
@@ -39,7 +39,6 @@
 CONFIG_ARC32=y
 CONFIG_I8259=y
 CONFIG_ISA=y
-CONFIG_PC_KEYB=y
 CONFIG_PCI=y
 CONFIG_ROTTEN_IRQ=y
 CONFIG_OLD_TIME_C=y
@@ -242,17 +241,6 @@
 # CONFIG_MOUSE is not set
 
 #
-# Joysticks
-#
-# CONFIG_INPUT_GAMEPORT is not set
-
-#
-# Input core support is needed for gameports
-#
-
-#
-# Input core support is needed for joysticks
-#
 # CONFIG_QIC02_TAPE is not set
 
 #
@@ -491,11 +479,65 @@
 #
 # Input core support
 #
-# CONFIG_INPUT is not set
-# CONFIG_INPUT_KEYBDEV is not set
-# CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_INPUT=y
+CONFIG_INPUT_KEYBDEV=y
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_EVBUG is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+# CONFIG_GAMEPORT_NS558 is not set
+# CONFIG_GAMEPORT_L4 is not set
+# CONFIG_INPUT_EMU10K1 is not set
+# CONFIG_GAMEPORT_VORTEX is not set
+# CONFIG_GAMEPORT_FM801 is not set
+# CONFIG_GAMEPORT_CS461x is not set
+CONFIG_SERIO=y
+CONFIG_SERIO_I8042=y
+CONFIG_I8042_REG_BASE=60
+CONFIG_I8042_KBD_IRQ=1
+CONFIG_I8042_AUX_IRQ=12
+# CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_PARKBD is not set
+CONFIG_INPUT_KEYBOARD=y
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_PS2SERKBD is not set
+CONFIG_KEYBOARD_XTKBD=y
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=y
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_GUNZE is not set
+# CONFIG_MOUSE_INPORT is not set
+# CONFIG_MOUSE_LOGIBM is not set
+# CONFIG_MOUSE_PC110PAD is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_JOYSTICK_ANALOG is not set
+# CONFIG_JOYSTICK_A3D is not set
+# CONFIG_JOYSTICK_ADI is not set
+# CONFIG_JOYSTICK_COBRA is not set
+# CONFIG_JOYSTICK_GF2K is not set
+# CONFIG_JOYSTICK_GRIP is not set
+# CONFIG_JOYSTICK_GUILLEMOT is not set
+# CONFIG_JOYSTICK_INTERACT is not set
+# CONFIG_JOYSTICK_SIDEWINDER is not set
+# CONFIG_JOYSTICK_TMDC is not set
+# CONFIG_JOYSTICK_IFORCE_USB is not set
+# CONFIG_JOYSTICK_IFORCE_232 is not set
+# CONFIG_JOYSTICK_WARRIOR is not set
+# CONFIG_JOYSTICK_MAGELLAN is not set
+# CONFIG_JOYSTICK_SPACEORB is not set
+# CONFIG_JOYSTICK_SPACEBALL is not set
+# CONFIG_JOYSTICK_STINGER is not set
+# CONFIG_JOYSTICK_TWIDDLER is not set
+# CONFIG_JOYSTICK_DB9 is not set
+# CONFIG_JOYSTICK_GAMECON is not set
+# CONFIG_JOYSTICK_TURBOGRAFX is not set
 
 #
 # Kernel hacking
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/arch/mips/lib/Makefile linux/arch/mips/lib/Makefile
--- linux-2.5.2-dj7/arch/mips/lib/Makefile	Fri Nov 30 11:46:05 2001
+++ linux/arch/mips/lib/Makefile	Wed Jan 30 15:43:09 2002
@@ -22,6 +22,5 @@
 
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy-no.o floppy-std.o
 obj-$(CONFIG_IDE)		+= ide-std.o ide-no.o
-obj-$(CONFIG_PC_KEYB)		+= kbd-std.o kbd-no.o
 
 include $(TOPDIR)/Rules.make
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/arch/mips64/defconfig-ip32 linux/arch/mips64/defconfig-ip32
--- linux-2.5.2-dj7/arch/mips64/defconfig-ip32	Fri Nov 30 11:46:11 2001
+++ linux/arch/mips64/defconfig-ip32	Wed Jan 30 16:35:51 2002
@@ -17,7 +17,6 @@
 # CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 CONFIG_BOOT_ELF32=y
 CONFIG_ARC32=y
-CONFIG_PC_KEYB=y
 CONFIG_PCI=y
 CONFIG_ARC_MEMORY=y
 CONFIG_L1_CACHE_SHIFT=5
@@ -500,7 +499,65 @@
 #
 # Input core support
 #
-# CONFIG_INPUT is not set
+CONFIG_INPUT=y
+CONFIG_INPUT_KEYBDEV=y
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_EVBUG is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+# CONFIG_GAMEPORT_NS558 is not set
+# CONFIG_GAMEPORT_L4 is not set
+# CONFIG_INPUT_EMU10K1 is not set
+# CONFIG_GAMEPORT_VORTEX is not set
+# CONFIG_GAMEPORT_FM801 is not set
+# CONFIG_GAMEPORT_CS461x is not set
+CONFIG_SERIO=y
+CONFIG_SERIO_I8042=y
+CONFIG_I8042_REG_BASE=60
+CONFIG_I8042_KBD_IRQ=1
+CONFIG_I8042_AUX_IRQ=12
+# CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_PARKBD is not set
+CONFIG_INPUT_KEYBOARD=y
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_PS2SERKBD is not set
+CONFIG_KEYBOARD_XTKBD=y
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=y
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_GUNZE is not set
+# CONFIG_MOUSE_INPORT is not set
+# CONFIG_MOUSE_LOGIBM is not set
+# CONFIG_MOUSE_PC110PAD is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_JOYSTICK_ANALOG is not set
+# CONFIG_JOYSTICK_A3D is not set
+# CONFIG_JOYSTICK_ADI is not set
+# CONFIG_JOYSTICK_COBRA is not set
+# CONFIG_JOYSTICK_GF2K is not set
+# CONFIG_JOYSTICK_GRIP is not set
+# CONFIG_JOYSTICK_GUILLEMOT is not set
+# CONFIG_JOYSTICK_INTERACT is not set
+# CONFIG_JOYSTICK_SIDEWINDER is not set
+# CONFIG_JOYSTICK_TMDC is not set
+# CONFIG_JOYSTICK_IFORCE_USB is not set
+# CONFIG_JOYSTICK_IFORCE_232 is not set
+# CONFIG_JOYSTICK_WARRIOR is not set
+# CONFIG_JOYSTICK_MAGELLAN is not set
+# CONFIG_JOYSTICK_SPACEORB is not set
+# CONFIG_JOYSTICK_SPACEBALL is not set
+# CONFIG_JOYSTICK_STINGER is not set
+# CONFIG_JOYSTICK_TWIDDLER is not set
+# CONFIG_JOYSTICK_DB9 is not set
+# CONFIG_JOYSTICK_GAMECON is not set
+# CONFIG_JOYSTICK_TURBOGRAFX is not set
 
 #
 # Kernel hacking
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/drivers/char/Config.in linux/drivers/char/Config.in
--- linux-2.5.2-dj7/drivers/char/Config.in	Tue Jan 29 17:36:38 2002
+++ linux/drivers/char/Config.in	Wed Jan 30 16:38:51 2002
@@ -75,9 +75,6 @@
    bool 'Enable Qtronix 990P Keyboard Support' CONFIG_QTRONIX_KEYBOARD
    if [ "$CONFIG_QTRONIX_KEYBOARD" = "y" ]; then
      define_bool CONFIG_IT8172_CIR y
-   else
-     bool '    Enable PS2 Keyboard Support' CONFIG_PC_KEYB
-   fi
    bool 'Enable Smart Card Reader 0 Support ' CONFIG_IT8172_SCR0
    bool 'Enable Smart Card Reader 1 Support ' CONFIG_IT8172_SCR1
 fi
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/drivers/char/Makefile linux/drivers/char/Makefile
--- linux-2.5.2-dj7/drivers/char/Makefile	Tue Jan 29 17:36:38 2002
+++ linux/drivers/char/Makefile	Wed Jan 30 16:38:25 2002
@@ -30,7 +30,6 @@
 list-multi	:=	
 
 KEYMAP   =defkeymap.o
-KEYBD    =pc_keyb.o
 CONSOLE  =console.o
 SERIAL   =serial.o
 
@@ -41,12 +40,6 @@
   SERIAL   =
 endif
 
-ifeq ($(ARCH),mips)
-  ifneq ($(CONFIG_PC_KEYB),y)
-    KEYBD    =
-  endif
-endif
-
 ifeq ($(ARCH),s390x)
   KEYMAP   =
   KEYBD    =
@@ -66,9 +59,6 @@
 ifeq ($(ARCH),arm)
   ifneq ($(CONFIG_PC_KEYMAP),y)
     KEYMAP   =
-  endif
-  ifneq ($(CONFIG_PC_KEYB),y)
-    KEYBD    =
   endif
 endif
 
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/drivers/input/serio/Config.in linux/drivers/input/serio/Config.in
--- linux-2.5.2-dj7/drivers/input/serio/Config.in	Tue Jan 29 17:36:39 2002
+++ linux/drivers/input/serio/Config.in	Wed Jan 30 13:04:14 2002
@@ -5,6 +5,11 @@
 tristate 'Serial i/o support' CONFIG_SERIO
 
 dep_tristate '  i8042 PC Keyboard controller' CONFIG_SERIO_I8042 $CONFIG_SERIO $CONFIG_ISA
+if [ "$CONFIG_INPUT_I8042" != "n" ]; then
+   hex '    Register Base Address' CONFIG_I8042_REG_BASE 60
+   int '    PS/2 Keyboard IRQ' CONFIG_I8042_KBD_IRQ 1
+   int '    PS/2 AUX IRQ' CONFIG_I8042_AUX_IRQ 12
+fi
 dep_tristate '  Serial port line discipline' CONFIG_SERIO_SERPORT $CONFIG_SERIO 
 dep_tristate '  ct82c710 Aux port controller' CONFIG_SERIO_CT82C710 $CONFIG_SERIO $CONFIG_ISA
 dep_tristate '  Parallel port keyboard adapter' CONFIG_SERIO_PARKBD $CONFIG_SERIO $CONFIG_PARPORT
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/drivers/input/serio/i8042.h linux/drivers/input/serio/i8042.h
--- linux-2.5.2-dj7/drivers/input/serio/i8042.h	Tue Jan 29 17:36:39 2002
+++ linux/drivers/input/serio/i8042.h	Wed Jan 30 13:07:29 2002
@@ -44,7 +44,7 @@
  * On most PC based systems the keyboard IRQ is 1.
  */
 
-#define I8042_KBD_IRQ 1
+#define I8042_KBD_IRQ CONFIG_I8042_KBD_IRQ 
 
 /*
  * On most PC based systems the aux port IRQ is 12. There are exceptions,
@@ -52,11 +52,7 @@
  * the device attached to the port.
  */
 
-#if defined(__alpha__) && !defined(CONFIG_PCI)
-#define I8042_AUX_IRQ 9		/* This is for Jensen Alpha */
-#else
-#define I8042_AUX_IRQ 12	/* This is for everyone else */
-#endif
+#define I8042_AUX_IRQ CONFIG_I8042_AUX_IRQ
 
 /*
  * This is in 50us units, the time we wait for the i8042 to react. This
@@ -70,9 +66,9 @@
  * Register numbers.
  */
 
-#define I8042_COMMAND_REG	0x64
-#define I8042_STATUS_REG	0x64
-#define I8042_DATA_REG		0x60
+#define I8042_COMMAND_REG	CONFIG_I8042_REG_BASE + 4	
+#define I8042_STATUS_REG	CONFIG_I8042_REG_BASE + 4	
+#define I8042_DATA_REG		CONFIG_I8042_REG_BASE	
 
 /*
  * Status register bits.
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/include/asm-mips/keyboard.h linux/include/asm-mips/keyboard.h
--- linux-2.5.2-dj7/include/asm-mips/keyboard.h	Fri Nov 30 11:45:50 2001
+++ linux/include/asm-mips/keyboard.h	Wed Jan 30 16:36:54 2002
@@ -19,30 +19,6 @@
 
 #define DISABLE_KBD_DURING_INTERRUPTS 0
 
-#ifdef CONFIG_PC_KEYB
-
-extern int pckbd_setkeycode(unsigned int scancode, unsigned int keycode);
-extern int pckbd_getkeycode(unsigned int scancode);
-extern int pckbd_translate(unsigned char scancode, unsigned char *keycode,
-			   char raw_mode);
-extern char pckbd_unexpected_up(unsigned char keycode);
-extern void pckbd_leds(unsigned char leds);
-extern int pckbd_rate(struct kbd_repeat *rep);
-extern void pckbd_init_hw(void);
-extern unsigned char pckbd_sysrq_xlate[128];
-extern void kbd_forward_char (int ch);
-
-#define kbd_setkeycode		pckbd_setkeycode
-#define kbd_getkeycode		pckbd_getkeycode
-#define kbd_translate		pckbd_translate
-#define kbd_unexpected_up	pckbd_unexpected_up
-#define kbd_leds		pckbd_leds
-#define kbd_rate		pckbd_rate
-#define kbd_init_hw		pckbd_init_hw
-#define kbd_sysrq_xlate         pckbd_sysrq_xlate
-
-#else
-
 extern int kbd_setkeycode(unsigned int scancode, unsigned int keycode);
 extern int kbd_getkeycode(unsigned int scancode);
 extern int kbd_translate(unsigned char scancode, unsigned char *keycode,
@@ -51,8 +27,6 @@
 extern void kbd_leds(unsigned char leds);
 extern void kbd_init_hw(void);
 extern unsigned char *kbd_sysrq_xlate;
-
-#endif
 
 #define SYSRQ_KEY 0x54
 

