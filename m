Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWEAVK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWEAVK5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWEAVK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:10:57 -0400
Received: from tayrelbas01.tay.hp.com ([161.114.80.244]:63171 "EHLO
	tayrelbas01.tay.hp.com") by vger.kernel.org with ESMTP
	id S1751258AbWEAVK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:10:56 -0400
Date: Mon, 1 May 2006 14:10:54 -0700
To: David Brownell <david-b@pacbell.net>,
       Samuel Ortiz <samuel.ortiz@nokia.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.17-rc3] smsc-ircc2, minimal PNP hotplug support
Message-ID: <20060501211054.GA506@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <200605011313.43625.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605011313.43625.david-b@pacbell.net>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 01:13:43PM -0700, David Brownell wrote:
> An old laptop now behaves more sanely.

> Minimal PNP hotplug support for the smsc-ircc2 driver.  A modular driver
> will be modprobed via hotplug, but still bypasses driver model probing.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

	Hi,

	Samuel Ortiz <samuel.ortiz@nokia.com> is now in charge of IrDA.
	Thanks...

	Jean

> Index: linux/drivers/net/irda/smsc-ircc2.c
> ===================================================================
> --- linux.orig/drivers/net/irda/smsc-ircc2.c	2006-04-23 23:23:38.000000000 -0700
> +++ linux/drivers/net/irda/smsc-ircc2.c	2006-04-28 21:42:14.000000000 -0700
> @@ -54,6 +54,7 @@
>  #include <linux/rtnetlink.h>
>  #include <linux/serial_reg.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/pnp.h>
>  #include <linux/platform_device.h>
>  
>  #include <asm/io.h>
> @@ -358,6 +360,16 @@
>                 iobase + IRCC_MASTER);
>  }
>  
> +#ifdef	CONFIG_PNP
> +/* PNP hotplug support */
> +static const struct pnp_device_id smsc_ircc_pnp_table[] = {
> +	{ .id = "SMCf010", .driver_data = 0 },
> +	/* and presumably others */
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(pnp, smsc_ircc_pnp_table);
> +#endif
> +
>  
>  /*******************************************************************************
>   *
> @@ -2072,7 +2084,8 @@
>  
>  /* PROBING
>   *
> - *
> + * REVISIT we can be told about the device by PNP, and should use that info
> + * instead of probing hardware and creating a platform_device ...
>   */
>  
>  static int __init smsc_ircc_look_for_chips(void)

