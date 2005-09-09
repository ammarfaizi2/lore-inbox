Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965226AbVIIBMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965226AbVIIBMQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 21:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965225AbVIIBMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 21:12:15 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:60433 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S965224AbVIIBMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 21:12:12 -0400
Date: Thu, 8 Sep 2005 21:08:18 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Tommy Christensen <tommy.christensen@tpack.net>
Cc: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Netdev List <netdev@vger.kernel.org>,
       nhorman@tuxdriver.com
Subject: Re: [PATCH] 3c59x: read current link status from phy
Message-ID: <20050909010816.GA28653@tuxdriver.com>
Mail-Followup-To: Tommy Christensen <tommy.christensen@tpack.net>,
	Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Netdev List <netdev@vger.kernel.org>,
	nhorman@tuxdriver.com
References: <200509080125.j881PcL9015847@hera.kernel.org> <431F9899.4060602@pobox.com> <Pine.LNX.4.63.0509081351160.21354@dingo.iwr.uni-heidelberg.de> <1126184700.4805.32.camel@tsc-6.cph.tpack.net> <Pine.LNX.4.63.0509081521140.21354@dingo.iwr.uni-heidelberg.de> <1126190554.4805.68.camel@tsc-6.cph.tpack.net> <Pine.LNX.4.63.0509081713500.22954@dingo.iwr.uni-heidelberg.de> <4320BD96.3060307@tpack.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4320BD96.3060307@tpack.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 12:39:18AM +0200, Tommy Christensen wrote:

> --- linux-2.6.13-git8/drivers/net/3c59x.c-orig	Fri Sep  9 00:05:49 2005
> +++ linux-2.6.13-git8/drivers/net/3c59x.c	Fri Sep  9 00:13:55 2005
> @@ -1889,7 +1889,9 @@ vortex_timer(unsigned long data)
>  		{
>  			spin_lock_bh(&vp->lock);
>  			mii_status = mdio_read(dev, vp->phys[0], 1);
> -			mii_status = mdio_read(dev, vp->phys[0], 1);
> +			if (!(mii_status & BMSR_LSTATUS))
> +				/* Re-read to get actual link status */
> +				mii_status = mdio_read(dev, vp->phys[0], 1);
>  			ok = 1;
>  			if (vortex_debug > 2)
>  				printk(KERN_DEBUG "%s: MII transceiver has status %4.4x.\n",

Any chance you could re-diff this to apply on top of the patch posted
earlier today by Neil Horman?

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com
