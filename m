Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965219AbWIVWIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965219AbWIVWIZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 18:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965218AbWIVWIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 18:08:25 -0400
Received: from havoc.gtf.org ([69.61.125.42]:4830 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965215AbWIVWIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 18:08:25 -0400
Date: Fri, 22 Sep 2006 18:07:59 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] net driver fixes
Message-ID: <20060922220759.GA15583@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git upstream-linus

to receive the following updates:

 drivers/net/lp486e.c      |    6 +++---
 drivers/net/mv643xx_eth.c |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

Jeff Garzik:
      [netdrvr] lp486e: fix typo
      [netdrvr] mv643xx_eth: fix obvious typo, which caused build breakage

diff --git a/drivers/net/lp486e.c b/drivers/net/lp486e.c
index b783a69..393aba9 100644
--- a/drivers/net/lp486e.c
+++ b/drivers/net/lp486e.c
@@ -442,16 +442,16 @@ #if 0
 		if (rbd) {
 			rbd->pad = 0;
 			rbd->count = 0;
-			rbd->skb = dev_alloc_skb(RX_SKB_SIZE);
+			rbd->skb = dev_alloc_skb(RX_SKBSIZE);
 			if (!rbd->skb) {
 				printk("dev_alloc_skb failed");
 			}
 			rbd->next = rfd->rbd;
 			if (i) {
 				rfd->rbd->prev = rbd;
-				rbd->size = RX_SKB_SIZE;
+				rbd->size = RX_SKBSIZE;
 			} else {
-				rbd->size = (RX_SKB_SIZE | RBD_EL);
+				rbd->size = (RX_SKBSIZE | RBD_EL);
 				lp->rbd_tail = rbd;
 			}
 
diff --git a/drivers/net/mv643xx_eth.c b/drivers/net/mv643xx_eth.c
index eeab1df..59de3e7 100644
--- a/drivers/net/mv643xx_eth.c
+++ b/drivers/net/mv643xx_eth.c
@@ -385,7 +385,7 @@ static int mv643xx_eth_receive_queue(str
 	struct pkt_info pkt_info;
 
 	while (budget-- > 0 && eth_port_receive(mp, &pkt_info) == ETH_OK) {
-		dma_unmap_single(NULL, pkt_info.buf_ptr, RX_SKB_SIZE,
+		dma_unmap_single(NULL, pkt_info.buf_ptr, ETH_RX_SKB_SIZE,
 							DMA_FROM_DEVICE);
 		mp->rx_desc_count--;
 		received_packets++;
