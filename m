Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751606AbVJ1IHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbVJ1IHw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 04:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbVJ1IHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 04:07:52 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26384 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751606AbVJ1IHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 04:07:51 -0400
Date: Fri, 28 Oct 2005 09:07:45 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: John Bowler <jbowler@acm.org>
Cc: "'Deepak Saxena'" <dsaxena@plexity.net>, linux-kernel@vger.kernel.org,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: [PATCH] 2.6.14: NSLU2 machine support
Message-ID: <20051028080745.GG5044@flint.arm.linux.org.uk>
Mail-Followup-To: John Bowler <jbowler@acm.org>,
	'Deepak Saxena' <dsaxena@plexity.net>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.arm.linux.org.uk
References: <001501c5db94$40eca320$1001a8c0@kalmiopsis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001501c5db94$40eca320$1001a8c0@kalmiopsis>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 12:50:22AM -0700, John Bowler wrote:
> +static irqreturn_t nslu2_power_handler(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +	/* Signal init to do the ctrlaltdel action */
> +	kill_proc(1, SIGINT, 1);

There is a function in the kernel for doing this.  It's called
ctrl_alt_del().

> +static struct resource nslu2_uart_resources[] = {
> +	{
> +		.start		= IXP4XX_UART1_BASE_PHYS,
> +		.end		= IXP4XX_UART1_BASE_PHYS + 0x0fff,
> +		.flags		= IORESOURCE_MEM
> +	},
> +	{
> +		.start		= IXP4XX_UART2_BASE_PHYS,
> +		.end		= IXP4XX_UART2_BASE_PHYS + 0x0fff,
> +		.flags		= IORESOURCE_MEM
> +	}

Initialisers should generally end with a ',' irrespective of whether
you have a following entry or not.  It makes maintainence and/or adding
new entries easier.

> +static struct platform_device *nslu2_devices[] __initdata = {
> +	&nslu2_i2c_controller,
> +	&nslu2_flash,
> +	&nslu2_uart

Ditto.

> +MACHINE_START(NSLU2, "Linksys NSLU2")
> +	/* Maintainer: www.nslu2-linux.org */
> +	.phys_ram	= PHYS_OFFSET,
> +	.phys_io	= IXP4XX_PERIPHERAL_BASE_PHYS,
> +	.io_pg_offst	= ((IXP4XX_PERIPHERAL_BASE_VIRT) >> 18) & 0xFFFC,
> +	.boot_params	= 0x00000100,
> +	.map_io		= ixp4xx_map_io,
> +	.init_irq	= ixp4xx_init_irq, /* FIXME: all irq are off here */

What's that FIXME about?

> +        .timer          = &ixp4xx_timer,
> +	.init_machine	= nslu2_init,

Please consistently format the code.

PS, please also send ARM related stuff via the patch system.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
