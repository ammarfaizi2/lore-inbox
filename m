Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261313AbTCOHj3>; Sat, 15 Mar 2003 02:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261317AbTCOHj2>; Sat, 15 Mar 2003 02:39:28 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:21162 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP
	id <S261313AbTCOHh0>; Sat, 15 Mar 2003 02:37:26 -0500
Message-ID: <3E72DA2C.ED6C19D1@verizon.net>
Date: Fri, 14 Mar 2003 23:45:48 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.59 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] update filesystems config. menu
Content-Type: multipart/mixed;
 boundary="------------2C9BC4E32F80DF564D4DA085"
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [4.64.238.61] at Sat, 15 Mar 2003 01:48:03 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2C9BC4E32F80DF564D4DA085
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

This is Robert PJ Day's patch that updates the filesystems
config menu.  It had become a bit ad hoc (jumbled:) and this
patch attempts to arrange it more logically.

Patch applies to 2.5.64-current.  Please apply.

Thanks,
~Randy
--------------2C9BC4E32F80DF564D4DA085
Content-Type: text/plain; charset=us-ascii;
 name="fsmenu-2561.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fsmenu-2561.patch"

Return-Path: <rpjday@mindspring.com>
Received: from fire-2.osdl.org (air2.pdx.osdl.net [172.20.0.6])
	by mail.osdl.org (8.11.6/8.11.6) with ESMTP id h1HJa8w07194
	for <rddunlap@osdl.org>; Mon, 17 Feb 2003 11:36:08 -0800
Received: from tomts10-srv.bellnexxia.net (tomts10.bellnexxia.net [209.226.175.54])
	by fire-2.osdl.org (8.11.6/8.11.6) with ESMTP id h1HJa7A12085
	for <rddunlap@osdl.org>; Mon, 17 Feb 2003 11:36:07 -0800
Received: from [192.168.1.100] ([65.93.102.22])
          by tomts10-srv.bellnexxia.net
          (InterMail vM.5.01.04.19 201-253-122-122-119-20020516) with ESMTP
          id <20030217193558.ODAM26691.tomts10-srv.bellnexxia.net@[192.168.1.100]>
          for <rddunlap@osdl.org>; Mon, 17 Feb 2003 14:35:58 -0500
Date: Mon, 17 Feb 2003 14:33:21 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Randy Dunlap <rddunlap@osdl.org>
Subject: new fs patch for 2.5.61 -- comments?  should apply cleanly
Message-ID: <Pine.LNX.4.44.0302171432350.4873-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII


diff -urN linux-2.5.61/fs/Kconfig linux-2.5.61-rday/fs/Kconfig
--- linux-2.5.61/fs/Kconfig	2003-02-14 18:51:48.000000000 -0500
+++ linux-2.5.61-rday/fs/Kconfig	2003-02-17 14:28:05.000000000 -0500
@@ -4,89 +4,180 @@
 
 menu "File systems"
 
-config QUOTA
-	bool "Quota support"
+config EXT2_FS
+	tristate "Second extended fs support"
 	help
-	  If you say Y here, you will be able to set per user limits for disk
-	  usage (also called disk quotas). Currently, it works for the
-	  ext2, ext3, and reiserfs file system. You need additional software
-	  in order to use quota support (you can download sources from
-	  <http://www.sf.net/projects/linuxquota/>). For further details, read
-	  the Quota mini-HOWTO, available from
-	  <http://www.linuxdoc.org/docs.html#howto>. Probably the quota
-	  support is only useful for multi user systems. If unsure, say N.
+	  This is the de facto standard Linux file system (method to organize
+	  files on a storage device) for hard disks.
 
-config QFMT_V1
-	tristate "Old quota format support"
-	depends on QUOTA
+	  You want to say Y here, unless you intend to use Linux exclusively
+	  from inside a DOS partition using the UMSDOS file system. The
+	  advantage of the latter is that you can get away without
+	  repartitioning your hard drive (which often implies backing
+	  everything up and restoring afterwards); the disadvantage is that
+	  Linux becomes susceptible to DOS viruses and that UMSDOS is somewhat
+	  slower than ext2fs. Even if you want to run Linux in this fashion,
+	  it might be a good idea to have ext2fs around: it enables you to
+	  read more floppy disks and facilitates the transition to a *real*
+	  Linux partition later. Another (rare) case which doesn't require
+	  ext2fs is a diskless Linux box which mounts all files over the
+	  network using NFS (in this case it's sufficient to say Y to "NFS
+	  file system support" below). Saying Y here will enlarge your kernel
+	  by about 44 KB.
+
+	  The Ext2fs-Undeletion mini-HOWTO, available from
+	  <http://www.linuxdoc.org/docs.html#howto>, gives information about
+	  how to retrieve deleted files on ext2fs file systems.
+
+	  To change the behavior of ext2 file systems, you can use the tune2fs
+	  utility ("man tune2fs"). To modify attributes of files and
+	  directories on ext2 file systems, use chattr ("man chattr").
+
+	  Ext2fs partitions can be read from within DOS using the ext2tool
+	  command line tool package (available from
+	  <ftp://ibiblio.org/pub/Linux/system/filesystems/ext2/>) and from
+	  within Windows NT using the ext2nt command line tool package from
+	  <ftp://ibiblio.org/pub/Linux/utils/dos/>.  Explore2fs is a
+	  graphical explorer for ext2fs partitions which runs on Windows 95
+	  and Windows NT and includes experimental write support; it is
+	  available from
+	  <http://jnewbigin-pc.it.swin.edu.au/Linux/Explore2fs.htm>.
+
+	  If you want to compile this file system as a module ( = code which
+	  can be inserted in and removed from the running kernel whenever you
+	  want), say M here and read <file:Documentation/modules.txt>.  The
+	  module will be called ext2.  Be aware however that the file system
+	  of your root partition (the one containing the directory /) cannot
+	  be compiled as a module, and so this could be dangerous.  Most
+	  everyone wants to say Y here.
+
+config EXT2_FS_XATTR
+	bool "Ext2 extended attributes"
+	depends on EXT2_FS
 	help
-	  This quota format was (is) used by kernels earlier than 2.4.??. If
-	  you have quota working and you don't want to convert to new quota
-	  format say Y here.
+	  Extended attributes are name:value pairs associated with inodes by
+	  the kernel or by users (see the attr(5) manual page, or visit
+	  <http://acl.bestbits.at/> for details).
 
-config QFMT_V2
-	tristate "Quota format v2 support"
-	depends on QUOTA
+	  If unsure, say N.
+
+config EXT2_FS_POSIX_ACL
+	bool "Ext2 POSIX Access Control Lists"
+	depends on EXT2_FS_XATTR
 	help
-	  This quota format allows using quotas with 32-bit UIDs/GIDs. If you
-	  need this functionality say Y here. Note that you will need latest
-	  quota utilities for new quota format with this kernel.
+	  Posix Access Control Lists (ACLs) support permissions for users and
+	  groups beyond the owner/group/world scheme.
 
-config QUOTACTL
-	bool
-	depends on XFS_QUOTA || QUOTA
+	  To learn more about Access Control Lists, visit the Posix ACLs for
+	  Linux website <http://acl.bestbits.at/>.
+
+	  If you don't know what Access Control Lists are, say N
+
+config EXT3_FS
+	tristate "Ext3 journalling file system support"
+	help
+	  This is the journaling version of the Second extended file system
+	  (often called ext3), the de facto standard Linux file system
+	  (method to organize files on a storage device) for hard disks.
+
+	  The journaling code included in this driver means you do not have
+	  to run e2fsck (file system checker) on your file systems after a
+	  crash.  The journal keeps track of any changes that were being made
+	  at the time the system crashed, and can ensure that your file system
+	  is consistent without the need for a lengthy check.
+
+	  Other than adding the journal to the file system, the on-disk format
+	  of ext3 is identical to ext2.  It is possible to freely switch
+	  between using the ext3 driver and the ext2 driver, as long as the
+	  file system has been cleanly unmounted, or e2fsck is run on the file
+	  system.
+
+	  To add a journal on an existing ext2 file system or change the
+	  behavior of ext3 file systems, you can use the tune2fs utility ("man
+	  tune2fs").  To modify attributes of files and directories on ext3
+	  file systems, use chattr ("man chattr").  You need to be using
+	  e2fsprogs version 1.20 or later in order to create ext3 journals
+	  (available at <http://sourceforge.net/projects/e2fsprogs/>).
+
+	  If you want to compile this file system as a module ( = code which
+	  can be inserted in and removed from the running kernel whenever you
+	  want), say M here and read <file:Documentation/modules.txt>.  The
+	  module will be called ext3.  Be aware however that the file system
+	  of your root partition (the one containing the directory /) cannot
+	  be compiled as a module, and so this may be dangerous.
+
+config EXT3_FS_XATTR
+	bool "Ext3 extended attributes"
+	depends on EXT3_FS
 	default y
+	help
+	  Extended attributes are name:value pairs associated with inodes by
+	  the kernel or by users (see the attr(5) manual page, or visit
+	  <http://acl.bestbits.at/> for details).
 
-config AUTOFS_FS
-	tristate "Kernel automounter support"
-	---help---
-	  The automounter is a tool to automatically mount remote file systems
-	  on demand. This implementation is partially kernel-based to reduce
-	  overhead in the already-mounted case; this is unlike the BSD
-	  automounter (amd), which is a pure user space daemon.
+	  If unsure, say N.
 
-	  To use the automounter you need the user-space tools from the autofs
-	  package; you can find the location in <file:Documentation/Changes>.
-	  You also want to answer Y to "NFS file system support", below.
+	  You need this for POSIX ACL support on ext3.
 
-	  If you want to use the newer version of the automounter with more
-	  features, say N here and say Y to "Kernel automounter v4 support",
-	  below.
+config EXT3_FS_POSIX_ACL
+	bool "Ext3 POSIX Access Control Lists"
+	depends on EXT3_FS_XATTR
+	help
+	  Posix Access Control Lists (ACLs) support permissions for users and
+	  groups beyond the owner/group/world scheme.
 
-	  If you want to compile this as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want),
-	  say M here and read <file:Documentation/modules.txt>.  The module
-	  will be called autofs.
+	  To learn more about Access Control Lists, visit the Posix ACLs for
+	  Linux website <http://acl.bestbits.at/>.
 
-	  If you are not a part of a fairly large, distributed network, you
-	  probably do not need an automounter, and can say N here.
+	  If you don't know what Access Control Lists are, say N
 
-config AUTOFS4_FS
-	tristate "Kernel automounter version 4 support (also supports v3)"
-	---help---
-	  The automounter is a tool to automatically mount remote file systems
-	  on demand. This implementation is partially kernel-based to reduce
-	  overhead in the already-mounted case; this is unlike the BSD
-	  automounter (amd), which is a pure user space daemon.
+config JBD
+# CONFIG_JBD could be its own option (even modular), but until there are
+# other users than ext3, we will simply make it be the same as CONFIG_EXT3_FS
+# dep_tristate '  Journal Block Device support (JBD for ext3)' CONFIG_JBD $CONFIG_EXT3_FS
+	bool
+	default EXT3_FS
+	help
+	  This is a generic journaling layer for block devices.  It is
+	  currently used by the ext3 file system, but it could also be used to
+	  add journal support to other file systems or block devices such as
+	  RAID or LVM.
 
-	  To use the automounter you need the user-space tools from
-	  <ftp://ftp.kernel.org/pub/linux/daemons/autofs/testing-v4/>; you also
-	  want to answer Y to "NFS file system support", below.
+	  If you are using the ext3 file system, you need to say Y here. If
+	  you are not using ext3 then you will probably want to say N.
 
-	  If you want to compile this as a module ( = code which can be
+	  If you want to compile this device as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want),
 	  say M here and read <file:Documentation/modules.txt>.  The module
-	  will be called autofs4.  You will need to add "alias autofs
-	  autofs4" to your modules configuration file.
+	  will be called jbd.  If you are compiling ext3 into the kernel,
+	  you cannot compile this code as a module.
 
-	  If you are not a part of a fairly large, distributed network or
-	  don't have a laptop which needs to dynamically reconfigure to the
-	  local network, you probably do not need an automounter, and can say
-	  N here.
+config JBD_DEBUG
+	bool "JBD (ext3) debugging support"
+	depends on JBD
+	help
+	  If you are using the ext3 journaled file system (or potentially any
+	  other file system/device using JBD), this option allows you to
+	  enable debugging output while the system is running, in order to
+	  help track down any problems you are having.  By default the
+	  debugging output will be turned off.
+
+	  If you select Y here, then you will be able to turn on debugging
+	  with "echo N > /proc/sys/fs/jbd-debug", where N is a number between
+	  1 and 5, the higher the number, the more debugging output is
+	  generated.  To turn debugging off again, do
+	  "echo 0 > /proc/sys/fs/jbd-debug".
+
+config FS_MBCACHE
+# Meta block cache for Extended Attributes (ext2/ext3)
+	tristate
+	depends on EXT2_FS_XATTR || EXT3_FS_XATTR
+	default y if EXT2_FS=y || EXT3_FS=y
+	default m if EXT2_FS=m || EXT3_FS=m
 
 config REISERFS_FS
 	tristate "Reiserfs support"
-	---help---
+	help
 	  Stores not just filenames but the files themselves in a balanced
 	  tree.  Uses journaling.
 
@@ -135,40 +226,653 @@
 	  Almost everyone but ReiserFS developers and people fine-tuning
 	  reiserfs or tracing problems should say N.
 
-config ADFS_FS
-	tristate "ADFS file system support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	---help---
-	  The Acorn Disc Filing System is the standard file system of the
-	  RiscOS operating system which runs on Acorn's ARM-based Risc PC
-	  systems and the Acorn Archimedes range of machines. If you say Y
-	  here, Linux will be able to read from ADFS partitions on hard drives
-	  and from ADFS-formatted floppy discs. If you also want to be able to
-	  write to those devices, say Y to "ADFS write support" below.
+config JFS_FS
+	tristate "JFS filesystem support"
+	help
+	  This is a port of IBM's Journaled Filesystem .  More information is
+	  available in the file Documentation/filesystems/jfs.txt.
 
-	  The ADFS partition should be the first partition (i.e.,
-	  /dev/[hs]d?1) on each of your drives. Please read the file
-	  <file:Documentation/filesystems/adfs.txt> for further details.
+	  If you do not intend to use the JFS filesystem, say N.
 
-	  This code is also available as a module called adfs ( = code which
-	  can be inserted in and removed from the running kernel whenever you
-	  want). If you want to compile it as a module, say M here and read
-	  <file:Documentation/modules.txt>.
+config JFS_POSIX_ACL
+	bool "JFS POSIX Access Control Lists"
+	depends on JFS_FS
+	help
+	  Posix Access Control Lists (ACLs) support permissions for users and
+	  groups beyond the owner/group/world scheme.
 
-	  If unsure, say N.
+	  To learn more about Access Control Lists, visit the Posix ACLs for
+	  Linux website <http://acl.bestbits.at/>.
 
-config ADFS_FS_RW
-	bool "ADFS write support (DANGEROUS)"
-	depends on ADFS_FS
-	help
-	  If you say Y here, you will be able to write to ADFS partitions on
-	  hard drives and ADFS-formatted floppy disks. This is experimental
-	  codes, so if you're unsure, say N.
+	  If you don't know what Access Control Lists are, say N
 
-config AFFS_FS
+config JFS_DEBUG
+	bool "JFS debugging"
+	depends on JFS_FS
+	help
+	  If you are experiencing any problems with the JFS filesystem, say
+	  Y here.  This will result in additional debugging messages to be
+	  written to the system log.  Under normal circumstances, this
+	  results in very little overhead.
+
+config JFS_STATISTICS
+	bool "JFS statistics"
+	depends on JFS_FS
+	help
+	  Enabling this option will cause statistics from the JFS file system
+	  to be made available to the user in the /proc/fs/jfs/ directory.
+
+config FS_POSIX_ACL
+# Posix ACL utility routines (for now, only ext2/ext3/jfs)
+#
+# NOTE: you can implement Posix ACLs without these helpers (XFS does).
+# 	Never use this symbol for ifdefs.
+#
+	bool
+	depends on EXT2_FS_POSIX_ACL || EXT3_FS_POSIX_ACL || JFS_POSIX_ACL
+	default y
+
+config XFS_FS
+	tristate "XFS filesystem support"
+	help
+	  XFS is a high performance journaling filesystem which originated
+	  on the SGI IRIX platform.  It is completely multi-threaded, can
+	  support large files and large filesystems, extended attributes,
+	  variable block sizes, is extent based, and makes extensive use of
+	  Btrees (directories, extents, free space) to aid both performance
+	  and scalability.
+
+	  Refer to the documentation at <http://oss.sgi.com/projects/xfs/>
+	  for complete details.  This implementation is on-disk compatible
+	  with the IRIX version of XFS.
+
+	  If you want to compile this file system as a module ( = code which
+	  can be inserted in and removed from the running kernel whenever you
+	  want), say M here and read <file:Documentation/modules.txt>. The
+	  module will be called xfs.  Be aware, however, that if the file
+	  system of your root partition is compiled as a module, you'll need
+	  to use an initial ramdisk (initrd) to boot.
+
+config XFS_RT
+	bool "Realtime support (EXPERIMENTAL)"
+	depends on XFS_FS && EXPERIMENTAL
+	help
+	  If you say Y here you will be able to mount and use XFS filesystems
+	  which contain a realtime subvolume. The realtime subvolume is a
+	  separate area of disk space where only file data is stored. The
+	  realtime subvolume is designed to provide very deterministic
+	  data rates suitable for media streaming applications.
+
+	  See the xfs man page in section 5 for a bit more information.
+
+	  This feature is unsupported at this time, is not yet fully
+	  functional, and may cause serious problems.
+
+	  If unsure, say N.
+
+config XFS_QUOTA
+	bool "Quota support"
+	depends on XFS_FS
+	help
+	  If you say Y here, you will be able to set limits for disk usage on
+	  a per user and/or a per group basis under XFS.  XFS considers quota
+	  information as filesystem metadata and uses journaling to provide a
+	  higher level guarantee of consistency.  The on-disk data format for
+	  quota is also compatible with the IRIX version of XFS, allowing a
+	  filesystem to be migrated between Linux and IRIX without any need
+	  for conversion.
+
+	  If unsure, say N.  More comprehensive documentation can be found in
+	  README.quota in the xfsprogs package.  XFS quota can be used either
+	  with or without the generic quota support enabled (CONFIG_QUOTA) -
+	  they are completely independent subsystems.
+
+config XFS_POSIX_ACL
+	bool "ACL support"
+	depends on XFS_FS
+	help
+	  Posix Access Control Lists (ACLs) support permissions for users and
+	  groups beyond the owner/group/world scheme.
+
+	  To learn more about Access Control Lists, visit the Posix ACLs for
+	  Linux website <http://acl.bestbits.at/>.
+
+	  If you don't know what Access Control Lists are, say N
+
+config MINIX_FS
+	tristate "Minix fs support"
+	help
+	  Minix is a simple operating system used in many classes about OS's.
+	  The minix file system (method to organize files on a hard disk
+	  partition or a floppy disk) was the original file system for Linux,
+	  but has been superseded by the second extended file system ext2fs.
+	  You don't want to use the minix file system on your hard disk
+	  because of certain built-in restrictions, but it is sometimes found
+	  on older Linux floppy disks.  This option will enlarge your kernel
+	  by about 28 KB. If unsure, say N.
+
+	  If you want to compile this as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want),
+	  say M here and read <file:Documentation/modules.txt>. The module
+	  will be called minix.  Note that the file system of your root
+	  partition (the one containing the directory /) cannot be compiled as
+	  a module.
+
+config ROMFS_FS
+	tristate "ROM file system support"
+	---help---
+	  This is a very small read-only file system mainly intended for
+	  initial ram disks of installation disks, but it could be used for
+	  other read-only media as well.  Read
+	  <file:Documentation/filesystems/romfs.txt> for details.
+
+	  This file system support is also available as a module ( = code
+	  which can be inserted in and removed from the running kernel
+	  whenever you want). The module is called romfs.  If you want to
+	  compile it as a module, say M here and read
+	  <file:Documentation/modules.txt>.  Note that the file system of your
+	  root partition (the one containing the directory /) cannot be a
+	  module.
+
+	  If you don't know whether you need it, then you don't need it:
+	  answer N.
+
+config HUGETLBFS
+	bool "HugeTLB file system support"
+	depends on HUGETLB_PAGE
+
+config QUOTA
+	bool "Quota support"
+	help
+	  If you say Y here, you will be able to set per user limits for disk
+	  usage (also called disk quotas). Currently, it works for the
+	  ext2, ext3, and reiserfs file system. You need additional software
+	  in order to use quota support (you can download sources from
+	  <http://www.sf.net/projects/linuxquota/>). For further details, read
+	  the Quota mini-HOWTO, available from
+	  <http://www.linuxdoc.org/docs.html#howto>. Probably the quota
+	  support is only useful for multi user systems. If unsure, say N.
+
+config QFMT_V1
+	tristate "Old quota format support"
+	depends on QUOTA
+	help
+	  This quota format was (is) used by kernels earlier than 2.4.??. If
+	  you have quota working and you don't want to convert to new quota
+	  format say Y here.
+
+config QFMT_V2
+	tristate "Quota format v2 support"
+	depends on QUOTA
+	help
+	  This quota format allows using quotas with 32-bit UIDs/GIDs. If you
+	  need this functionality say Y here. Note that you will need latest
+	  quota utilities for new quota format with this kernel.
+
+config QUOTACTL
+	bool
+	depends on XFS_QUOTA || QUOTA
+	default y
+
+config AUTOFS_FS
+	tristate "Kernel automounter support"
+	help
+	  The automounter is a tool to automatically mount remote file systems
+	  on demand. This implementation is partially kernel-based to reduce
+	  overhead in the already-mounted case; this is unlike the BSD
+	  automounter (amd), which is a pure user space daemon.
+
+	  To use the automounter you need the user-space tools from the autofs
+	  package; you can find the location in <file:Documentation/Changes>.
+	  You also want to answer Y to "NFS file system support", below.
+
+	  If you want to use the newer version of the automounter with more
+	  features, say N here and say Y to "Kernel automounter v4 support",
+	  below.
+
+	  If you want to compile this as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want),
+	  say M here and read <file:Documentation/modules.txt>.  The module
+	  will be called autofs.
+
+	  If you are not a part of a fairly large, distributed network, you
+	  probably do not need an automounter, and can say N here.
+
+config AUTOFS4_FS
+	tristate "Kernel automounter version 4 support (also supports v3)"
+	help
+	  The automounter is a tool to automatically mount remote file systems
+	  on demand. This implementation is partially kernel-based to reduce
+	  overhead in the already-mounted case; this is unlike the BSD
+	  automounter (amd), which is a pure user space daemon.
+
+	  To use the automounter you need the user-space tools from
+	  <ftp://ftp.kernel.org/pub/linux/daemons/autofs/testing-v4/>; you also
+	  want to answer Y to "NFS file system support", below.
+
+	  If you want to compile this as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want),
+	  say M here and read <file:Documentation/modules.txt>.  The module
+	  will be called autofs4.  You will need to add "alias autofs
+	  autofs4" to your modules configuration file.
+
+	  If you are not a part of a fairly large, distributed network or
+	  don't have a laptop which needs to dynamically reconfigure to the
+	  local network, you probably do not need an automounter, and can say
+	  N here.
+
+menu "CD-ROM/DVD Filesystems"
+
+config ISO9660_FS
+	tristate "ISO 9660 CDROM file system support"
+	help
+	  This is the standard file system used on CD-ROMs.  It was previously
+	  known as "High Sierra File System" and is called "hsfs" on other
+	  Unix systems.  The so-called Rock-Ridge extensions which allow for
+	  long Unix filenames and symbolic links are also supported by this
+	  driver.  If you have a CD-ROM drive and want to do more with it than
+	  just listen to audio CDs and watch its LEDs, say Y (and read
+	  <file:Documentation/filesystems/isofs.txt> and the CD-ROM-HOWTO,
+	  available from <http://www.linuxdoc.org/docs.html#howto>), thereby
+	  enlarging your kernel by about 27 KB; otherwise say N.
+
+	  If you want to compile this as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want),
+	  say M here and read <file:Documentation/modules.txt>.  The module
+	  will be called isofs.
+
+config JOLIET
+	bool "Microsoft Joliet CDROM extensions"
+	depends on ISO9660_FS
+	help
+	  Joliet is a Microsoft extension for the ISO 9660 CD-ROM file system
+	  which allows for long filenames in unicode format (unicode is the
+	  new 16 bit character code, successor to ASCII, which encodes the
+	  characters of almost all languages of the world; see
+	  <http://www.unicode.org/> for more information).  Say Y here if you
+	  want to be able to read Joliet CD-ROMs under Linux.
+
+config ZISOFS
+	bool "Transparent decompression extension"
+	depends on ISO9660_FS
+	help
+	  This is a Linux-specific extension to RockRidge which lets you store
+	  data in compressed form on a CD-ROM and have it transparently
+	  decompressed when the CD-ROM is accessed.  See
+	  <http://www.kernel.org/pub/linux/utils/fs/zisofs/> for the tools
+	  necessary to create such a filesystem.  Say Y here if you want to be
+	  able to read such compressed CD-ROMs.
+
+config ZISOFS_FS
+# for fs/nls/Config.in
+	tristate
+	depends on ZISOFS
+	default ISO9660_FS
+
+config UDF_FS
+	tristate "UDF file system support"
+	help
+	  This is the new file system used on some CD-ROMs and DVDs. Say Y if
+	  you intend to mount DVD discs or CDRW's written in packet mode, or
+	  if written to by other UDF utilities, such as DirectCD.
+	  Please read <file:Documentation/filesystems/udf.txt>.
+
+	  This file system support is also available as a module ( = code
+	  which can be inserted in and removed from the running kernel
+	  whenever you want). The module is called udf. If you want to
+	  compile it as a module, say M here and read
+	  <file:Documentation/modules.txt>.
+
+	  If unsure, say N.
+
+endmenu
+
+menu "DOS/FAT/NT Filesystems"
+
+config FAT_FS
+	tristate "DOS FAT fs support"
+	help
+	  If you want to use one of the FAT-based file systems (the MS-DOS,
+	  VFAT (Windows 95) and UMSDOS (used to run Linux on top of an
+	  ordinary DOS partition) file systems), then you must say Y or M here
+	  to include FAT support. You will then be able to mount partitions or
+	  diskettes with FAT-based file systems and transparently access the
+	  files on them, i.e. MSDOS files will look and behave just like all
+	  other Unix files.
+
+	  This FAT support is not a file system in itself, it only provides
+	  the foundation for the other file systems. You will have to say Y or
+	  M to at least one of "MSDOS fs support" or "VFAT fs support" in
+	  order to make use of it.
+
+	  Another way to read and write MSDOS floppies and hard drive
+	  partitions from within Linux (but not transparently) is with the
+	  mtools ("man mtools") program suite. You don't need to say Y here in
+	  order to do that.
+
+	  If you need to move large files on floppies between a DOS and a
+	  Linux box, say Y here, mount the floppy under Linux with an MSDOS
+	  file system and use GNU tar's M option. GNU tar is a program
+	  available for Unix and DOS ("man tar" or "info tar").
+
+	  It is now also becoming possible to read and write compressed FAT
+	  file systems; read <file:Documentation/filesystems/fat_cvf.txt> for
+	  details.
+
+	  The FAT support will enlarge your kernel by about 37 KB. If unsure,
+	  say Y.
+
+	  If you want to compile this as a module however ( = code which can
+	  be inserted in and removed from the running kernel whenever you
+	  want), say M here and read <file:Documentation/modules.txt>.  The
+	  module will be called fat.  Note that if you compile the FAT
+	  support as a module, you cannot compile any of the FAT-based file
+	  systems into the kernel -- they will have to be modules as well.
+	  The file system of your root partition (the one containing the
+	  directory /) cannot be a module, so don't say M here if you intend
+	  to use UMSDOS as your root file system.
+
+config MSDOS_FS
+	tristate "MSDOS fs support"
+	depends on FAT_FS
+	help
+	  This allows you to mount MSDOS partitions of your hard drive (unless
+	  they are compressed; to access compressed MSDOS partitions under
+	  Linux, you can either use the DOS emulator DOSEMU, described in the
+	  DOSEMU-HOWTO, available from
+	  <http://www.linuxdoc.org/docs.html#howto>, or try dmsdosfs in
+	  <ftp://ibiblio.org/pub/Linux/system/filesystems/dosfs/>. If you
+	  intend to use dosemu with a non-compressed MSDOS partition, say Y
+	  here) and MSDOS floppies. This means that file access becomes
+	  transparent, i.e. the MSDOS files look and behave just like all
+	  other Unix files.
+
+	  If you want to use UMSDOS, the Unix-like file system on top of a
+	  DOS file system, which allows you to run Linux from within a DOS
+	  partition without repartitioning, you'll have to say Y or M here.
+
+	  If you have Windows 95 or Windows NT installed on your MSDOS
+	  partitions, you should use the VFAT file system (say Y to "VFAT fs
+	  support" below), or you will not be able to see the long filenames
+	  generated by Windows 95 / Windows NT.
+
+	  This option will enlarge your kernel by about 7 KB. If unsure,
+	  answer Y. This will only work if you said Y to "DOS FAT fs support"
+	  as well. If you want to compile this as a module however ( = code
+	  which can be inserted in and removed from the running kernel
+	  whenever you want), say M here and read
+	  <file:Documentation/modules.txt>.
+	  The module will be called msdos.
+
+config VFAT_FS
+	tristate "VFAT (Windows-95) fs support"
+	depends on FAT_FS
+	help
+	  This option provides support for normal Windows file systems with
+	  long filenames.  That includes non-compressed FAT-based file systems
+	  used by Windows 95, Windows 98, Windows NT 4.0, and the Unix
+	  programs from the mtools package.
+
+	  You cannot use the VFAT file system for your Linux root partition
+	  (the one containing the directory /); use UMSDOS instead if you
+	  want to run Linux from within a DOS partition (i.e. say Y to
+	  "Unix like fs on top of std MSDOS fs", below).
+
+	  The VFAT support enlarges your kernel by about 10 KB and it only
+	  works if you said Y to the "DOS FAT fs support" above.  Please read
+	  the file <file:Documentation/filesystems/vfat.txt> for details.  If
+	  unsure, say Y.
+
+	  If you want to compile this as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want),
+	  say M here and read <file:Documentation/modules.txt>.  The module
+	  will be called vfat.
+
+config UMSDOS_FS
+#dep_tristate '    UMSDOS: Unix-like file system on top of standard MSDOS fs' CONFIG_UMSDOS_FS $CONFIG_MSDOS_FS
+# UMSDOS is temprory broken
+	bool
+	help
+	  Say Y here if you want to run Linux from within an existing DOS
+	  partition of your hard drive. The advantage of this is that you can
+	  get away without repartitioning your hard drive (which often implies
+	  backing everything up and restoring afterwards) and hence you're
+	  able to quickly try out Linux or show it to your friends; the
+	  disadvantage is that Linux becomes susceptible to DOS viruses and
+	  that UMSDOS is somewhat slower than ext2fs.  Another use of UMSDOS
+	  is to write files with long unix filenames to MSDOS floppies; it
+	  also allows Unix-style soft-links and owner/permissions of files on
+	  MSDOS floppies.  You will need a program called umssync in order to
+	  make use of UMSDOS; read
+	  <file:Documentation/filesystems/umsdos.txt>.
+
+	  To get utilities for initializing/checking UMSDOS file system, or
+	  latest patches and/or information, visit the UMSDOS home page at
+	  <http://www.voyager.hr/~mnalis/umsdos/>.
+
+	  This option enlarges your kernel by about 28 KB and it only works if
+	  you said Y to both "DOS FAT fs support" and "MSDOS fs support"
+	  above.  If you want to compile this as a module ( = code which can
+	  be inserted in and removed from the running kernel whenever you
+	  want), say M here and read <file:Documentation/modules.txt>.  The
+	  module will be called umsdos.  Note that the file system of your
+	  root partition (the one containing the directory /) cannot be a
+	  module, so saying M could be dangerous.  If unsure, say N.
+
+config NTFS_FS
+	tristate "NTFS file system support (read only)"
+	help
+	  NTFS is the file system of Microsoft Windows NT/2000/XP. For more
+	  information see <file:Documentation/filesystems/ntfs.txt>. Saying Y
+	  here would allow you to read from NTFS partitions.
+
+	  This file system is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module will be called ntfs. If you want to compile it as a
+	  module, say M here and read <file:Documentation/modules.txt>.
+
+	  If you are not using Windows NT/2000/XP in addition to Linux on your
+	  computer it is safe to say N.
+
+config NTFS_DEBUG
+	bool "NTFS debugging support"
+	depends on NTFS_FS
+	help
+	  If you are experiencing any problems with the NTFS file system, say
+	  Y here. This will result in additional consistency checks to be
+	  performed by the driver as well as additional debugging messages to
+	  be written to the system log. Note that debugging messages are
+	  disabled by default. To enable them, supply the option debug_msgs=1
+	  at the kernel command line when booting the kernel or as an option
+	  to insmod when loading the ntfs module. Once the driver is active,
+	  you can enable debugging messages by doing (as root):
+	  echo 1 > /proc/sys/fs/ntfs-debug
+	  Replacing the "1" with "0" would disable debug messages.
+
+	  If you leave debugging messages disabled, this results in little
+	  overhead, but enabling debug messages results in very significant
+	  slowdown of the system.
+
+	  When reporting bugs, please try to have available a full dump of
+	  debugging messages while the misbehaviour was occurring.
+
+config NTFS_RW
+	bool "NTFS write support (DANGEROUS)"
+	depends on NTFS_FS && EXPERIMENTAL
+	help
+	  This enables the experimental write support in the NTFS driver.
+
+	  WARNING: Do not use this option unless you are actively developing
+	  NTFS as it is currently guaranteed to be broken and you
+	  may lose all your data!
+
+	  It is strongly recommended and perfectly safe to say N here.
+
+endmenu
+
+menu "Pseudo filesystems"
+
+config PROC_FS
+	bool "/proc file system support"
+	help
+	  This is a virtual file system providing information about the status
+	  of the system. "Virtual" means that it doesn't take up any space on
+	  your hard disk: the files are created on the fly by the kernel when
+	  you try to access them. Also, you cannot read the files with older
+	  version of the program less: you need to use more or cat.
+
+	  It's totally cool; for example, "cat /proc/interrupts" gives
+	  information about what the different IRQs are used for at the moment
+	  (there is a small number of Interrupt ReQuest lines in your computer
+	  that are used by the attached devices to gain the CPU's attention --
+	  often a source of trouble if two devices are mistakenly configured
+	  to use the same IRQ). The program procinfo to display some
+	  information about your system gathered from the /proc file system.
+
+	  Before you can use the /proc file system, it has to be mounted,
+	  meaning it has to be given a location in the directory hierarchy.
+	  That location should be /proc. A command such as "mount -t proc proc
+	  /proc" or the equivalent line in /etc/fstab does the job.
+
+	  The /proc file system is explained in the file
+	  <file:Documentation/filesystems/proc.txt> and on the proc(5) manpage
+	  ("man 5 proc").
+
+	  This option will enlarge your kernel by about 67 KB. Several
+	  programs depend on this, so everyone should say Y here.
+
+config DEVFS_FS
+	bool "/dev file system support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  This is support for devfs, a virtual file system (like /proc) which
+	  provides the file system interface to device drivers, normally found
+	  in /dev. Devfs does not depend on major and minor number
+	  allocations. Device drivers register entries in /dev which then
+	  appear automatically, which means that the system administrator does
+	  not have to create character and block special device files in the
+	  /dev directory using the mknod command (or MAKEDEV script) anymore.
+
+	  This is work in progress. If you want to use this, you *must* read
+	  the material in <file:Documentation/filesystems/devfs/>, especially
+	  the file README there.
+
+	  If unsure, say N.
+
+config DEVFS_MOUNT
+	bool "Automatically mount at boot"
+	depends on DEVFS_FS
+	help
+	  This option appears if you have CONFIG_DEVFS_FS enabled. Setting
+	  this to 'Y' will make the kernel automatically mount devfs onto /dev
+	  when the system is booted, before the init thread is started.
+	  You can override this with the "devfs=nomount" boot option.
+
+	  If unsure, say N.
+
+config DEVFS_DEBUG
+	bool "Debug devfs"
+	depends on DEVFS_FS
+	help
+	  If you say Y here, then the /dev file system code will generate
+	  debugging messages. See the file
+	  <file:Documentation/filesystems/devfs/boot-options> for more
+	  details.
+
+	  If unsure, say N.
+
+config DEVPTS_FS
+# It compiles as a module for testing only.  It should not be used
+# as a module in general.  If we make this "tristate", a bunch of people
+# who don't know what they are doing turn it on and complain when it
+# breaks.
+	bool "/dev/pts file system for Unix98 PTYs"
+	depends on UNIX98_PTYS
+	---help---
+	  You should say Y here if you said Y to "Unix98 PTY support" above.
+	  You'll then get a virtual file system which can be mounted on
+	  /dev/pts with "mount -t devpts". This, together with the pseudo
+	  terminal master multiplexer /dev/ptmx, is used for pseudo terminal
+	  support as described in The Open Group's Unix98 standard: in order
+	  to acquire a pseudo terminal, a process opens /dev/ptmx; the number
+	  of the pseudo terminal is then made available to the process and the
+	  pseudo terminal slave can be accessed as /dev/pts/<number>. What was
+	  traditionally /dev/ttyp2 will then be /dev/pts/2, for example.
+
+	  The GNU C library glibc 2.1 contains the requisite support for this
+	  mode of operation; you also need client programs that use the Unix98
+	  API. Please read <file:Documentation/Changes> for more information
+	  about the Unix98 pty devices.
+
+	  Note that the experimental "/dev file system support"
+	  (CONFIG_DEVFS_FS)  is a more general facility.
+
+config TMPFS
+	bool "Virtual memory file system support (former shm fs)"
+	help
+	  Tmpfs is a file system which keeps all files in virtual memory.
+
+	  Everything in tmpfs is temporary in the sense that no files will be
+	  created on your hard drive. The files live in memory and swap
+	  space. If you unmount a tmpfs instance, everything stored therein is
+	  lost.
+
+	  See <file:Documentation/filesystems/tmpfs.txt> for details.
+
+config RAMFS
+	bool
+	default y
+	---help---
+	  Ramfs is a file system which keeps all files in RAM. It allows
+	  read and write access.
+
+	  It is more of an programming example than a useable file system.  If
+	  you need a file system which lives in RAM with limit checking use
+	  tmpfs.
+
+	  If you want to compile this as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want),
+	  say M here and read <file:Documentation/modules.txt>.  The module
+	  will be called ramfs.
+
+endmenu
+
+menu "Miscellaneous filesystems"
+
+config ADFS_FS
+	tristate "ADFS file system support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  The Acorn Disc Filing System is the standard file system of the
+	  RiscOS operating system which runs on Acorn's ARM-based Risc PC
+	  systems and the Acorn Archimedes range of machines. If you say Y
+	  here, Linux will be able to read from ADFS partitions on hard drives
+	  and from ADFS-formatted floppy discs. If you also want to be able to
+	  write to those devices, say Y to "ADFS write support" below.
+
+	  The ADFS partition should be the first partition (i.e.,
+	  /dev/[hs]d?1) on each of your drives. Please read the file
+	  <file:Documentation/filesystems/adfs.txt> for further details.
+
+	  This code is also available as a module called adfs ( = code which
+	  can be inserted in and removed from the running kernel whenever you
+	  want). If you want to compile it as a module, say M here and read
+	  <file:Documentation/modules.txt>.
+
+	  If unsure, say N.
+
+config ADFS_FS_RW
+	bool "ADFS write support (DANGEROUS)"
+	depends on ADFS_FS
+	help
+	  If you say Y here, you will be able to write to ADFS partitions on
+	  hard drives and ADFS-formatted floppy disks. This is experimental
+	  codes, so if you're unsure, say N.
+
+config AFFS_FS
 	tristate "Amiga FFS file system support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
-	---help---
+	help
 	  The Fast File System (FFS) is the common file system used on hard
 	  disks by Amiga(tm) systems since AmigaOS Version 1.3 (34.20).  Say Y
 	  if you want to be able to read and write files from and to an Amiga
@@ -193,7 +897,7 @@
 config HFS_FS
 	tristate "Apple Macintosh file system support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
-	---help---
+	help
 	  If you say Y here, you will be able to mount Macintosh-formatted
 	  floppy disks and hard drive partitions with full read-write access.
 	  Please read <file:fs/hfs/HFS.txt> to learn about the available mount
@@ -208,7 +912,7 @@
 config BEFS_FS
 	tristate "BeOS file systemv(BeFS) support (read only) (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
-	---help---
+	help
 	  The BeOS File System (BeFS) is the native file system of Be, Inc's
 	  BeOS. Notable features include support for arbitrary attributes
 	  on files and directories, and database-like indices on selected
@@ -236,7 +940,7 @@
 config BFS_FS
 	tristate "BFS file system support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
-	---help---
+	help
 	  Boot File System (BFS) is a file system used under SCO UnixWare to
 	  allow the bootloader access to the kernel image and other important
 	  files during the boot process.  It is usually mounted under /stand
@@ -256,236 +960,12 @@
 	  partition (the one containing the directory /) cannot be compiled as
 	  a module.
 
-config EXT3_FS
-	tristate "Ext3 journalling file system support"
-	---help---
-	  This is the journaling version of the Second extended file system
-	  (often called ext3), the de facto standard Linux file system
-	  (method to organize files on a storage device) for hard disks.
-
-	  The journaling code included in this driver means you do not have
-	  to run e2fsck (file system checker) on your file systems after a
-	  crash.  The journal keeps track of any changes that were being made
-	  at the time the system crashed, and can ensure that your file system
-	  is consistent without the need for a lengthy check.
-
-	  Other than adding the journal to the file system, the on-disk format
-	  of ext3 is identical to ext2.  It is possible to freely switch
-	  between using the ext3 driver and the ext2 driver, as long as the
-	  file system has been cleanly unmounted, or e2fsck is run on the file
-	  system.
-
-	  To add a journal on an existing ext2 file system or change the
-	  behavior of ext3 file systems, you can use the tune2fs utility ("man
-	  tune2fs").  To modify attributes of files and directories on ext3
-	  file systems, use chattr ("man chattr").  You need to be using
-	  e2fsprogs version 1.20 or later in order to create ext3 journals
-	  (available at <http://sourceforge.net/projects/e2fsprogs/>).
-
-	  If you want to compile this file system as a module ( = code which
-	  can be inserted in and removed from the running kernel whenever you
-	  want), say M here and read <file:Documentation/modules.txt>.  The
-	  module will be called ext3.  Be aware however that the file system
-	  of your root partition (the one containing the directory /) cannot
-	  be compiled as a module, and so this may be dangerous.
-
-config EXT3_FS_XATTR
-	bool "Ext3 extended attributes"
-	depends on EXT3_FS
-	default y
-	---help---
-	  Extended attributes are name:value pairs associated with inodes by
-	  the kernel or by users (see the attr(5) manual page, or visit
-	  <http://acl.bestbits.at/> for details).
-
-	  If unsure, say N.
-
-	  You need this for POSIX ACL support on ext3.
-
-config EXT3_FS_POSIX_ACL
-	bool "Ext3 POSIX Access Control Lists"
-	depends on EXT3_FS_XATTR
-	---help---
-	  Posix Access Control Lists (ACLs) support permissions for users and
-	  groups beyond the owner/group/world scheme.
-
-	  To learn more about Access Control Lists, visit the Posix ACLs for
-	  Linux website <http://acl.bestbits.at/>.
-
-	  If you don't know what Access Control Lists are, say N
-
-# CONFIG_JBD could be its own option (even modular), but until there are
-# other users than ext3, we will simply make it be the same as CONFIG_EXT3_FS
-# dep_tristate '  Journal Block Device support (JBD for ext3)' CONFIG_JBD $CONFIG_EXT3_FS
-config JBD
-	bool
-	default EXT3_FS
-	---help---
-	  This is a generic journaling layer for block devices.  It is
-	  currently used by the ext3 file system, but it could also be used to
-	  add journal support to other file systems or block devices such as
-	  RAID or LVM.
-
-	  If you are using the ext3 file system, you need to say Y here. If
-	  you are not using ext3 then you will probably want to say N.
-
-	  If you want to compile this device as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want),
-	  say M here and read <file:Documentation/modules.txt>.  The module
-	  will be called jbd.  If you are compiling ext3 into the kernel,
-	  you cannot compile this code as a module.
-
-config JBD_DEBUG
-	bool "JBD (ext3) debugging support"
-	depends on JBD
-	---help---
-	  If you are using the ext3 journaled file system (or potentially any
-	  other file system/device using JBD), this option allows you to
-	  enable debugging output while the system is running, in order to
-	  help track down any problems you are having.  By default the
-	  debugging output will be turned off.
-
-	  If you select Y here, then you will be able to turn on debugging
-	  with "echo N > /proc/sys/fs/jbd-debug", where N is a number between
-	  1 and 5, the higher the number, the more debugging output is
-	  generated.  To turn debugging off again, do
-	  "echo 0 > /proc/sys/fs/jbd-debug".
-
-# msdos file systems
-config FAT_FS
-	tristate "DOS FAT fs support"
-	---help---
-	  If you want to use one of the FAT-based file systems (the MS-DOS,
-	  VFAT (Windows 95) and UMSDOS (used to run Linux on top of an
-	  ordinary DOS partition) file systems), then you must say Y or M here
-	  to include FAT support. You will then be able to mount partitions or
-	  diskettes with FAT-based file systems and transparently access the
-	  files on them, i.e. MSDOS files will look and behave just like all
-	  other Unix files.
-
-	  This FAT support is not a file system in itself, it only provides
-	  the foundation for the other file systems. You will have to say Y or
-	  M to at least one of "MSDOS fs support" or "VFAT fs support" in
-	  order to make use of it.
-
-	  Another way to read and write MSDOS floppies and hard drive
-	  partitions from within Linux (but not transparently) is with the
-	  mtools ("man mtools") program suite. You don't need to say Y here in
-	  order to do that.
-
-	  If you need to move large files on floppies between a DOS and a
-	  Linux box, say Y here, mount the floppy under Linux with an MSDOS
-	  file system and use GNU tar's M option. GNU tar is a program
-	  available for Unix and DOS ("man tar" or "info tar").
-
-	  It is now also becoming possible to read and write compressed FAT
-	  file systems; read <file:Documentation/filesystems/fat_cvf.txt> for
-	  details.
-
-	  The FAT support will enlarge your kernel by about 37 KB. If unsure,
-	  say Y.
-
-	  If you want to compile this as a module however ( = code which can
-	  be inserted in and removed from the running kernel whenever you
-	  want), say M here and read <file:Documentation/modules.txt>.  The
-	  module will be called fat.  Note that if you compile the FAT
-	  support as a module, you cannot compile any of the FAT-based file
-	  systems into the kernel -- they will have to be modules as well.
-	  The file system of your root partition (the one containing the
-	  directory /) cannot be a module, so don't say M here if you intend
-	  to use UMSDOS as your root file system.
-
-config MSDOS_FS
-	tristate "MSDOS fs support"
-	depends on FAT_FS
-	---help---
-	  This allows you to mount MSDOS partitions of your hard drive (unless
-	  they are compressed; to access compressed MSDOS partitions under
-	  Linux, you can either use the DOS emulator DOSEMU, described in the
-	  DOSEMU-HOWTO, available from
-	  <http://www.linuxdoc.org/docs.html#howto>, or try dmsdosfs in
-	  <ftp://ibiblio.org/pub/Linux/system/filesystems/dosfs/>. If you
-	  intend to use dosemu with a non-compressed MSDOS partition, say Y
-	  here) and MSDOS floppies. This means that file access becomes
-	  transparent, i.e. the MSDOS files look and behave just like all
-	  other Unix files.
-
-	  If you want to use UMSDOS, the Unix-like file system on top of a
-	  DOS file system, which allows you to run Linux from within a DOS
-	  partition without repartitioning, you'll have to say Y or M here.
-
-	  If you have Windows 95 or Windows NT installed on your MSDOS
-	  partitions, you should use the VFAT file system (say Y to "VFAT fs
-	  support" below), or you will not be able to see the long filenames
-	  generated by Windows 95 / Windows NT.
-
-	  This option will enlarge your kernel by about 7 KB. If unsure,
-	  answer Y. This will only work if you said Y to "DOS FAT fs support"
-	  as well. If you want to compile this as a module however ( = code
-	  which can be inserted in and removed from the running kernel
-	  whenever you want), say M here and read
-	  <file:Documentation/modules.txt>.
-	  The module will be called msdos.
-
-#dep_tristate '    UMSDOS: Unix-like file system on top of standard MSDOS fs' CONFIG_UMSDOS_FS $CONFIG_MSDOS_FS
-# UMSDOS is temprory broken
-config UMSDOS_FS
-	bool
-	---help---
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
-	  above.  If you want to compile this as a module ( = code which can
-	  be inserted in and removed from the running kernel whenever you
-	  want), say M here and read <file:Documentation/modules.txt>.  The
-	  module will be called umsdos.  Note that the file system of your
-	  root partition (the one containing the directory /) cannot be a
-	  module, so saying M could be dangerous.  If unsure, say N.
-
-config VFAT_FS
-	tristate "VFAT (Windows-95) fs support"
-	depends on FAT_FS
-	---help---
-	  This option provides support for normal Windows file systems with
-	  long filenames.  That includes non-compressed FAT-based file systems
-	  used by Windows 95, Windows 98, Windows NT 4.0, and the Unix
-	  programs from the mtools package.
-
-	  You cannot use the VFAT file system for your Linux root partition
-	  (the one containing the directory /); use UMSDOS instead if you
-	  want to run Linux from within a DOS partition (i.e. say Y to
-	  "Unix like fs on top of std MSDOS fs", below).
-
-	  The VFAT support enlarges your kernel by about 10 KB and it only
-	  works if you said Y to the "DOS FAT fs support" above.  Please read
-	  the file <file:Documentation/filesystems/vfat.txt> for details.  If
-	  unsure, say Y.
 
-	  If you want to compile this as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want),
-	  say M here and read <file:Documentation/modules.txt>.  The module
-	  will be called vfat.
 
 config EFS_FS
 	tristate "EFS file system support (read only) (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
-	---help---
+	help
 	  EFS is an older file system used for non-ISO9660 CD-ROMs and hard
 	  disk partitions by SGI's IRIX operating system (IRIX 6.0 and newer
 	  uses the XFS file system for hard disk partitions however).
@@ -538,7 +1018,7 @@
 	int "JFFS2 debugging verbosity (0 = quiet, 2 = noisy)"
 	depends on JFFS2_FS
 	default "0"
-	---help---
+	help
 	  This controls the amount of debugging messages produced by the JFFS2
 	  code. Set it to zero for use in production systems. For evaluation,
 	  testing and debugging, it's advisable to set it to one. This will
@@ -555,7 +1035,7 @@
 	bool "JFFS2 support for NAND flash (EXPERIMENTAL)"
 	depends on JFFS2_FS && EXPERIMENTAL
 	default n
-	---help---
+	help
 	  This enables the experimental support for NAND flash in JFFS2. NAND
 	  is a newer type of flash chip design than the traditional NOR flash,
 	  with higher density but a handful of characteristics which make it
@@ -570,7 +1050,7 @@
 
 config CRAMFS
 	tristate "Compressed ROM file system support"
-	---help---
+	help
 	  Saying Y here includes support for CramFs (Compressed ROM File
 	  System).  CramFs is designed to be a simple, small, and compressed
 	  file system for ROM based embedded systems.  CramFs is read-only,
@@ -588,136 +1068,9 @@
 
 	  If unsure, say N.
 
-config TMPFS
-	bool "Virtual memory file system support (former shm fs)"
-	help
-	  Tmpfs is a file system which keeps all files in virtual memory.
-
-	  Everything in tmpfs is temporary in the sense that no files will be
-	  created on your hard drive. The files live in memory and swap
-	  space. If you unmount a tmpfs instance, everything stored therein is
-	  lost.
-
-	  See <file:Documentation/filesystems/tmpfs.txt> for details.
-
-config RAMFS
-	bool
-	default y
-	---help---
-	  Ramfs is a file system which keeps all files in RAM. It allows
-	  read and write access.
-
-	  It is more of an programming example than a useable file system.  If
-	  you need a file system which lives in RAM with limit checking use
-	  tmpfs.
-
-	  If you want to compile this as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want),
-	  say M here and read <file:Documentation/modules.txt>.  The module
-	  will be called ramfs.
-
-config HUGETLBFS
-	bool "HugeTLB file system support"
-	depends on HUGETLB_PAGE
-
-config ISO9660_FS
-	tristate "ISO 9660 CDROM file system support"
-	---help---
-	  This is the standard file system used on CD-ROMs.  It was previously
-	  known as "High Sierra File System" and is called "hsfs" on other
-	  Unix systems.  The so-called Rock-Ridge extensions which allow for
-	  long Unix filenames and symbolic links are also supported by this
-	  driver.  If you have a CD-ROM drive and want to do more with it than
-	  just listen to audio CDs and watch its LEDs, say Y (and read
-	  <file:Documentation/filesystems/isofs.txt> and the CD-ROM-HOWTO,
-	  available from <http://www.linuxdoc.org/docs.html#howto>), thereby
-	  enlarging your kernel by about 27 KB; otherwise say N.
-
-	  If you want to compile this as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want),
-	  say M here and read <file:Documentation/modules.txt>.  The module
-	  will be called isofs.
-
-config JOLIET
-	bool "Microsoft Joliet CDROM extensions"
-	depends on ISO9660_FS
-	help
-	  Joliet is a Microsoft extension for the ISO 9660 CD-ROM file system
-	  which allows for long filenames in unicode format (unicode is the
-	  new 16 bit character code, successor to ASCII, which encodes the
-	  characters of almost all languages of the world; see
-	  <http://www.unicode.org/> for more information).  Say Y here if you
-	  want to be able to read Joliet CD-ROMs under Linux.
-
-config ZISOFS
-	bool "Transparent decompression extension"
-	depends on ISO9660_FS
-	help
-	  This is a Linux-specific extension to RockRidge which lets you store
-	  data in compressed form on a CD-ROM and have it transparently
-	  decompressed when the CD-ROM is accessed.  See
-	  <http://www.kernel.org/pub/linux/utils/fs/zisofs/> for the tools
-	  necessary to create such a filesystem.  Say Y here if you want to be
-	  able to read such compressed CD-ROMs.
-
-config JFS_FS
-	tristate "JFS filesystem support"
-	help
-	  This is a port of IBM's Journaled Filesystem .  More information is
-	  available in the file Documentation/filesystems/jfs.txt.
-
-	  If you do not intend to use the JFS filesystem, say N.
-
-config JFS_POSIX_ACL
-	bool "JFS POSIX Access Control Lists"
-	depends on JFS_FS
-	---help---
-	  Posix Access Control Lists (ACLs) support permissions for users and
-	  groups beyond the owner/group/world scheme.
-
-	  To learn more about Access Control Lists, visit the Posix ACLs for
-	  Linux website <http://acl.bestbits.at/>.
-
-	  If you don't know what Access Control Lists are, say N
-
-config JFS_DEBUG
-	bool "JFS debugging"
-	depends on JFS_FS
-	help
-	  If you are experiencing any problems with the JFS filesystem, say
-	  Y here.  This will result in additional debugging messages to be
-	  written to the system log.  Under normal circumstances, this
-	  results in very little overhead.
-
-config JFS_STATISTICS
-	bool "JFS statistics"
-	depends on JFS_FS
-	help
-	  Enabling this option will cause statistics from the JFS file system
-	  to be made available to the user in the /proc/fs/jfs/ directory.
-
-config MINIX_FS
-	tristate "Minix fs support"
-	---help---
-	  Minix is a simple operating system used in many classes about OS's.
-	  The minix file system (method to organize files on a hard disk
-	  partition or a floppy disk) was the original file system for Linux,
-	  but has been superseded by the second extended file system ext2fs.
-	  You don't want to use the minix file system on your hard disk
-	  because of certain built-in restrictions, but it is sometimes found
-	  on older Linux floppy disks.  This option will enlarge your kernel
-	  by about 28 KB. If unsure, say N.
-
-	  If you want to compile this as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want),
-	  say M here and read <file:Documentation/modules.txt>. The module
-	  will be called minix.  Note that the file system of your root
-	  partition (the one containing the directory /) cannot be compiled as
-	  a module.
-
 config VXFS_FS
 	tristate "FreeVxFS file system support (VERITAS VxFS(TM) compatible)"
-	---help---
+	help
 	  FreeVxFS is a file system driver that support the VERITAS VxFS(TM)
 	  file system format.  VERITAS VxFS(TM) is the standard file system
 	  of SCO UnixWare (and possibly others) and optionally available
@@ -731,173 +1084,32 @@
 	  This file system is also available as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want).
 	  The module is called freevxfs.  If you want to compile it as a
-	  module, say M here and read <file:Documentation/modules.txt>.  If
-	  unsure, say N.
-
-config NTFS_FS
-	tristate "NTFS file system support (read only)"
-	---help---
-	  NTFS is the file system of Microsoft Windows NT/2000/XP. For more
-	  information see <file:Documentation/filesystems/ntfs.txt>. Saying Y
-	  here would allow you to read from NTFS partitions.
-
-	  This file system is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called ntfs. If you want to compile it as a
-	  module, say M here and read <file:Documentation/modules.txt>.
-
-	  If you are not using Windows NT/2000/XP in addition to Linux on your
-	  computer it is safe to say N.
-
-config NTFS_DEBUG
-	bool "NTFS debugging support"
-	depends on NTFS_FS
-	---help---
-	  If you are experiencing any problems with the NTFS file system, say
-	  Y here. This will result in additional consistency checks to be
-	  performed by the driver as well as additional debugging messages to
-	  be written to the system log. Note that debugging messages are
-	  disabled by default. To enable them, supply the option debug_msgs=1
-	  at the kernel command line when booting the kernel or as an option
-	  to insmod when loading the ntfs module. Once the driver is active,
-	  you can enable debugging messages by doing (as root):
-	  echo 1 > /proc/sys/fs/ntfs-debug
-	  Replacing the "1" with "0" would disable debug messages.
-
-	  If you leave debugging messages disabled, this results in little
-	  overhead, but enabling debug messages results in very significant
-	  slowdown of the system.
-
-	  When reporting bugs, please try to have available a full dump of
-	  debugging messages while the misbehaviour was occurring.
-
-config NTFS_RW
-	bool "NTFS write support (DANGEROUS)"
-	depends on NTFS_FS && EXPERIMENTAL
-	help
-	  This enables the experimental write support in the NTFS driver.
-
-	  WARNING: Do not use this option unless you are actively developing
-	  NTFS as it is currently guaranteed to be broken and you
-	  may lose all your data!
-
-	  It is strongly recommended and perfectly safe to say N here.
-
-config HPFS_FS
-	tristate "OS/2 HPFS file system support"
-	---help---
-	  OS/2 is IBM's operating system for PC's, the same as Warp, and HPFS
-	  is the file system used for organizing files on OS/2 hard disk
-	  partitions. Say Y if you want to be able to read files from and
-	  write files to an OS/2 HPFS partition on your hard drive. OS/2
-	  floppies however are in regular MSDOS format, so you don't need this
-	  option in order to be able to read them. Read
-	  <file:Documentation/filesystems/hpfs.txt>.
-
-	  This file system is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module is called hpfs.  If you want to compile it as a module,
-	  say M here and read <file:Documentation/modules.txt>.  If unsure,
-	  say N.
-
-config PROC_FS
-	bool "/proc file system support"
-	---help---
-	  This is a virtual file system providing information about the status
-	  of the system. "Virtual" means that it doesn't take up any space on
-	  your hard disk: the files are created on the fly by the kernel when
-	  you try to access them. Also, you cannot read the files with older
-	  version of the program less: you need to use more or cat.
-
-	  It's totally cool; for example, "cat /proc/interrupts" gives
-	  information about what the different IRQs are used for at the moment
-	  (there is a small number of Interrupt ReQuest lines in your computer
-	  that are used by the attached devices to gain the CPU's attention --
-	  often a source of trouble if two devices are mistakenly configured
-	  to use the same IRQ). The program procinfo to display some
-	  information about your system gathered from the /proc file system.
-
-	  Before you can use the /proc file system, it has to be mounted,
-	  meaning it has to be given a location in the directory hierarchy.
-	  That location should be /proc. A command such as "mount -t proc proc
-	  /proc" or the equivalent line in /etc/fstab does the job.
-
-	  The /proc file system is explained in the file
-	  <file:Documentation/filesystems/proc.txt> and on the proc(5) manpage
-	  ("man 5 proc").
-
-	  This option will enlarge your kernel by about 67 KB. Several
-	  programs depend on this, so everyone should say Y here.
-
-config DEVFS_FS
-	bool "/dev file system support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	---help---
-	  This is support for devfs, a virtual file system (like /proc) which
-	  provides the file system interface to device drivers, normally found
-	  in /dev. Devfs does not depend on major and minor number
-	  allocations. Device drivers register entries in /dev which then
-	  appear automatically, which means that the system administrator does
-	  not have to create character and block special device files in the
-	  /dev directory using the mknod command (or MAKEDEV script) anymore.
-
-	  This is work in progress. If you want to use this, you *must* read
-	  the material in <file:Documentation/filesystems/devfs/>, especially
-	  the file README there.
-
-	  If unsure, say N.
-
-config DEVFS_MOUNT
-	bool "Automatically mount at boot"
-	depends on DEVFS_FS
-	help
-	  This option appears if you have CONFIG_DEVFS_FS enabled. Setting
-	  this to 'Y' will make the kernel automatically mount devfs onto /dev
-	  when the system is booted, before the init thread is started.
-	  You can override this with the "devfs=nomount" boot option.
+	  module, say M here and read <file:Documentation/modules.txt>.  If
+	  unsure, say N.
 
-	  If unsure, say N.
 
-config DEVFS_DEBUG
-	bool "Debug devfs"
-	depends on DEVFS_FS
+config HPFS_FS
+	tristate "OS/2 HPFS file system support"
 	help
-	  If you say Y here, then the /dev file system code will generate
-	  debugging messages. See the file
-	  <file:Documentation/filesystems/devfs/boot-options> for more
-	  details.
-
-	  If unsure, say N.
+	  OS/2 is IBM's operating system for PC's, the same as Warp, and HPFS
+	  is the file system used for organizing files on OS/2 hard disk
+	  partitions. Say Y if you want to be able to read files from and
+	  write files to an OS/2 HPFS partition on your hard drive. OS/2
+	  floppies however are in regular MSDOS format, so you don't need this
+	  option in order to be able to read them. Read
+	  <file:Documentation/filesystems/hpfs.txt>.
 
-# It compiles as a module for testing only.  It should not be used
-# as a module in general.  If we make this "tristate", a bunch of people
-# who don't know what they are doing turn it on and complain when it
-# breaks.
-config DEVPTS_FS
-	bool "/dev/pts file system for Unix98 PTYs"
-	depends on UNIX98_PTYS
-	---help---
-	  You should say Y here if you said Y to "Unix98 PTY support" above.
-	  You'll then get a virtual file system which can be mounted on
-	  /dev/pts with "mount -t devpts". This, together with the pseudo
-	  terminal master multiplexer /dev/ptmx, is used for pseudo terminal
-	  support as described in The Open Group's Unix98 standard: in order
-	  to acquire a pseudo terminal, a process opens /dev/ptmx; the number
-	  of the pseudo terminal is then made available to the process and the
-	  pseudo terminal slave can be accessed as /dev/pts/<number>. What was
-	  traditionally /dev/ttyp2 will then be /dev/pts/2, for example.
+	  This file system is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module is called hpfs.  If you want to compile it as a module,
+	  say M here and read <file:Documentation/modules.txt>.  If unsure,
+	  say N.
 
-	  The GNU C library glibc 2.1 contains the requisite support for this
-	  mode of operation; you also need client programs that use the Unix98
-	  API. Please read <file:Documentation/Changes> for more information
-	  about the Unix98 pty devices.
 
-	  Note that the experimental "/dev file system support"
-	  (CONFIG_DEVFS_FS)  is a more general facility.
 
 config QNX4FS_FS
 	tristate "QNX4 file system support (read only)"
-	---help---
+	help
 	  This is the file system used by the real-time operating systems
 	  QNX 4 and QNX 6 (the latter is also called QNX RTP).
 	  Further information is available at <http://www.qnx.com/>.
@@ -923,97 +1135,11 @@
 	  It's currently broken, so for now:
 	  answer N.
 
-config ROMFS_FS
-	tristate "ROM file system support"
-	---help---
-	  This is a very small read-only file system mainly intended for
-	  initial ram disks of installation disks, but it could be used for
-	  other read-only media as well.  Read
-	  <file:Documentation/filesystems/romfs.txt> for details.
-
-	  This file system support is also available as a module ( = code
-	  which can be inserted in and removed from the running kernel
-	  whenever you want). The module is called romfs.  If you want to
-	  compile it as a module, say M here and read
-	  <file:Documentation/modules.txt>.  Note that the file system of your
-	  root partition (the one containing the directory /) cannot be a
-	  module.
-
-	  If you don't know whether you need it, then you don't need it:
-	  answer N.
-
-config EXT2_FS
-	tristate "Second extended fs support"
-	---help---
-	  This is the de facto standard Linux file system (method to organize
-	  files on a storage device) for hard disks.
-
-	  You want to say Y here, unless you intend to use Linux exclusively
-	  from inside a DOS partition using the UMSDOS file system. The
-	  advantage of the latter is that you can get away without
-	  repartitioning your hard drive (which often implies backing
-	  everything up and restoring afterwards); the disadvantage is that
-	  Linux becomes susceptible to DOS viruses and that UMSDOS is somewhat
-	  slower than ext2fs. Even if you want to run Linux in this fashion,
-	  it might be a good idea to have ext2fs around: it enables you to
-	  read more floppy disks and facilitates the transition to a *real*
-	  Linux partition later. Another (rare) case which doesn't require
-	  ext2fs is a diskless Linux box which mounts all files over the
-	  network using NFS (in this case it's sufficient to say Y to "NFS
-	  file system support" below). Saying Y here will enlarge your kernel
-	  by about 44 KB.
-
-	  The Ext2fs-Undeletion mini-HOWTO, available from
-	  <http://www.linuxdoc.org/docs.html#howto>, gives information about
-	  how to retrieve deleted files on ext2fs file systems.
-
-	  To change the behavior of ext2 file systems, you can use the tune2fs
-	  utility ("man tune2fs"). To modify attributes of files and
-	  directories on ext2 file systems, use chattr ("man chattr").
-
-	  Ext2fs partitions can be read from within DOS using the ext2tool
-	  command line tool package (available from
-	  <ftp://ibiblio.org/pub/Linux/system/filesystems/ext2/>) and from
-	  within Windows NT using the ext2nt command line tool package from
-	  <ftp://ibiblio.org/pub/Linux/utils/dos/>.  Explore2fs is a
-	  graphical explorer for ext2fs partitions which runs on Windows 95
-	  and Windows NT and includes experimental write support; it is
-	  available from
-	  <http://jnewbigin-pc.it.swin.edu.au/Linux/Explore2fs.htm>.
-
-	  If you want to compile this file system as a module ( = code which
-	  can be inserted in and removed from the running kernel whenever you
-	  want), say M here and read <file:Documentation/modules.txt>.  The
-	  module will be called ext2.  Be aware however that the file system
-	  of your root partition (the one containing the directory /) cannot
-	  be compiled as a module, and so this could be dangerous.  Most
-	  everyone wants to say Y here.
-
-config EXT2_FS_XATTR
-	bool "Ext2 extended attributes"
-	depends on EXT2_FS
-	---help---
-	  Extended attributes are name:value pairs associated with inodes by
-	  the kernel or by users (see the attr(5) manual page, or visit
-	  <http://acl.bestbits.at/> for details).
-
-	  If unsure, say N.
-
-config EXT2_FS_POSIX_ACL
-	bool "Ext2 POSIX Access Control Lists"
-	depends on EXT2_FS_XATTR
-	---help---
-	  Posix Access Control Lists (ACLs) support permissions for users and
-	  groups beyond the owner/group/world scheme.
-
-	  To learn more about Access Control Lists, visit the Posix ACLs for
-	  Linux website <http://acl.bestbits.at/>.
 
-	  If you don't know what Access Control Lists are, say N
 
 config SYSV_FS
 	tristate "System V/Xenix/V7/Coherent file system support"
-	---help---
+	help
 	  SCO, Xenix and Coherent are commercial Unix systems for Intel
 	  machines, and Version 7 was used on the DEC PDP-11. Saying Y
 	  here would allow you to read from their floppies and hard disk
@@ -1049,172 +1175,55 @@
 
 	  If you haven't heard about all of this before, it's safe to say N.
 
-config UDF_FS
-	tristate "UDF file system support"
-	---help---
-	  This is the new file system used on some CD-ROMs and DVDs. Say Y if
-	  you intend to mount DVD discs or CDRW's written in packet mode, or
-	  if written to by other UDF utilities, such as DirectCD.
-	  Please read <file:Documentation/filesystems/udf.txt>.
-
-	  This file system support is also available as a module ( = code
-	  which can be inserted in and removed from the running kernel
-	  whenever you want). The module is called udf. If you want to
-	  compile it as a module, say M here and read
-	  <file:Documentation/modules.txt>.
 
-	  If unsure, say N.
 
 config UFS_FS
 	tristate "UFS file system support (read only)"
-	---help---
-	  BSD and derivate versions of Unix (such as SunOS, FreeBSD, NetBSD,
-	  OpenBSD and NeXTstep) use a file system called UFS. Some System V
-	  Unixes can create and mount hard disk partitions and diskettes using
-	  this file system as well. Saying Y here will allow you to read from
-	  these partitions; if you also want to write to them, say Y to the
-	  experimental "UFS file system write support", below. Please read the
-	  file <file:Documentation/filesystems/ufs.txt> for more information.
-
-	  If you only intend to mount files from some other Unix over the
-	  network using NFS, you don't need the UFS file system support (but
-	  you need NFS file system support obviously).
-
-	  Note that this option is generally not needed for floppies, since a
-	  good portable way to transport files and directories between unixes
-	  (and even other operating systems) is given by the tar program ("man
-	  tar" or preferably "info tar").
-
-	  When accessing NeXTstep files, you may need to convert them from the
-	  NeXT character set to the Latin1 character set; use the program
-	  recode ("info recode") for this purpose.
-
-	  If you want to compile the UFS file system support as a module ( =
-	  code which can be inserted in and removed from the running kernel
-	  whenever you want), say M here and read
-	  <file:Documentation/modules.txt>. The module will be called ufs.
-
-	  If you haven't heard about all of this before, it's safe to say N.
-
-config UFS_FS_WRITE
-	bool "UFS file system write support (DANGEROUS)"
-	depends on UFS_FS && EXPERIMENTAL
 	help
-	  Say Y here if you want to try writing to UFS partitions. This is
-	  experimental, so you should back up your UFS partitions beforehand.
-
-config XFS_FS
-	tristate "XFS filesystem support"
-	---help---
-	  XFS is a high performance journaling filesystem which originated
-	  on the SGI IRIX platform.  It is completely multi-threaded, can
-	  support large files and large filesystems, extended attributes,
-	  variable block sizes, is extent based, and makes extensive use of
-	  Btrees (directories, extents, free space) to aid both performance
-	  and scalability.
-
-	  Refer to the documentation at <http://oss.sgi.com/projects/xfs/>
-	  for complete details.  This implementation is on-disk compatible
-	  with the IRIX version of XFS.
-
-	  If you want to compile this file system as a module ( = code which
-	  can be inserted in and removed from the running kernel whenever you
-	  want), say M here and read <file:Documentation/modules.txt>. The
-	  module will be called xfs.  Be aware, however, that if the file
-	  system of your root partition is compiled as a module, you'll need
-	  to use an initial ramdisk (initrd) to boot.
-
-config XFS_RT
-	bool "Realtime support (EXPERIMENTAL)"
-	depends on XFS_FS && EXPERIMENTAL
-	---help---
-	  If you say Y here you will be able to mount and use XFS filesystems
-	  which contain a realtime subvolume. The realtime subvolume is a
-	  separate area of disk space where only file data is stored. The
-	  realtime subvolume is designed to provide very deterministic
-	  data rates suitable for media streaming applications.
-
-	  See the xfs man page in section 5 for a bit more information.
-
-	  This feature is unsupported at this time, is not yet fully
-	  functional, and may cause serious problems.
-
-	  If unsure, say N.
-
-config XFS_QUOTA
-	bool "Quota support"
-	depends on XFS_FS
-	---help---
-	  If you say Y here, you will be able to set limits for disk usage on
-	  a per user and/or a per group basis under XFS.  XFS considers quota
-	  information as filesystem metadata and uses journaling to provide a
-	  higher level guarantee of consistency.  The on-disk data format for
-	  quota is also compatible with the IRIX version of XFS, allowing a
-	  filesystem to be migrated between Linux and IRIX without any need
-	  for conversion.
-
-	  If unsure, say N.  More comprehensive documentation can be found in
-	  README.quota in the xfsprogs package.  XFS quota can be used either
-	  with or without the generic quota support enabled (CONFIG_QUOTA) -
-	  they are completely independent subsystems.
-
-config XFS_POSIX_ACL
-	bool "ACL support"
-	depends on XFS_FS
-	---help---
-	  Posix Access Control Lists (ACLs) support permissions for users and
-	  groups beyond the owner/group/world scheme.
-
-	  To learn more about Access Control Lists, visit the Posix ACLs for
-	  Linux website <http://acl.bestbits.at/>.
-
-	  If you don't know what Access Control Lists are, say N
-
+	  BSD and derivate versions of Unix (such as SunOS, FreeBSD, NetBSD,
+	  OpenBSD and NeXTstep) use a file system called UFS. Some System V
+	  Unixes can create and mount hard disk partitions and diskettes using
+	  this file system as well. Saying Y here will allow you to read from
+	  these partitions; if you also want to write to them, say Y to the
+	  experimental "UFS file system write support", below. Please read the
+	  file <file:Documentation/filesystems/ufs.txt> for more information.
 
-menu "Network File Systems"
-	depends on NET
+	  If you only intend to mount files from some other Unix over the
+	  network using NFS, you don't need the UFS file system support (but
+	  you need NFS file system support obviously).
 
-config CODA_FS
-	tristate "Coda file system support (advanced network fs)"
-	depends on INET
-	---help---
-	  Coda is an advanced network file system, similar to NFS in that it
-	  enables you to mount file systems of a remote server and access them
-	  with regular Unix commands as if they were sitting on your hard
-	  disk.  Coda has several advantages over NFS: support for
-	  disconnected operation (e.g. for laptops), read/write server
-	  replication, security model for authentication and encryption,
-	  persistent client caches and write back caching.
+	  Note that this option is generally not needed for floppies, since a
+	  good portable way to transport files and directories between unixes
+	  (and even other operating systems) is given by the tar program ("man
+	  tar" or preferably "info tar").
 
-	  If you say Y here, your Linux box will be able to act as a Coda
-	  *client*.  You will need user level code as well, both for the
-	  client and server.  Servers are currently user level, i.e. they need
-	  no kernel support.  Please read
-	  <file:Documentation/filesystems/coda.txt> and check out the Coda
-	  home page <http://www.coda.cs.cmu.edu/>.
+	  When accessing NeXTstep files, you may need to convert them from the
+	  NeXT character set to the Latin1 character set; use the program
+	  recode ("info recode") for this purpose.
 
-	  If you want to compile the coda client support as a module ( = code
-	  which can be inserted in and removed from the running kernel
+	  If you want to compile the UFS file system support as a module ( =
+	  code which can be inserted in and removed from the running kernel
 	  whenever you want), say M here and read
-	  <file:Documentation/modules.txt>.  The module will be called coda.
+	  <file:Documentation/modules.txt>. The module will be called ufs.
 
-config INTERMEZZO_FS
-	tristate "InterMezzo file system support (replicating fs) (EXPERIMENTAL)"
-	depends on INET && EXPERIMENTAL
+	  If you haven't heard about all of this before, it's safe to say N.
+
+config UFS_FS_WRITE
+	bool "UFS file system write support (DANGEROUS)"
+	depends on UFS_FS && EXPERIMENTAL
 	help
-	  InterMezzo is a networked file system with disconnected operation
-	  and kernel level write back caching.  It is most often used for
-	  replicating potentially large trees or keeping laptop/desktop copies
-	  in sync.
+	  Say Y here if you want to try writing to UFS partitions. This is
+	  experimental, so you should back up your UFS partitions beforehand.
 
-	  If you say Y or M your kernel or module will provide InterMezzo
-	  support.  You will also need a file server daemon, which you can get
-	  from <http://www.inter-mezzo.org/>.
+endmenu
+
+menu "Network File Systems"
+	depends on NET
 
 config NFS_FS
 	tristate "NFS file system support"
 	depends on INET
-	---help---
+	help
 	  If you are connected to some other (usually local) Unix computer
 	  (using SLIP, PLIP, PPP or Ethernet) and want to mount files residing
 	  on that computer (the NFS server) using the Network File Sharing
@@ -1268,24 +1277,10 @@
 
 	  If unsure, say N.
 
-config ROOT_NFS
-	bool "Root file system on NFS"
-	depends on NFS_FS=y && IP_PNP
-	help
-	  If you want your Linux box to mount its whole root file system (the
-	  one containing the directory /) from some other computer over the
-	  net via NFS (presumably because your box doesn't have a hard disk),
-	  say Y. Read <file:Documentation/nfsroot.txt> for details. It is
-	  likely that in this case, you also want to say Y to "Kernel level IP
-	  autoconfiguration" so that your box can discover its network address
-	  at boot time.
-
-	  Most people say N here.
-
 config NFSD
 	tristate "NFS server support"
 	depends on INET
-	---help---
+	help
 	  If you want your Linux box to act as an NFS *server*, so that other
 	  computers on your local network which support NFS can access certain
 	  directories on your box transparently, you have two options: you can
@@ -1334,34 +1329,19 @@
 	  Enable NFS service over TCP connections.  This the officially
 	  still experimental, but seems to work well.
 
-config SUNRPC
-	tristate
-	default m if NFS_FS!=y && NFSD!=y && (NFS_FS=m || NFSD=m)
-	default y if NFS_FS=y || NFSD=y
-
-config SUNRPC_GSS
-	tristate "Provide RPCSEC_GSS authentication (EXPERIMENTAL)"
-	depends on SUNRPC && EXPERIMENTAL
-	default SUNRPC if NFS_V4=y
-	help
-	  Provides cryptographic authentication for NFS rpc requests.  To
-	  make this useful, you must also select at least one rpcsec_gss
-	  mechanism.
-	  Note: You should always select this option if you wish to use
-	  NFSv4.
-
-config RPCSEC_GSS_KRB5
-	tristate "Kerberos V mechanism for RPCSEC_GSS (EXPERIMENTAL)"
-	depends on SUNRPC_GSS && CRYPTO_DES && CRYPTO_MD5
-	default SUNRPC_GSS if NFS_V4=y
+config ROOT_NFS
+	bool "Root file system on NFS"
+	depends on NFS_FS=y && IP_PNP
 	help
-	  Provides a gss-api mechanism based on Kerberos V5 (this is
-	  mandatory for RFC3010-compliant NFSv4 implementations).
-	  Requires a userspace daemon;
-		see http://www.citi.umich.edu/projects/nfsv4/.
+	  If you want your Linux box to mount its whole root file system (the
+	  one containing the directory /) from some other computer over the
+	  net via NFS (presumably because your box doesn't have a hard disk),
+	  say Y. Read <file:Documentation/nfsroot.txt> for details. It is
+	  likely that in this case, you also want to say Y to "Kernel level IP
+	  autoconfiguration" so that your box can discover its network address
+	  at boot time.
 
-	  Note: If you select this option, please ensure that you also
-	  enable the MD5 and DES crypto ciphers.
+	  Most people say N here.
 
 config LOCKD
 	tristate
@@ -1377,32 +1357,10 @@
 	tristate
 	default NFSD
 
-config CIFS
-	tristate "CIFS support (advanced network filesystem for Samba, Window and other CIFS compliant servers)(EXPERIMENTAL)"
-	depends on INET
-	---help---
-	  This is the client VFS module for the Common Internet File System
-	  (CIFS) protocol which is the successor to the Server Message Block 
-	  (SMB) protocol, the native file sharing mechanism for most early
-	  PC operating systems.  CIFS is fully supported by current network
-	  file servers such as Windows 2000 (including Windows NT version 4 
-	  and Windows XP) as well by Samba (which provides excellent CIFS
-	  server support for Linux and many other operating systems).  For
-	  production systems the smbfs module may be used instead of this
-	  cifs module since smbfs is currently more stable and provides
-	  support for older servers.  The intent of this module is to provide the
-	  most advanced network file system function for CIFS compliant servers, 
-	  including support for dfs (heirarchical name space), secure per-user
-	  session establishment, safe distributed caching (oplock), optional
-	  packet signing, Unicode and other internationalization improvements, and
-	  optional Winbind (nsswitch) integration.  This module is in an early
-	  development stage, so unless you are specifically interested in this
-	  filesystem, just say N.
-
 config SMB_FS
 	tristate "SMB file system support (to mount Windows shares etc.)"
 	depends on INET
-	---help---
+	help
 	  SMB (Server Message Block) is the protocol Windows for Workgroups
 	  (WfW), Windows 95/98, Windows NT and OS/2 Lan Manager use to share
 	  files and printers over local networks.  Saying Y here allows you to
@@ -1456,10 +1414,32 @@
 
 	  smbmount from samba 2.2.0 or later supports this.
 
+config CIFS
+	tristate "CIFS support (advanced network filesystem for Samba, Window and other CIFS compliant servers)(EXPERIMENTAL)"
+	depends on INET
+	help
+	  This is the client VFS module for the Common Internet File System
+	  (CIFS) protocol which is the successor to the Server Message Block 
+	  (SMB) protocol, the native file sharing mechanism for most early
+	  PC operating systems.  CIFS is fully supported by current network
+	  file servers such as Windows 2000 (including Windows NT version 4 
+	  and Windows XP) as well by Samba (which provides excellent CIFS
+	  server support for Linux and many other operating systems).  For
+	  production systems the smbfs module may be used instead of this
+	  cifs module since smbfs is currently more stable and provides
+	  support for older servers.  The intent of this module is to provide the
+	  most advanced network file system function for CIFS compliant servers, 
+	  including support for dfs (heirarchical name space), secure per-user
+	  session establishment, safe distributed caching (oplock), optional
+	  packet signing, Unicode and other internationalization improvements, and
+	  optional Winbind (nsswitch) integration.  This module is in an early
+	  development stage, so unless you are specifically interested in this
+	  filesystem, just say N.
+
 config NCP_FS
 	tristate "NCP file system support (to mount NetWare volumes)"
 	depends on IPX!=n || INET
-	---help---
+	help
 	  NCP (NetWare Core Protocol) is a protocol that runs over IPX and is
 	  used by Novell NetWare clients to talk to file servers.  It is to
 	  IPX what NFS is to TCP/IP, if that helps.  Saying Y here allows you
@@ -1480,10 +1460,76 @@
 	  will be called ncpfs.  Say N unless you are connected to a Novell
 	  network.
 
+config CODA_FS
+	tristate "Coda file system support (advanced network fs)"
+	depends on INET
+	help
+	  Coda is an advanced network file system, similar to NFS in that it
+	  enables you to mount file systems of a remote server and access them
+	  with regular Unix commands as if they were sitting on your hard
+	  disk.  Coda has several advantages over NFS: support for
+	  disconnected operation (e.g. for laptops), read/write server
+	  replication, security model for authentication and encryption,
+	  persistent client caches and write back caching.
+
+	  If you say Y here, your Linux box will be able to act as a Coda
+	  *client*.  You will need user level code as well, both for the
+	  client and server.  Servers are currently user level, i.e. they need
+	  no kernel support.  Please read
+	  <file:Documentation/filesystems/coda.txt> and check out the Coda
+	  home page <http://www.coda.cs.cmu.edu/>.
+
+	  If you want to compile the coda client support as a module ( = code
+	  which can be inserted in and removed from the running kernel
+	  whenever you want), say M here and read
+	  <file:Documentation/modules.txt>.  The module will be called coda.
+
+config INTERMEZZO_FS
+	tristate "InterMezzo file system support (replicating fs) (EXPERIMENTAL)"
+	depends on INET && EXPERIMENTAL
+	help
+	  InterMezzo is a networked file system with disconnected operation
+	  and kernel level write back caching.  It is most often used for
+	  replicating potentially large trees or keeping laptop/desktop copies
+	  in sync.
+
+	  If you say Y or M your kernel or module will provide InterMezzo
+	  support.  You will also need a file server daemon, which you can get
+	  from <http://www.inter-mezzo.org/>.
+
+config SUNRPC
+	tristate
+	default m if NFS_FS!=y && NFSD!=y && (NFS_FS=m || NFSD=m)
+	default y if NFS_FS=y || NFSD=y
+
+config SUNRPC_GSS
+	tristate "Provide RPCSEC_GSS authentication (EXPERIMENTAL)"
+	depends on SUNRPC && EXPERIMENTAL
+	default SUNRPC if NFS_V4=y
+	help
+	  Provides cryptographic authentication for NFS rpc requests.  To
+	  make this useful, you must also select at least one rpcsec_gss
+	  mechanism.
+	  Note: You should always select this option if you wish to use
+	  NFSv4.
+
+config RPCSEC_GSS_KRB5
+	tristate "Kerberos V mechanism for RPCSEC_GSS (EXPERIMENTAL)"
+	depends on SUNRPC_GSS && CRYPTO_DES && CRYPTO_MD5
+	default SUNRPC_GSS if NFS_V4=y
+	help
+	  Provides a gss-api mechanism based on Kerberos V5 (this is
+	  mandatory for RFC3010-compliant NFSv4 implementations).
+	  Requires a userspace daemon;
+		see http://www.citi.umich.edu/projects/nfsv4/.
+
+	  Note: If you select this option, please ensure that you also
+	  enable the MD5 and DES crypto ciphers.
+
 source "fs/ncpfs/Kconfig"
 
-# for fs/nls/Config.in
 config AFS_FS
+# for fs/nls/Config.in
 	tristate "Andrew File System support (AFS) (Experimental)"
 	depends on INET && EXPERIMENTAL
 	help
@@ -1501,29 +1547,6 @@
 
 endmenu
 
-# for fs/nls/Config.in
-config ZISOFS_FS
-	tristate
-	depends on ZISOFS
-	default ISO9660_FS
-
-# Meta block cache for Extended Attributes (ext2/ext3)
-config FS_MBCACHE
-	tristate
-	depends on EXT2_FS_XATTR || EXT3_FS_XATTR
-	default y if EXT2_FS=y || EXT3_FS=y
-	default m if EXT2_FS=m || EXT3_FS=m
-
-# Posix ACL utility routines (for now, only ext2/ext3/jfs)
-#
-# NOTE: you can implement Posix ACLs without these helpers (XFS does).
-# 	Never use this symbol for ifdefs.
-#
-config FS_POSIX_ACL
-	bool
-	depends on EXT2_FS_POSIX_ACL || EXT3_FS_POSIX_ACL || JFS_POSIX_ACL
-	default y
-
 menu "Partition Types"
 
 source "fs/partitions/Kconfig"

--------------2C9BC4E32F80DF564D4DA085--

