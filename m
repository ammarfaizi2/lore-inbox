Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWDJVSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWDJVSk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 17:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWDJVSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 17:18:40 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13843 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751201AbWDJVSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 17:18:39 -0400
Date: Mon, 10 Apr 2006 22:18:00 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, starvik@axis.com, dev-etrax@axis.com
Subject: Re: [RFC: 2.6 patch] remove unused ide_init_default_hwifs()'s
Message-ID: <20060410211759.GA26732@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, starvik@axis.com, dev-etrax@axis.com
References: <20060410203950.GG2408@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060410203950.GG2408@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2006 at 10:39:50PM +0200, Adrian Bunk wrote:
> --- linux-2.6.17-rc1-mm2-full/include/asm-arm/arch-sa1100/ide.h.old	2006-04-10 21:15:04.000000000 +0200
> +++ linux-2.6.17-rc1-mm2-full/include/asm-arm/arch-sa1100/ide.h	2006-04-10 21:15:37.000000000 +0200
> @@ -49,28 +49,3 @@
>  		*irq = 0;
>  }
>  
> -/*
> - * This registers the standard ports for this architecture with the IDE
> - * driver.
> - */
> -static __inline__ void
> -ide_init_default_hwifs(void)
> -{
> -    if (machine_is_lart()) {
> -#ifdef CONFIG_SA1100_LART
> -        hw_regs_t hw;
> -
> -        /* Enable GPIO as interrupt line */
> -        GPDR &= ~LART_GPIO_IDE;
> -	set_irq_type(LART_IRQ_IDE, IRQT_RISING);
> -
> -        /* set PCMCIA interface timing */
> -        MECR = 0x00060006;
> -
> -        /* init the interface */
> -	ide_init_hwif_ports(&hw, PCMCIA_IO_0_BASE + 0x0000, PCMCIA_IO_0_BASE + 0x1000, NULL);
> -        hw.irq = LART_IRQ_IDE;
> -        ide_register_hw(&hw);
> -#endif
> -    }
> -}

NAK.  Waiting for the LART folk to get off their backsides and submit a
patch to do what's required.  Think of the above as merely documentation
for what's required.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
