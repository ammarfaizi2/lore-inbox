Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbVHPQDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbVHPQDe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 12:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbVHPQDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 12:03:34 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:15497 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030203AbVHPQDe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 12:03:34 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: [2.6-BK-URL] Urgent NTFS bug fix
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Organization: Computing Service, University of Cambridge, UK
Date: Tue, 16 Aug 2005 17:03:27 +0100
Message-Id: <1124208207.30476.27.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs-2.6.git/HEAD

This is an urgent NTFS bug fix which fixes the oops reported by Martin
MOKREJŠ.

Please apply before you release 2.6.13.  Thanks!

The diff style patch produced with git format-patch linux-2.6 is below.

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

[PATCH] NTFS: Fix bug in mft record writing where we forgot to set the device in
      the buffers when mapping them after the VM had discarded them.
      Thanks to Martin MOKREJŠ for the bug report.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>
---

 fs/ntfs/ChangeLog |    3 +++
 fs/ntfs/mft.c     |    2 ++
 2 files changed, 5 insertions(+), 0 deletions(-)

e74589ac250e463973361774a90fee2c9d71da02
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -174,6 +174,9 @@ ToDo/Notes:
 	  fact that the vfs and ntfs inodes are one struct in memory to find
 	  the ntfs inode in memory if present.  Also, the ntfs inode has its
 	  own locking so it does not matter if the vfs inode is locked.
+	- Fix bug in mft record writing where we forgot to set the device in
+	  the buffers when mapping them after the VM had discarded them
+	  Thanks to Martin MOKREJŠ for the bug report.
 
 2.1.22 - Many bug and race fixes and error handling improvements.
 
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -533,6 +533,7 @@ int ntfs_sync_mft_mirror(ntfs_volume *vo
 			LCN lcn;
 			unsigned int vcn_ofs;
 
+			bh->b_bdev = vol->sb->s_bdev;
 			/* Obtain the vcn and offset of the current block. */
 			vcn = ((VCN)mft_no << vol->mft_record_size_bits) +
 					(block_start - m_start);
@@ -725,6 +726,7 @@ int write_mft_record_nolock(ntfs_inode *
 			LCN lcn;
 			unsigned int vcn_ofs;
 
+			bh->b_bdev = vol->sb->s_bdev;
 			/* Obtain the vcn and offset of the current block. */
 			vcn = ((VCN)ni->mft_no << vol->mft_record_size_bits) +
 					(block_start - m_start);


