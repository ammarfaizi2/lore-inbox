Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWBXQOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWBXQOw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 11:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWBXQOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 11:14:52 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:30114 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932290AbWBXQOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 11:14:51 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 24 Feb 2006 16:07:05 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 1/5] NTFS: Fix a potential overflow by casting (index + 1)
 to s64
In-Reply-To: <Pine.LNX.4.64.0602241559150.2136@hermes-2.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0602241605210.2136@hermes-2.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0602241559150.2136@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Fix a potential overflow by casting (index + 1) to s64 before doing a
      left shift using PAGE_CACHE_SHIFT in fs/ntfs/file.c.  Thanks to Andrew
      Morton pointing this out to.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

 fs/ntfs/file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

3c6af7fa787f21f8873a050568ed892312899eb5
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 7275338..c73c886 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -248,7 +248,7 @@ do_non_resident_extend:
 		 * enough to make ntfs_writepage() work.
 		 */
 		write_lock_irqsave(&ni->size_lock, flags);
-		ni->initialized_size = (index + 1) << PAGE_CACHE_SHIFT;
+		ni->initialized_size = (s64)(index + 1) << PAGE_CACHE_SHIFT;
 		if (ni->initialized_size > new_init_size)
 			ni->initialized_size = new_init_size;
 		write_unlock_irqrestore(&ni->size_lock, flags);
-- 
1.2.3.g9821
