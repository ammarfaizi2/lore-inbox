Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316162AbSEJXRg>; Fri, 10 May 2002 19:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316163AbSEJXRf>; Fri, 10 May 2002 19:17:35 -0400
Received: from [195.63.194.11] ([195.63.194.11]:51206 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316162AbSEJXRe>; Fri, 10 May 2002 19:17:34 -0400
Message-ID: <3CDC4648.207@evision-ventures.com>
Date: Sat, 11 May 2002 00:14:32 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, irda-users@lists.sourceforge.net,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] : ir253_smc_msg.diff
In-Reply-To: <20020510154108.B14407@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Jean Tourrilhes napisa?:
> ir253_smc_msg.diff :
> ------------------
> 	        <Following patch from Jeff Snyder>
> 	o [CRITICA] Release the proper region and not NULL pointer
> 	o [FEATURE] Fix messages
> 
> 
> diff -u -p linux/drivers/net/irda/smc-ircc.d8.c linux/drivers/net/irda/smc-ircc.c
> --- linux/drivers/net/irda/smc-ircc.d8.c	Fri May  3 18:52:33 2002
> +++ linux/drivers/net/irda/smc-ircc.c	Fri May  3 18:54:44 2002
> @@ -10,6 +10,8 @@
>   * Modified by:   Dag Brattli <dag@brattli.net>
>   * Modified at:   Tue Jun 26 2001
>   * Modified by:   Stefani Seibold <stefani@seibold.net>
> + * Modified at:   Thur Apr 18 2002
> + * Modified by:   Jeff Snyder <je4d@pobox.com>
>   * 
>   *     Copyright (c) 2001      Stefani Seibold
>   *     Copyright (c) 1999-2001 Dag Brattli
> @@ -539,7 +541,7 @@ static int __init ircc_open(unsigned int
>  	if (ircc_irq < 255) {
>  		if (ircc_irq!=irq)
>  			MESSAGE("%s, Overriding IRQ - chip says %d, using %d\n",
> -				driver_name, self->io->irq, ircc_irq);
> +				driver_name, irq, ircc_irq);
>  		self->io->irq = ircc_irq;
>  	}
>  	else
> @@ -547,13 +549,13 @@ static int __init ircc_open(unsigned int
>  	if (ircc_dma < 255) {
>  		if (ircc_dma!=dma)
>  			MESSAGE("%s, Overriding DMA - chip says %d, using %d\n",
> -				driver_name, self->io->dma, ircc_dma);
> +				driver_name, dma, ircc_dma);
>  		self->io->dma = ircc_dma;
>  	}
>  	else
>  		self->io->dma = dma;
>  
> -	request_region(fir_base, CHIP_IO_EXTENT, driver_name);
> +	request_region(self->io->fir_base, CHIP_IO_EXTENT, driver_name);
>  
>  	/* Initialize QoS for this device */
>  	irda_init_max_qos_capabilies(&irport->qos);
> @@ -1191,10 +1193,9 @@ static int __exit ircc_close(struct ircc
>          outb(IRCC_CFGB_IR, iobase+IRCC_SCE_CFGB);
>  #endif
>  	/* Release the PORT that this driver is using */
> -	IRDA_DEBUG(0, __FUNCTION__ "(), releasing 0x%03x\n", 
> -		   self->io->fir_base);
> +	IRDA_DEBUG(0, __FUNCTION__ "(), releasing 0x%03x\n", iobase);

Should read:
   +     IRDA_DEBUG(0, "%s (), releasin.... ", __FUNCTION__,

due to the fact that newer versions of GCC will be more standard
aheren. Well the motivation is to coalesce all the places
where __FUNCTION__ is used in to one instance of the corresponding
string only.

>

