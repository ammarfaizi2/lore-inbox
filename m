Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267353AbUHRQvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267353AbUHRQvy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 12:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267354AbUHRQvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 12:51:54 -0400
Received: from smtp.terra.es ([213.4.129.129]:64685 "EHLO tsmtp7.mail.isp")
	by vger.kernel.org with ESMTP id S267353AbUHRQvq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 12:51:46 -0400
Date: Wed, 18 Aug 2004 18:42:49 +0200
From: Diego Calleja <diegocg@teleline.es>
To: Janusz Dziemidowicz <rraptorr@kursor.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] ext3 documentation (lack of)
Message-Id: <20040818184249.5b266538.diegocg@teleline.es>
In-Reply-To: <Pine.LNX.4.61.0408181414450.18542@stacja.kursor.pl>
References: <20040818025951.63c4134e.diegocg@teleline.es>
	<200408172301.09350.ryan@spitfire.gotdns.org>
	<20040818133818.7b0582f3.diegocg@teleline.es>
	<Pine.LNX.4.61.0408181414450.18542@stacja.kursor.pl>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 18 Aug 2004 14:24:43 +0200 (CEST) Janusz Dziemidowicz <rraptorr@kursor.pl> escribió:

> AFAIK
> user_xattr - turns on POSIX Extended attributes
> nouser_xattr - obvious
> acl - turns on ACL (Access Control Lists)
> noacl - obvious

Thanks. I've recollected those, explained it a bit (except the barrier bits,
I don't really mean what barriers are), and updated ext2 documentation with
some of them, and deleted a small comentary about ext3 not being available.

unchanged:
--- stable/Documentation/filesystems/ext2.txt-document	2004-08-18 18:17:28.000000000 +0200
+++ stable/Documentation/filesystems/ext2.txt	2004-08-18 18:15:45.000000000 +0200
@@ -17,6 +17,33 @@
 bsddf			(*)	Makes `df' act like BSD.
 minixdf				Makes `df' act like Minix.
 
+barrier=1			This enables/disables barriers. barrier=0 disables it,
+				barrier=1 enables it.
+
+orlov			(*)	This enables the new Orlov block allocator. It's
+				enabled by default.
+
+oldalloc			This disables the Orlov block allocator and
+				enables the old block allocator. Orlov should
+				have better performance, we'd like to get some
+				feedback  if it's the contrary for you.
+
+user_xattr		(*)	Enables POSIX Extended Attributes. It's enabled by
+				default, however you need to confifure its support
+				(CONFIG_EXT2_FS_XATTR). This is neccesary if you want
+				to use POSIX Acces Control Lists support. You can visit
+				http://acl.bestbits.at to know more about POSIX Extended
+				attributes.
+
+nouser_xattr			Disables POSIX Extended Attributes.
+
+acl			(*)	Enables POSIX Access Control Lists support. This is
+				enabled by default, however you need to configure
+				its support (CONFIG_EXT2_FS_POSIX_ACL). If you want
+				to know more about ACLs visit http://acl.bestbits.at
+
+noacl				This option disables POSIX Access Control List support.
+
 check=none, nocheck	(*)	Don't do extra checking of bitmaps on mount
 				(check=normal and check=strict options removed)
 
@@ -336,9 +363,8 @@
 the time of the crash, then there is no guarantee of consistency for
 the blocks in that transaction so they are discarded (which means any
 filesystem changes they represent are also lost).
-
-The ext3 code is currently (Apr 2001) available for 2.2 kernels only,
-and not yet available for 2.4 kernels.
+Check Documentation/filesystems/ext3.txt if you want to read more about
+ext3 and journaling.
 
 References
 ==========
@@ -349,8 +375,6 @@
 Journaling (ext3)	ftp://ftp.uk.linux.org/pub/linux/sct/fs/jfs/
 Hashed Directories	http://kernelnewbies.org/~phillips/htree/
 Filesystem Resizing	http://ext2resize.sourceforge.net/
-Extended Attributes &
-Access Control Lists	http://acl.bestbits.at/
 Compression (*)		http://www.netspace.net.au/~reiter/e2compr/
 
 Implementations for:
only in patch2:
unchanged:
--- stable/Documentation/filesystems/ext3.txt-document	2004-08-18 01:55:48.000000000 +0200
+++ stable/Documentation/filesystems/ext3.txt	2004-08-18 18:15:15.000000000 +0200
@@ -22,6 +22,63 @@
 			the inode which will represent the ext3 file
 			system's journal file.
 
+noload			Don't load the journal on mounting.
+
+data=journal		All data are committed into the journal prior 
+			to being written into the main file system.
+
+data=ordered	(*)	All data are forced directly out to the main file
+			system prior to its metadata being committed to
+			the journal.
+
+data=writeback		Data ordering is not preserved, data may be 
+			written into the main file system after its
+			metadata has been committed to the journal.
+
+commit=nrsec	(*)	Ext3 can be told to sync all its data and metadata
+			every 'nrsec' seconds. The default value is 5 seconds.
+			This means that if you lose your power, you will lose,
+			as much, the latest 5 seconds of work (your filesystem
+			will not be damaged though, thanks to journaling). This
+			default value (or any low value) will hurt performance,
+			but it's good for data-safety. Setting it to 0 will
+			have the same effect than leaving the default 5 sec.
+			Setting it to very large values will improve
+			performance.
+
+barrier=1		This enables/disables barriers. barrier=0 disables it, 
+			barrier=1 enables it.
+
+orlov		(*)	This enables the new Orlov block allocator. It's enabled
+			by default. 
+
+oldalloc		This disables the Orlov block allocator and enables the
+			old block allocator. Orlov should have better performance,
+			we'd like to get some feedback if it's the contrary for
+			you.
+
+user_xattr	(*)	Enables POSIX Extended Attributes. It's enabled by
+			default, however you need to confifure its support
+			(CONFIG_EXT3_FS_XATTR). This is neccesary if you want
+			to use POSIX Acces Control Lists support. You can visit
+			http://acl.bestbits.at to know more about POSIX Extended
+			attributes.
+
+nouser_xattr		Disables POSIX Extended Attributes. 
+
+acl		(*)	Enables POSIX Access Control Lists support. This is
+			enabled by default, however you need to configure
+			its support (CONFIG_EXT3_FS_POSIX_ACL). If you want
+			to know more about ACLs visit http://acl.bestbits.at
+
+noacl			This option disables POSIX Access Control List support.
+
+reservation
+
+noreservation
+
+resize=
+
 bsddf 		(*)	Make 'df' act like BSD.
 minixdf			Make 'df' act like Minix.
 
@@ -30,8 +87,6 @@
 
 debug			Extra debugging information is sent to syslog.
 
-noload			Don't load the journal on mounting.
-
 errors=remount-ro(*)	Remount the filesystem read-only on an error.
 errors=continue		Keep going on a filesystem error.
 errors=panic		Panic and halt the machine if an error occurs.
@@ -48,17 +103,6 @@
 
 sb=n			Use alternate superblock at this location.
 
-data=journal		All data are committed into the journal prior 
-			to being written into the main file system.
-		
-data=ordered	(*)	All data are forced directly out to the main file 
-			system prior to its metadata being committed to 
-			the journal.
-		
-data=writeback  	Data ordering is not preserved, data may be 
-			written into the main file system after its
-			metadata has been committed to the journal.
-
 quota			Quota options are currently silently ignored.
 noquota			(see fs/ext3/super.c, line 594)
 grpquota
@@ -114,7 +158,7 @@
 -------------
 
 Ext2 partitions can be easily convert to ext3, with `tune2fs -j <dev>`.
- Ext3 is fully compatible with Ext2.  Ext3 partitions can easily be
+Ext3 is fully compatible with Ext2.  Ext3 partitions can easily be
 mounted as Ext2.
 
 External Tools
