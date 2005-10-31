Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbVJaOka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbVJaOka (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbVJaOka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:40:30 -0500
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:63159 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932295AbVJaOk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:40:29 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 31 Oct 2005 14:40:22 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 15/17] NTFS: Use %z for size_t to fix compilation warnings.
  (Andrew Morton)
In-Reply-To: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0510311438520.27357@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Use %z for size_t to fix compilation warnings.  (Andrew Morton)

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    3 ++-
 fs/ntfs/file.c    |    4 ++--
 fs/ntfs/super.c   |    2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

applies-to: 462b8caf5a1f787398a93485e4170605f81ea8d9
d04bd1fb60252f30f4f41a56613ade48df130588
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index bc6ec16..2a76b1f 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -75,7 +75,8 @@ ToDo/Notes:
 	  for highly fragmented files, i.e. ones whose data attribute is split
 	  across multiple extents.   When such a case is encountered,
 	  EOPNOTSUPP is returned.
-	- $EA attributes can be both resident non-resident.
+	- $EA attributes can be both resident and non-resident.
+	- Use %z for size_t to fix compilation warnings.  (Andrew Morton)
 
 2.1.24 - Lots of bug fixes and support more clean journal states.
 
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index a142bf3..cdedc84 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -531,7 +531,7 @@ static int ntfs_prepare_pages_for_non_re
 	ni = NTFS_I(vi);
 	vol = ni->vol;
 	ntfs_debug("Entering for inode 0x%lx, attribute type 0x%x, start page "
-			"index 0x%lx, nr_pages 0x%x, pos 0x%llx, bytes 0x%x.",
+			"index 0x%lx, nr_pages 0x%x, pos 0x%llx, bytes 0x%zx.",
 			vi->i_ino, ni->type, pages[0]->index, nr_pages,
 			(long long)pos, bytes);
 	blocksize_bits = vi->i_blkbits;
@@ -1693,7 +1693,7 @@ static int ntfs_commit_pages_after_write
 	vi = page->mapping->host;
 	ni = NTFS_I(vi);
 	ntfs_debug("Entering for inode 0x%lx, attribute type 0x%x, start page "
-			"index 0x%lx, nr_pages 0x%x, pos 0x%llx, bytes 0x%x.",
+			"index 0x%lx, nr_pages 0x%x, pos 0x%llx, bytes 0x%zx.",
 			vi->i_ino, ni->type, page->index, nr_pages,
 			(long long)pos, bytes);
 	if (NInoNonResident(ni))
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 453d0d5..6c16db9 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1447,7 +1447,7 @@ not_enabled:
 	if (unlikely(i_size_read(tmp_ino) < sizeof(USN_HEADER))) {
 		ntfs_error(vol->sb, "Found corrupt $UsnJrnl/$DATA/$Max "
 				"attribute (size is 0x%llx but should be at "
-				"least 0x%x bytes).", i_size_read(tmp_ino),
+				"least 0x%zx bytes).", i_size_read(tmp_ino),
 				sizeof(USN_HEADER));
 		return FALSE;
 	}
---
0.99.9
