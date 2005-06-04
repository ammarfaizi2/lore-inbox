Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVFDT7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVFDT7u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 15:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVFDT7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 15:59:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60170 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261232AbVFDT6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 15:58:14 -0400
Date: Sat, 4 Jun 2005 20:58:10 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Support for read-only MMC cards
Message-ID: <20050604205810.A23449@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <42A2070D.9060608@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42A2070D.9060608@drzeus.cx>; from drzeus-list@drzeus.cx on Sat, Jun 04, 2005 at 09:54:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 04, 2005 at 09:54:53PM +0200, Pierre Ossman wrote:
> If the card does not support the write commands then only allow
> read-only access.

> @@ -403,9 +407,12 @@ static int mmc_blk_probe(struct mmc_card
>  	if (err)
>  		goto out;
>  
> -	printk(KERN_INFO "%s: %s %s %dKiB\n",
> +	printk(KERN_INFO "%s: %s %s %dKiB",
>  		md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
>  		(card->csd.capacity << card->csd.read_blkbits) / 1024);
> +	if (!())
> +		printk(" (ro)");
> +	printk("\n");

I'd prefer this to be:

	printk(KERN_INFO "%s: %s %s %dKiB%s\n",
 		md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
 		(card->csd.capacity << card->csd.read_blkbits) / 1024,
		card->csd.cmdclass & CCC_BLOCK_WRITE ? "" : " (ro)");

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
