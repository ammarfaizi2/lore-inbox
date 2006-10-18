Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423154AbWJRXiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423154AbWJRXiF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 19:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423160AbWJRXiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 19:38:04 -0400
Received: from [63.64.152.142] ([63.64.152.142]:49678 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1423154AbWJRXiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 19:38:00 -0400
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 1/7] I/OAT: Push pending transactions to hardware more frequently
Date: Wed, 18 Oct 2006 16:46:48 -0700
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       jeff@garzik.org
Message-Id: <20061018234648.26671.41703.stgit@gitlost.site>
In-Reply-To: <20061018234417.26671.56773.stgit@gitlost.site>
References: <20061018234417.26671.56773.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every 20 descriptors turns out to be to few append commands with
newer/faster CPUs.  Pushing every 4 still cuts down on MMIO writes to an
acceptable level without letting the DMA engine run out of work.

Signed-off-by: Chris Leech <christopher.leech@intel.com>
---

 drivers/dma/ioatdma.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ioatdma.c b/drivers/dma/ioatdma.c
index 0358419..f3b34b5 100644
--- a/drivers/dma/ioatdma.c
+++ b/drivers/dma/ioatdma.c
@@ -310,7 +310,7 @@ static dma_cookie_t do_ioat_dma_memcpy(s
 	list_splice_init(&new_chain, ioat_chan->used_desc.prev);
 
 	ioat_chan->pending += desc_count;
-	if (ioat_chan->pending >= 20) {
+	if (ioat_chan->pending >= 4) {
 		append = 1;
 		ioat_chan->pending = 0;
 	}
@@ -818,7 +818,7 @@ static void __devexit ioat_remove(struct
 }
 
 /* MODULE API */
-MODULE_VERSION("1.7");
+MODULE_VERSION("1.9");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Intel Corporation");
 

