Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbWHHSd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWHHSd7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 14:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWHHSd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 14:33:59 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:35257
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S964899AbWHHSd6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 14:33:58 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [RFC: -mm patch] bcm43xx_main.c: remove 3 functions
Date: Tue, 8 Aug 2006 20:32:37 +0200
User-Agent: KMail/1.9.1
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <20060807210415.GO3691@stusta.de>
In-Reply-To: <20060807210415.GO3691@stusta.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, linville@tuxdriver.com,
       jgarzik@pobox.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608082032.38365.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 August 2006 23:04, Adrian Bunk wrote:
> This patch removes three no longer used functions (that are even 
> generating gcc warnings).
> 
> This patch doesn't look right, but it is the result of 
> 58e5528ee464d38040b9489e10033c9387a10d56 in git-netdev...

Hm, can't find that commit in a tree.
I looked at linus', netdev-2.6.

But one thing is for sure. This patch is _wrong_. ;)

> Signed-off-by: Adrian Bunk <bunk@stusta.de>

NACK.

>  drivers/net/wireless/bcm43xx/bcm43xx_main.c |   33 --------------------
>  1 file changed, 33 deletions(-)
> 
> --- linux-2.6.18-rc3-mm2-full/drivers/net/wireless/bcm43xx/bcm43xx_main.c.old	2006-08-07 18:21:31.000000000 +0200
> +++ linux-2.6.18-rc3-mm2-full/drivers/net/wireless/bcm43xx/bcm43xx_main.c	2006-08-07 18:23:36.000000000 +0200
> @@ -3194,39 +3194,6 @@
>  	bcm43xx_clear_keys(bcm);
>  }
>  
> -static int bcm43xx_rng_read(struct hwrng *rng, u32 *data)
> -{
> -	struct bcm43xx_private *bcm = (struct bcm43xx_private *)rng->priv;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&(bcm)->irq_lock, flags);
> -	*data = bcm43xx_read16(bcm, BCM43xx_MMIO_RNG);
> -	spin_unlock_irqrestore(&(bcm)->irq_lock, flags);
> -
> -	return (sizeof(u16));
> -}
> -
> -static void bcm43xx_rng_exit(struct bcm43xx_private *bcm)
> -{
> -	hwrng_unregister(&bcm->rng);
> -}
> -
> -static int bcm43xx_rng_init(struct bcm43xx_private *bcm)
> -{
> -	int err;
> -
> -	snprintf(bcm->rng_name, ARRAY_SIZE(bcm->rng_name),
> -		 "%s_%s", KBUILD_MODNAME, bcm->net_dev->name);
> -	bcm->rng.name = bcm->rng_name;
> -	bcm->rng.data_read = bcm43xx_rng_read;
> -	bcm->rng.priv = (unsigned long)bcm;
> -	err = hwrng_register(&bcm->rng);
> -	if (err)
> -		printk(KERN_ERR PFX "RNG init failed (%d)\n", err);
> -
> -	return err;
> -}
> -
>  static int bcm43xx_shutdown_all_wireless_cores(struct bcm43xx_private *bcm)
>  {

-- 
Greetings Michael.
