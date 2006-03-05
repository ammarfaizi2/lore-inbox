Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWCESX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWCESX4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 13:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWCESX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 13:23:56 -0500
Received: from tim.rpsys.net ([194.106.48.114]:26852 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750955AbWCESXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 13:23:55 -0500
Subject: Re: [patch] collie: fix missing pcmcia bits
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, linux@dominikbrodowski.net
In-Reply-To: <20060305135351.GA16481@elf.ucw.cz>
References: <20060305135351.GA16481@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 05 Mar 2006 18:23:27 +0000
Message-Id: <1141583008.6521.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-05 at 14:53 +0100, Pavel Machek wrote: 
> This adds missing bits of collie (sharp sl-5500) PCMCIA support.
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
> index f146e5e..8bd802e 100644
> --- a/arch/arm/mach-sa1100/collie.c
> +++ b/arch/arm/mach-sa1100/collie.c
> @@ -76,6 +76,12 @@ static struct scoop_pcmcia_dev collie_pc
>  },
>  };
>  
> +static struct scoop_pcmcia_config collie_pcmcia_config = {
> +	.devs         = &collie_pcmcia_scoop[0],
> +	.num_devs     = 1,
> +};
> +
> +
>  static struct mcp_plat_data collie_mcp_data = {
>  	.mccr0          = MCCR0_ADM,
>  	.sclk_rate      = 11981000,
> @@ -242,8 +249,7 @@ static void __init collie_init(void)
>  	GPDR |= GPIO_32_768kHz;
>  	TUCR  = TUCR_32_768kHz;
>  
> -	scoop_num = 1;
> -	scoop_devs = &collie_pcmcia_scoop[0];

These lines don't exist in mainline kernels anymore? What was this
diffed against?

> +	platform_scoop_config = &collie_pcmcia_config;

This is fine (and its definition above).

>  	ret = platform_add_devices(devices, ARRAY_SIZE(devices));
>  	if (ret) {
> diff --git a/drivers/pcmcia/pxa2xx_sharpsl.c b/drivers/pcmcia/pxa2xx_sharpsl.c
> index fd36473..f1363b8 100644
> --- a/drivers/pcmcia/pxa2xx_sharpsl.c
> +++ b/drivers/pcmcia/pxa2xx_sharpsl.c
> @@ -22,6 +22,15 @@
>  #include <asm/hardware.h>
>  #include <asm/irq.h>
>  #include <asm/hardware/scoop.h>
> +#include <asm/mach-types.h>

This is needed but its already in mainline?

> +#include <linux/delay.h>

This is no longer needed (and should have been above asm anyway).

> +
> +#ifdef CONFIG_SA1100_COLLIE
> +#include <asm/arch-sa1100/collie.h>

I can't immediately see why this is needed anymore.

> +#else
> +#include <asm/arch/spitz.h>
> +#include <asm/arch-pxa/pxa-regs.h>
> +#endif

These aren't needed.

Richard

