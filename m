Return-Path: <linux-kernel-owner+w=401wt.eu-S1422940AbWLUKoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422940AbWLUKoU (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 05:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965207AbWLUKoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 05:44:20 -0500
Received: from office-abk.mandriva.com ([84.55.162.90]:4148 "EHLO
	office.mandriva.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965204AbWLUKoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 05:44:19 -0500
X-Greylist: delayed 768 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 05:44:19 EST
From: Arnaud Patard <apatard@mandriva.com>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>,
       pHilipp Zabel <philipp.zabel@gmail.com>,
       Ben Dooks <ben-linux@fluff.org>
Subject: Re: [patch 2.6.20-rc1 6/6] S3C2410 GPIO wrappers
Organization: Mandriva
References: <200611111541.34699.david-b@pacbell.net>
	<200612201304.03912.david-b@pacbell.net>
	<200612201314.19905.david-b@pacbell.net>
Date: Thu, 21 Dec 2006 11:33:11 +0100
In-Reply-To: <200612201314.19905.david-b@pacbell.net> (David Brownell's
	message of "Wed, 20 Dec 2006 13:14:18 -0800")
Message-ID: <m3ac1h7d3s.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(adding Ben Dooks as he's taking care of s3c24xx stuff)

David Brownell <david-b@pacbell.net> writes:


Note that I neither tested it nor build tested it. It's only remarks I
have when I read the code.


> Arch-neutral GPIO calls for S3C24xx.
>
> From: Philipp Zabel <philipp.zabel@gmail.com>
>
> Index: at91/include/asm-arm/arch-s3c2410/gpio.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ at91/include/asm-arm/arch-s3c2410/gpio.h	2006-12-19 02:05:52.000000000 -0800
> @@ -0,0 +1,65 @@
> +/*
> + * linux/include/asm-arm/arch-pxa/gpio.h

arch-pxa ? forgot to change it ? :)

> + *
> + * S3C2400 GPIO wrappers for arch-neutral GPIO calls

you meant S3C2410 ?

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

pxa again :(

> +
> +#include <asm/arch/pxa-regs.h>

That's annoying. include/asm-arm/arch-s3c2410/pxa-regs.h doesn't
exist. Lack of build testing ?

> +#include <asm/arch/irqs.h>

imho, this is not needed. The user who will use irq will add it in his
code anyway.

> +#include <asm/arch/hardware.h>
> +
> +#include <asm/errno.h>

Is it really needed ?

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
> +	s3c2410_gpio_cfgpin(gpio, S3C2410_GPIO_INPUT);
> +	return 0;
> +}
> +
> +static inline int gpio_direction_output(unsigned gpio)
> +{
> +	s3c2410_gpio_cfgpin(gpio, S3C2410_GPIO_OUTPUT);
> +	return 0;
> +}
> +
> +#define gpio_get_value(gpio)		s3c2410_gpio_getpin(gpio)
> +#define gpio_set_value(gpio,value)	s3c2410_gpio_setpin(gpio, value)
> +
> +#include <asm-generic/gpio.h>			/* cansleep wrappers */
> +
> +/* FIXME or maybe s3c2400_gpio_getirq() ... */
> +#define gpio_to_irq(gpio)		s3c2410_gpio_getirq(gpio)

imho, this should be fixed even if the s3c2400 is not 100% supported in
mainline.


Regards,
Arnaud

