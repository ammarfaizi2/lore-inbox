Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbSLYO77>; Wed, 25 Dec 2002 09:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbSLYO76>; Wed, 25 Dec 2002 09:59:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48645 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261996AbSLYO74>;
	Wed, 25 Dec 2002 09:59:56 -0500
Date: Wed, 25 Dec 2002 15:08:08 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: PATCH: put ext2 next to ext3 in config
Message-ID: <20021225150808.GB721@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 15:06:46 up 21:33,  1 user,  load average: 0.00, 0.01, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor little patch - this puts the Ext2 config switch next to the Ext3
config switch in the config menus, and also calls it Ext2 rather than
Second Extended.

Dave
{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}
--- linux-2.5.53/fs/Kconfig.predag	2002-12-25 14:59:31.000000000 +0000
+++ linux-2.5.53/fs/Kconfig	2002-12-25 15:00:43.000000000 +0000
@@ -256,6 +256,75 @@
 	  partition (the one containing the directory /) cannot be compiled as
 	  a module.
 
+config EXT2_FS
+	tristate "Ext2 (Second extended) fs support"
+	---help---
+	  This is the de facto standard Linux file system (method to organize
+	  files on a storage device) for hard disks.
+
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
+	  module will be called ext2.o.  Be aware however that the file system
+	  of your root partition (the one containing the directory /) cannot
+	  be compiled as a module, and so this could be dangerous.  Most
+	  everyone wants to say Y here.
+
+config EXT2_FS_XATTR
+	bool "Ext2 extended attributes"
+	depends on EXT2_FS
+	---help---
+	  Extended attributes are name:value pairs associated with inodes by
+	  the kernel or by users (see the attr(5) manual page, or visit
+	  <http://acl.bestbits.at/> for details).
+
+	  If unsure, say N.
+
+config EXT2_FS_POSIX_ACL
+	bool "Ext2 POSIX Access Control Lists"
+	depends on EXT2_FS_XATTR
+	---help---
+	  Posix Access Control Lists (ACLs) support permissions for users and
+	  groups beyond the owner/group/world scheme.
+
+	  To learn more about Access Control Lists, visit the Posix ACLs for
+	  Linux website <http://acl.bestbits.at/>.
+
+	  If you don't know what Access Control Lists are, say N
+
 config EXT3_FS
 	tristate "Ext3 journalling file system support"
 	---help---
@@ -942,75 +1011,6 @@
 	  If you don't know whether you need it, then you don't need it:
 	  answer N.
 
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
-	  module will be called ext2.o.  Be aware however that the file system
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
-
-	  If you don't know what Access Control Lists are, say N
-
 config SYSV_FS
 	tristate "System V/Xenix/V7/Coherent file system support"
 	---help---
{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
