Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268514AbRGXXKo>; Tue, 24 Jul 2001 19:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268508AbRGXXKf>; Tue, 24 Jul 2001 19:10:35 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:34993 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S268512AbRGXXJn>; Tue, 24 Jul 2001 19:09:43 -0400
Subject: [PATCH] And another small ntfs fix
To: torvalds@transmeta.com
Date: Wed, 25 Jul 2001 00:09:49 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E15PBJF-0001WR-00@virgo.cus.cam.ac.uk>
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Linus,

Please apply below patch. It is incremental to patch before previous one.

Fixes a truly silly bug reported by the Stanford Checker, where we
dereference an inode pointer and then check for it not being NULL
afterwards...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

------ cut here -------
--- linux-2.4.7-pre8-vanilla/fs/ntfs/dir.c.old	Wed Jul 25 00:03:57 2001
+++ linux-2.4.7-pre8-vanilla/fs/ntfs/dir.c	Wed Jul 25 00:04:40 2001
@@ -789,7 +789,7 @@
 	int block;
 	int start;
 	ntfs_attribute *attr;
-	ntfs_volume *vol = ino->vol;
+	ntfs_volume *vol;
 	int byte, bit;
 	int error = 0;
 
@@ -797,6 +797,7 @@
 		ntfs_error("No inode passed to getdir_unsorted\n");
 		return -EINVAL;
 	}
+	vol = ino->vol;
 	if (!vol) {
 		ntfs_error("Inode %d has no volume\n", ino->i_number);
 		return -EINVAL;

