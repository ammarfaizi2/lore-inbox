Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268051AbRGVUMm>; Sun, 22 Jul 2001 16:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268052AbRGVUMc>; Sun, 22 Jul 2001 16:12:32 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:17651 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S268051AbRGVUMT>; Sun, 22 Jul 2001 16:12:19 -0400
Subject: [PATCH] 2.4.7 tiny NTFS fix
To: torvalds@transmeta.com
Date: Sun, 22 Jul 2001 21:12:24 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E15OPaS-0002yz-00@draco.cus.cam.ac.uk>
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Linus,

Please apply below patch (this time properly inlined I hope). It is
against 2.4.7-pre8 but should apply cleanly to 2.4.7. It adds a return
value check.

Thanks to Rasmus Andersen for initial patch.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

------ cut here ------
--- linux-2.4.7-pre8-vanilla/fs/ntfs/dir.c.old	Sun Jul 22 21:03:08 2001
+++ linux-2.4.7-pre8-vanilla/fs/ntfs/dir.c	Sun Jul 22 21:02:59 2001
@@ -894,6 +894,11 @@
 		return -EIO;
 	}
 	attr = ntfs_find_attr(ino, vol->at_index_allocation, I30);
+	if (!attr) {
+		ntfs_free(buf);
+		ntfs_debug(DEBUG_DIR3, "unsorted 9.5\n");
+		return -EIO;
+	}
 	while (1) {
 		if ((__s64)*p_high << vol->cluster_size_bits > attr->size) {
 			/* No more index records. */
