Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263784AbUHWM4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUHWM4F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 08:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUHWM4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 08:56:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60341 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263784AbUHWMz7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 08:55:59 -0400
Date: Mon, 23 Aug 2004 08:35:33 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "O.Sezer" <sezeroz@ttnet.net.tr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] gcc-3.4 more fixes
Message-ID: <20040823113533.GA4569@logos.cnet>
References: <4112906E.4060707@ttnet.net.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <4112906E.4060707@ttnet.net.tr>
User-Agent: Mutt/1.5.5.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 10:54:22PM +0300, O.Sezer wrote:
> Hi all:
> 
> The attached patch applies to 2.4.27-rc5 + Mikael's patch
> series. Most fixes are taken from 2.6. The only non-lvalue
> change is to e100.h which, otherwise, caused some tens of
> warning lines on my logs.
> 
> There still are some lvalue related warnings (eicon_idi.c:2057,
> 53c7,8xx.c:3929,  fs/affs/super.c:133, rio_linux.c:1209,1333,
> intermezzo/sysctl.c:305,  and ibmphp_hpc.c and  pciehp_hpc.c).
> The hotplug dir (ibmphp_hpc.c and  pciehp_hpc.c) seems to get
> very many updates in 2.6 compared to 2.4 so it wasn't easy to
> decide. And for the rest, I got tired and bored..
> 
> There also are "integer constant is too large for "long" type"
> warnings all around and I would like to know how serious they
> are.
> 
> Compilations were tested with the gcc-3.4.0-1 package from FC2
> (rebuilt on rh9). I would like to have the folks review this
> for any of my errors/typos/brainfarts etc ;)
> 
> Thanks,
> Özkan Sezer

Ozkan, 

This are just warning fixes right?

I dont like this patches, that is, I'm not confident about them.

 Let the warnings be.

[marcelo@logos atm]$ grep PRIV idt77*
idt77105.c:#define PRIV(dev) ((struct idt77105_priv *) dev->phy_data)

> --- 27rc5~/drivers/atm/idt77105.c
> +++ 27rc5/drivers/atm/idt77105.c
> @@ -267,7 +267,7 @@
>  {
>  	unsigned long flags;
>  
> -	if (!(PRIV(dev) = kmalloc(sizeof(struct idt77105_priv),GFP_KERNEL)))
> +	if (!(dev->dev_data = kmalloc(sizeof(struct idt77105_priv),GFP_KERNEL)))
>  		return -ENOMEM;
>  	PRIV(dev)->dev = dev;
>  	spin_lock_irqsave(&idt77105_priv_lock, flags);
> @@ -345,7 +345,7 @@
>                  else
>                      idt77105_all = walk->next;
>  	        dev->phy = NULL;
> -                PRIV(dev) = NULL;
> +                dev->dev_data = NULL;
>                  kfree(walk);
>                  break;
>              }
