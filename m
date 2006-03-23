Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWCWRXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWCWRXd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWCWRXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:23:32 -0500
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:29108 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932090AbWCWRXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:23:31 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 23 Mar 2006 17:23:27 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 04/14] NTFS: Use buffer_migrate_page() for the ->migratepage
 function
In-Reply-To: <Pine.LNX.4.64.0603231721240.18984@hermes-2.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0603231722330.18984@hermes-2.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0603231713430.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231717460.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231720130.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231721240.18984@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Use buffer_migrate_page() for the ->migratepage function of all ntfs
      address space operations.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

 fs/ntfs/ChangeLog |    4 +++-
 fs/ntfs/aops.c    |    7 +++++++
 2 files changed, 10 insertions(+), 1 deletions(-)

78264bd9c239237fe356c32d08abf8e52a2d8737
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index d35a5c8..8df1070 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -19,13 +19,15 @@ ToDo/Notes:
 	- Enable the code for setting the NT4 compatibility flag when we start
 	  making NTFS 1.2 specific modifications.
 
-2.1.27 - Various bug fixes.
+2.1.27 - Various bug fixes and cleanups.
 
 	- Fix two compiler warnings on Alpha.  Thanks to Andrew Morton for
 	  reporting them.
 	- Fix an (innocent) off-by-one error in the runlist code.
 	- Fix a buggette in an "should be impossible" case handling where we
 	  continued the attribute lookup loop instead of aborting it.
+	- Use buffer_migrate_page() for the ->migratepage function of all ntfs
+	  address space operations.
 
 2.1.26 - Minor bug fixes and updates.
 
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 7e361da..7c7e313 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -22,6 +22,7 @@
  */
 
 #include <linux/errno.h>
+#include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
@@ -1551,6 +1552,9 @@ struct address_space_operations ntfs_aop
 #ifdef NTFS_RW
 	.writepage	= ntfs_writepage,	/* Write dirty page to disk. */
 #endif /* NTFS_RW */
+	.migratepage	= buffer_migrate_page,	/* Move a page cache page from
+						   one physical page to an
+						   other. */
 };
 
 /**
@@ -1567,6 +1571,9 @@ struct address_space_operations ntfs_mst
 						   without touching the buffers
 						   belonging to the page. */
 #endif /* NTFS_RW */
+	.migratepage	= buffer_migrate_page,	/* Move a page cache page from
+						   one physical page to an
+						   other. */
 };
 
 #ifdef NTFS_RW
-- 
1.2.3.g9821

