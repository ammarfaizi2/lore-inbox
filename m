Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261482AbSIZUBm>; Thu, 26 Sep 2002 16:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261480AbSIZUA1>; Thu, 26 Sep 2002 16:00:27 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:26337 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261476AbSIZUAD>; Thu, 26 Sep 2002 16:00:03 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.38 - Config.in: Second extended fs rename / move Ext3 to a wiser place
Date: Thu, 26 Sep 2002 21:53:56 +0200
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Message-Id: <200209261944.23447.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_WX92JE19UT9Z3RMRBZ3S"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_WX92JE19UT9Z3RMRBZ3S
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi there,

these are just cosmetic fixes.

I think we can do the following:

1. rename: "Second extended fs support" to "Ext2 file system support"
    (to be equal to Ext3fs)

2. move: "Ext3 journalling file system support" near under to Ext2 fs.

Coments?

--

I also thought about splitting the "Journal Filesystems" into an extra me=
nu=20
option just to clear up the whole menu a bit since we have: ReiserFS, Ext=
3,=20
XFS, JFS, JFFS and JFFSv2. I cooked up a patch which does it, also attach=
ed!

Comments?



All against 2.5.38 vanilla.

Linus, if ok, please apply either 2.5_1* and 2.5_2* or 2.5_1* and the pat=
ch=20
which removes current journalfs entries and creates a new menu option.

--=20
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.
--------------Boundary-00=_WX92JE19UT9Z3RMRBZ3S
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.5_1-ext2-rename.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.5_1-ext2-rename.patch"

--- linux-2.5-old/fs/Config.in		Thu Sep 26 12:19:14 2002
+++ linux-2.5-new/fs/Config.in		Thu Sep 26 19:26:31 2002
@@ -91,7 +91,7 @@
 
 tristate 'ROM file system support' CONFIG_ROMFS_FS
 
-tristate 'Second extended fs support' CONFIG_EXT2_FS
+tristate 'Ext2 file system support' CONFIG_EXT2_FS
 
 tristate 'System V/Xenix/V7/Coherent file system support' CONFIG_SYSV_FS
 

--------------Boundary-00=_WX92JE19UT9Z3RMRBZ3S
Content-Type: text/x-diff;
  charset="us-ascii";
  name="journal-fs-move.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="journal-fs-move.patch"

# I think it's time to split up the Filesystem menu in a "better reading" way.
# So place every Journalling Filesystem into a seperate menu:
# We have: ReiserFS, JFFS, JFFSv2, Ext3, XFS and JFS

--- linux-2.5-old/fs/Config.in		Thu Sep 26 12:19:14 2002
+++ linux-2.5-new/fs/Config.in		Thu Sep 26 21:15:37 2002
@@ -13,10 +13,6 @@
 tristate 'Kernel automounter support' CONFIG_AUTOFS_FS
 tristate 'Kernel automounter version 4 support (also supports v3)' CONFIG_AUTOFS4_FS
 
-tristate 'Reiserfs support' CONFIG_REISERFS_FS
-dep_mbool '  Enable reiserfs debug mode' CONFIG_REISERFS_CHECK $CONFIG_REISERFS_FS
-dep_mbool '  Stats in /proc/fs/reiserfs' CONFIG_REISERFS_PROC_INFO $CONFIG_REISERFS_FS
-
 dep_tristate 'ADFS file system support (EXPERIMENTAL)' CONFIG_ADFS_FS $CONFIG_EXPERIMENTAL
 dep_mbool '  ADFS write support (DANGEROUS)' CONFIG_ADFS_FS_RW $CONFIG_ADFS_FS $CONFIG_EXPERIMENTAL
 
@@ -26,13 +26,6 @@
 
 dep_tristate 'BFS file system support (EXPERIMENTAL)' CONFIG_BFS_FS $CONFIG_EXPERIMENTAL
 
-tristate 'Ext3 journalling file system support' CONFIG_EXT3_FS
-# CONFIG_JBD could be its own option (even modular), but until there are
-# other users than ext3, we will simply make it be the same as CONFIG_EXT3_FS
-# dep_tristate '  Journal Block Device support (JBD for ext3)' CONFIG_JBD $CONFIG_EXT3_FS
-define_bool CONFIG_JBD $CONFIG_EXT3_FS
-dep_mbool '  JBD (ext3) debugging support' CONFIG_JBD_DEBUG $CONFIG_JBD
-
 # msdos file systems
 tristate 'DOS FAT fs support' CONFIG_FAT_FS
 dep_tristate '  MSDOS fs support' CONFIG_MSDOS_FS $CONFIG_FAT_FS
@@ -42,16 +42,7 @@
 
 dep_tristate '  VFAT (Windows-95) fs support' CONFIG_VFAT_FS $CONFIG_FAT_FS
 dep_tristate 'EFS file system support (read only) (EXPERIMENTAL)' CONFIG_EFS_FS $CONFIG_EXPERIMENTAL
-dep_tristate 'Journalling Flash File System (JFFS) support' CONFIG_JFFS_FS $CONFIG_MTD
-if [ "$CONFIG_JFFS_FS" = "y" -o "$CONFIG_JFFS_FS" = "m" ] ; then
-   int 'JFFS debugging verbosity (0 = quiet, 3 = noisy)' CONFIG_JFFS_FS_VERBOSE 0
-   bool 'JFFS stats available in /proc filesystem' CONFIG_JFFS_PROC_FS
-fi
-dep_tristate 'Journalling Flash File System v2 (JFFS2) support' CONFIG_JFFS2_FS $CONFIG_MTD
-if [ "$CONFIG_JFFS2_FS" = "y" -o "$CONFIG_JFFS2_FS" = "m" ] ; then
-   int '  JFFS2 debugging verbosity (0 = quiet, 2 = noisy)' CONFIG_JFFS2_FS_DEBUG 0
-   dep_bool '  JFFS2 support for NAND flash (EXPERIMENTAL)' CONFIG_JFFS2_FS_NAND $CONFIG_EXPERIMENTAL
-fi
+
 tristate 'Compressed ROM file system support' CONFIG_CRAMFS
 bool 'Virtual memory file system support (former shm fs)' CONFIG_TMPFS
 define_bool CONFIG_RAMFS y
@@ -60,10 +60,6 @@
 dep_mbool '  Microsoft Joliet CDROM extensions' CONFIG_JOLIET $CONFIG_ISO9660_FS
 dep_mbool '  Transparent decompression extension' CONFIG_ZISOFS $CONFIG_ISO9660_FS
 
-tristate 'JFS filesystem support' CONFIG_JFS_FS
-dep_mbool '  JFS debugging' CONFIG_JFS_DEBUG $CONFIG_JFS_FS
-dep_mbool '  JFS statistics' CONFIG_JFS_STATISTICS $CONFIG_JFS_FS
-
 tristate 'Minix fs support' CONFIG_MINIX_FS
 
 tristate 'FreeVxFS file system support (VERITAS VxFS(TM) compatible)' CONFIG_VXFS_FS
@@ -101,13 +101,9 @@
 tristate 'UFS file system support (read only)' CONFIG_UFS_FS
 dep_mbool '  UFS file system write support (DANGEROUS)' CONFIG_UFS_FS_WRITE $CONFIG_UFS_FS $CONFIG_EXPERIMENTAL
 
-tristate 'XFS filesystem support' CONFIG_XFS_FS
-dep_mbool    '  Realtime support (EXPERIMENTAL)' CONFIG_XFS_RT $CONFIG_XFS_FS $CONFIG_EXPERIMENTAL
-dep_mbool    '  Quota support' CONFIG_XFS_QUOTA $CONFIG_XFS_FS
-if [ "$CONFIG_XFS_QUOTA" = "y" ]; then
-   define_bool CONFIG_QUOTACTL y
-fi
-
+# Journalling File Systems
+source fs/journalfs/Config.in
+
 if [ "$CONFIG_NET" = "y" ]; then
 
    mainmenu_option next_comment
--- linux-2.5-old/fs/journalfs/Config.in	Thu Sep 26 12:19:14 2002
+++ linux-2.5-new/fs/journalfs/Config.in	Thu Sep 26 21:15:37 2002
@@ -0,0 +1,57 @@
+#
+# Journalling File Systems
+#
+# We have: JFFS, JFFSv2, ReiserFS, Ext3fs, JFS, XFS
+
+mainmenu_option next_comment
+comment 'Journalling File Systems'
+
+
+# JFFS
+dep_tristate 'Journalling Flash File System (JFFS) support' CONFIG_JFFS_FS $CONFIG_MTD
+if [ "$CONFIG_JFFS_FS" = "y" -o "$CONFIG_JFFS_FS" = "m" ] ; then
+   int '  JFFS debugging verbosity (0 = quiet, 3 = noisy)' CONFIG_JFFS_FS_VERBOSE 0
+   bool '  JFFS stats available in /proc filesystem' CONFIG_JFFS_PROC_FS
+fi
+
+
+# JFFSv2
+dep_tristate 'Journalling Flash File System v2 (JFFS2) support' CONFIG_JFFS2_FS $CONFIG_MTD
+if [ "$CONFIG_JFFS2_FS" = "y" -o "$CONFIG_JFFS2_FS" = "m" ] ; then
+   int '  JFFS2 debugging verbosity (0 = quiet, 2 = noisy)' CONFIG_JFFS2_FS_DEBUG 0
+   dep_bool '  JFFS2 support for NAND flash (EXPERIMENTAL)' CONFIG_JFFS2_FS_NAND $CONFIG_EXPERIMENTAL
+fi
+
+
+# ReiserFS
+tristate 'Reiserfs support' CONFIG_REISERFS_FS
+dep_mbool '  Enable reiserfs debug mode' CONFIG_REISERFS_CHECK $CONFIG_REISERFS_FS
+dep_mbool '  Stats in /proc/fs/reiserfs' CONFIG_REISERFS_PROC_INFO $CONFIG_REISERFS_FS
+
+
+# Ext3 FS
+tristate 'Ext3 journalling file system support' CONFIG_EXT3_FS
+# CONFIG_JBD could be its own option (even modular), but until there are
+# other users than ext3, we will simply make it be the same as CONFIG_EXT3_FS
+# dep_tristate '  Journal Block Device support (JBD for ext3)' CONFIG_JBD $CONFIG_EXT3_FS
+define_bool CONFIG_JBD $CONFIG_EXT3_FS
+dep_mbool '  JBD (ext3) debugging support' CONFIG_JBD_DEBUG $CONFIG_JBD
+
+
+# JFS
+tristate 'JFS filesystem support' CONFIG_JFS_FS
+dep_mbool '  JFS debugging' CONFIG_JFS_DEBUG $CONFIG_JFS_FS
+dep_mbool '  JFS statistics' CONFIG_JFS_STATISTICS $CONFIG_JFS_FS
+
+
+# XFS
+tristate 'XFS filesystem support' CONFIG_XFS_FS
+dep_mbool    '  Realtime support (EXPERIMENTAL)' CONFIG_XFS_RT $CONFIG_XFS_FS $CONFIG_EXPERIMENTAL
+dep_mbool    '  Quota support' CONFIG_XFS_QUOTA $CONFIG_XFS_FS
+if [ "$CONFIG_XFS_QUOTA" = "y" ]; then
+   define_bool CONFIG_QUOTACTL y
+fi
+
+
+endmenu
+

--------------Boundary-00=_WX92JE19UT9Z3RMRBZ3S
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.5_2-ext3-move-right-place.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.5_2-ext3-move-right-place.patch"

--- linux-2.5-old/fs/Config.in		Thu Sep 26 12:19:14 2002
+++ linux-2.5-new/fs/Config.in		Thu Sep 26 19:26:31 2002
@@ -26,12 +26,7 @@
 
 dep_tristate 'BFS file system support (EXPERIMENTAL)' CONFIG_BFS_FS $CONFIG_EXPERIMENTAL
 
-tristate 'Ext3 journalling file system support' CONFIG_EXT3_FS
-# CONFIG_JBD could be its own option (even modular), but until there are
-# other users than ext3, we will simply make it be the same as CONFIG_EXT3_FS
-# dep_tristate '  Journal Block Device support (JBD for ext3)' CONFIG_JBD $CONFIG_EXT3_FS
-define_bool CONFIG_JBD $CONFIG_EXT3_FS
-dep_mbool '  JBD (ext3) debugging support' CONFIG_JBD_DEBUG $CONFIG_JBD
+# old ext3fs config place. Moved near to ext2fs
 
 # msdos file systems
 tristate 'DOS FAT fs support' CONFIG_FAT_FS
@@ -93,6 +93,13 @@
 
 tristate 'Ext2 file system support' CONFIG_EXT2_FS
 
+tristate 'Ext3 journalling file system support' CONFIG_EXT3_FS
+# CONFIG_JBD could be its own option (even modular), but until there are
+# other users than ext3, we will simply make it be the same as CONFIG_EXT3_FS
+# dep_tristate '  Journal Block Device support (JBD for ext3)' CONFIG_JBD $CONFIG_EXT3_FS
+define_bool CONFIG_JBD $CONFIG_EXT3_FS
+dep_mbool '  JBD (ext3) debugging support' CONFIG_JBD_DEBUG $CONFIG_JBD
+
 tristate 'System V/Xenix/V7/Coherent file system support' CONFIG_SYSV_FS
 
 tristate 'UDF file system support (read only)' CONFIG_UDF_FS

--------------Boundary-00=_WX92JE19UT9Z3RMRBZ3S--


