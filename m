Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWGEIfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWGEIfi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 04:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWGEIfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 04:35:37 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63757 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932349AbWGEIfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 04:35:36 -0400
Date: Wed, 5 Jul 2006 09:35:24 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq: ARM dyntick cleanup
Message-ID: <20060705083524.GB543@flint.arm.linux.org.uk>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Christoph Hellwig <hch@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <1151885928.24611.24.camel@localhost.localdomain> <20060702173527.cbdbf0e1.akpm@osdl.org> <1151908178.24611.39.camel@localhost.localdomain> <20060703065735.GA19780@elte.hu> <20060704115425.GA2313@infradead.org> <20060704122231.GA2319@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060704122231.GA2319@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2006 at 02:22:31PM +0200, Ingo Molnar wrote:
> > > - rename asm/irq.h to asm/irqchips.h
> > 
> > Note that currently asm/irq.h is included all over.  
> 
> yeah, but only 335 times in drivers/*, so it's a 4 minute job to convert 
> them over. (ok, i just did it to check - it results in a 144K patch and 
> it took 50 seconds to do. I've attached the result.)

Note that ARM drivers generally require asm/irq.h by way of it defining
the IRQ numbers for the platform, so this patch moves the include of it
to linux/genirq.h.

Also note that including genirq.h (formerly irq.h) is broken for
architectures which don't yet use this stuff - it'll probably cause
compile failures because it wants asm/hw_irq.h.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
