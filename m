Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbWGMMNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWGMMNg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWGMMNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:13:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6665 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751489AbWGMMNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:13:35 -0400
Date: Thu, 13 Jul 2006 13:13:28 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Change SDHCI version error to a warning
Message-ID: <20060713121328.GA8376@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus@drzeus.cx>,
	linux-kernel@vger.kernel.org
References: <20060711190710.12686.11805.stgit@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711190710.12686.11805.stgit@poseidon.drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 09:07:10PM +0200, Pierre Ossman wrote:
> O2 Micro's controllers have a larger specification version value and are
> therefore denied by the driver. When bypassing this check they seem to work
> fine. This patch makes the code a bit more forgiving by changing the
> warning to an error.

Doesn't this patch change the error to a warning instead?

> Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
> ---
> 
>  drivers/mmc/sdhci.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
> index fd34d84..9ec4200 100644
> --- a/drivers/mmc/sdhci.c
> +++ b/drivers/mmc/sdhci.c
> @@ -1193,10 +1193,8 @@ static int __devinit sdhci_probe_slot(st
>  	version = (version & SDHCI_SPEC_VER_MASK) >> SDHCI_SPEC_VER_SHIFT;
>  	if (version != 0) {
>  		printk(KERN_ERR "%s: Unknown controller version (%d). "
> -			"Cowardly refusing to continue.\n", host->slot_descr,
> +			"You may experience problems.\n", host->slot_descr,
>  			version);
> -		ret = -ENODEV;
> -		goto unmap;
>  	}
>  
>  	caps = readl(host->ioaddr + SDHCI_CAPABILITIES);

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
