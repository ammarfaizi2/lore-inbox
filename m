Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266569AbUGKL2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266569AbUGKL2k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 07:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266570AbUGKL2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 07:28:40 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:5573 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266569AbUGKL21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 07:28:27 -0400
Date: Sun, 11 Jul 2004 13:28:22 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Matija Nalis <mnalis-umsdos@voyager.hr>
Cc: linux-kernel@vger.kernel.org, mnalis-umsdos2@voyager.hr
Subject: RFC: [2.6 patch] remove UMSDOS
Message-ID: <20040711112821.GC4701@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UMSDOS in 2.6 is broken, and it seems noone needs it enough to bother 
fixing it.

I'd suggest the patch below to remove UMSDOS.


diffstat output:
 Documentation/filesystems/00-INDEX |    2 -
 MAINTAINERS                        |    7 ----
 fs/Kconfig                         |   46 +----------------------------
 fs/Makefile                        |    1 
 4 files changed, 2 insertions(+), 54 deletions(-)

Additionally, the following commands are required:
  rm -r fs/umsdos
  rm include/linux/umsdos_fs.h
  rm include/linux/umsdos_fs.p
  rm include/linux/umsdos_fs_i.h
  rm Documentation/filesystems/umsdos.txt


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm7-full/MAINTAINERS.old	2004-07-11 13:15:24.000000000 +0200
+++ linux-2.6.7-mm7-full/MAINTAINERS	2004-07-11 13:15:47.000000000 +0200
@@ -2127,13 +2127,6 @@
 W:	http://linux-udf.sourceforge.net
 S:	Maintained
 
-UMSDOS FILESYSTEM
-P:	Matija Nalis
-M:	Matija Nalis <mnalis-umsdos@voyager.hr>
-L:	linux-kernel@vger.kernel.org
-W:	http://linux.voyager.hr/umsdos/
-S:	Maintained
-
 UNIFORM CDROM DRIVER
 P:	Jens Axboe
 M:	axboe@suse.de
--- linux-2.6.7-mm7-full/fs/Kconfig.old	2004-07-11 13:15:24.000000000 +0200
+++ linux-2.6.7-mm7-full/fs/Kconfig	2004-07-11 13:19:08.000000000 +0200
@@ -555,9 +555,8 @@
 	tristate "DOS FAT fs support"
 	select NLS
 	help
-	  If you want to use one of the FAT-based file systems (the MS-DOS,
-	  VFAT (Windows 95) and UMSDOS (used to run Linux on top of an
-	  ordinary DOS partition) file systems), then you must say Y or M here
+	  If you want to use one of the FAT-based file systems (MS-DOS
+	  and VFAT (Windows 95)) then you must say Y or M here
 	  to include FAT support. You will then be able to mount partitions or
 	  diskettes with FAT-based file systems and transparently access the
 	  files on them, i.e. MSDOS files will look and behave just like all
@@ -589,9 +588,6 @@
 	  fat.  Note that if you compile the FAT support as a module, you
 	  cannot compile any of the FAT-based file systems into the kernel
 	  -- they will have to be modules as well.
-	  The file system of your root partition (the one containing the
-	  directory /) cannot be a module, so don't say M here if you intend
-	  to use UMSDOS as your root file system.
 
 config MSDOS_FS
 	tristate "MSDOS fs support"
@@ -608,10 +604,6 @@
 	  transparent, i.e. the MSDOS files look and behave just like all
 	  other Unix files.
 
-	  If you want to use UMSDOS, the Unix-like file system on top of a
-	  DOS file system, which allows you to run Linux from within a DOS
-	  partition without repartitioning, you'll have to say Y or M here.
-
 	  If you have Windows 95 or Windows NT installed on your MSDOS
 	  partitions, you should use the VFAT file system (say Y to "VFAT fs
 	  support" below), or you will not be able to see the long filenames
@@ -631,11 +623,6 @@
 	  used by Windows 95, Windows 98, Windows NT 4.0, and the Unix
 	  programs from the mtools package.
 
-	  You cannot use the VFAT file system for your Linux root partition
-	  (the one containing the directory /); use UMSDOS instead if you
-	  want to run Linux from within a DOS partition (i.e. say Y to
-	  "Unix like fs on top of std MSDOS fs", below).
-
 	  The VFAT support enlarges your kernel by about 10 KB and it only
 	  works if you said Y to the "DOS FAT fs support" above.  Please read
 	  the file <file:Documentation/filesystems/vfat.txt> for details.  If
@@ -663,35 +650,6 @@
 	  mount option for FAT filesystems.  Note that UTF8 is *not* a
 	  supported charset for FAT filesystems.
 
-config UMSDOS_FS
-#dep_tristate '    UMSDOS: Unix-like file system on top of standard MSDOS fs' CONFIG_UMSDOS_FS $CONFIG_MSDOS_FS
-# UMSDOS is temprory broken
-	bool
-	help
-	  Say Y here if you want to run Linux from within an existing DOS
-	  partition of your hard drive. The advantage of this is that you can
-	  get away without repartitioning your hard drive (which often implies
-	  backing everything up and restoring afterwards) and hence you're
-	  able to quickly try out Linux or show it to your friends; the
-	  disadvantage is that Linux becomes susceptible to DOS viruses and
-	  that UMSDOS is somewhat slower than ext2fs.  Another use of UMSDOS
-	  is to write files with long unix filenames to MSDOS floppies; it
-	  also allows Unix-style soft-links and owner/permissions of files on
-	  MSDOS floppies.  You will need a program called umssync in order to
-	  make use of UMSDOS; read
-	  <file:Documentation/filesystems/umsdos.txt>.
-
-	  To get utilities for initializing/checking UMSDOS file system, or
-	  latest patches and/or information, visit the UMSDOS home page at
-	  <http://www.voyager.hr/~mnalis/umsdos/>.
-
-	  This option enlarges your kernel by about 28 KB and it only works if
-	  you said Y to both "DOS FAT fs support" and "MSDOS fs support"
-	  above.  To compile this as a module, choose M here: the module will be
-	  called umsdos.  Note that the file system of your root partition
-	  (the one containing the directory /) cannot be a module, so saying M
-	  could be dangerous.  If unsure, say N.
-
 config NTFS_FS
 	tristate "NTFS file system support"
 	select NLS
--- linux-2.6.7-mm7-full/fs/Makefile.old	2004-07-11 13:15:24.000000000 +0200
+++ linux-2.6.7-mm7-full/fs/Makefile	2004-07-11 13:17:26.000000000 +0200
@@ -55,7 +55,6 @@
 obj-$(CONFIG_CODA_FS)		+= coda/
 obj-$(CONFIG_MINIX_FS)		+= minix/
 obj-$(CONFIG_FAT_FS)		+= fat/
-obj-$(CONFIG_UMSDOS_FS)		+= umsdos/
 obj-$(CONFIG_MSDOS_FS)		+= msdos/
 obj-$(CONFIG_VFAT_FS)		+= vfat/
 obj-$(CONFIG_BFS_FS)		+= bfs/
--- linux-2.6.7-mm7-full/Documentation/filesystems/00-INDEX.old	2004-07-11 13:15:24.000000000 +0200
+++ linux-2.6.7-mm7-full/Documentation/filesystems/00-INDEX	2004-07-11 13:17:31.000000000 +0200
@@ -42,8 +42,6 @@
 	- info and mount options for the UDF filesystem.
 ufs.txt
 	- info on the ufs filesystem.
-umsdos.txt
-	- info on the umsdos extensions to the msdos filesystem.
 vfat.txt
 	- info on using the VFAT filesystem used in Windows NT and Windows 95
 vfs.txt

