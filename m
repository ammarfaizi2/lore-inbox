Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129477AbQLEHtO>; Tue, 5 Dec 2000 02:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129582AbQLEHtE>; Tue, 5 Dec 2000 02:49:04 -0500
Received: from tungsten.btinternet.com ([194.73.73.81]:55511 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S129477AbQLEHs5>; Tue, 5 Dec 2000 02:48:57 -0500
Date: Tue, 5 Dec 2000 07:17:31 +0000 (GMT)
From: davej@suse.de
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] UDF compile fix.
Message-ID: <Pine.LNX.4.21.0012050716110.13931-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus, 

 A writepage() parameter got removed, but not the caller in
the UDF filesystem, patch below fixes this.

regards,

Davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

diff -urN linux.vanilla/fs/udf/inode.c linux/fs/udf/inode.c
--- linux.vanilla/fs/udf/inode.c	Tue Dec  5 01:13:22 2000
+++ linux/fs/udf/inode.c	Tue Dec  5 01:14:11 2000
@@ -202,7 +202,7 @@
 	mark_buffer_dirty(bh);
 	udf_release_data(bh);
 
-	inode->i_data.a_ops->writepage(NULL, page);
+	inode->i_data.a_ops->writepage(page);
 	UnlockPage(page);
 	page_cache_release(page);
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
