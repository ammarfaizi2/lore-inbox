Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131412AbQLGSih>; Thu, 7 Dec 2000 13:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131388AbQLGSi2>; Thu, 7 Dec 2000 13:38:28 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:7684 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S131424AbQLGSiP>; Thu, 7 Dec 2000 13:38:15 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200012071755.SAA00978@green.mif.pg.gda.pl>
Subject: [PATCH] i386 config
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 7 Dec 2000 18:55:42 +0100 (CET)
Cc: linux-kernel@vger.kernel.org (kernel list), tao@acc.umu.se
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    I noticed that it is impossible to select "Math emulation" in
test12-pre* basing on the default config in a single configuration process
using Menuconfig or xconfig. It is because of CONFIG_X86_FXSR being never
unset/set to "n". The following patch fixes this problem (the first chunk)
and it also contains some indentation fixes.

   The second problem (the second patch) concerns CONFIG_JFFS_FS checking
in fs/config.in. Checking for != "n" there breaks xconfig, as it never 
sets dep_* variables to "n". It is a well known xconfig bug, but not
easily fixable.

Regards
    Andrzej

******************************************************************
--- arch/i386/config.in.old	Tue Dec  5 22:23:32 2000
+++ arch/i386/config.in	Tue Dec  5 22:31:09 2000
@@ -44,6 +44,9 @@
 #
 # Define implied options from the CPU selection here
 #
+
+unset CONFIG_X86_FXSR
+
 if [ "$CONFIG_M386" = "y" ]; then
    define_bool CONFIG_X86_CMPXCHG n
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
@@ -162,15 +165,15 @@
 bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
 bool 'Symmetric multi-processing support' CONFIG_SMP
 if [ "$CONFIG_SMP" != "y" ]; then
-    bool 'APIC and IO-APIC support on uniprocessors' CONFIG_X86_UP_IOAPIC
-    if [ "$CONFIG_X86_UP_IOAPIC" = "y" ]; then
-       define_bool CONFIG_X86_IO_APIC y
-       define_bool CONFIG_X86_LOCAL_APIC y
-    fi
+   bool 'APIC and IO-APIC support on uniprocessors' CONFIG_X86_UP_IOAPIC
+   if [ "$CONFIG_X86_UP_IOAPIC" = "y" ]; then
+      define_bool CONFIG_X86_IO_APIC y
+      define_bool CONFIG_X86_LOCAL_APIC y
+   fi
 fi
 
 if [ "$CONFIG_SMP" = "y" -a "$CONFIG_X86_CMPXCHG" = "y" ]; then
-    define_bool CONFIG_HAVE_DEC_LOCK y
+   define_bool CONFIG_HAVE_DEC_LOCK y
 fi
 endmenu
 
@@ -278,10 +281,10 @@
 tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
 
 if [ "$CONFIG_IDE" != "n" ]; then
-  source drivers/ide/Config.in
+   source drivers/ide/Config.in
 else
-  define_bool CONFIG_BLK_DEV_IDE_MODES n
-  define_bool CONFIG_BLK_DEV_HD n
+   define_bool CONFIG_BLK_DEV_IDE_MODES n
+   define_bool CONFIG_BLK_DEV_HD n
 fi
 endmenu
 
******************************************************************
--- fs/Config.in.old	Tue Dec  5 22:48:02 2000
+++ fs/Config.in	Tue Dec  5 22:49:22 2000
@@ -25,8 +25,8 @@
 dep_tristate '  VFAT (Windows-95) fs support' CONFIG_VFAT_FS $CONFIG_FAT_FS
 dep_tristate 'EFS file system support (read only) (EXPERIMENTAL)' CONFIG_EFS_FS $CONFIG_EXPERIMENTAL
 dep_tristate 'Journalling Flash File System (JFFS) support (EXPERIMENTAL)' CONFIG_JFFS_FS $CONFIG_EXPERIMENTAL $CONFIG_MTD
-if [ "$CONFIG_JFFS_FS" != "n" ] ; then
-	int 'JFFS debugging verbosity (0 = quiet, 3 = noisy)' CONFIG_JFFS_FS_VERBOSE 0
+if [ "$CONFIG_JFFS_FS" = "y" -o "$CONFIG_JFFS_FS" = "m" ] ; then
+   int 'JFFS debugging verbosity (0 = quiet, 3 = noisy)' CONFIG_JFFS_FS_VERBOSE 0
 fi
 tristate 'Compressed ROM file system support' CONFIG_CRAMFS
 tristate 'Simple RAM-based file system support' CONFIG_RAMFS
******************************************************************

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
