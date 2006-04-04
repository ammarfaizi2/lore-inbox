Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWDDStv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWDDStv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 14:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWDDStv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 14:49:51 -0400
Received: from mail11.bluewin.ch ([195.186.18.61]:974 "EHLO mail11.bluewin.ch")
	by vger.kernel.org with ESMTP id S1750795AbWDDStu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 14:49:50 -0400
Date: Tue, 4 Apr 2006 20:49:16 +0200
From: Roger Luethi <rl@hellgate.ch>
To: linux-kernel@vger.kernel.org
Cc: pin xue <pinxue@gmail.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] via-rhine: execute bounce buffers code on Rhine-I only
Message-ID: <20060404184916.GD13676@k3.hellgate.ch>
References: <61291d840604040738k1477cf72w7aadbc1e83d67bba@mail.gmail.com> <61291d840604040739m69642b26x4b24615112e37ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61291d840604040739m69642b26x4b24615112e37ce@mail.gmail.com>
X-Operating-System: Linux 2.6.16 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch suggested by Yang Wu (pin xue <pinxue@gmail.com>).

Signed-off-by: Roger Luethi <rl@hellgate.ch>

--- linux-2.6.16/drivers/net/via-rhine.c.orig	2006-04-04 13:52:29.000000000 +0200
+++ linux-2.6.16/drivers/net/via-rhine.c	2006-04-04 20:40:08.000000000 +0200
@@ -475,7 +475,7 @@ struct rhine_private {
 	struct sk_buff *tx_skbuff[TX_RING_SIZE];
 	dma_addr_t tx_skbuff_dma[TX_RING_SIZE];
 
-	/* Tx bounce buffers */
+	/* Tx bounce buffers (Rhine-I only) */
 	unsigned char *tx_buf[TX_RING_SIZE];
 	unsigned char *tx_bufs;
 	dma_addr_t tx_bufs_dma;
@@ -1052,7 +1052,8 @@ static void alloc_tbufs(struct net_devic
 		rp->tx_ring[i].desc_length = cpu_to_le32(TXDESC);
 		next += sizeof(struct tx_desc);
 		rp->tx_ring[i].next_desc = cpu_to_le32(next);
-		rp->tx_buf[i] = &rp->tx_bufs[i * PKT_BUF_SZ];
+		if (rp->quirks & rqRhineI)
+			rp->tx_buf[i] = &rp->tx_bufs[i * PKT_BUF_SZ];
 	}
 	rp->tx_ring[i-1].next_desc = cpu_to_le32(rp->tx_ring_dma);
 
