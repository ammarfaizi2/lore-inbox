Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbTDQA5N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 20:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTDQA5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 20:57:12 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:65411 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262134AbTDQA5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 20:57:08 -0400
Date: Wed, 16 Apr 2003 21:08:43 -0400 (EDT)
From: Rik van Riel <riel@surriel.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: chas@cmf.nrl.navy.mil
cc: "David S. Miller" <davem@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] compile fix for br2684
Message-ID: <Pine.LNX.4.44.0304162107370.12494-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It looks like the recent ATM updates forgot br2684.c, here is
the patch needed to make that driver compile.

--- linux-2.4.20/net/atm/br2684.c.compile	2003-04-16 20:41:05.000000000 -0400
+++ linux-2.4.20/net/atm/br2684.c	2003-04-16 20:42:05.000000000 -0400
@@ -188,7 +188,7 @@ static int br2684_xmit_vcc(struct sk_buf
 		dev_kfree_skb(skb);
 		return 0;
 		}
-	atomic_add(skb->truesize, &atmvcc->tx_inuse);
+	atomic_add(skb->truesize, &atmvcc->sk->wmem_alloc);
 	ATM_SKB(skb)->iovcnt = 0;
 	ATM_SKB(skb)->atm_options = atmvcc->atm_options;
 	brdev->stats.tx_packets++;
@@ -551,7 +551,7 @@ Note: we do not have explicit unassign, 
 	barrier();
 	atmvcc->push = br2684_push;
 	skb_queue_head_init(&copy);
-	skb_migrate(&atmvcc->recvq, &copy);
+	skb_migrate(&atmvcc->sk->receive_queue, &copy);
 	while ((skb = skb_dequeue(&copy))) {
 		BRPRIV(skb->dev)->stats.rx_bytes -= skb->len;
 		BRPRIV(skb->dev)->stats.rx_packets--;

