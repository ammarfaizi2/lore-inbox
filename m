Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbUKHN4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUKHN4F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 08:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbUKHN4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 08:56:05 -0500
Received: from hera.cwi.nl ([192.16.191.8]:65239 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261582AbUKHNz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 08:55:56 -0500
Date: Mon, 8 Nov 2004 14:55:42 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ext2 docs
Message-ID: <20041108135541.GA23052@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below an update of ext2.txt.
Removed barrier - it is not an ext2 option.
Corrected the distinction between kernel-selected defaults
and values read from the filesystem.
Fixed some typos. Shortened line length to 80.

Andries

diff -uprN -X /linux/dontdiff a/Documentation/filesystems/ext2.txt b/Documentation/filesystems/ext2.txt
--- a/Documentation/filesystems/ext2.txt	2004-10-30 21:43:59.000000000 +0200
+++ b/Documentation/filesystems/ext2.txt	2004-11-08 14:41:22.000000000 +0100
@@ -11,57 +11,53 @@ for NetBSD, FreeBSD, the GNU HURD, Windo
 Options
 =======
 
-When mounting an ext2 filesystem, the following options are accepted.
-Defaults are marked with (*).
+Most defaults are determined by the filesystem superblock, and can be
+set using tune2fs(8). Kernel-determined defaults are indicated by (*).
 
 bsddf			(*)	Makes `df' act like BSD.
 minixdf				Makes `df' act like Minix.
 
-barrier=1			This enables/disables barriers. barrier=0 disables it,
-				barrier=1 enables it.
-
-orlov			(*)	This enables the new Orlov block allocator. It's
-				enabled by default.
-
-oldalloc			This disables the Orlov block allocator and
-				enables the old block allocator. Orlov should
-				have better performance, we'd like to get some
-				feedback  if it's the contrary for you.
-
-user_xattr		(*)	Enables POSIX Extended Attributes. It's enabled by
-				default, however you need to confifure its support
-				(CONFIG_EXT2_FS_XATTR). This is neccesary if you want
-				to use POSIX Acces Control Lists support. You can visit
-				http://acl.bestbits.at to know more about POSIX Extended
-				attributes.
-
-nouser_xattr			Disables POSIX Extended Attributes.
-
-acl			(*)	Enables POSIX Access Control Lists support. This is
-				enabled by default, however you need to configure
-				its support (CONFIG_EXT2_FS_POSIX_ACL). If you want
-				to know more about ACLs visit http://acl.bestbits.at
-
-noacl				This option disables POSIX Access Control List support.
-
+check				Check block and inode bitmaps at mount time
+				(requires CONFIG_EXT2_CHECK).
 check=none, nocheck	(*)	Don't do extra checking of bitmaps on mount
 				(check=normal and check=strict options removed)
 
 debug				Extra debugging information is sent to the
 				kernel syslog.  Useful for developers.
 
-errors=continue		(*)	Keep going on a filesystem error.
+errors=continue			Keep going on a filesystem error.
 errors=remount-ro		Remount the filesystem read-only on an error.
 errors=panic			Panic and halt the machine if an error occurs.
 
 grpid, bsdgroups		Give objects the same group ID as their parent.
-nogrpid, sysvgroups	(*)	New objects have the group ID of their creator.
+nogrpid, sysvgroups		New objects have the group ID of their creator.
+
+nouid32				Use 16-bit UIDs and GIDs.
+
+oldalloc			Enable the old block allocator. Orlov should
+				have better performance, we'd like to get some
+				feedback if it's the contrary for you.
+orlov			(*)	Use the Orlov block allocator.
+				(See http://lwn.net/Articles/14633/ and
+				http://lwn.net/Articles/14446/.)
 
 resuid=n			The user ID which may use the reserved blocks.
-resgid=n			The group ID which may use the reserved blocks. 
+resgid=n			The group ID which may use the reserved blocks.
 
 sb=n				Use alternate superblock at this location.
 
+user_xattr			Enable "user." POSIX Extended Attributes
+				(requires CONFIG_EXT2_FS_XATTR).
+				See also http://acl.bestbits.at
+nouser_xattr			Don't support "user." extended attributes.
+
+acl				Enable POSIX Access Control Lists support
+				(requires CONFIG_EXT2_FS_POSIX_ACL).
+				See also http://acl.bestbits.at
+noacl				Don't support POSIX ACLs.
+
+nobh				Do not attach buffer_heads to file pagecache.
+
 grpquota,noquota,quota,usrquota	Quota options are silently ignored by ext2.
 
 
