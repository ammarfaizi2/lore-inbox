Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965128AbVIIJZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbVIIJZE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbVIIJZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:25:01 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:25486 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S965129AbVIIJZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:25:00 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 9 Sep 2005 10:24:57 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 10/25] NTFS: Fix a bug in fs/ntfs/index.c::ntfs_index_lookup().
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509091024320.26845@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 10/25] NTFS: Fix a bug in fs/ntfs/index.c::ntfs_index_lookup().  When the returned
      index entry is in the index root, we forgot to set the @ir pointer in
      the index context.  Thanks for Yura Pakhuchiy for finding this bug.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    3 +++
 fs/ntfs/index.c   |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

8e08ceaeacd5d300aaad166f2eef8bfc37e09831
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -55,6 +55,9 @@ ToDo/Notes:
 	  length is zero.
 	- Add runlist.[hc]::ntfs_rl_punch_nolock() which punches a caller
 	  specified hole into a runlist.
+	- Fix a bug in fs/ntfs/index.c::ntfs_index_lookup().  When the returned
+	  index entry is in the index root, we forgot to set the @ir pointer in
+	  the index context.  Thanks to Yura Pakhuchiy for finding this bug.
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -205,6 +205,7 @@ int ntfs_index_lookup(const void *key, c
 				&ie->key, key_len)) {
 ir_done:
 			ictx->is_in_root = TRUE;
+			ictx->ir = ir;
 			ictx->actx = actx;
 			ictx->base_ni = base_ni;
 			ictx->ia = NULL;
