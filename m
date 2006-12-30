Return-Path: <linux-kernel-owner+w=401wt.eu-S1755137AbWL3PJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137AbWL3PJe (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 10:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755139AbWL3PJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 10:09:33 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4117 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755137AbWL3PJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 10:09:33 -0500
Date: Sat, 30 Dec 2006 15:08:59 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, Nicolas Pitre <nico@cam.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>,
       Kevin Hilman <khilman@mvista.com>, Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.20-rc1 5/6] SA1100 GPIO wrappers
Message-ID: <20061230150859.GA23170@flint.arm.linux.org.uk>
Mail-Followup-To: pHilipp Zabel <philipp.zabel@gmail.com>,
	David Brownell <david-b@pacbell.net>, Nicolas Pitre <nico@cam.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Andrew Victor <andrew@sanpeople.com>,
	Bill Gatliff <bgat@billgatliff.com>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Kevin Hilman <khilman@mvista.com>, Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <200612291821.44675.david-b@pacbell.net> <Pine.LNX.4.64.0612292141440.18171@xanadu.home> <200612292201.24989.david-b@pacbell.net> <74d0deb30612300559y144427ebi45518e8f2edfb14d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74d0deb30612300559y144427ebi45518e8f2edfb14d@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 30, 2006 at 02:59:39PM +0100, pHilipp Zabel wrote:
> --- linux-2.6.orig/arch/arm/mach-sa1100/generic.c	2006-12-27
> 21:50:03.000000000 +0100
> +++ linux-2.6/arch/arm/mach-sa1100/generic.c	2006-12-30 
> 14:50:42.000000000 +0100
> @@ -138,6 +138,36 @@
> 	return v;
> }
> 
> +int sa1100_gpio_direction_input(unsigned gpio)
> +{
> +        unsigned long flags;
> +
> +	if (gpio > GPIO_MAX)

Obvious space/tab confusion.  Please use a consistent indentation style.

> +		return -EINVAL;
> +
> +        local_irq_save(flags);

Ditto.

> +	GPDR &= ~GPIO_GPIO(gpio);
> +        local_irq_restore(flags);

Ditto.

> +	return 0;
> +}
> +
> +EXPORT_SYMBOL(sa1100_gpio_direction_input);
> +
> +int sa1100_gpio_direction_output(unsigned gpio)
> +{
> +        unsigned long flags;

Ditto.

> +
> +	if (gpio > GPIO_MAX)
> +		return -EINVAL;
> +
> +        local_irq_save(flags);

Ditto.

> +	GPDR |= GPIO_GPIO(gpio);
> +        local_irq_restore(flags);

Ditto.


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
