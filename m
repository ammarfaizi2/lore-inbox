Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264447AbRGWXPE>; Mon, 23 Jul 2001 19:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264432AbRGWXOy>; Mon, 23 Jul 2001 19:14:54 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:39873 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S264416AbRGWXOr>; Mon, 23 Jul 2001 19:14:47 -0400
Subject: [PATCH] 2.4.7 More tiny NTFS fixes
To: torvalds@transmeta.com
Date: Tue, 24 Jul 2001 00:14:52 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E15Ooub-0000jq-00@virgo.cus.cam.ac.uk>
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Linus,

Please apply below patch. It is against 2.4.7 and adds three more return
checks (it is orthogonal to the one sent on Sunday).

Thanks to Rasmus Andersen for supplying the patch.

Best regards,

	Anton 
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

------ cut here ------
--- linux-247-clean/fs/ntfs/inode.c	Mon Jul 23 21:10:49 2001
+++ linux-247/fs/ntfs/inode.c	Mon Jul 23 22:04:58 2001
@@ -95,6 +95,8 @@
 	ntfs_io io;
 
 	mdata = ntfs_find_attr(vol->mft_ino, vol->at_data, 0);
+	if (!mdata)
+		return -EINVAL;
 	/* First check whether there is uninitialized space. */
 	if (mdata->allocated < mdata->size + vol->mft_record_size) {
 		size = (__s64)ntfs_get_free_cluster_count(vol->bitmap) <<
@@ -127,6 +129,8 @@
 	/* Now extend the bitmap if necessary. */
 	rcount = mdata->size >> vol->mft_record_size_bits;
 	bmp = ntfs_find_attr(vol->mft_ino, vol->at_bitmap, 0);
+	if (!bmp)
+		return -EINVAL;
 	if (bmp->size * 8 < rcount) { /* Less bits than MFT records. */
 		ntfs_u8 buf[1];
 		/* Extend bitmap by one byte. */
@@ -1305,6 +1309,8 @@
 	*result = 0;
 	/* Determine the number of mft records in the mft. */
 	data = ntfs_find_attr(vol->mft_ino, vol->at_data, 0);
+	if (!data)
+		return -EINVAL;
 	length = data->size >> vol->mft_record_size_bits;
 	/* Allocate sufficient space for the mft bitmap attribute value,
 	   inferring it from the number of mft records. */

