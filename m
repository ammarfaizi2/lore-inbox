Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274674AbRIYWr7>; Tue, 25 Sep 2001 18:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274675AbRIYWrs>; Tue, 25 Sep 2001 18:47:48 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:55427 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S274674AbRIYWrj>;
	Tue, 25 Sep 2001 18:47:39 -0400
Date: Wed, 26 Sep 2001 00:47:55 +0200
From: David Weinehall <tao@acc.umu.se>
To: Kapr Johnik <kapr.johnik@seznam.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH-2.2.19] bug in cs89x0
Message-ID: <20010926004755.A968@khan.acc.umu.se>
In-Reply-To: <3BB03C3E.3080906@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3BB03C3E.3080906@seznam.cz>; from kapr.johnik@seznam.cz on Tue, Sep 25, 2001 at 10:11:42AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 10:11:42AM +0200, Kapr Johnik wrote:
> Hi to all.
> 
> I think I've found bug in the cs89x0 network driver in 2.2.19, which we 
> are using in an embedded network router. The driver does not use 
> skb_put(), instead it writes directly to skb->len and leaves skb->tail 
> incorrect. Patch follows.

The same error exists in the v2.4-kernel, drivers/net/mac89x0.c


/David Weinehall

--- linux-2.4.10/drivers/net/mac89x0.c.old	Wed Sep 26 00:45:44 2001
+++ linux-2.4.10/drivers/net/mac89x0.c	Wed Sep 26 00:46:34 2001
@@ -524,7 +524,7 @@
 		lp->stats.rx_dropped++;
 		return;
 	}
-	skb->len = length;
+	skb_put(skb, length);
 	skb->dev = dev;
 
 	memcpy_fromio(skb->data, dev->mem_start + PP_RxFrame, length);
