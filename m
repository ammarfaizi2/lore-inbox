Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129454AbRBBPvD>; Fri, 2 Feb 2001 10:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129790AbRBBPux>; Fri, 2 Feb 2001 10:50:53 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:54278 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129454AbRBBPun>; Fri, 2 Feb 2001 10:50:43 -0500
Subject: RAMFS
To: linux-kernel@vger.kernel.org
Date: Fri, 2 Feb 2001 15:51:53 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OiV8-0006hH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Random quick poking

Does this fix the ramfs problem in -ac ?


--- fs/ramfs/inode.c~	Wed Jan 31 22:02:16 2001
+++ fs/ramfs/inode.c	Fri Feb  2 14:51:47 2001
@@ -174,7 +174,6 @@
 		inode->i_blocks += IBLOCKS_PER_PAGE;
 		rsb->free_pages--;
 		SetPageDirty(page);
-		UnlockPage(page);
 	} else {
 		ClearPageUptodate(page);
 		ret = 0;
@@ -264,6 +263,7 @@
 
 	if (! ramfs_alloc_page(inode, page))
 		return -ENOSPC;
+	UnlockPage(page);
 	return 0;
 }
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
