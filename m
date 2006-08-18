Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbWHRGMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWHRGMj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 02:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWHRGMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 02:12:39 -0400
Received: from msr26.hinet.net ([168.95.4.126]:187 "EHLO msr26.hinet.net")
	by vger.kernel.org with ESMTP id S1750983AbWHRGMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 02:12:38 -0400
Message-ID: <02ea01c6c28d$20943940$4964a8c0@icplus.com.tw>
From: "Jesse Huang" <jesse@icplus.com.tw>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <akpm@osdl.org>
References: <1155841712.4532.19.camel@localhost.localdomain> <44E48281.1060504@pobox.com>
Subject: Re: [PATCH 5/6] IP100A correct init and close step
Date: Fri, 18 Aug 2006 14:11:21 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff:
(1)Should I change to :
spin_lock_irqsave(&np->lock,flags);
reset_tx(dev);
spin_lock_irqrestore(&np->lock,flags);

(2)I will remove date and author information out of source code comment.

----- Original Message ----- 
From: "Jeff Garzik" <jgarzik@pobox.com>
To: "Jesse Huang" <jesse@icplus.com.tw>
Cc: <linux-kernel@vger.kernel.org>; <netdev@vger.kernel.org>;
<akpm@osdl.org>
Sent: Thursday, August 17, 2006 10:51 PM
Subject: Re: [PATCH 5/6] IP100A correct init and close step


Jesse Huang wrote:
> From: Jesse Huang <jesse@icplus.com.tw>
>
> correct init and close step
>
> Change Logs:
>     correct init and close step
>
> ---
>
>  drivers/net/sundance.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
>
> b5e343a17f5d70d1cc9a4ba20d366bab355f64a6
> diff --git a/drivers/net/sundance.c b/drivers/net/sundance.c
> index f63871a..c7c22f0 100755
> --- a/drivers/net/sundance.c
> +++ b/drivers/net/sundance.c
> @@ -830,6 +830,11 @@ #endif
>  iowrite8(0x01, ioaddr + DebugCtrl1);
>  netif_start_queue(dev);
>
> + // 04/19/2005 Jesse fix for complete initial step
> + spin_lock(&np->lock);
> + reset_tx(dev);
> + spin_unlock(&np->lock);
> +

NAK -- ineffective locking.

If you need locking here, you must use spin_lock_irqsave()


> @@ -1654,7 +1659,10 @@ static int netdev_close(struct net_devic
>
>  /* Disable interrupts by clearing the interrupt mask. */
>  iowrite16(0x0000, ioaddr + IntrEnable);
> -
> +
> + // 04/19/2005 Jesse fix for complete initial step
> + writew(0x500, ioaddr + DMACtrl);

NAK:

1) date and author information is already present in the kernel
changelog.  It should not be present in the source code.

2) The comment (or patch description) fails to describe -why- this
change is needed.  It only described what is being changes, which is
already obvious from reading the source code.



