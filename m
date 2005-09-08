Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbVIHO7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbVIHO7c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 10:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbVIHO7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 10:59:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16392 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932524AbVIHO7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 10:59:31 -0400
Date: Thu, 8 Sep 2005 15:59:26 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [-mm patch 5/5] SharpSL: Add new ARM PXA machines Spitz and Borzoi with partial Akita Support
Message-ID: <20050908155926.B5661@flint.arm.linux.org.uk>
Mail-Followup-To: Richard Purdie <rpurdie@rpsys.net>,
	Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <1126007632.8338.130.camel@localhost.localdomain> <20050908132340.D31595@flint.arm.linux.org.uk> <1126191158.8147.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1126191158.8147.61.camel@localhost.localdomain>; from rpurdie@rpsys.net on Thu, Sep 08, 2005 at 03:52:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 03:52:37PM +0100, Richard Purdie wrote:
> Alternatively, would you accept a patch to add an optional delay option
> to mmc_detect_change()?

Yes, since a number of hosts seem to require this (and sometimes it
even depends whether we're inserting or removing a card.)

Can I have a signed-off-by line for this patch please?

> Index: linux-2.6.13/drivers/mmc/mmc.c
> ===================================================================
> --- linux-2.6.13.orig/drivers/mmc/mmc.c	2005-09-07 22:23:01.000000000 +0100
> +++ linux-2.6.13/drivers/mmc/mmc.c	2005-09-07 22:40:03.000000000 +0100
> @@ -1067,13 +1067,17 @@
>  /**
>   *	mmc_detect_change - process change of state on a MMC socket
>   *	@host: host which changed state.
> + *	@delay: optional delay to wait before detection (jiffies)
>   *
>   *	All we know is that card(s) have been inserted or removed
>   *	from the socket(s).  We don't know which socket or cards.
>   */
> -void mmc_detect_change(struct mmc_host *host)
> +void mmc_detect_change(struct mmc_host *host, unsigned long delay)
>  {
> -	schedule_work(&host->detect);
> +	if (delay)
> +		schedule_delayed_work(&host->detect, delay);
> +	else
> +		schedule_work(&host->detect);
>  }
> 
> 
> 

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
