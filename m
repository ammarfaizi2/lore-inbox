Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWCWRWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWCWRWh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWCWRWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:22:37 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:40853 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751435AbWCWRWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:22:36 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 23 Mar 2006 17:22:30 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 03/14] NTFS: Fix a buggette in an "should be impossible" case
 handling
In-Reply-To: <Pine.LNX.4.64.0603231720130.18984@hermes-2.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0603231721240.18984@hermes-2.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0603231713430.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231717460.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231720130.18984@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Fix a buggette in an "should be impossible" case handling where we
      continued the attribute lookup loop instead of aborting it.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

 fs/ntfs/ChangeLog |    2 ++
 fs/ntfs/attrib.c  |    4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

3ccc7384db3d762e834dfdae13c1d6434b2fdeab
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index 3d8d60b..d35a5c8 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -24,6 +24,8 @@ ToDo/Notes:
 	- Fix two compiler warnings on Alpha.  Thanks to Andrew Morton for
 	  reporting them.
 	- Fix an (innocent) off-by-one error in the runlist code.
+	- Fix a buggette in an "should be impossible" case handling where we
+	  continued the attribute lookup loop instead of aborting it.
 
 2.1.26 - Minor bug fixes and updates.
 
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 9480a05..a92b9e9 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -1,7 +1,7 @@
 /**
  * attrib.c - NTFS attribute operations.  Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2005 Anton Altaparmakov
+ * Copyright (c) 2001-2006 Anton Altaparmakov
  * Copyright (c) 2002 Richard Russon
  *
  * This program/include file is free software; you can redistribute it and/or
@@ -1048,7 +1048,7 @@ do_next_attr_loop:
 				le32_to_cpu(ctx->mrec->bytes_allocated))
 			break;
 		if (a->type == AT_END)
-			continue;
+			break;
 		if (!a->length)
 			break;
 		if (al_entry->instance != a->instance)
-- 
1.2.3.g9821

