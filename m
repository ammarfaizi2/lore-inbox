Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274557AbRIYILU>; Tue, 25 Sep 2001 04:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274561AbRIYILL>; Tue, 25 Sep 2001 04:11:11 -0400
Received: from mail.tinysw.cz ([195.39.55.2]:48396 "EHLO mail.tinysw.cz")
	by vger.kernel.org with ESMTP id <S274557AbRIYILA>;
	Tue, 25 Sep 2001 04:11:00 -0400
Message-ID: <3BB03C3E.3080906@seznam.cz>
Date: Tue, 25 Sep 2001 10:11:42 +0200
From: Kapr Johnik <kapr.johnik@seznam.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010917
X-Accept-Language: cs, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH-2.2.19] bug in cs89x0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to all.

I think I've found bug in the cs89x0 network driver in 2.2.19, which we 
are using in an embedded network router. The driver does not use 
skb_put(), instead it writes directly to skb->len and leaves skb->tail 
incorrect. Patch follows.

diff -u -r linux-2.2.19/drivers/net/cs89x0.c linux/drivers/net/cs89x0.c
--- linux-2.2.19/drivers/net/cs89x0.c	Sun Mar 25 18:37:34 2001
+++ linux/drivers/net/cs89x0.c	Tue Sep 25 09:39:35 2001
@@ -904,7 +904,7 @@
 		lp->stats.rx_dropped++;
 		return;
 	}
-	skb->len = length;
+	skb_put(skb, length);
 	skb->dev = dev;
 
         insw(ioaddr + RX_FRAME_PORT, skb->data, length >> 1);




