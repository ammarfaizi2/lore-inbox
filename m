Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262690AbREaBzH>; Wed, 30 May 2001 21:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262962AbREaBy5>; Wed, 30 May 2001 21:54:57 -0400
Received: from elaine5.Stanford.EDU ([171.64.15.70]:56286 "EHLO
	elaine5.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S262690AbREaByo>; Wed, 30 May 2001 21:54:44 -0400
Date: Wed, 30 May 2001 18:54:31 -0700 (PDT)
From: John Martin <suntzu@stanford.edu>
To: <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: [PATCH] mtdram.c
Message-ID: <Pine.GSO.4.31.0105301851210.21137-100000@elaine5.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this seemed to be a straight forward null pointer bug.  i just copied the
error handling code from about 5 lines below what i added in.
   -john martin


--- drivers/mtd/mtdram.c.orig       Fri Feb  9 11:30:23 2001
+++ drivers/mtd/mtdram.c    Sat May 26 20:52:56 2001
@@ -115,6 +115,11 @@
    mtd_info->size = MTDRAM_TOTAL_SIZE;
    mtd_info->erasesize = MTDRAM_ERASE_SIZE;
    mtd_info->priv = vmalloc(MTDRAM_TOTAL_SIZE);
+   if (!mtd_info->priv) {
+     kfree(mtd_info);
+     mtd_info = NULL;
+     return -ENOMEM;
+   }
    memset(mtd_info->priv, 0xff, MTDRAM_TOTAL_SIZE);

 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)

