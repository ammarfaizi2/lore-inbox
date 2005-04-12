Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVDLJz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVDLJz6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 05:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbVDLJz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 05:55:58 -0400
Received: from h142-az.mvista.com ([65.200.49.142]:44928 "HELO
	xyzzy.farnsworth.org") by vger.kernel.org with SMTP id S262091AbVDLJzX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 05:55:23 -0400
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 12 Apr 2005 02:55:22 -0700
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc32: MV643XX ethernet is an option for Pegasos
Message-ID: <20050412095522.GA20129@xyzzy>
References: <1113289985.21548.66.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113289985.21548.66.camel@gaston>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 07:13:04AM +0000, Benjamin Herrenschmidt wrote:
> This patch allows Kconfig to build the MV643xx ethernet driver on
> Pegasos (CONFIG_PPC_MULTIPLATFORM) and adds what I think is a missing
> fix from Dale's batch, that is remove SA_INTERRUPT and add SA_SHIRQ in
> there as the interrupt is shared if I understand things correctly.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Fabio Massimo Di Nitto <fabbione@ubuntu.com>

This looks identical to the patch I posted to netdev two weeks ago
as the first of 20 patches for the MV643xx ethernet driver.

See <http://oss.sgi.com/archives/netdev/2005-03/msg01644.html> and
<http://oss.sgi.com/archives/netdev/2005-03/msg01642.html>.

Thanks,
-Dale

> #! /bin/sh -e
> 
> . $(dirname $0)/DPATCH
> 
> @DPATCH@
> diff -urNad linux-source-2.6.12-2.6.11.90/drivers/net/Kconfig /usr/src/dpatchtemp/dpep.nYRoKc/linux-source-2.6.12-2.6.11.90/drivers/net/Kconfig
> --- linux-source-2.6.12-2.6.11.90/drivers/net/Kconfig	2005-04-11 16:13:06.000000000 +0200
> +++ /usr/src/dpatchtemp/dpep.nYRoKc/linux-source-2.6.12-2.6.11.90/drivers/net/Kconfig	2005-04-12 08:05:33.535955920 +0200
> @@ -2044,7 +2044,7 @@
>  
>  config MV643XX_ETH
>  	tristate "MV-643XX Ethernet support"
> -	depends on MOMENCO_OCELOT_C || MOMENCO_JAGUAR_ATX || MV64360 || MOMENCO_OCELOT_3
> +	depends on MOMENCO_OCELOT_C || MOMENCO_JAGUAR_ATX || MV64360 || MOMENCO_OCELOT_3 || PPC_MULTIPLATFORM
>  	help
>  	  This driver supports the gigabit Ethernet on the Marvell MV643XX
>  	  chipset which is used in the Momenco Ocelot C and Jaguar ATX and
> diff -urNad linux-source-2.6.12-2.6.11.90/drivers/net/mv643xx_eth.c /usr/src/dpatchtemp/dpep.nYRoKc/linux-source-2.6.12-2.6.11.90/drivers/net/mv643xx_eth.c
> --- linux-source-2.6.12-2.6.11.90/drivers/net/mv643xx_eth.c	2005-04-07 14:57:16.000000000 +0200
> +++ /usr/src/dpatchtemp/dpep.nYRoKc/linux-source-2.6.12-2.6.11.90/drivers/net/mv643xx_eth.c	2005-04-12 08:07:36.246301112 +0200
> @@ -668,7 +668,7 @@
>  	spin_lock_irq(&mp->lock);
>  
>  	err = request_irq(dev->irq, mv643xx_eth_int_handler,
> -			SA_INTERRUPT | SA_SAMPLE_RANDOM, dev->name, dev);
> +			SA_SHIRQ | SA_SAMPLE_RANDOM, dev->name, dev);
>  
>  	if (err) {
>  		printk(KERN_ERR "Can not assign IRQ number to MV643XX_eth%d\n",
> 
