Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbUKJOpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbUKJOpq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbUKJNpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 08:45:31 -0500
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:11465 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261876AbUKJNoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:44:39 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 5/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRslx-0006NN-3G@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:44:29 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 5/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/25 1.2026.1.21)
   NTFS: Fix min_size and max_size definitions in ATTR_DEF structure in
         fs/ntfs/layout.h to be signed.
   
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
--- a/fs/ntfs/ChangeLog	2004-11-10 13:44:32 +00:00
+++ b/fs/ntfs/ChangeLog	2004-11-10 13:44:32 +00:00
@@ -29,6 +29,8 @@
 	  vfs ->truncate method.
 	- Add a new ntfs inode flag NInoTruncateFailed() and modify
 	  fs/ntfs/inode.c::ntfs_truncate() to set and clear it appropriately.
+	- Fix min_size and max_size definitions in ATTR_DEF structure in
+	  fs/ntfs/layout.h to be signed.
 
 2.1.21 - Fix some races and bugs, rewrite mft write code, add mft allocator.
 
diff -Nru a/fs/ntfs/layout.h b/fs/ntfs/layout.h
--- a/fs/ntfs/layout.h	2004-11-10 13:44:32 +00:00
+++ b/fs/ntfs/layout.h	2004-11-10 13:44:32 +00:00
@@ -589,8 +589,8 @@
 					   FIXME: What does it mean? (AIA) */
 /* 88*/ COLLATION_RULE collation_rule;	/* Default collation rule. */
 /* 8c*/	ATTR_DEF_FLAGS flags;		/* Flags describing the attribute. */
-/* 90*/	le64 min_size;			/* Optional minimum attribute size. */
-/* 98*/	le64 max_size;			/* Maximum size of attribute. */
+/* 90*/	sle64 min_size;			/* Optional minimum attribute size. */
+/* 98*/	sle64 max_size;			/* Maximum size of attribute. */
 /* sizeof() = 0xa0 or 160 bytes */
 } __attribute__ ((__packed__)) ATTR_DEF;
 
