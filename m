Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288974AbSAITgD>; Wed, 9 Jan 2002 14:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288976AbSAITfx>; Wed, 9 Jan 2002 14:35:53 -0500
Received: from balu.sch.bme.hu ([152.66.208.40]:31422 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S288974AbSAITfj>;
	Wed, 9 Jan 2002 14:35:39 -0500
Date: Wed, 9 Jan 2002 20:35:24 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: <jgarzik@mandrakesoft.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 8139too: too early dev_kfree_skb
Message-ID: <Pine.GSO.4.30.0201092029570.14274-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch was originally sent to lkml on nov 30, 2001, from
<kumon@flab.fujitsu.co.jp>, but it is not in 2.4.18-pre2.

Was it just overlooked, or is it unneccessary?

Note that I rediffed it, and moved the +dev_kfree_skb after the DPRINTK,
because it also uses the len.

patch follows:

--- linux/drivers/net/8139too.c.orig	Fri Dec 21 12:41:54 2001
+++ linux/drivers/net/8139too.c	Wed Jan  9 20:19:43 2002
@@ -1643,7 +1643,6 @@

 	if (likely(len < TX_BUF_SIZE)) {
 		skb_copy_and_csum_dev(skb, tp->tx_buf[entry]);
-		dev_kfree_skb(skb);
 	} else {
 		dev_kfree_skb(skb);
 		tp->stats.tx_dropped++;
@@ -1667,6 +1666,7 @@
 	DPRINTK ("%s: Queued Tx packet size %u to slot %d.\n",
 		 dev->name, len, entry);

+	dev_kfree_skb(skb);
 	return 0;
 }


-- 
Balazs Pozsar.

