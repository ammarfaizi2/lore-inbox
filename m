Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317521AbSHTXl1>; Tue, 20 Aug 2002 19:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317525AbSHTXl1>; Tue, 20 Aug 2002 19:41:27 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:39128 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317521AbSHTXlZ>; Tue, 20 Aug 2002 19:41:25 -0400
Subject: [BK-2.5 PATCH] NTFS 2.1.0 3/7: Small bug fix
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 21 Aug 2002 00:45:31 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17hIgl-0001K3-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-2.5

Thanks! The 3rd changeset, fixing a small bug in previous changeset.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 fs/ntfs/aops.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

through these ChangeSets:

<aia21@cantab.net> (02/08/14 1.456.26.4)
   NTFS: Fix silly bug in ntfs_write_block(). iblock and dblock have
   different semantics so the check was bogus. Compare the byte sizes
   instead.


diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	Tue Aug 20 23:57:24 2002
+++ b/fs/ntfs/aops.c	Tue Aug 20 23:57:24 2002
@@ -560,7 +560,8 @@
 			continue;
 
 		/* Make sure we have enough initialized size. */
-		if (unlikely((block >= iblock) && (iblock < dblock))) {
+		if (unlikely((block >= iblock) &&
+				(ni->initialized_size < vi->i_size))) {
 			/*
 			 * If this page is fully outside initialized size, zero
 			 * out all pages between the current initialized size

