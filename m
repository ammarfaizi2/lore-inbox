Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbTDQBoq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 21:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbTDQBoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 21:44:46 -0400
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:3042 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262258AbTDQBop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 21:44:45 -0400
Message-Id: <200304170153.h3H1rOGi007109@locutus.cmf.nrl.navy.mil>
To: Rik van Riel <riel@surriel.com>
cc: "David S. Miller" <davem@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compile fix for br2684 
In-reply-to: Your message of "Wed, 16 Apr 2003 21:08:43 EDT."
             <Pine.LNX.4.44.0304162107370.12494-100000@chimarrao.boston.redhat.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Wed, 16 Apr 2003 21:53:24 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0304162107370.12494-100000@chimarrao.boston.redhat.com>,Rik van Riel writes:
>It looks like the recent ATM updates forgot br2684.c, here is
>the patch needed to make that driver compile.

forgive me, but i didnt think the recvq to sk->receive_queue changes were
in the 2.4 kernel series yet?

>--- linux-2.4.20/net/atm/br2684.c.compile	2003-04-16 20:41:05.000000000 -0400
>+++ linux-2.4.20/net/atm/br2684.c	2003-04-16 20:42:05.000000000 -0400
>@@ -188,7 +188,7 @@ static int br2684_xmit_vcc(struct sk_buf
> 		dev_kfree_skb(skb);
> 		return 0;
> 		}
>-	atomic_add(skb->truesize, &atmvcc->tx_inuse);
>+	atomic_add(skb->truesize, &atmvcc->sk->wmem_alloc);
> 	ATM_SKB(skb)->iovcnt = 0;
> 	ATM_SKB(skb)->atm_options = atmvcc->atm_options;
> 	brdev->stats.tx_packets++;
>@@ -551,7 +551,7 @@ Note: we do not have explicit unassign, 
> 	barrier();
> 	atmvcc->push = br2684_push;
> 	skb_queue_head_init(&copy);
>-	skb_migrate(&atmvcc->recvq, &copy);
>+	skb_migrate(&atmvcc->sk->receive_queue, &copy);
> 	while ((skb = skb_dequeue(&copy))) {
> 		BRPRIV(skb->dev)->stats.rx_bytes -= skb->len;
> 		BRPRIV(skb->dev)->stats.rx_packets--;
