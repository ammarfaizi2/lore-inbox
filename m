Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319181AbSHND2R>; Tue, 13 Aug 2002 23:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319182AbSHND2Q>; Tue, 13 Aug 2002 23:28:16 -0400
Received: from surf.cadcamlab.org ([156.26.20.182]:58505 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S319181AbSHND2L>; Tue, 13 Aug 2002 23:28:11 -0400
Date: Tue, 13 Aug 2002 22:28:41 -0500
To: Greg Banks <gnb@alphalink.com.au>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
Message-ID: <20020814032841.GM761@cadcamlab.org>
References: <Pine.LNX.4.44.0208120924320.5882-100000@chaos.physics.uiowa.edu> <3D587483.1C459694@alphalink.com.au> <20020813033951.GF761@cadcamlab.org> <3D59110B.6D9A1223@alphalink.com.au> <20020813155330.GG761@cadcamlab.org> <3D59AEB7.7B80F33@alphalink.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <3D59AEB7.7B80F33@alphalink.com.au>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


[Greg Banks]
  [I wrote]
> > (BTW, the format is great - I can use 'M-x compile' and 'M-x
> > next-error' and Emacs pulls up files and lines for me.)
> 
> This is not a coincidence.

Indeed not - if you hadn't already used that format I would have
munged it.  Grew up on gcc, so this is my favorite error message
format.  Yours too, I guess. (:

> > CONFIG_SCSI should be defined earlier, like in the "Block Devices"
> > menu.  Then again, 'sg' is not a block device so this isn't strictly
> > correct.  Perhaps a "kernel subsystems" submenu under "general setup",
> > or even as a toplevel menu.
> 
> Sounds like a good idea.  You could put CONFIG_SERIAL and CONFIG_PCMCIA
> in there too.

CONFIG_SERIAL and CONFIG_PCMCIA didn't generate any noise, though.
Minimum necessary change and all that.  It's easy enough to add later,
if desired.

Here's a start.  It looks a little hacky but it does fix real issues.
I decided to combine "general setup", "module config" and "major
subsystems" - the latter needs to come after modules but really
belongs with general setup.  Eh?

I think the first patch belongs on trivial@rustcorp - what's the
protocol there, just an email cc?  Attach or inline?  etc.

Peter

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.diff"

diff -urNXxpk 2.5.31/arch/alpha/config.in 2.5.31-1/arch/alpha/config.in
--- 2.5.31/arch/alpha/config.in	2002-08-11 15:08:07.000000000 -0500
+++ 2.5.31-1/arch/alpha/config.in	2002-08-13 20:49:18.000000000 -0500
@@ -340,6 +340,10 @@
 fi
 endmenu
 
+#
+# input before char - char/joystick depends on it. As does USB.
+#
+source drivers/input/Config.in
 source drivers/char/Config.in
 
 #source drivers/misc/Config.in
@@ -375,7 +379,6 @@
 endmenu
 
 source drivers/usb/Config.in
-source drivers/input/Config.in
 
 source net/bluetooth/Config.in
 
diff -urNXxpk 2.5.31/arch/mips/config.in 2.5.31-1/arch/mips/config.in
--- 2.5.31/arch/mips/config.in	2002-08-11 15:08:07.000000000 -0500
+++ 2.5.31-1/arch/mips/config.in	2002-08-13 20:48:35.000000000 -0500
@@ -400,6 +400,10 @@
 fi
 endmenu
 
+#
+# input before char - char/joystick depends on it. As does USB.
+#
+source drivers/input/Config.in
 source drivers/char/Config.in
 
 source drivers/media/Config.in
@@ -485,7 +489,6 @@
 fi
 
 source drivers/usb/Config.in
-source drivers/input/Config.in
 
 mainmenu_option next_comment
 comment 'Kernel hacking'
diff -urNXxpk 2.5.31/arch/mips64/config.in 2.5.31-1/arch/mips64/config.in
--- 2.5.31/arch/mips64/config.in	2002-08-11 15:08:07.000000000 -0500
+++ 2.5.31-1/arch/mips64/config.in	2002-08-13 20:49:00.000000000 -0500
@@ -191,6 +191,10 @@
 fi
 endmenu
 
+#
+# input before char - char/joystick depends on it. As does USB.
+#
+source drivers/input/Config.in
 source drivers/char/Config.in
 
 #source drivers/misc/Config.in
@@ -232,7 +236,6 @@
 fi
 
 source drivers/usb/Config.in
-source drivers/input/Config.in
 
 mainmenu_option next_comment
 comment 'Kernel hacking'

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.diff"

diff -urNXxpk 2.5.31-1/arch/alpha/config.in 2.5.31-2/arch/alpha/config.in
--- 2.5.31-1/arch/alpha/config.in	2002-08-13 20:49:18.000000000 -0500
+++ 2.5.31-2/arch/alpha/config.in	2002-08-13 22:07:23.000000000 -0500
@@ -299,15 +299,12 @@
 fi
 endmenu
 
-mainmenu_option next_comment
-comment 'SCSI support'
-
-tristate 'SCSI support' CONFIG_SCSI
-
 if [ "$CONFIG_SCSI" != "n" ]; then
+  mainmenu_option next_comment
+  comment 'SCSI support'
   source drivers/scsi/Config.in
+  endmenu
 fi
-endmenu
 
 if [ "$CONFIG_PCI" = "y" ]; then
   source drivers/message/fusion/Config.in
diff -urNXxpk 2.5.31-1/arch/arm/config.in 2.5.31-2/arch/arm/config.in
--- 2.5.31-1/arch/arm/config.in	2002-08-11 15:08:07.000000000 -0500
+++ 2.5.31-2/arch/arm/config.in	2002-08-13 22:07:42.000000000 -0500
@@ -559,15 +559,12 @@
 fi
 endmenu
 
-mainmenu_option next_comment
-comment 'SCSI support'
-
-tristate 'SCSI support' CONFIG_SCSI
-
 if [ "$CONFIG_SCSI" != "n" ]; then
+   mainmenu_option next_comment
+   comment 'SCSI support'
    source drivers/scsi/Config.in
+   endmenu
 fi
-endmenu
 
 if [ "$CONFIG_ARCH_CLPS711X" = "y" ]; then
    source drivers/ssi/Config.in
diff -urNXxpk 2.5.31-1/arch/cris/config.in 2.5.31-2/arch/cris/config.in
--- 2.5.31-1/arch/cris/config.in	2002-07-27 04:14:32.000000000 -0500
+++ 2.5.31-2/arch/cris/config.in	2002-08-13 22:08:01.000000000 -0500
@@ -153,15 +153,12 @@
 fi
 endmenu
 
-mainmenu_option next_comment
-comment 'SCSI support'
-
-tristate 'SCSI support' CONFIG_SCSI
-
 if [ "$CONFIG_SCSI" != "n" ]; then
+  mainmenu_option next_comment
+  comment 'SCSI support'
   source drivers/scsi/Config.in
+  endmenu
 fi
-endmenu
 
 source drivers/ieee1394/Config.in
 
diff -urNXxpk 2.5.31-1/arch/i386/config.in 2.5.31-2/arch/i386/config.in
--- 2.5.31-1/arch/i386/config.in	2002-08-11 15:08:07.000000000 -0500
+++ 2.5.31-2/arch/i386/config.in	2002-08-13 22:05:49.000000000 -0500
@@ -311,15 +311,12 @@
 fi
 endmenu
 
-mainmenu_option next_comment
-comment 'SCSI device support'
-
-tristate 'SCSI device support' CONFIG_SCSI
-
 if [ "$CONFIG_SCSI" != "n" ]; then
+   mainmenu_option next_comment
+   comment 'SCSI device support'
    source drivers/scsi/Config.in
+   endmenu
 fi
-endmenu
 
 mainmenu_option next_comment
 comment 'Old non-SCSI/ATAPI CD-ROM drives'
diff -urNXxpk 2.5.31-1/arch/ia64/config.in 2.5.31-2/arch/ia64/config.in
--- 2.5.31-1/arch/ia64/config.in	2002-08-08 22:43:27.000000000 -0500
+++ 2.5.31-2/arch/ia64/config.in	2002-08-13 22:08:38.000000000 -0500
@@ -157,15 +157,12 @@
 endmenu
 fi # !HP_SIM
 
-mainmenu_option next_comment
-comment 'SCSI support'
-
-tristate 'SCSI support' CONFIG_SCSI
-
 if [ "$CONFIG_SCSI" != "n" ]; then
+  mainmenu_option next_comment
+  comment 'SCSI support'
   source drivers/scsi/Config.in
+  endmenu
 fi
-endmenu
 
 if [ "$CONFIG_IA64_HP_SIM" = "n" ]; then
 
diff -urNXxpk 2.5.31-1/arch/m68k/config.in 2.5.31-2/arch/m68k/config.in
--- 2.5.31-1/arch/m68k/config.in	2002-08-11 15:08:07.000000000 -0500
+++ 2.5.31-2/arch/m68k/config.in	2002-08-13 22:09:34.000000000 -0500
@@ -172,12 +172,9 @@
 fi
 endmenu
 
-mainmenu_option next_comment
-comment 'SCSI device support'
-
-tristate 'SCSI device support' CONFIG_SCSI
-
 if [ "$CONFIG_SCSI" != "n" ]; then
+   mainmenu_option next_comment
+   comment 'SCSI device support'
 
    comment 'SCSI support type (disk, tape, CD-ROM)'
 
@@ -266,9 +263,8 @@
    fi
 
    endmenu
-
+   endmenu
 fi
-endmenu
 
 if [ "$CONFIG_NET" = "y" ]; then
 
diff -urNXxpk 2.5.31-1/arch/mips/config.in 2.5.31-2/arch/mips/config.in
--- 2.5.31-1/arch/mips/config.in	2002-08-13 20:48:35.000000000 -0500
+++ 2.5.31-2/arch/mips/config.in	2002-08-13 22:09:54.000000000 -0500
@@ -356,15 +356,13 @@
    endmenu
 fi
 
-mainmenu_option next_comment
-comment 'SCSI support'
-
-tristate 'SCSI support' CONFIG_SCSI
 
 if [ "$CONFIG_SCSI" != "n" ]; then
+   mainmenu_option next_comment
+   comment 'SCSI support'
    source drivers/scsi/Config.in
+   endmenu
 fi
-endmenu
 
 if [ "$CONFIG_DECSTATION" != "y" -a \
      "$CONFIG_SGI_IP22" != "y" ]; then
diff -urNXxpk 2.5.31-1/arch/mips64/config.in 2.5.31-2/arch/mips64/config.in
--- 2.5.31-1/arch/mips64/config.in	2002-08-13 20:49:00.000000000 -0500
+++ 2.5.31-2/arch/mips64/config.in	2002-08-13 22:10:16.000000000 -0500
@@ -150,15 +150,12 @@
 fi
 endmenu
 
-mainmenu_option next_comment
-comment 'SCSI support'
-
-tristate 'SCSI support' CONFIG_SCSI
-
 if [ "$CONFIG_SCSI" != "n" ]; then
+   mainmenu_option next_comment
+   comment 'SCSI support'
    source drivers/scsi/Config.in
+   endmenu
 fi
-endmenu
 
 #source drivers/message/i2o/Config.in
 
diff -urNXxpk 2.5.31-1/arch/parisc/config.in 2.5.31-2/arch/parisc/config.in
--- 2.5.31-1/arch/parisc/config.in	2002-08-11 15:08:07.000000000 -0500
+++ 2.5.31-2/arch/parisc/config.in	2002-08-13 22:13:42.000000000 -0500
@@ -103,12 +103,10 @@
   source net/Config.in
 fi
 
-mainmenu_option next_comment
-comment 'SCSI support'
-
-tristate 'SCSI support' CONFIG_SCSI
-
 if [ "$CONFIG_SCSI" != "n" ]; then
+  mainmenu_option next_comment
+  comment 'SCSI support'
+
   comment 'SCSI support type (disk, tape, CDrom)'
 
   dep_tristate 'SCSI disk support' CONFIG_BLK_DEV_SD $CONFIG_SCSI
@@ -145,8 +143,8 @@
     bool '  use normal IO' CONFIG_SCSI_NCR53C8XX_IOMAPPED
   fi
   endmenu
+  endmenu
 fi
-endmenu
 
 if [ "$CONFIG_NET" = "y" ]; then
   mainmenu_option next_comment
diff -urNXxpk 2.5.31-1/arch/ppc/config.in 2.5.31-2/arch/ppc/config.in
--- 2.5.31-1/arch/ppc/config.in	2002-08-11 15:08:07.000000000 -0500
+++ 2.5.31-2/arch/ppc/config.in	2002-08-13 22:14:09.000000000 -0500
@@ -434,13 +434,12 @@
 fi
 endmenu
 
-mainmenu_option next_comment
-comment 'SCSI support'
-tristate 'SCSI support' CONFIG_SCSI
 if [ "$CONFIG_SCSI" != "n" ]; then
+   mainmenu_option next_comment
+   comment 'SCSI support'
    source drivers/scsi/Config.in
+   endmenu
 fi
-endmenu
 
 source drivers/message/fusion/Config.in
 
diff -urNXxpk 2.5.31-1/arch/ppc64/config.in 2.5.31-2/arch/ppc64/config.in
--- 2.5.31-1/arch/ppc64/config.in	2002-07-27 04:14:32.000000000 -0500
+++ 2.5.31-2/arch/ppc64/config.in	2002-08-13 22:14:24.000000000 -0500
@@ -103,13 +103,12 @@
 fi
 endmenu
 
-mainmenu_option next_comment
-comment 'SCSI support'
-tristate 'SCSI support' CONFIG_SCSI
 if [ "$CONFIG_SCSI" != "n" ]; then
+   mainmenu_option next_comment
+   comment 'SCSI support'
    source drivers/scsi/Config.in
+   endmenu
 fi
-endmenu
 
 source drivers/message/fusion/Config.in
 
diff -urNXxpk 2.5.31-1/arch/s390/config.in 2.5.31-2/arch/s390/config.in
--- 2.5.31-1/arch/s390/config.in	2002-07-27 04:14:33.000000000 -0500
+++ 2.5.31-2/arch/s390/config.in	2002-08-13 22:11:47.000000000 -0500
@@ -47,15 +47,13 @@
 bool 'VM shared kernel support' CONFIG_SHARED_KERNEL
 endmenu
 
-mainmenu_option next_comment
-comment 'SCSI support'
-
-tristate 'SCSI support' CONFIG_SCSI
 
 if [ "$CONFIG_SCSI" != "n" ]; then
+   mainmenu_option next_comment
+   comment 'SCSI support'
    source drivers/scsi/Config.in
+   endmenu
 fi
-endmenu
 
 source drivers/s390/Config.in
 
diff -urNXxpk 2.5.31-1/arch/s390x/config.in 2.5.31-2/arch/s390x/config.in
--- 2.5.31-1/arch/s390x/config.in	2002-07-27 04:14:33.000000000 -0500
+++ 2.5.31-2/arch/s390x/config.in	2002-08-13 22:11:48.000000000 -0500
@@ -50,15 +50,13 @@
 bool 'VM shared kernel support' CONFIG_SHARED_KERNEL
 endmenu
 
-mainmenu_option next_comment
-comment 'SCSI support'
-
-tristate 'SCSI support' CONFIG_SCSI
 
 if [ "$CONFIG_SCSI" != "n" ]; then
+   mainmenu_option next_comment
+   comment 'SCSI support'
    source drivers/scsi/Config.in
+   endmenu
 fi
-endmenu
 
 source drivers/s390/Config.in
 
diff -urNXxpk 2.5.31-1/arch/sh/config.in 2.5.31-2/arch/sh/config.in
--- 2.5.31-1/arch/sh/config.in	2002-08-11 15:08:07.000000000 -0500
+++ 2.5.31-2/arch/sh/config.in	2002-08-13 22:11:50.000000000 -0500
@@ -223,15 +223,13 @@
 fi
 endmenu
 
-mainmenu_option next_comment
-comment 'SCSI support'
-
-tristate 'SCSI support' CONFIG_SCSI
 
 if [ "$CONFIG_SCSI" != "n" ]; then
+   mainmenu_option next_comment
+   comment 'SCSI support'
    source drivers/scsi/Config.in
+   endmenu
 fi
-endmenu
 
 source drivers/ieee1394/Config.in
 
diff -urNXxpk 2.5.31-1/arch/sparc/config.in 2.5.31-2/arch/sparc/config.in
--- 2.5.31-1/arch/sparc/config.in	2002-08-11 15:08:07.000000000 -0500
+++ 2.5.31-2/arch/sparc/config.in	2002-08-13 22:14:51.000000000 -0500
@@ -112,12 +112,10 @@
 
 source drivers/isdn/Config.in
 
-mainmenu_option next_comment
-comment 'SCSI support'
-
-tristate 'SCSI support' CONFIG_SCSI
-
 if [ "$CONFIG_SCSI" != "n" ]; then
+   mainmenu_option next_comment
+   comment 'SCSI support'
+
    comment 'SCSI support type (disk, tape, CDrom)'
 
    dep_tristate '  SCSI disk support' CONFIG_BLK_DEV_SD $CONFIG_SCSI
@@ -152,8 +150,8 @@
    dep_tristate 'Sparc ESP Scsi Driver' CONFIG_SCSI_SUNESP $CONFIG_SCSI
    dep_tristate 'PTI Qlogic,ISP Driver' CONFIG_SCSI_QLOGICPTI $CONFIG_SCSI
    endmenu
+   endmenu
 fi
-endmenu
 
 source drivers/fc4/Config.in
 
diff -urNXxpk 2.5.31-1/arch/sparc64/config.in 2.5.31-2/arch/sparc64/config.in
--- 2.5.31-1/arch/sparc64/config.in	2002-08-11 15:08:09.000000000 -0500
+++ 2.5.31-2/arch/sparc64/config.in	2002-08-13 22:15:12.000000000 -0500
@@ -111,12 +111,10 @@
 fi
 endmenu
 
-mainmenu_option next_comment
-comment 'SCSI support'
-
-tristate 'SCSI support' CONFIG_SCSI
-
 if [ "$CONFIG_SCSI" != "n" ]; then
+   mainmenu_option next_comment
+   comment 'SCSI support'
+
    comment 'SCSI support type (disk, tape, CDrom)'
 
    dep_tristate '  SCSI disk support' CONFIG_BLK_DEV_SD $CONFIG_SCSI
@@ -195,8 +193,8 @@
    fi
 
    endmenu
+   endmenu
 fi
-endmenu
 
 source drivers/fc4/Config.in
 
diff -urNXxpk 2.5.31-1/arch/x86_64/config.in 2.5.31-2/arch/x86_64/config.in
--- 2.5.31-1/arch/x86_64/config.in	2002-07-27 04:14:33.000000000 -0500
+++ 2.5.31-2/arch/x86_64/config.in	2002-08-13 22:11:44.000000000 -0500
@@ -137,15 +137,13 @@
 fi
 endmenu
 
-mainmenu_option next_comment
-comment 'SCSI support'
-
-tristate 'SCSI support' CONFIG_SCSI
 
 if [ "$CONFIG_SCSI" != "n" ]; then
+   mainmenu_option next_comment
+   comment 'SCSI support'
    source drivers/scsi/Config.in
+   endmenu
 fi
-endmenu
 
 source drivers/message/fusion/Config.in
 
diff -urNXxpk 2.5.31-1/drivers/i2c/Config.in 2.5.31-2/drivers/i2c/Config.in
--- 2.5.31-1/drivers/i2c/Config.in	2002-07-19 09:14:57.000000000 -0500
+++ 2.5.31-2/drivers/i2c/Config.in	2002-08-13 22:18:35.000000000 -0500
@@ -1,14 +1,10 @@
 #
-# Character device configuration
+# I2C device configuration
 #
-mainmenu_option next_comment
-comment 'I2C support'
-
-tristate 'I2C support' CONFIG_I2C
-
 if [ "$CONFIG_I2C" != "n" ]; then
+   mainmenu_option next_comment
+   comment 'I2C support'
 
-   dep_tristate 'I2C bit-banging interfaces'  CONFIG_I2C_ALGOBIT $CONFIG_I2C
    if [ "$CONFIG_I2C_ALGOBIT" != "n" ]; then
       dep_tristate '  Philips style parallel port adapter' CONFIG_I2C_PHILIPSPAR $CONFIG_I2C_ALGOBIT $CONFIG_PARPORT
       dep_tristate '  ELV adapter' CONFIG_I2C_ELV $CONFIG_I2C_ALGOBIT
@@ -45,5 +41,5 @@
    dep_tristate 'I2C device interface' CONFIG_I2C_CHARDEV $CONFIG_I2C
    dep_tristate 'I2C /proc interface (required for hardware sensors)' CONFIG_I2C_PROC $CONFIG_I2C $CONFIG_SYSCTL
 
+   endmenu
 fi
-endmenu
diff -urNXxpk 2.5.31-1/drivers/input/Config.in 2.5.31-2/drivers/input/Config.in
--- 2.5.31-1/drivers/input/Config.in	2002-07-19 09:15:13.000000000 -0500
+++ 2.5.31-2/drivers/input/Config.in	2002-08-13 21:31:16.000000000 -0500
@@ -5,8 +5,6 @@
 mainmenu_option next_comment
 comment 'Input device support'
 
-tristate 'Input core support' CONFIG_INPUT
-
 comment 'Userland interfaces'
 dep_tristate '  Keyboard interface' CONFIG_INPUT_KEYBDEV $CONFIG_INPUT
 dep_tristate '  Mouse interface' CONFIG_INPUT_MOUSEDEV $CONFIG_INPUT
diff -urNXxpk 2.5.31-1/drivers/usb/Config.in 2.5.31-2/drivers/usb/Config.in
--- 2.5.31-1/drivers/usb/Config.in	2002-06-09 00:29:12.000000000 -0500
+++ 2.5.31-2/drivers/usb/Config.in	2002-08-13 21:23:18.000000000 -0500
@@ -1,17 +1,10 @@
 #
 # USB device configuration
 #
-mainmenu_option next_comment
-comment 'USB support'
-
-# ARM SA1111 chips have a non-PCI based "OHCI-compatible" USB host interface.
-if [ "$CONFIG_PCI" = "y" -o "$CONFIG_SA1111" = "y" ]; then
-   tristate 'Support for USB' CONFIG_USB
-else
-   define_bool CONFIG_USB n
-fi
-
 if [ "$CONFIG_USB" = "y" -o  "$CONFIG_USB" = "m" ]; then
+   mainmenu_option next_comment
+   comment 'USB support'
+
    source drivers/usb/core/Config.in
 
    source drivers/usb/host/Config.in
@@ -39,6 +32,5 @@
    dep_tristate '  USB Auerswald ISDN support (EXPERIMENTAL)' CONFIG_USB_AUERSWALD $CONFIG_USB $CONFIG_EXPERIMENTAL
    dep_tristate '  USB Diamond Rio500 support (EXPERIMENTAL)' CONFIG_USB_RIO500 $CONFIG_USB $CONFIG_EXPERIMENTAL
    dep_tristate '  Tieman Voyager USB Braille display support (EXPERIMENTAL)' CONFIG_USB_BRLVGER $CONFIG_USB $CONFIG_EXPERIMENTAL
-
+   endmenu
 fi
-endmenu
diff -urNXxpk 2.5.31-1/init/Config.in 2.5.31-2/init/Config.in
--- 2.5.31-1/init/Config.in	2002-06-09 00:27:27.000000000 -0500
+++ 2.5.31-2/init/Config.in	2002-08-13 22:03:13.000000000 -0500
@@ -9,13 +9,30 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
-endmenu
 
-mainmenu_option next_comment
 comment 'Loadable module support'
 bool 'Enable loadable module support' CONFIG_MODULES
 if [ "$CONFIG_MODULES" = "y" ]; then
    bool '  Set version information on all module symbols' CONFIG_MODVERSIONS
    bool '  Kernel module loader' CONFIG_KMOD
 fi
+
+comment 'Other major subsystems'
+
+tristate 'SCSI support' CONFIG_SCSI
+
+# FIXME usb should depend on (PCI || SA1111) - but that causes other ordering problems
+tristate 'USB support' CONFIG_USB
+
+# FIXME parisc, sparc didn't include this menu before - any reason?
+if [ "$CONFIG_ARCH_S390" != "y" ]; then
+   tristate 'Input core support' CONFIG_INPUT
+fi
+
+# FIXME m68k, sparc* didn't include this either but we can't test for them
+if [ "$CONFIG_ARCH_S390" != "y" -a "$CONFIG_SUPERH" != "y" ]; then
+   tristate 'I2C support' CONFIG_I2C
+   dep_tristate '  I2C bit-banging interfaces' CONFIG_I2C_ALGOBIT $CONFIG_I2C
+fi
+
 endmenu

--OgqxwSJOaUobr8KG--
