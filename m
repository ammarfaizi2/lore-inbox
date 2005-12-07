Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbVLGXqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbVLGXqM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 18:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbVLGXqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 18:46:11 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34833 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964899AbVLGXqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 18:46:10 -0500
Date: Wed, 7 Dec 2005 23:46:04 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dave Jones <davej@redhat.com>, Xavier Bestel <xavier.bestel@free.fr>,
       Jason Dravet <dravet@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: wrong number of serial port detected
Message-ID: <20051207234603.GQ6793@flint.arm.linux.org.uk>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Xavier Bestel <xavier.bestel@free.fr>,
	Jason Dravet <dravet@hotmail.com>, linux-kernel@vger.kernel.org
References: <20051207155034.GB6793@flint.arm.linux.org.uk> <BAY103-F32F90C9849D407E9336826DF430@phx.gbl> <20051207211551.GL6793@flint.arm.linux.org.uk> <1133990886.6184.2.camel@bip.parateam.prv> <20051207213128.GM6793@flint.arm.linux.org.uk> <20051207213856.GN6793@flint.arm.linux.org.uk> <20051207230302.GD22690@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207230302.GD22690@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 06:03:02PM -0500, Dave Jones wrote:
> Ok, how about something along the lines of this (completely untested) patch,
> which adds a runtime param to lower the number of registered ports,
> also allowing a default to be set for common cases.
> 
> Would something like this be acceptable ?

Sure, looks fine.  The new parameter should probably be documented
though, so folk know about it.

> @@ -2653,6 +2657,9 @@ module_param(share_irqs, uint, 0644);
>  MODULE_PARM_DESC(share_irqs, "Share IRQs with other non-8250/16x50 devices"
>  	" (unsafe)");
>  
> +module_param(nr_uarts, uint, 0644);
> +MODULE_PARM_DESC(nr_uarts, "Maximum number of UARTs supported.");

Should this help string include the compile-time maximum somehow?

What limits it to the compile-time maximum?

> diff -urpN --exclude-from=/home/devel/davej/.exclude vanilla/drivers/serial/Kconfig linux-2.6.14/drivers/serial/Kconfig
> --- vanilla/drivers/serial/Kconfig	2005-12-07 17:56:56.000000000 -0500
> +++ linux-2.6.14/drivers/serial/Kconfig	2005-12-07 17:53:34.000000000 -0500
> @@ -95,6 +100,15 @@ config SERIAL_8250_NR_UARTS
>  	  PCI enumeration and any ports that may be added at run-time
>  	  via hot-plug, or any ISA multi-port serial cards.
>  
> +config SERIAL_8250_RUNTIME_UARTS
> +	int "Number of 8250/16550 serial ports to register at runtime"
> +	depends on SERIAL_8250
> +	default "4"

Can this be restricted to a range of 1 to SERIAL_8250_UARTS ?

> +	help
> +	  Set this to the maximum number of serial ports you want
> +	  the kernel to register at boot time.  This can be overriden
> +	  with the parameter "nr_uarts".

And should we also give a pointer to the boot-time parameter (which
I think will be 8250.nr_uarts ?)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
