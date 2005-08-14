Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbVHNAdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVHNAdV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 20:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbVHNAdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 20:33:21 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:7399 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751359AbVHNAdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 20:33:20 -0400
Subject: Re: [BUG] PLIP: Badness in enable_irq and Oops
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-parport@lists.infradead.org
In-Reply-To: <42FE8DD2.10204@gmail.com>
References: <42FE8DD2.10204@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 14 Aug 2005 02:00:10 +0100
Message-Id: <1123981210.14138.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-08-14 at 02:18 +0200, Jiri Slaby wrote:
> I founded out, that in plip_error (drivers/plip.c)
>                 ENABLE(dev->irq);
> is called by before not calling
>                 DISABLE(dev->irq);
> in plip_bh_timeout_error in

It used to be valid to call enable/disable indiscriminately. 

>         if (error == HS_TIMEOUT) { ...
> My opinion is, that ENABLE in plip_error should be called only if the 
> error was HS_TIMEOUT too.

Tracking the state would fix it yes

> That was badness. And what about the oops:
>         case PLIP_PK_DONE:
>                 /* Inform the upper layer for the arrival of a packet. */
>                 rcv->skb->protocol=plip_type_trans(rcv->skb, dev); <---- 
> the skb here is NULL
>                 netif_rx(rcv->skb);
> Should we inform somebody, if skb is NULL?

You should never get to PK_DONE with rcv->skb = NULL as if that is the
case you are not done. Its years since I looked at plip.

