Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWHQJ2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWHQJ2W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 05:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWHQJ2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 05:28:22 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:65294 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964774AbWHQJ2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 05:28:21 -0400
Date: Thu, 17 Aug 2006 10:28:11 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Fulghum <paulkf@microgate.com>, Lee Revell <rlrevell@joe-job.com>,
       Raphael Hertzog <hertzog@debian.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: How to avoid serial port buffer overruns?
Message-ID: <20060817092811.GA28474@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Paul Fulghum <paulkf@microgate.com>,
	Lee Revell <rlrevell@joe-job.com>,
	Raphael Hertzog <hertzog@debian.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20060816104559.GF4325@ouaza.com> <1155753868.3397.41.camel@mindpipe> <44E37095.9070200@microgate.com> <1155762739.7338.18.camel@mindpipe> <1155767066.2600.19.camel@localhost.localdomain> <20060816231033.GB12407@flint.arm.linux.org.uk> <1155806446.15195.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155806446.15195.42.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 10:20:46AM +0100, Alan Cox wrote:
> Ar Iau, 2006-08-17 am 00:10 +0100, ysgrifennodd Russell King:
> > MIDI uses its own driver - sound/drivers/serial-u16550.c.  My guess
> 
> How peculiar
> 
> > is there's something in the system starving interrupt servicing.
> > Serial is very sensitive to that, and increases in other system
> > latencies tends to have an adverse impact on serial.
> 
> I see no support for the 16650 specific bits in the driver, so that
> alone may be a problem ?

Huh?  16550 not 16650.  Did you miss this?

        outb(UART_FCR_ENABLE_FIFO       /* Enable FIFO's (if available) */
             | UART_FCR_CLEAR_RCVR      /* Clear receiver FIFO */
             | UART_FCR_CLEAR_XMIT      /* Clear transmitter FIFO */
             | UART_FCR_TRIGGER_4       /* Set FIFO trigger at 4-bytes */
        /* NOTE: interrupt generated after T=(time)4-bytes
         * if less than UART_FCR_TRIGGER bytes received
         */
             ,uart->base + UART_FCR);   /* FIFO Control Register */

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
