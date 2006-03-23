Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWCWRbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWCWRbA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWCWRbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:31:00 -0500
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:63167 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932470AbWCWRa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:30:59 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 23 Mar 2006 17:30:56 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 14/14] NTFS: 2.1.27 - Various bug fixes and cleanups.
In-Reply-To: <Pine.LNX.4.64.0603231729160.18984@hermes-2.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0603231730150.18984@hermes-2.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0603231713430.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231717460.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231720130.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231721240.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231722330.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231723320.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231724200.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231724570.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231725420.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231726250.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231727040.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231727450.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231728310.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231729160.18984@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: 2.1.27 - Various bug fixes and cleanups.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

 Documentation/filesystems/ntfs.txt |    5 +++++
 fs/ntfs/super.c                    |    2 +-
 2 files changed, 6 insertions(+), 1 deletions(-)

e750d1c7cc314b9ba1934b0b474b7d39f906f865
diff --git a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
index 2511685..638cbd3 100644
--- a/Documentation/filesystems/ntfs.txt
+++ b/Documentation/filesystems/ntfs.txt
@@ -457,6 +457,11 @@ ChangeLog
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.1.27:
+	- Implement page migration support so the kernel can move memory used
+	  by NTFS files and directories around for management purposes.
+	- Add support for writing to sparse files created with Windows XP SP2.
+	- Many minor improvements and bug fixes.
 2.1.26:
 	- Implement support for sector sizes above 512 bytes (up to the maximum
 	  supported by NTFS which is 4096 bytes).
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 6816eda..7646b50 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -3090,7 +3090,7 @@ static void ntfs_big_inode_init_once(voi
 struct kmem_cache *ntfs_attr_ctx_cache;
 struct kmem_cache *ntfs_index_ctx_cache;
 
-/* Driver wide semaphore. */
+/* Driver wide mutex. */
 DEFINE_MUTEX(ntfs_lock);
 
 static struct super_block *ntfs_get_sb(struct file_system_type *fs_type,
-- 
1.2.3.g9821

