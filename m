Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289048AbSAIWaZ>; Wed, 9 Jan 2002 17:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289055AbSAIWaM>; Wed, 9 Jan 2002 17:30:12 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:16639 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S289048AbSAIW3y>;
	Wed, 9 Jan 2002 17:29:54 -0500
Date: Wed, 9 Jan 2002 14:29:51 -0800
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Steven Walter <srwalter@yahoo.com>
Subject: Re: [PATCH] wavelan: check request_region return value
Message-ID: <20020109142951.A10219@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20011230172229.M24320@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011230172229.M24320@hapablap.dyn.dhs.org>; from srwalter@yahoo.com on Sun, Dec 30, 2001 at 05:22:29PM -0600
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2001 at 05:22:29PM -0600, Steven Walter wrote:
> I recently changed several drivers in drivers/net of the Linux kernel to
> correctly check the return value of request_region.  Since you appear
> to be the maintainer of this driver, I'm forwarding the patch to you.
> 
> Thanks
> -- 
> -Steven

	For some reason, the tab got mangled, so I redid the
patch. Ready to go in kernel 2.4.X and 2.5.X.

	Jean

diff -u -p linux/drivers/net/wavelan.j1.c linux/drivers/net/wavelan.c
--- linux/drivers/net/wavelan.j1.c	Wed Jan  9 14:23:19 2002
+++ linux/drivers/net/wavelan.c	Wed Jan  9 14:25:04 2002
@@ -4019,7 +4019,8 @@ static int __init wavelan_config(device 
 
 	dev->irq = irq;
 
-	request_region(ioaddr, sizeof(ha_t), "wavelan");
+	if (!request_region(ioaddr, sizeof(ha_t), "wavelan"))
+		return -EBUSY;
 
 	dev->mem_start = 0x0000;
 	dev->mem_end = 0x0000;
