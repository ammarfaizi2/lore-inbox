Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbQLaTP3>; Sun, 31 Dec 2000 14:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130667AbQLaTPS>; Sun, 31 Dec 2000 14:15:18 -0500
Received: from www.wen-online.de ([212.223.88.39]:34821 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130352AbQLaTPJ>;
	Sun, 31 Dec 2000 14:15:09 -0500
Date: Sun, 31 Dec 2000 19:44:44 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: vmstat
Message-ID: <Pine.Linu.4.10.10012311939550.894-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Nobody watches vmstat any more? ;-)

--- linux-2.4.0-test13-pre7/drivers/block/ll_rw_blk.c.org	Sun Dec 31 08:41:47 2000
+++ linux-2.4.0-test13-pre7/drivers/block/ll_rw_blk.c	Sun Dec 31 08:49:21 2000
@@ -964,6 +964,15 @@
 	bh->b_rsector = bh->b_blocknr * (bh->b_size>>9);
 
 	generic_make_request(rw, bh);
+
+	switch (rw) {
+		case WRITE:
+			kstat.pgpgout++;
+			break;
+		default:
+			kstat.pgpgin++;
+			break;
+	}
 }
 
 /*
@@ -1057,7 +1066,6 @@
 				/* Hmmph! Nothing to write */
 				goto end_io;
 			__mark_buffer_clean(bh);
-			kstat.pgpgout++;
 			break;
 
 		case READA:
@@ -1065,7 +1073,6 @@
 			if (buffer_uptodate(bh))
 				/* Hmmph! Already have it */
 				goto end_io;
-			kstat.pgpgin++;
 			break;
 		default:
 			BUG();

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
