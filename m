Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317171AbSGZGuc>; Fri, 26 Jul 2002 02:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317192AbSGZGuc>; Fri, 26 Jul 2002 02:50:32 -0400
Received: from [195.63.194.11] ([195.63.194.11]:46342 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317171AbSGZGu2>; Fri, 26 Jul 2002 02:50:28 -0400
Message-ID: <3D40F0C6.7060800@evision.ag>
Date: Fri, 26 Jul 2002 08:48:38 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.28 IDE 102
References: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------010307080302030608030802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010307080302030608030802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Just getting trivia out of the way, so the interresting parts
don't get burried by them:

- Sanitize the menu configuration system.

- Allow to compile atapi.c as a "foundation module" for the
   consuming device type drivers.


--------------010307080302030608030802
Content-Type: text/plain;
 name="ide-102.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-102.diff"

diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h -x autoconf.h -x compile.h -x version.h -x System.map -x gen-devlist -x fixdep -x split-include linux-2.5.28/arch/alpha/config.in linux/arch/alpha/config.in
--- linux-2.5.28/arch/alpha/config.in	2002-07-24 23:03:22.000000000 +0200
+++ linux/arch/alpha/config.in	2002-07-25 23:02:05.000000000 +0200
@@ -283,9 +283,9 @@ if [ "$CONFIG_NET" = "y" ]; then
 fi
 
 mainmenu_option next_comment
-comment 'ATA/IDE/MFM/RLL support'
+comment 'ATA/ATAPI/MFM/RLL support'
 
-tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
+tristate 'ATA/ATAPI/MFM/RLL support' CONFIG_IDE
 
 if [ "$CONFIG_IDE" != "n" ]; then
   source drivers/ide/Config.in
diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h -x autoconf.h -x compile.h -x version.h -x System.map -x gen-devlist -x fixdep -x split-include linux-2.5.28/arch/arm/config.in linux/arch/arm/config.in
--- linux-2.5.28/arch/arm/config.in	2002-07-24 23:03:22.000000000 +0200
+++ linux/arch/arm/config.in	2002-07-25 23:02:05.000000000 +0200
@@ -529,9 +529,9 @@ if [ "$CONFIG_NET" = "y" ]; then
 fi
 
 mainmenu_option next_comment
-comment 'ATA/IDE/MFM/RLL support'
+comment 'ATA/ATAPI/MFM/RLL support'
 
-tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
+tristate 'ATA/ATAPI/MFM/RLL support' CONFIG_IDE
 
 if [ "$CONFIG_IDE" != "n" ]; then
   source drivers/ide/Config.in
diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h -x autoconf.h -x compile.h -x version.h -x System.map -x gen-devlist -x fixdep -x split-include linux-2.5.28/arch/i386/config.in linux/arch/i386/config.in
--- linux-2.5.28/arch/i386/config.in	2002-07-24 23:03:24.000000000 +0200
+++ linux/arch/i386/config.in	2002-07-25 23:02:05.000000000 +0200
@@ -298,18 +298,10 @@ source drivers/pnp/Config.in
 
 source drivers/block/Config.in
 
-source drivers/md/Config.in
-
-if [ "$CONFIG_NET" = "y" ]; then
-   source net/Config.in
-fi
-
-source drivers/telephony/Config.in
-
 mainmenu_option next_comment
-comment 'ATA/IDE/MFM/RLL support'
+comment 'ATA/ATAPI/MFM/RLL device support'
 
-tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
+tristate 'ATA/ATAPI/MFM/RLL device support' CONFIG_IDE
 
 if [ "$CONFIG_IDE" != "n" ]; then
    source drivers/ide/Config.in
@@ -319,15 +311,32 @@ fi
 endmenu
 
 mainmenu_option next_comment
-comment 'SCSI support'
+comment 'SCSI device support'
 
-tristate 'SCSI support' CONFIG_SCSI
+tristate 'SCSI device support' CONFIG_SCSI
 
 if [ "$CONFIG_SCSI" != "n" ]; then
    source drivers/scsi/Config.in
 fi
 endmenu
 
+mainmenu_option next_comment
+comment 'Old non-SCSI/ATAPI CD-ROM drives'
+
+bool 'Support non-SCSI/ATAPI CDROM drives' CONFIG_CD_NO_IDESCSI
+if [ "$CONFIG_CD_NO_IDESCSI" != "n" ]; then
+   source drivers/cdrom/Config.in
+fi
+endmenu
+
+source drivers/md/Config.in
+
+if [ "$CONFIG_NET" = "y" ]; then
+   source net/Config.in
+fi
+
+source drivers/telephony/Config.in
+
 source drivers/message/fusion/Config.in
 
 source drivers/ieee1394/Config.in
@@ -354,15 +363,6 @@ source net/irda/Config.in
 
 source drivers/isdn/Config.in
 
-mainmenu_option next_comment
-comment 'Old CD-ROM drivers (not SCSI, not IDE)'
-
-bool 'Support non-SCSI/IDE/ATAPI CDROM drives' CONFIG_CD_NO_IDESCSI
-if [ "$CONFIG_CD_NO_IDESCSI" != "n" ]; then
-   source drivers/cdrom/Config.in
-fi
-endmenu
-
 #
 # input before char - char/joystick depends on it. As does USB.
 #
diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h -x autoconf.h -x compile.h -x version.h -x System.map -x gen-devlist -x fixdep -x split-include linux-2.5.28/arch/ia64/config.in linux/arch/ia64/config.in
--- linux-2.5.28/arch/ia64/config.in	2002-07-24 23:03:32.000000000 +0200
+++ linux/arch/ia64/config.in	2002-07-25 23:02:05.000000000 +0200
@@ -133,9 +133,9 @@ source drivers/md/Config.in
 source drivers/message/fusion/Config.in
 
 mainmenu_option next_comment
-comment 'ATA/IDE/MFM/RLL support'
+comment 'ATA/ATAPI/MFM/RLL support'
 
-tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
+tristate 'ATA/ATAPI/MFM/RLL support' CONFIG_IDE
 
 if [ "$CONFIG_IDE" != "n" ]; then
   source drivers/ide/Config.in
diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h -x autoconf.h -x compile.h -x version.h -x System.map -x gen-devlist -x fixdep -x split-include linux-2.5.28/arch/m68k/config.in linux/arch/m68k/config.in
--- linux-2.5.28/arch/m68k/config.in	2002-07-24 23:03:30.000000000 +0200
+++ linux/arch/m68k/config.in	2002-07-25 23:02:05.000000000 +0200
@@ -160,9 +160,9 @@ if [ "$CONFIG_MAC" = "y" ]; then
 fi
 
 mainmenu_option next_comment
-comment 'ATA/IDE/MFM/RLL support'
+comment 'ATA/ATAPI/MFM/RLL device support'
 
-tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
+tristate 'ATA/ATAPI/MFM/RLL device support' CONFIG_IDE
 
 if [ "$CONFIG_IDE" != "n" ]; then
   source drivers/ide/Config.in
@@ -172,9 +172,9 @@ fi
 endmenu
 
 mainmenu_option next_comment
-comment 'SCSI support'
+comment 'SCSI device support'
 
-tristate 'SCSI support' CONFIG_SCSI
+tristate 'SCSI device support' CONFIG_SCSI
 
 if [ "$CONFIG_SCSI" != "n" ]; then
 
diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h -x autoconf.h -x compile.h -x version.h -x System.map -x gen-devlist -x fixdep -x split-include linux-2.5.28/arch/mips/config.in linux/arch/mips/config.in
--- linux-2.5.28/arch/mips/config.in	2002-07-24 23:03:29.000000000 +0200
+++ linux/arch/mips/config.in	2002-07-25 23:02:05.000000000 +0200
@@ -343,9 +343,9 @@ if [ "$CONFIG_SGI_IP22" != "y" -a \
      "$CONFIG_DECSTATION" != "y" ]; then
 
    mainmenu_option next_comment
-   comment 'ATA/IDE/MFM/RLL support'
+   comment 'ATA/ATAPI/MFM/RLL support'
     
-   tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
+   tristate 'ATA/ATAPI/MFM/RLL support' CONFIG_IDE
     
    if [ "$CONFIG_IDE" != "n" ]; then
       source drivers/ide/Config.in
diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h -x autoconf.h -x compile.h -x version.h -x System.map -x gen-devlist -x fixdep -x split-include linux-2.5.28/arch/mips64/config.in linux/arch/mips64/config.in
--- linux-2.5.28/arch/mips64/config.in	2002-07-24 23:03:20.000000000 +0200
+++ linux/arch/mips64/config.in	2002-07-25 23:02:05.000000000 +0200
@@ -138,9 +138,9 @@ fi
 source drivers/telephony/Config.in
 
 mainmenu_option next_comment
-comment 'ATA/IDE/MFM/RLL support'
+comment 'ATA/ATAPI/MFM/RLL support'
 
-tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
+tristate 'ATA/ATAPI/MFM/RLL support' CONFIG_IDE
 
 if [ "$CONFIG_IDE" != "n" ]; then
   source drivers/ide/Config.in
diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h -x autoconf.h -x compile.h -x version.h -x System.map -x gen-devlist -x fixdep -x split-include linux-2.5.28/arch/ppc64/config.in linux/arch/ppc64/config.in
--- linux-2.5.28/arch/ppc64/config.in	2002-07-24 23:03:21.000000000 +0200
+++ linux/arch/ppc64/config.in	2002-07-25 23:02:05.000000000 +0200
@@ -92,9 +92,9 @@ if [ "$CONFIG_NET" = "y" ]; then
 fi
 
 mainmenu_option next_comment
-comment 'ATA/IDE/MFM/RLL support'
+comment 'ATA/ATAPI/MFM/RLL support'
 
-tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
+tristate 'ATA/ATAPI/MFM/RLL support' CONFIG_IDE
 
 if [ "$CONFIG_IDE" != "n" ]; then
   source drivers/ide/Config.in
diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h -x autoconf.h -x compile.h -x version.h -x System.map -x gen-devlist -x fixdep -x split-include linux-2.5.28/arch/sh/config.in linux/arch/sh/config.in
--- linux-2.5.28/arch/sh/config.in	2002-07-24 23:03:28.000000000 +0200
+++ linux/arch/sh/config.in	2002-07-25 23:02:05.000000000 +0200
@@ -211,9 +211,9 @@ if [ "$CONFIG_NET" = "y" ]; then
 fi
 
 mainmenu_option next_comment
-comment 'ATA/IDE/MFM/RLL support'
+comment 'ATA/ATAPI/MFM/RLL support'
 
-tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
+tristate 'ATA/ATAPI/MFM/RLL support' CONFIG_IDE
 
 if [ "$CONFIG_IDE" != "n" ]; then
   source drivers/ide/Config.in
diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h -x autoconf.h -x compile.h -x version.h -x System.map -x gen-devlist -x fixdep -x split-include linux-2.5.28/arch/sparc/config.in linux/arch/sparc/config.in
--- linux-2.5.28/arch/sparc/config.in	2002-07-24 23:03:19.000000000 +0200
+++ linux/arch/sparc/config.in	2002-07-25 23:02:06.000000000 +0200
@@ -104,9 +104,9 @@ fi
 if [ "$CONFIG_PCI" = "y" ]; then
 
   mainmenu_option next_comment
-  comment 'ATA/IDE/MFM/RLL support'
+  comment 'ATA/ATAPI/MFM/RLL support'
 
-  tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
+  tristate 'ATA/ATAPI/MFM/RLL support' CONFIG_IDE
 
   if [ "$CONFIG_IDE" != "n" ]; then
     source drivers/ide/Config.in
diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h -x autoconf.h -x compile.h -x version.h -x System.map -x gen-devlist -x fixdep -x split-include linux-2.5.28/arch/sparc64/config.in linux/arch/sparc64/config.in
--- linux-2.5.28/arch/sparc64/config.in	2002-07-24 23:03:24.000000000 +0200
+++ linux/arch/sparc64/config.in	2002-07-25 23:02:06.000000000 +0200
@@ -105,9 +105,9 @@ if [ "$CONFIG_NET" = "y" ]; then
 fi
 
 mainmenu_option next_comment
-comment 'ATA/IDE/MFM/RLL support'
+comment 'ATA/ATAPI/MFM/RLL device support'
 
-tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
+tristate 'ATA/ATAPI/MFM/RLL device support' CONFIG_IDE
 
 if [ "$CONFIG_IDE" != "n" ]; then
   source drivers/ide/Config.in
diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h -x autoconf.h -x compile.h -x version.h -x System.map -x gen-devlist -x fixdep -x split-include linux-2.5.28/arch/x86_64/config.in linux/arch/x86_64/config.in
--- linux-2.5.28/arch/x86_64/config.in	2002-07-24 23:03:23.000000000 +0200
+++ linux/arch/x86_64/config.in	2002-07-25 23:02:06.000000000 +0200
@@ -126,9 +126,9 @@ fi
 source drivers/telephony/Config.in
 
 mainmenu_option next_comment
-comment 'ATA/IDE/MFM/RLL support'
+comment 'ATA/ATAPI/MFM/RLL support'
 
-tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
+tristate 'ATA/ATAPI/MFM/RLL support' CONFIG_IDE
 
 if [ "$CONFIG_IDE" != "n" ]; then
   source drivers/ide/Config.in
diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h -x autoconf.h -x compile.h -x version.h -x System.map -x gen-devlist -x fixdep -x split-include linux-2.5.28/drivers/ide/Config.help linux/drivers/ide/Config.help
--- linux-2.5.28/drivers/ide/Config.help	2002-07-24 23:03:31.000000000 +0200
+++ linux/drivers/ide/Config.help	2002-07-25 23:02:06.000000000 +0200
@@ -84,6 +84,16 @@ CONFIG_BLK_DEV_IDECS
   Support for outboard IDE disks, tape drives, and CD-ROM drives
   connected through a  PCMCIA card.
 
+CONFIG_ATAPI
+  If you wish to enable basic support for devices attached to the system 
+  through the ATA interface, and which are using using the ATAPI protocol
+  (CD-ROM, CD-RW, DVD, DVD-RW, LS120, ZIP, ...), say Y.
+  
+  If you want to compile the driver as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want),
+  say M here and read <file:Documentation/modules.txt>.  The module
+  will be called atapi.o.
+  
 CONFIG_BLK_DEV_IDECD
   If you have a CD-ROM drive using the ATAPI protocol, say Y. ATAPI is
   a newer protocol used by IDE CD-ROM and TAPE drives, similar to the
diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h -x autoconf.h -x compile.h -x version.h -x System.map -x gen-devlist -x fixdep -x split-include linux-2.5.28/drivers/ide/Config.in linux/drivers/ide/Config.in
--- linux-2.5.28/drivers/ide/Config.in	2002-07-24 23:03:31.000000000 +0200
+++ linux/drivers/ide/Config.in	2002-07-25 23:02:06.000000000 +0200
@@ -1,40 +1,37 @@
 #
-# IDE ATA ATAPI Block device driver configuration
-#
-# Andre Hedrick <andre@linux-ide.org>
+# ATA/ATAPI block device driver configuration
 #
-mainmenu_option next_comment
-comment 'ATA and ATAPI Block devices'
-
-dep_tristate 'Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support' CONFIG_BLK_DEV_IDE $CONFIG_IDE
-comment 'Please see Documentation/ide.txt for help/info on IDE drives'
+dep_tristate 'Enhanced ATA/ATAPI device (disk,cdrom,...) support' CONFIG_BLK_DEV_IDE $CONFIG_IDE
 if [ "$CONFIG_BLK_DEV_IDE" != "n" ]; then
    dep_bool '  Use old disk-only driver on primary interface' CONFIG_BLK_DEV_HD_IDE $CONFIG_X86
    define_bool CONFIG_BLK_DEV_HD $CONFIG_BLK_DEV_HD_IDE
 
-   dep_tristate '  Include IDE/ATA-2 DISK support' CONFIG_BLK_DEV_IDEDISK $CONFIG_BLK_DEV_IDE
-   dep_mbool '    Use multi-mode by default' CONFIG_IDEDISK_MULTI_MODE $CONFIG_BLK_DEV_IDEDISK
-   dep_mbool '    Auto-Geometry Resizing support' CONFIG_IDEDISK_STROKE $CONFIG_BLK_DEV_IDEDISK
-   dep_tristate '  PCMCIA IDE support' CONFIG_BLK_DEV_IDECS $CONFIG_BLK_DEV_IDE $CONFIG_PCMCIA
-   dep_tristate '  Include IDE/ATAPI CDROM support' CONFIG_BLK_DEV_IDECD $CONFIG_BLK_DEV_IDE
-   dep_tristate '  Include IDE/ATAPI TAPE support' CONFIG_BLK_DEV_IDETAPE $CONFIG_BLK_DEV_IDE
-   dep_tristate '  Include IDE/ATAPI FLOPPY support' CONFIG_BLK_DEV_IDEFLOPPY $CONFIG_BLK_DEV_IDE
-   dep_tristate '  SCSI emulation support' CONFIG_BLK_DEV_IDESCSI $CONFIG_BLK_DEV_IDE $CONFIG_SCSI
+   dep_tristate '  ATA disk support' CONFIG_BLK_DEV_IDEDISK $CONFIG_BLK_DEV_IDE
+   dep_bool '    Use multi-mode by default' CONFIG_IDEDISK_MULTI_MODE $CONFIG_BLK_DEV_IDEDISK
+   dep_bool '    Auto-Geometry Resizing support' CONFIG_IDEDISK_STROKE $CONFIG_BLK_DEV_IDEDISK
+   
+   dep_tristate '  ATAPI device support (CD-ROM, floppy)' CONFIG_ATAPI $CONFIG_BLK_DEV_IDE
+   dep_tristate '    CD-ROM support' CONFIG_BLK_DEV_IDECD $CONFIG_ATAPI $CONFIG_BLK_DEV_IDE
+   dep_tristate '    Tape support' CONFIG_BLK_DEV_IDETAPE $CONFIG_ATAPI $CONFIG_BLK_DEV_IDE
+   dep_tristate '    Floppy support' CONFIG_BLK_DEV_IDEFLOPPY $CONFIG_ATAPI $CONFIG_BLK_DEV_IDE
+   dep_tristate '    SCSI emulation support' CONFIG_BLK_DEV_IDESCSI $CONFIG_ATAPI $CONFIG_BLK_DEV_IDE $CONFIG_SCSI
+   
+   dep_tristate '  PCMCIA/CardBus support' CONFIG_BLK_DEV_IDECS $CONFIG_BLK_DEV_IDE $CONFIG_PCMCIA
 
-   comment 'ATA host chip set support'
-   dep_bool '  CMD640 chip set bugfix/support' CONFIG_BLK_DEV_CMD640 $CONFIG_X86
+   comment 'ATA host controller support'
+   dep_bool '  RZ1000 bugfix/support' CONFIG_BLK_DEV_RZ1000 $CONFIG_X86
+   dep_bool '  CMD640 bugfix/support' CONFIG_BLK_DEV_CMD640 $CONFIG_X86
    dep_bool '    CMD640 enhanced support' CONFIG_BLK_DEV_CMD640_ENHANCED $CONFIG_BLK_DEV_CMD640
    dep_bool '  ISA-PNP support' CONFIG_BLK_DEV_ISAPNP $CONFIG_ISAPNP
-   if [ "$CONFIG_PCI" = "y" ]; then
-      dep_bool '  RZ1000 chip set bugfix/support' CONFIG_BLK_DEV_RZ1000 $CONFIG_X86
-      comment '  PCI host chip set support'
-      dep_bool '    Boot off-board chip sets first support' CONFIG_BLK_DEV_OFFBOARD $CONFIG_PCI
-      dep_bool '    Sharing PCI ATA interrupts support' CONFIG_IDEPCI_SHARE_IRQ $CONFIG_PCI
+   if [ "$CONFIG_PCI" != "n" ]; then
+      comment '  PCI host controller support'
+      dep_bool '    Boot off-board controllers first' CONFIG_BLK_DEV_OFFBOARD $CONFIG_PCI
+      dep_bool '    Sharing PCI ATA interrupts' CONFIG_IDEPCI_SHARE_IRQ $CONFIG_PCI
       dep_bool '    Generic PCI bus-master DMA support' CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_PCI
       dep_bool '      Use PCI DMA by default when available' CONFIG_IDEDMA_PCI_AUTO $CONFIG_BLK_DEV_IDEDMA_PCI
       dep_bool '      Enable DMA only for disks ' CONFIG_IDEDMA_ONLYDISK $CONFIG_IDEDMA_PCI_AUTO
       define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PCI
-      dep_bool '    ATA tagged command queueing (DANGEROUS)' CONFIG_BLK_DEV_IDE_TCQ $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_EXPERIMENTAL
+      dep_bool '    Tagged command queueing (DANGEROUS)' CONFIG_BLK_DEV_IDE_TCQ $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_EXPERIMENTAL
       dep_bool '      TCQ on by default' CONFIG_BLK_DEV_IDE_TCQ_DEFAULT $CONFIG_BLK_DEV_IDE_TCQ
       if [ "$CONFIG_BLK_DEV_IDE_TCQ" != "n" ]; then
          int '      Default queue depth' CONFIG_BLK_DEV_IDE_TCQ_DEPTH 32
@@ -110,7 +107,7 @@ if [ "$CONFIG_BLK_DEV_IDE" != "n" ]; the
    fi
 
    # assume no ISA -> also no VLB
-   dep_bool '  Other ISA/VLB IDE chipset support' CONFIG_IDE_CHIPSETS $CONFIG_ISA
+   dep_bool '  ISA/VLB IDE chipset support' CONFIG_IDE_CHIPSETS $CONFIG_ISA
    if [ "$CONFIG_IDE_CHIPSETS" = "y" ]; then
       comment 'Note: most of these also require special kernel boot parameters'
       bool '    ALI M14xx support' CONFIG_BLK_DEV_ALI14XX
@@ -122,15 +119,13 @@ if [ "$CONFIG_BLK_DEV_IDE" != "n" ]; the
       dep_tristate '    QDI QD65xx support' CONFIG_BLK_DEV_QD65XX $CONFIG_BLK_DEV_IDE
       bool '    UMC-8672 support' CONFIG_BLK_DEV_UMC8672
    fi
-   if [ "$CONFIG_BLK_DEV_IDEDMA_PCI" = "y" -o \
-        "$CONFIG_BLK_DEV_IDEDMA_PMAC" = "y" -o \
-        "$CONFIG_BLK_DEV_IDEDMA_ICS" = "y" ]; then
+   if [ "$CONFIG_BLK_DEV_IDEDMA_PCI" != "n" -o \
+        "$CONFIG_BLK_DEV_IDEDMA_PMAC" != "n" -o \
+        "$CONFIG_BLK_DEV_IDEDMA_ICS" != "n" ]; then
       bool '  IGNORE word93 Validation BITS' CONFIG_IDEDMA_IVB
    fi
-   
-   define_bool  CONFIG_ATAPI y
 else
-   bool 'Old hard disk (MFM/RLL/IDE) driver' CONFIG_BLK_DEV_HD_ONLY
+   bool 'Old disk only (MFM/RLL/IDE) driver' CONFIG_BLK_DEV_HD_ONLY
    define_bool CONFIG_BLK_DEV_HD $CONFIG_BLK_DEV_HD_ONLY
 fi
 
@@ -142,8 +137,6 @@ else
    define_bool CONFIG_IDEDMA_AUTO n
 fi
 
-dep_tristate 'Support for IDE Raid controllers (EXPERIMENTAL)' CONFIG_BLK_DEV_ATARAID $CONFIG_BLK_DEV_IDE $CONFIG_EXPERIMENTAL
-dep_tristate '   Support Promise software RAID (Fasttrak(tm)) (EXPERIMENTAL)' CONFIG_BLK_DEV_ATARAID_PDC $CONFIG_BLK_DEV_IDE $CONFIG_EXPERIMENTAL $CONFIG_BLK_DEV_ATARAID
-dep_tristate '   Highpoint 370 software RAID (EXPERIMENTAL)' CONFIG_BLK_DEV_ATARAID_HPT $CONFIG_BLK_DEV_IDE $CONFIG_EXPERIMENTAL $CONFIG_BLK_DEV_ATARAID
-
-endmenu
+dep_tristate 'Support for software RAID controllers (EXPERIMENTAL)' CONFIG_BLK_DEV_ATARAID $CONFIG_BLK_DEV_IDE $CONFIG_EXPERIMENTAL
+dep_tristate '   Support Promise (Fasttrak(tm)) (EXPERIMENTAL)' CONFIG_BLK_DEV_ATARAID_PDC $CONFIG_BLK_DEV_IDE $CONFIG_EXPERIMENTAL $CONFIG_BLK_DEV_ATARAID
+dep_tristate '   Highpoint 370 EXPERIMENTAL)' CONFIG_BLK_DEV_ATARAID_HPT $CONFIG_BLK_DEV_IDE $CONFIG_EXPERIMENTAL $CONFIG_BLK_DEV_ATARAID
diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h -x autoconf.h -x compile.h -x version.h -x System.map -x gen-devlist -x fixdep -x split-include linux-2.5.28/drivers/ide/Makefile linux/drivers/ide/Makefile
--- linux-2.5.28/drivers/ide/Makefile	2002-07-24 23:03:29.000000000 +0200
+++ linux/drivers/ide/Makefile	2002-07-25 23:02:06.000000000 +0200
@@ -15,7 +15,7 @@ obj-$(CONFIG_BLK_DEV_HD)	+= hd.o
 obj-$(CONFIG_BLK_DEV_IDE)       += ide-mod.o
 obj-$(CONFIG_BLK_DEV_IDECS)     += ide-cs.o
 obj-$(CONFIG_BLK_DEV_IDEDISK)   += ide-disk.o
-# obj-$(CONFIG_ATAPI)		+= atapi.o
+obj-$(CONFIG_ATAPI)		+= atapi.o
 obj-$(CONFIG_BLK_DEV_IDECD)     += ide-cd.o
 obj-$(CONFIG_BLK_DEV_IDETAPE)   += ide-tape.o
 obj-$(CONFIG_BLK_DEV_IDEFLOPPY) += ide-floppy.o
@@ -69,6 +69,6 @@ obj-$(CONFIG_BLK_DEV_ATARAID_PDC)	+= pdc
 obj-$(CONFIG_BLK_DEV_ATARAID_HPT)	+= hptraid.o
 
 ide-mod-objs	:= device.o ide-taskfile.o main.o ide.o probe.o \
-		   ioctl.o atapi.o ata-timing.o $(ide-obj-y)
+		   ioctl.o ata-timing.o $(ide-obj-y)
 
 include $(TOPDIR)/Rules.make

--------------010307080302030608030802--

