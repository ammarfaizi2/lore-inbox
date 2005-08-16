Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbVHPTlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbVHPTlm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 15:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVHPTll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 15:41:41 -0400
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:15810 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932310AbVHPTll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 15:41:41 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Tue, 16 Aug 2005 20:41:37 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [2.6-BK-URL] Another urgent NTFS bug fix!
Message-ID: <Pine.LNX.4.60.0508162037450.3110@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1870869256-691403781-1124221297=:3110"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1870869256-691403781-1124221297=:3110
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi again Linus, please pull from

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs-2.6.git/HEAD

This is another urgent NTFS bug fix which fixes an analogous problem to=20
the previous one.  In the rush of getting out the previous patch I=20
completely forgot there are two different code paths that lead to mft=20
records being written out.  The previous patch addressed the inode dirty=20
based writeout while this one addresses the page dirty based writeout.

Please apply before you release 2.6.13.  Many thanks and apologies for=20
sending two merge requests in a row like this!

The diff style patch produced with git format-patch linux-2.6 is below.

Best regards,

        Anton
--=20
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

[PATCH] NTFS: Complete the previous fix for the unset device when mapping
      buffers for mft record writing.  I had missed the writepage based mft
      record write code path.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>
---

 fs/ntfs/ChangeLog |    2 +-
 fs/ntfs/aops.c    |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

481d0374217f3fefaf98efbd8d21d73c138dd928
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -175,7 +175,7 @@ ToDo/Notes:
 =09  the ntfs inode in memory if present.  Also, the ntfs inode has its
 =09  own locking so it does not matter if the vfs inode is locked.
 =09- Fix bug in mft record writing where we forgot to set the device in
-=09  the buffers when mapping them after the VM had discarded them
+=09  the buffers when mapping them after the VM had discarded them.
 =09  Thanks to Martin MOKREJ=C5=A0 for the bug report.
=20
 2.1.22 - Many bug and race fixes and error handling improvements.
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -924,6 +924,7 @@ static int ntfs_write_mst_block(struct p
 =09=09=09LCN lcn;
 =09=09=09unsigned int vcn_ofs;
=20
+=09=09=09bh->b_bdev =3D vol->sb->s_bdev;
 =09=09=09/* Obtain the vcn and offset of the current block. */
 =09=09=09vcn =3D (VCN)block << bh_size_bits;
 =09=09=09vcn_ofs =3D vcn & vol->cluster_size_mask;
--1870869256-691403781-1124221297=:3110--
