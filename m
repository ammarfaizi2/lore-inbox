Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWCWRUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWCWRUz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWCWRUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:20:55 -0500
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:14256 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751397AbWCWRUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:20:53 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 23 Mar 2006 17:20:08 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 01/14] NTFS: Fix two compiler warnings on Alpha.
In-Reply-To: <Pine.LNX.4.64.0603231713430.18984@hermes-2.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0603231717460.18984@hermes-2.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0603231713430.18984@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Fix two compiler warnings on Alpha.  Thanks to Andrew Morton for
      reporting them.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

 fs/ntfs/dir.c  |    2 +-
 fs/ntfs/file.c |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

bb8047d3540affd6b8c2adac3fe792e07143be0f
diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index b0690d4..9d9ed3f 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -1136,7 +1136,7 @@ static int ntfs_readdir(struct file *fil
 	if (fpos == 1) {
 		ntfs_debug("Calling filldir for .. with len 2, fpos 0x1, "
 				"inode 0x%lx, DT_DIR.",
-				parent_ino(filp->f_dentry));
+				(unsigned long)parent_ino(filp->f_dentry));
 		rc = filldir(dirent, "..", 2, fpos,
 				parent_ino(filp->f_dentry), DT_DIR);
 		if (rc)
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 5027d3d..2e5ba0c 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -943,7 +943,8 @@ rl_not_mapped_enoent:
 		}
 		ni->runlist.rl = rl;
 		status.runlist_merged = 1;
-		ntfs_debug("Allocated cluster, lcn 0x%llx.", lcn);
+		ntfs_debug("Allocated cluster, lcn 0x%llx.",
+				(unsigned long long)lcn);
 		/* Map and lock the mft record and get the attribute record. */
 		if (!NInoAttr(ni))
 			base_ni = ni;
-- 
1.2.3.g9821
