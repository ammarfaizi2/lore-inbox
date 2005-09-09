Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbVIIJXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbVIIJXH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbVIIJXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:23:06 -0400
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:27346 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S965122AbVIIJXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:23:04 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 9 Sep 2005 10:22:58 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 6/25] NTFS: Fix handling of valid but empty mapping pairs
 array
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509091022230.26845@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 6/25] NTFS: Fix handling of valid but empty mapping pairs array in
      fs/ntfs/runlist.c::ntfs_mapping_pairs_decompress().

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    2 ++
 fs/ntfs/runlist.c |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

2b0ada2b8e086c267dd116a39ad41ff0a717b665
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -46,6 +46,8 @@ ToDo/Notes:
 	- Fix two nasty runlist merging bugs that had gone unnoticed so far.
 	  Thanks to Stefano Picerno for the bug report.
 	- Remove two bogus BUG_ON()s from fs/ntfs/mft.c.
+	- Fix handling of valid but empty mapping pairs array in
+	  fs/ntfs/runlist.c::ntfs_mapping_pairs_decompress().
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
--- a/fs/ntfs/runlist.c
+++ b/fs/ntfs/runlist.c
@@ -760,6 +760,9 @@ runlist_element *ntfs_mapping_pairs_deco
 		ntfs_error(vol->sb, "Corrupt attribute.");
 		return ERR_PTR(-EIO);
 	}
+	/* If the mapping pairs array is valid but empty, nothing to do. */
+	if (!vcn && !*buf)
+		return old_rl;
 	/* Current position in runlist array. */
 	rlpos = 0;
 	/* Allocate first page and set current runlist size to one page. */
