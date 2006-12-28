Return-Path: <linux-kernel-owner+w=401wt.eu-S1754971AbWL1Url@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754971AbWL1Url (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 15:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754969AbWL1Url
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 15:47:41 -0500
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:22721 "HELO
	smtp114.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754968AbWL1Urj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 15:47:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=pjfAqAsZg6RXdSVJdxkycdZqEkGKPUpMQwniJyUDHQi+tJUupoupM4W50hgmBMBllTIQbJlmKHyT/De2FLshpASuWe4D2et9cihBF2807Zyvv0XQDGWyGmVRCbd1gg433VAWFAAEikgiTj+ZiP7WPmTNgyT4UCiqgnuJpYMrR/A=  ;
X-YMail-OSG: gDyu6wcVM1k4QM5uCAvzKBvgU6Fv6vFQc1JMb0qJfcSsCMtM5hxME1qOP9OQAeURbEQ4NfDa8CSCNIm1z1jLpWjyxX_kS4aDa9cY7WTx1xmgEp9fIKHhQAsRj_5RSLJ77ZMw7EDt.0R5d0k-
From: David Brownell <david-b@pacbell.net>
To: "pHilipp Zabel" <philipp.zabel@gmail.com>
Subject: Re: [patch 2.6.20-rc1 4/6] PXA GPIO wrappers
Date: Thu, 28 Dec 2006 12:47:36 -0800
User-Agent: KMail/1.7.1
Cc: "Nicolas Pitre" <nico@cam.org>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Andrew Victor" <andrew@sanpeople.com>,
       "Bill Gatliff" <bgat@billgatliff.com>,
       "Haavard Skinnemoen" <hskinnemoen@atmel.com>,
       "Kevin Hilman" <khilman@mvista.com>,
       "Russell King" <rmk@arm.linux.org.uk>,
       "Tony Lindgren" <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <Pine.LNX.4.64.0612211457390.18171@xanadu.home> <74d0deb30612212253s7d35cf92q80bbebe9d8ae9476@mail.gmail.com>
In-Reply-To: <74d0deb30612212253s7d35cf92q80bbebe9d8ae9476@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612281247.36869.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip:  is this the final version, then?  It's missing
a signed-off-by line, so I can't do anything appropriate.

Nico, your signoff here would be a Good Thing too if it
meets your technical review.  (My only comment, ISTR, was
that gpio_set_value macro should probably test for whether
the value is a constant too, not just the gpio pin.)

- Dave


On Thursday 21 December 2006 10:53 pm, pHilipp Zabel wrote:
> 
> Index: linux-2.6/include/asm-arm/arch-pxa/gpio.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6/include/asm-arm/arch-pxa/gpio.h	2006-12-21
> 20:07:48.000000000 +0100
> @@ -0,0 +1,82 @@
> +/*
> + * linux/include/asm-arm/arch-pxa/gpio.h
> + *
> + * PXA GPIO wrappers for arch-neutral GPIO calls
> + *
> + * Written by Philipp Zabel <philipp.zabel@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + *
> + */
> +
> +#ifndef __ASM_ARCH_PXA_GPIO_H
> +#define __ASM_ARCH_PXA_GPIO_H
> +
> +#include <asm/arch/pxa-regs.h>
> +#include <asm/arch/irqs.h>
> +#include <asm/arch/hardware.h>
> +
> +#include <asm/errno.h>
> +
> +static inline int gpio_request(unsigned gpio, const char *label)
> +{
> +	return 0;
> +}
> +
> +static inline void gpio_free(unsigned gpio)
> +{
> +	return;
> +}
> +
> +static inline int gpio_direction_input(unsigned gpio)
> +{
> +	return pxa_gpio_mode(gpio | GPIO_IN);
> +}
> +
> +static inline int gpio_direction_output(unsigned gpio)
> +{
> +	return pxa_gpio_mode(gpio | GPIO_OUT);
> +}
> +
> +static inline int __gpio_get_value(unsigned gpio)
> +{
> +	return GPLR(gpio) & GPIO_bit(gpio);
> +}
> +
> +#define gpio_get_value(gpio)			\
> +	(__builtin_constant_p(gpio) ?		\
> +	 __gpioe_get_value(gpio) :		\
> +	 pxa_gpio_get_value(gpio))
> +
> +static inline void __gpio_set_value(unsigned gpio, int value)
> +{
> +	if (value)
> +		GPSR(gpio) = GPIO_bit(gpio);
> +	else
> +		GPCR(gpio) = GPIO_bit(gpio);
> +}
> +
> +#define gpio_set_value(gpio,value)		\
> +	(__builtin_constant_p(gpio) ?		\
> +	 __gpio_set_value(gpio, value) :	\
> +	 pxa_gpio_set_value(gpio, value))
> +
> +#include <asm-generic/gpio.h>			/* cansleep wrappers */
> +
> +#define gpio_to_irq(gpio)	IRQ_GPIO(gpio)
> +#define irq_to_gpio(irq)	IRQ_TO_GPIO(irq)
> +
> +
> +#endif
> Index: linux-2.6/arch/arm/mach-pxa/generic.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-pxa/generic.c	2006-12-21
> 13:30:01.000000000 +0100
> +++ linux-2.6/arch/arm/mach-pxa/generic.c	2006-12-21 21:25:24.000000000 +0100
> @@ -36,6 +36,7 @@
>  #include <asm/mach/map.h>
> 
>  #include <asm/arch/pxa-regs.h>
> +#include <asm/arch/gpio.h>
>  #include <asm/arch/udc.h>
>  #include <asm/arch/pxafb.h>
>  #include <asm/arch/serial.h>
> @@ -105,13 +106,16 @@
>   * Handy function to set GPIO alternate functions
>   */
> 
> -void pxa_gpio_mode(int gpio_mode)
> +int pxa_gpio_mode(int gpio_mode)
>  {
>  	unsigned long flags;
>  	int gpio = gpio_mode & GPIO_MD_MASK_NR;
>  	int fn = (gpio_mode & GPIO_MD_MASK_FN) >> 8;
>  	int gafr;
> 
> +	if (gpio > PXA_LAST_GPIO)
> +		return -EINVAL;
> +
>  	local_irq_save(flags);
>  	if (gpio_mode & GPIO_DFLT_LOW)
>  		GPCR(gpio) = GPIO_bit(gpio);
> @@ -124,11 +128,33 @@
>  	gafr = GAFR(gpio) & ~(0x3 << (((gpio) & 0xf)*2));
>  	GAFR(gpio) = gafr |  (fn  << (((gpio) & 0xf)*2));
>  	local_irq_restore(flags);
> +
> +	return 0;
>  }
> 
>  EXPORT_SYMBOL(pxa_gpio_mode);
> 
>  /*
> + * Return GPIO level
> + */
> +int pxa_gpio_get_value(unsigned gpio)
> +{
> +	return __gpio_get_value(gpio);
> +}
> +
> +EXPORT_SYMBOL(pxa_gpio_get_value);
> +
> +/*
> + * Set output GPIO level
> + */
> +void pxa_gpio_set_value(unsigned gpio, int value)
> +{
> +	__gpio_set_value(gpio, value);
> +}
> +
> +EXPORT_SYMBOL(pxa_gpio_set_value);
> +
> +/*
>   * Routine to safely enable or disable a clock in the CKEN
>   */
>  void pxa_set_cken(int clock, int enable)
> Index: linux-2.6/include/asm-arm/arch-pxa/hardware.h
> ===================================================================
> --- linux-2.6.orig/include/asm-arm/arch-pxa/hardware.h	2006-12-21
> 13:30:01.000000000 +0100
> +++ linux-2.6/include/asm-arm/arch-pxa/hardware.h	2006-12-21
> 20:03:55.000000000 +0100
> @@ -65,7 +65,17 @@
>  /*
>   * Handy routine to set GPIO alternate functions
>   */
> -extern void pxa_gpio_mode( int gpio_mode );
> +extern int pxa_gpio_mode( int gpio_mode );
> +
> +/*
> + * Return GPIO level, nonzero means high, zero is low
> + */
> +extern int pxa_gpio_get_value(unsigned gpio);
> +
> +/*
> + * Set output GPIO level
> + */
> +extern void pxa_gpio_set_value(unsigned gpio, int value);
> 
>  /*
>   * Routine to enable or disable CKEN
> 
