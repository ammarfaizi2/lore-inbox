Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130017AbRAWVrE>; Tue, 23 Jan 2001 16:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130322AbRAWVqp>; Tue, 23 Jan 2001 16:46:45 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:7180 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S130017AbRAWVqc>;
	Tue, 23 Jan 2001 16:46:32 -0500
Date: Tue, 23 Jan 2001 22:46:14 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Vojtech Pavlik <vojtech@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] No VIA IDE DMA unless configured
Message-ID: <Pine.LNX.4.30.0101232239280.27097-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please consider this patch for 2.4.1.  It makes sure the VIA IDE
driver does not enable DMA automatically, unless the user has requested it
using "make whateverconfig".

/Tobias

--- via82cxxx.c.orig	Tue Jan 23 22:26:25 2001
+++ via82cxxx.c	Tue Jan 23 22:27:05 2001
@@ -602,7 +602,9 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_base) {
 		hwif->dmaproc = &via82cxxx_dmaproc;
+#ifdef CONFIG_IDEDMA_AUTO
 		hwif->autodma = 1;
+#endif /* CONFIG_IDEDMA_AUTO */
 	}
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 }


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
