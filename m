Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965121AbVIIJWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbVIIJWb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965122AbVIIJWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:22:30 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:31940 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S965121AbVIIJW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:22:29 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 9 Sep 2005 10:22:21 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 5/25] NTFS: Remove two bogus BUG_ON()s from fs/ntfs/mft.c.
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509091022040.26845@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 5/25] NTFS: Remove two bogus BUG_ON()s from fs/ntfs/mft.c.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    1 +
 fs/ntfs/mft.c     |    2 --
 2 files changed, 1 insertions(+), 2 deletions(-)

8bb735216a0675e247bbe8b8b92c09d6884d1a17
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -45,6 +45,7 @@ ToDo/Notes:
 	  need to panic() if the allocation fails as it now cannot fail.
 	- Fix two nasty runlist merging bugs that had gone unnoticed so far.
 	  Thanks to Stefano Picerno for the bug report.
+	- Remove two bogus BUG_ON()s from fs/ntfs/mft.c.
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -511,7 +511,6 @@ int ntfs_sync_mft_mirror(ntfs_volume *vo
 		} while (bh);
 		tail->b_this_page = head;
 		attach_page_buffers(page, head);
-		BUG_ON(!page_has_buffers(page));
 	}
 	bh = head = page_buffers(page);
 	BUG_ON(!bh);
@@ -692,7 +691,6 @@ int write_mft_record_nolock(ntfs_inode *
 	 */
 	if (!NInoTestClearDirty(ni))
 		goto done;
-	BUG_ON(!page_has_buffers(page));
 	bh = head = page_buffers(page);
 	BUG_ON(!bh);
 	rl = NULL;
