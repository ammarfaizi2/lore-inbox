Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268716AbUJSKFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268716AbUJSKFY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 06:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268148AbUJSKEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 06:04:24 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:5345 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268149AbUJSJn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:43:56 -0400
Date: Tue, 19 Oct 2004 10:43:48 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 21/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191043240.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191043370.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040050.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040220.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040360.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040490.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041050.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041180.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041290.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041420.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041590.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042200.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042320.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042440.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042560.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043100.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043240.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 21/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/10 1.2032.1.2)
   NTFS: Fix warnings on x86-64.  (Randy Dunlap with slight modification from me)
   
   Fix printk arg type warnings on x86-64 (and OK on x86-32) (gcc 3.3.3):
   fs/ntfs/dir.c:1272: warning: long long unsigned int format, long unsigned int arg (arg 6)
   fs/ntfs/dir.c:1388: warning: long long unsigned int format, long unsigned int arg (arg 5
   
   Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-10-19 10:14:22 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:14:22 +01:00
@@ -68,6 +68,8 @@
 	- Update fs/ntfs/inode.c::ntfs_write_inode() to also use the helper
 	  mark_ntfs_record_dirty() and thus to set the buffers belonging to the
 	  mft record dirty as well as the page itself.
+	- Fix compiler warnings on x86-64 in fs/ntfs/dir.c.  (Randy Dunlap,
+	  slightly modified by me)
 
 2.1.20 - Fix two stupid bugs introduced in 2.1.18 release.
 
diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c	2004-10-19 10:14:22 +01:00
+++ b/fs/ntfs/dir.c	2004-10-19 10:14:22 +01:00
@@ -1278,7 +1278,7 @@
 	ntfs_debug("Reading bitmap with page index 0x%llx, bit ofs 0x%llx",
 			(unsigned long long)bmp_pos >> (3 + PAGE_CACHE_SHIFT),
 			(unsigned long long)bmp_pos &
-			((PAGE_CACHE_SIZE * 8) - 1));
+			(unsigned long long)((PAGE_CACHE_SIZE * 8) - 1));
 	bmp_page = ntfs_map_page(bmp_mapping,
 			bmp_pos >> (3 + PAGE_CACHE_SHIFT));
 	if (IS_ERR(bmp_page)) {
@@ -1392,8 +1392,8 @@
 	 */
 	for (;; ie = (INDEX_ENTRY*)((u8*)ie + le16_to_cpu(ie->length))) {
 		ntfs_debug("In index allocation, offset 0x%llx.",
-				(unsigned long long)ia_start + ((u8*)ie -
-				(u8*)ia));
+				(unsigned long long)ia_start +
+				(unsigned long long)((u8*)ie - (u8*)ia));
 		/* Bounds checks. */
 		if (unlikely((u8*)ie < (u8*)ia || (u8*)ie +
 				sizeof(INDEX_ENTRY_HEADER) > index_end ||
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-10-19 10:14:22 +01:00
+++ b/fs/ntfs/inode.c	2004-10-19 10:14:22 +01:00
@@ -25,7 +25,7 @@
 #include <linux/quotaops.h>
 #include <linux/mount.h>
 
-#include "ntfs.h"
+#include "aops.h"
 #include "dir.h"
 #include "debug.h"
 #include "inode.h"
@@ -33,6 +33,7 @@
 #include "malloc.h"
 #include "mft.h"
 #include "time.h"
+#include "ntfs.h"
 
 /**
  * ntfs_test_inode - compare two (possibly fake) inodes for equality
