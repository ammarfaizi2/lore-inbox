Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030374AbWBAKVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbWBAKVY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 05:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbWBAKVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 05:21:24 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25100 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030374AbWBAKVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 05:21:24 -0500
Date: Wed, 1 Feb 2006 10:21:13 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Anderson Briglia <anderson.briglia@indt.org.br>
Cc: linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 3/5] MMC OMAP driver
Message-ID: <20060201102113.GD27735@flint.arm.linux.org.uk>
Mail-Followup-To: Anderson Briglia <anderson.briglia@indt.org.br>,
	linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
References: <43DF6807.9020907@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DF6807.9020907@indt.org.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 09:37:11AM -0400, Anderson Briglia wrote:
> Here are some misc fixes we've had in the OMAP tree. Might be worth
> testing them on other platforms too.

I've already provided feedback on this a year or so ago - and it
annoys me that absolutely _nothing_ has happened as a result.

The quoted part of this patch is WRONG and will _NEVER_ be merged.
You must NOT enable the clock until the power is stable.  Maybe
this is a cause of the problems that you're seeing with various
cards, since you're not allowing them to reset correctly?

Fix this first, then re-test to see if every other fix you have
is actually necessary.

Sorry, but not following the power up protocol invalidates all other
testing wrt card initialisation behaviour.

> Index: linux-2.6.15-mmc_omap/drivers/mmc/mmc.c
> ===================================================================
> --- linux-2.6.15-mmc_omap.orig/drivers/mmc/mmc.c	2006-01-30 10:24:50.000000000 -0400
> +++ linux-2.6.15-mmc_omap/drivers/mmc/mmc.c	2006-01-30 10:25:19.000000000 -0400
> @@ -704,6 +704,7 @@ static void mmc_power_up(struct mmc_host
>  	int bit = fls(host->ocr_avail) - 1;
> 
>  	host->ios.vdd = bit;
> +	host->ios.clock = host->f_min;
>  	host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
>  	host->ios.chip_select = MMC_CS_DONTCARE;
>  	host->ios.power_mode = MMC_POWER_UP;
> @@ -712,7 +713,6 @@ static void mmc_power_up(struct mmc_host
> 
>  	mmc_delay(1);
> 
> -	host->ios.clock = host->f_min;
>  	host->ios.power_mode = MMC_POWER_ON;
>  	host->ops->set_ios(host, &host->ios);
> 

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
