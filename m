Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161207AbWAHV3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161207AbWAHV3h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 16:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbWAHV3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 16:29:37 -0500
Received: from lust.fud.no ([213.145.167.25]:41635 "EHLO lust.fud.no")
	by vger.kernel.org with ESMTP id S1161207AbWAHV3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 16:29:36 -0500
Date: Sun, 8 Jan 2006 22:29:12 +0100
From: Tore Anderson <tore@fud.no>
To: sct@redhat.com, akpm@osdl.org, adilger@clusterfs.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] ext3: fix documentation of online resizing
Message-ID: <20060108212912.GB5717@fud.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Undocument the non-working resize= mount option in ext3, and add some
references to the ext2resize package instead, which appears to be the
only proper way of doing online resizing of ext3 filesystems.

Signed-off-by: Tore Anderson <tore@fud.no>

---

I first thought online resizing was supposed to be done like in JFS
(using mount -o remount,resize=nblocks), and fixed fs/ext3/super.c so
the resize option was recognized properly.  However, the feature
simply didn't work (mount ended up in blocking I/O sleep with nothing
happening), so I assume the option is intentionally disabled.

diff --git a/Documentation/filesystems/ext3.txt b/Documentation/filesystems/ext3.txt
index 9840d5b..c665644 100644
--- a/Documentation/filesystems/ext3.txt
+++ b/Documentation/filesystems/ext3.txt
@@ -77,8 +77,6 @@ reservation
 
 noreservation
 
-resize=
-
 bsddf 		(*)	Make 'df' act like BSD.
 minixdf			Make 'df' act like Minix.
 
@@ -168,6 +166,7 @@ see manual pages to know more.
 tune2fs: 	create a ext3 journal on a ext2 partition with the -j flags
 mke2fs: 	create a ext3 partition with the -j flags
 debugfs: 	ext2 and ext3 file system debugger
+ext2online:	online (mounted) ext2 and ext3 filesystem resizer
 
 References
 ==========
@@ -176,6 +175,7 @@ kernel source:	file:/usr/src/linux/fs/ex
 		file:/usr/src/linux/fs/jbd
 
 programs: 	http://e2fsprogs.sourceforge.net
+		http://ext2resize.sourceforge.net
 
 useful link:
 		http://www.zip.com.au/~akpm/linux/ext3/ext3-usage.html

-- 
Tore Anderson
