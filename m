Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264891AbTFLQVm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 12:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbTFLQVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 12:21:21 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:54915
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264891AbTFLQUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 12:20:10 -0400
Date: Thu, 12 Jun 2003 12:22:44 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL][PATCH][2.5] Remove warning due to comparison in
 drivers/net/pcnet32.c
Message-ID: <Pine.LNX.4.50.0306121221400.738-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(already sent to the trivial patch monkey, forgot to Cc LKML)

drivers/net/pcnet32.c: In function `pcnet32_init_ring':
drivers/net/pcnet32.c:1006: warning: comparison between pointer and integer

Index: linux-2.5/drivers/net/pcnet32.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/net/pcnet32.c,v
retrieving revision 1.31
diff -u -p -B -r1.31 pcnet32.c
--- linux-2.5/drivers/net/pcnet32.c	30 May 2003 17:46:04 -0000	1.31
+++ linux-2.5/drivers/net/pcnet32.c	12 Jun 2003 14:54:29 -0000
@@ -1003,7 +1003,7 @@ pcnet32_init_ring(struct net_device *dev
 	    skb_reserve (rx_skbuff, 2);
 	}
 
-	if (lp->rx_dma_addr[i] == NULL) 
+	if (lp->rx_dma_addr[i] == 0) 
 		lp->rx_dma_addr[i] = pci_map_single(lp->pci_dev, rx_skbuff->tail, rx_skbuff->len, PCI_DMA_FROMDEVICE);
 	lp->rx_ring[i].base = (u32)le32_to_cpu(lp->rx_dma_addr[i]);
 	lp->rx_ring[i].buf_length = le16_to_cpu(-PKT_BUF_SZ);
-- 
function.linuxpower.ca
