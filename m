Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318403AbSGRWYE>; Thu, 18 Jul 2002 18:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318407AbSGRWYE>; Thu, 18 Jul 2002 18:24:04 -0400
Received: from mta06bw.bigpond.com ([139.134.6.96]:42224 "EHLO
	mta06bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S318403AbSGRWWa>; Thu, 18 Jul 2002 18:22:30 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: torvalds@transmeta.com
Subject: [patch] Mass storage device config re-org
Date: Fri, 19 Jul 2002 08:21:33 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_X3UG9982IV3TT5FLBAKV"
Message-Id: <200207190821.33547.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_X3UG9982IV3TT5FLBAKV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

I'm looking at usability cleanups on the configuration files ([Cc]onfig.in).

The main concepts are to keep related menu entries together without excessive
resort to 'misc" and "general", and to keep xconfig and menuconfig entries to
about a screenful. Those two concepts are sometimes contradictory....

The current focus is on the various mass storage drivers. I plan to group them
all under a single menu entry (done for i386, easily extensible to other arch,
except for sparc of course). The main changes are pulling the parallel port
IDE stuff out of the rest of block to a separate menu item, pulling QIC02 and
ftape out of the rest of char(!) and some changes to the way IDE configuration
works. I got a response from Martin Dalecki (to an RFC patch to lkml) that
the IDE changes looked OK.

I'll work the other arch's when this bit is in.

Please apply. 

Brad

-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
--------------Boundary-00=_X3UG9982IV3TT5FLBAKV
Content-Type: text/x-diff;
  charset="us-ascii";
  name="config-storage-2.5.26.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="config-storage-2.5.26.patch"

diff -Naur -X dontdiff linux-2.5.26-clean/arch/alpha/config.in linux-2.5.26-confighacking/arch/alpha/config.in
--- linux-2.5.26-clean/arch/alpha/config.in	Wed Jul 17 09:49:28 2002
+++ linux-2.5.26-confighacking/arch/alpha/config.in	Thu Jul 18 22:58:21 2002
@@ -276,6 +276,8 @@
 
 source drivers/block/Config.in
 
+source drivers/block/Config-paride.in
+
 source drivers/md/Config.in
 
 if [ "$CONFIG_NET" = "y" ]; then
@@ -285,13 +287,8 @@
 mainmenu_option next_comment
 comment 'ATA/IDE/MFM/RLL support'
 
-tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
+source drivers/ide/Config.in
 
-if [ "$CONFIG_IDE" != "n" ]; then
-  source drivers/ide/Config.in
-else
-  define_bool CONFIG_BLK_DEV_HD n
-fi
 endmenu
 
 mainmenu_option next_comment
@@ -336,6 +333,7 @@
 endmenu
 
 source drivers/char/Config.in
+source drivers/char/Config-tape.in
 
 #source drivers/misc/Config.in
 
diff -Naur -X dontdiff linux-2.5.26-clean/arch/arm/config.in linux-2.5.26-confighacking/arch/arm/config.in
--- linux-2.5.26-clean/arch/arm/config.in	Wed Jul 17 09:49:28 2002
+++ linux-2.5.26-confighacking/arch/arm/config.in	Thu Jul 18 22:58:21 2002
@@ -505,6 +505,7 @@
 
 source drivers/pnp/Config.in
 source drivers/block/Config.in
+source drivers/block/Config-paride.in
 source drivers/md/Config.in
 
 if [ "$CONFIG_ARCH_ACORN" = "y" ]; then
@@ -531,13 +532,8 @@
 mainmenu_option next_comment
 comment 'ATA/IDE/MFM/RLL support'
 
-tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
+source drivers/ide/Config.in
 
-if [ "$CONFIG_IDE" != "n" ]; then
-  source drivers/ide/Config.in
-else
-  define_bool CONFIG_BLK_DEV_HD n
-fi
 endmenu
 
 mainmenu_option next_comment
@@ -574,6 +570,7 @@
       define_bool CONFIG_RPCMOUSE y
    fi
 fi
+source drivers/char/Config-tape.in
 
 source drivers/media/Config.in
 
diff -Naur -X dontdiff linux-2.5.26-clean/arch/cris/config.in linux-2.5.26-confighacking/arch/cris/config.in
--- linux-2.5.26-clean/arch/cris/config.in	Wed Jul 17 09:49:34 2002
+++ linux-2.5.26-confighacking/arch/cris/config.in	Thu Jul 18 22:58:21 2002
@@ -133,6 +133,8 @@
 
 source drivers/block/Config.in
 
+source drivers/block/Config-paride.in
+
 source drivers/md/Config.in
 
 if [ "$CONFIG_NET" = "y" ]; then
@@ -144,13 +146,8 @@
 mainmenu_option next_comment
 comment 'ATA/IDE/MFM/RLL support'
 
-tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
+source drivers/ide/Config.in
 
-if [ "$CONFIG_IDE" != "n" ]; then
-  source drivers/ide/Config.in
-else
-  define_bool CONFIG_BLK_DEV_HD n
-fi
 endmenu
 
 mainmenu_option next_comment
@@ -201,6 +198,7 @@
 #
 source drivers/input/Config.in
 source drivers/char/Config.in
+source drivers/char/Config-tape.in
 
 #source drivers/misc/Config.in
 
diff -Naur -X dontdiff linux-2.5.26-clean/arch/i386/config.in linux-2.5.26-confighacking/arch/i386/config.in
--- linux-2.5.26-clean/arch/i386/config.in	Wed Jul 17 09:49:30 2002
+++ linux-2.5.26-confighacking/arch/i386/config.in	Thu Jul 18 22:58:21 2002
@@ -294,33 +294,16 @@
 
 endmenu
 
-source drivers/mtd/Config.in
-
 source drivers/parport/Config.in
 
 source drivers/pnp/Config.in
 
-source drivers/block/Config.in
-
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
+comment 'Mass storage support'
 
-tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
+source drivers/block/Config.in
 
-if [ "$CONFIG_IDE" != "n" ]; then
-   source drivers/ide/Config.in
-else
-   define_bool CONFIG_BLK_DEV_HD n
-fi
-endmenu
+source drivers/ide/Config.in
 
 mainmenu_option next_comment
 comment 'SCSI support'
@@ -332,6 +315,31 @@
 fi
 endmenu
 
+mainmenu_option next_comment
+comment 'Old CD-ROM drivers (not SCSI, not IDE)'
+
+bool 'Support non-SCSI/IDE/ATAPI CDROM drives' CONFIG_CD_NO_IDESCSI
+if [ "$CONFIG_CD_NO_IDESCSI" != "n" ]; then
+   source drivers/cdrom/Config.in
+fi
+endmenu
+
+source drivers/block/Config-paride.in
+
+source drivers/mtd/Config.in
+
+source drivers/md/Config.in
+
+source drivers/char/Config-tape.in
+
+endmenu
+
+if [ "$CONFIG_NET" = "y" ]; then
+   source net/Config.in
+fi
+
+source drivers/telephony/Config.in
+
 source drivers/message/fusion/Config.in
 
 source drivers/ieee1394/Config.in
@@ -358,15 +366,6 @@
 
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
diff -Naur -X dontdiff linux-2.5.26-clean/arch/ia64/config.in linux-2.5.26-confighacking/arch/ia64/config.in
--- linux-2.5.26-clean/arch/ia64/config.in	Wed Jul 17 09:49:39 2002
+++ linux-2.5.26-confighacking/arch/ia64/config.in	Thu Jul 18 22:58:21 2002
@@ -127,6 +127,7 @@
 source drivers/mtd/Config.in
 source drivers/pnp/Config.in
 source drivers/block/Config.in
+source drivers/block/Config-paride.in
 source drivers/ieee1394/Config.in
 source drivers/message/i2o/Config.in
 source drivers/md/Config.in
@@ -135,13 +136,8 @@
 mainmenu_option next_comment
 comment 'ATA/IDE/MFM/RLL support'
 
-tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
+source drivers/ide/Config.in
 
-if [ "$CONFIG_IDE" != "n" ]; then
-  source drivers/ide/Config.in
-else
-  define_bool CONFIG_BLK_DEV_HD n
-fi
 endmenu
 
 else # ! HP_SIM
@@ -200,6 +196,7 @@
 #
 source drivers/input/Config.in
 source drivers/char/Config.in
+source drivers/char/Config-tape.in
 
 #source drivers/misc/Config.in
 
diff -Naur -X dontdiff linux-2.5.26-clean/arch/m68k/config.in linux-2.5.26-confighacking/arch/m68k/config.in
--- linux-2.5.26-clean/arch/m68k/config.in	Wed Jul 17 09:49:36 2002
+++ linux-2.5.26-confighacking/arch/m68k/config.in	Thu Jul 18 22:58:21 2002
@@ -149,6 +149,8 @@
 
 source drivers/block/Config.in
 
+source drivers/block/Config-paride.in
+
 source drivers/md/Config.in
 
 if [ "$CONFIG_NET" = "y" ]; then
@@ -162,13 +164,8 @@
 mainmenu_option next_comment
 comment 'ATA/IDE/MFM/RLL support'
 
-tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
+source drivers/ide/Config.in
 
-if [ "$CONFIG_IDE" != "n" ]; then
-  source drivers/ide/Config.in
-else
-  define_bool CONFIG_BLK_DEV_HD n
-fi
 endmenu
 
 mainmenu_option next_comment
diff -Naur -X dontdiff linux-2.5.26-clean/arch/mips/config.in linux-2.5.26-confighacking/arch/mips/config.in
--- linux-2.5.26-clean/arch/mips/config.in	Wed Jul 17 09:49:35 2002
+++ linux-2.5.26-confighacking/arch/mips/config.in	Thu Jul 18 22:58:22 2002
@@ -331,6 +331,8 @@
 
 source drivers/block/Config.in
 
+source drivers/block/Config-paride.in
+
 source drivers/md/Config.in
 
 if [ "$CONFIG_NET" = "y" ]; then
@@ -345,13 +347,8 @@
    mainmenu_option next_comment
    comment 'ATA/IDE/MFM/RLL support'
     
-   tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
-    
-   if [ "$CONFIG_IDE" != "n" ]; then
-      source drivers/ide/Config.in
-   else
-      define_bool CONFIG_BLK_DEV_HD n
-   fi
+   source drivers/ide/Config.in
+
    endmenu
 fi
 
@@ -400,6 +397,7 @@
 endmenu
 
 source drivers/char/Config.in
+source drivers/char/Config-tape.in
 
 source drivers/media/Config.in
 
diff -Naur -X dontdiff linux-2.5.26-clean/arch/mips64/config.in linux-2.5.26-confighacking/arch/mips64/config.in
--- linux-2.5.26-clean/arch/mips64/config.in	Wed Jul 17 09:49:26 2002
+++ linux-2.5.26-confighacking/arch/mips64/config.in	Thu Jul 18 22:58:22 2002
@@ -129,6 +129,8 @@
 
 source drivers/block/Config.in
 
+source drivers/block/Config-paride.in
+
 source drivers/md/Config.in
 
 if [ "$CONFIG_NET" = "y" ]; then
@@ -140,13 +142,8 @@
 mainmenu_option next_comment
 comment 'ATA/IDE/MFM/RLL support'
 
-tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
+source drivers/ide/Config.in
 
-if [ "$CONFIG_IDE" != "n" ]; then
-  source drivers/ide/Config.in
-else
-  define_bool CONFIG_BLK_DEV_HD n
-fi
 endmenu
 
 mainmenu_option next_comment
@@ -191,6 +188,7 @@
 endmenu
 
 source drivers/char/Config.in
+source drivers/char/Config-tape.in
 
 #source drivers/misc/Config.in
 
diff -Naur -X dontdiff linux-2.5.26-clean/arch/parisc/config.in linux-2.5.26-confighacking/arch/parisc/config.in
--- linux-2.5.26-clean/arch/parisc/config.in	Wed Jul 17 09:49:38 2002
+++ linux-2.5.26-confighacking/arch/parisc/config.in	Thu Jul 18 22:58:22 2002
@@ -98,6 +98,8 @@
 
 source drivers/block/Config.in
 
+source drivers/block/Config-paride.in
+
 if [ "$CONFIG_NET" = "y" ]; then
   source net/Config.in
 fi
@@ -163,6 +165,7 @@
 fi
 
 source drivers/char/Config.in
+source drivers/char/Config-tape.in
 
 source fs/Config.in
 
diff -Naur -X dontdiff linux-2.5.26-clean/arch/ppc/config.in linux-2.5.26-confighacking/arch/ppc/config.in
--- linux-2.5.26-clean/arch/ppc/config.in	Wed Jul 17 09:49:22 2002
+++ linux-2.5.26-confighacking/arch/ppc/config.in	Thu Jul 18 22:58:22 2002
@@ -413,6 +413,7 @@
 source drivers/mtd/Config.in
 source drivers/pnp/Config.in
 source drivers/block/Config.in
+source drivers/block/Config-paride.in
 source drivers/md/Config.in
 
 if [ "$CONFIG_NET" = "y" ]; then
@@ -422,12 +423,8 @@
 mainmenu_option next_comment
 comment 'ATA/IDE/MFM/RLL support'
 
-tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
-if [ "$CONFIG_IDE" != "n" ]; then
-   source drivers/ide/Config.in
-else
-   define_bool CONFIG_BLK_DEV_HD n
-fi
+source drivers/ide/Config.in
+
 endmenu
 
 mainmenu_option next_comment
@@ -554,6 +551,8 @@
 
 source drivers/char/Config.in
 
+source drivers/char/Config-tape.in
+
 source drivers/media/Config.in
 
 source fs/Config.in
diff -Naur -X dontdiff linux-2.5.26-clean/arch/ppc64/config.in linux-2.5.26-confighacking/arch/ppc64/config.in
--- linux-2.5.26-clean/arch/ppc64/config.in	Wed Jul 17 09:49:26 2002
+++ linux-2.5.26-confighacking/arch/ppc64/config.in	Thu Jul 18 22:58:22 2002
@@ -79,6 +79,7 @@
 source drivers/mtd/Config.in
 source drivers/pnp/Config.in
 source drivers/block/Config.in
+source drivers/block/Config-paride.in
 source drivers/md/Config.in
 
 if [ "$CONFIG_NET" = "y" ]; then
@@ -88,13 +89,8 @@
 mainmenu_option next_comment
 comment 'ATA/IDE/MFM/RLL support'
 
-tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
+source drivers/ide/Config.in
 
-if [ "$CONFIG_IDE" != "n" ]; then
-  source drivers/ide/Config.in
-else
-  define_bool CONFIG_BLK_DEV_HD n
-fi
 endmenu
 
 mainmenu_option next_comment
@@ -188,6 +184,8 @@
 
 source drivers/char/Config.in
 
+source drivers/char/Config-tape.in
+
 source drivers/media/Config.in
 
 source fs/Config.in
diff -Naur -X dontdiff linux-2.5.26-clean/arch/sh/config.in linux-2.5.26-confighacking/arch/sh/config.in
--- linux-2.5.26-clean/arch/sh/config.in	Wed Jul 17 09:49:34 2002
+++ linux-2.5.26-confighacking/arch/sh/config.in	Thu Jul 18 22:58:22 2002
@@ -204,6 +204,8 @@
 
 source drivers/block/Config.in
 
+source drivers/block/Config-paride.in
+
 source drivers/md/Config.in
 
 if [ "$CONFIG_NET" = "y" ]; then
diff -Naur -X dontdiff linux-2.5.26-clean/arch/sparc/config.in linux-2.5.26-confighacking/arch/sparc/config.in
--- linux-2.5.26-clean/arch/sparc/config.in	Wed Jul 17 09:49:25 2002
+++ linux-2.5.26-confighacking/arch/sparc/config.in	Thu Jul 18 22:58:22 2002
@@ -106,13 +106,8 @@
   mainmenu_option next_comment
   comment 'ATA/IDE/MFM/RLL support'
 
-  tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
+  source drivers/ide/Config.in
 
-  if [ "$CONFIG_IDE" != "n" ]; then
-    source drivers/ide/Config.in
-  else
-    define_bool CONFIG_BLK_DEV_HD n
-  fi
   endmenu
 else
   define_bool CONFIG_IDE n
diff -Naur -X dontdiff linux-2.5.26-clean/arch/sparc64/config.in linux-2.5.26-confighacking/arch/sparc64/config.in
--- linux-2.5.26-clean/arch/sparc64/config.in	Wed Jul 17 09:49:30 2002
+++ linux-2.5.26-confighacking/arch/sparc64/config.in	Thu Jul 18 22:58:22 2002
@@ -107,13 +107,8 @@
 mainmenu_option next_comment
 comment 'ATA/IDE/MFM/RLL support'
 
-tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
+source drivers/ide/Config.in
 
-if [ "$CONFIG_IDE" != "n" ]; then
-  source drivers/ide/Config.in
-else
-  define_bool CONFIG_BLK_DEV_HD n
-fi
 endmenu
 
 mainmenu_option next_comment
diff -Naur -X dontdiff linux-2.5.26-clean/arch/x86_64/config.in linux-2.5.26-confighacking/arch/x86_64/config.in
--- linux-2.5.26-clean/arch/x86_64/config.in	Wed Jul 17 09:49:28 2002
+++ linux-2.5.26-confighacking/arch/x86_64/config.in	Thu Jul 18 22:58:22 2002
@@ -117,6 +117,8 @@
 
 source drivers/block/Config.in
 
+source drivers/block/Config-paride.in
+
 source drivers/md/Config.in
 
 if [ "$CONFIG_NET" = "y" ]; then
@@ -128,13 +130,8 @@
 mainmenu_option next_comment
 comment 'ATA/IDE/MFM/RLL support'
 
-tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
+source drivers/ide/Config.in
 
-if [ "$CONFIG_IDE" != "n" ]; then
-  source drivers/ide/Config.in
-else
-  define_bool CONFIG_BLK_DEV_HD n
-fi
 endmenu
 
 mainmenu_option next_comment
@@ -182,6 +179,7 @@
 #
 source drivers/input/Config.in
 source drivers/char/Config.in
+source drivers/char/Config-tape.in
 
 source drivers/misc/Config.in
 
diff -Naur -X dontdiff linux-2.5.26-clean/drivers/block/Config-paride.in linux-2.5.26-confighacking/drivers/block/Config-paride.in
--- linux-2.5.26-clean/drivers/block/Config-paride.in	Thu Jan  1 10:00:00 1970
+++ linux-2.5.26-confighacking/drivers/block/Config-paride.in	Thu Jul 18 22:58:22 2002
@@ -0,0 +1,12 @@
+#
+# Block device driver configuration
+#
+mainmenu_option next_comment
+comment 'Parallel Port IDE device support'
+
+dep_tristate 'Parallel port IDE device support' CONFIG_PARIDE $CONFIG_PARPORT
+if [ "$CONFIG_PARIDE" = "y" -o "$CONFIG_PARIDE" = "m" ]; then
+   source drivers/block/paride/Config.in
+fi
+
+endmenu
diff -Naur -X dontdiff linux-2.5.26-clean/drivers/block/Config.in linux-2.5.26-confighacking/drivers/block/Config.in
--- linux-2.5.26-clean/drivers/block/Config.in	Wed Jul 17 09:49:29 2002
+++ linux-2.5.26-confighacking/drivers/block/Config.in	Thu Jul 18 22:58:22 2002
@@ -29,10 +29,7 @@
    fi
 fi
 dep_tristate 'XT hard disk support' CONFIG_BLK_DEV_XD $CONFIG_ISA
-dep_tristate 'Parallel port IDE device support' CONFIG_PARIDE $CONFIG_PARPORT
-if [ "$CONFIG_PARIDE" = "y" -o "$CONFIG_PARIDE" = "m" ]; then
-   source drivers/block/paride/Config.in
-fi
+
 dep_tristate 'Compaq SMART2 support' CONFIG_BLK_CPQ_DA $CONFIG_PCI
 dep_tristate 'Compaq Smart Array 5xxx support' CONFIG_BLK_CPQ_CISS_DA $CONFIG_PCI 
 dep_mbool '       SCSI tape drive support for Smart Array 5xxx' CONFIG_CISS_SCSI_TAPE $CONFIG_BLK_CPQ_CISS_DA $CONFIG_SCSI
diff -Naur -X dontdiff linux-2.5.26-clean/drivers/char/Config-tape.in linux-2.5.26-confighacking/drivers/char/Config-tape.in
--- linux-2.5.26-clean/drivers/char/Config-tape.in	Thu Jan  1 10:00:00 1970
+++ linux-2.5.26-confighacking/drivers/char/Config-tape.in	Thu Jul 18 22:58:22 2002
@@ -0,0 +1,24 @@
+#
+# Character device configuration
+#
+mainmenu_option next_comment
+comment 'Miscellaneous tape devices'
+
+tristate 'QIC-02 tape support' CONFIG_QIC02_TAPE
+if [ "$CONFIG_QIC02_TAPE" != "n" ]; then
+   bool '  Do you want runtime configuration for QIC-02' CONFIG_QIC02_DYNCONF
+   if [ "$CONFIG_QIC02_DYNCONF" != "y" ]; then
+      comment '  Edit configuration parameters in ./include/linux/tpqic02.h!'
+   else
+      comment '  Setting runtime QIC-02 configuration is done with qic02conf'
+      comment '  from the tpqic02-support package.  It is available at'
+      comment '  metalab.unc.edu or ftp://titus.cfw.com/pub/Linux/util/'
+   fi
+fi
+
+tristate 'Ftape (QIC-80/Travan) support' CONFIG_FTAPE
+if [ "$CONFIG_FTAPE" != "n" ]; then
+   source drivers/char/ftape/Config.in
+fi
+endmenu
+
diff -Naur -X dontdiff linux-2.5.26-clean/drivers/char/Config.in linux-2.5.26-confighacking/drivers/char/Config.in
--- linux-2.5.26-clean/drivers/char/Config.in	Wed Jul 17 09:49:28 2002
+++ linux-2.5.26-confighacking/drivers/char/Config.in	Thu Jul 18 22:58:22 2002
@@ -117,18 +117,6 @@
    bool 'PS/2 mouse (aka "auxiliary device") support' CONFIG_PSMOUSE
 endmenu
 
-tristate 'QIC-02 tape support' CONFIG_QIC02_TAPE
-if [ "$CONFIG_QIC02_TAPE" != "n" ]; then
-   bool '  Do you want runtime configuration for QIC-02' CONFIG_QIC02_DYNCONF
-   if [ "$CONFIG_QIC02_DYNCONF" != "y" ]; then
-      comment '  Edit configuration parameters in ./include/linux/tpqic02.h!'
-   else
-      comment '  Setting runtime QIC-02 configuration is done with qic02conf'
-      comment '  from the tpqic02-support package.  It is available at'
-      comment '  metalab.unc.edu or ftp://titus.cfw.com/pub/Linux/util/'
-   fi
-fi
-
 mainmenu_option next_comment
 comment 'Watchdog Cards'
 bool 'Watchdog Timer Support'	CONFIG_WATCHDOG
@@ -190,14 +178,6 @@
    dep_tristate 'Sony Vaio Programmable I/O Control Device support (EXPERIMENTAL)' CONFIG_SONYPI $CONFIG_PCI
 fi
 
-mainmenu_option next_comment
-comment 'Ftape, the floppy tape device driver'
-tristate 'Ftape (QIC-80/Travan) support' CONFIG_FTAPE
-if [ "$CONFIG_FTAPE" != "n" ]; then
-   source drivers/char/ftape/Config.in
-fi
-endmenu
-
 dep_tristate '/dev/agpgart (AGP Support)' CONFIG_AGP $CONFIG_DRM_AGP
 if [ "$CONFIG_AGP" != "n" ]; then
    bool '  Intel 440LX/BX/GX and I815/I820/I830M/I830MP/I840/I845/I850/I860 support' CONFIG_AGP_INTEL
diff -Naur -X dontdiff linux-2.5.26-clean/drivers/ide/Config.in linux-2.5.26-confighacking/drivers/ide/Config.in
--- linux-2.5.26-clean/drivers/ide/Config.in	Wed Jul 17 09:49:37 2002
+++ linux-2.5.26-confighacking/drivers/ide/Config.in	Thu Jul 18 22:58:22 2002
@@ -6,6 +6,8 @@
 mainmenu_option next_comment
 comment 'ATA and ATAPI Block devices'
 
+tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
+
 dep_tristate 'Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support' CONFIG_BLK_DEV_IDE $CONFIG_IDE
 comment 'Please see Documentation/ide.txt for help/info on IDE drives'
 if [ "$CONFIG_BLK_DEV_IDE" != "n" ]; then

--------------Boundary-00=_X3UG9982IV3TT5FLBAKV--

