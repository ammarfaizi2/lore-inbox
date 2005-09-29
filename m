Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbVI2Uw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbVI2Uw6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 16:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbVI2Uw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 16:52:58 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:520 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751297AbVI2Uw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 16:52:57 -0400
Date: Thu, 29 Sep 2005 21:52:52 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
Subject: Re: [PATCH] Fix IXP4xx MTD driver no cast warning
Message-ID: <20050929205252.GG7684@flint.arm.linux.org.uk>
Mail-Followup-To: Deepak Saxena <dsaxena@plexity.net>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
References: <20050929195205.GA30002@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050929195205.GA30002@plexity.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 12:52:05PM -0700, Deepak Saxena wrote:
> Fix following warning:
> 
> drivers/mtd/maps/ixp4xx.c: In function 'ixp4xx_flash_probe':
> drivers/mtd/maps/ixp4xx.c:199: warning: assignment makes integer from
> pointer without a cast
> 
> Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
> 
> diff --git a/drivers/mtd/maps/ixp4xx.c b/drivers/mtd/maps/ixp4xx.c
> --- a/drivers/mtd/maps/ixp4xx.c
> +++ b/drivers/mtd/maps/ixp4xx.c
> @@ -196,7 +196,7 @@ static int ixp4xx_flash_probe(struct dev
>  		goto Error;
>  	}
>  
> -	info->map.map_priv_1 = ioremap(dev->resource->start,
> +	info->map.map_priv_1 = (unsigned long)ioremap(dev->resource->start,

Shouldn't this be using info->map.virt instead of the old map.map_priv_1 ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
