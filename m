Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262482AbTCRPke>; Tue, 18 Mar 2003 10:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262490AbTCRPke>; Tue, 18 Mar 2003 10:40:34 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:4612 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262482AbTCRPkd>; Tue, 18 Mar 2003 10:40:33 -0500
Date: Tue, 18 Mar 2003 15:51:27 +0000
From: John Levon <levon@movementarian.org>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Cc: chas@locutus.cmf.nrl.navy.mil
Subject: [PATCH] fix pppoatm compile in 2.5.65
Message-ID: <20030318155127.GA96943@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18vJNA-0008rr-00*XH9L543K6ac*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It seems to work with the patch below

regards
john

--- linux-linus/net/atm/pppoatm.c	2003-03-17 21:44:19.000000000 +0000
+++ up/net/atm/pppoatm.c	2003-03-18 15:27:47.000000000 +0000
@@ -231,7 +231,7 @@
 		kfree_skb(skb);
 		return 1;
 	}
-	atomic_add(skb->truesize, &ATM_SKB(skb)->vcc->tx_inuse);
+	atomic_add(skb->truesize, &ATM_SKB(skb)->vcc->sk->wmem_alloc);
 	ATM_SKB(skb)->iovcnt = 0;
 	ATM_SKB(skb)->atm_options = ATM_SKB(skb)->vcc->atm_options;
 	DPRINTK("(unit %d): atm_skb(%p)->vcc(%p)->dev(%p)\n",
