Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316615AbSGVNe4>; Mon, 22 Jul 2002 09:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315536AbSGVNe4>; Mon, 22 Jul 2002 09:34:56 -0400
Received: from mx1.elte.hu ([157.181.1.137]:13722 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S316615AbSGVNez>;
	Mon, 22 Jul 2002 09:34:55 -0400
Date: Mon, 22 Jul 2002 15:36:57 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@lst.de>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: [patch] remove-irqlock-2.5.27-D7
In-Reply-To: <20020722153000.A18763@lst.de>
Message-ID: <Pine.LNX.4.44.0207221529270.8547-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 Jul 2002, Christoph Hellwig wrote:

> > no, the on is not implicit at all. If you restore into a disabled state
> > then it will go from on to off.
> 
> well, for the normal use of it.  Okay, I give up, even if the nameing
> looks strange in the beginning is is consistant :)

it does precisely what it says:
	
    irq_off()           => turn local IRQs off

    irq_on()            => turn local IRQs on

    irq_save(flags)     => save the current IRQ state into flags. The 
                           state can be on or off. (on some 
                           architectures there's even more bits in it.)

    irq_save_off(flags) => save the current IRQ state into flags and 
                           disable interrupts.

    irq_restore(flags)  => restore the IRQ state from flags.

while it's true that 'normally' we save irq-enabled state, it's not at all
sure, eg. when nested irq_save() is done then the first flags will carry
an irqs-on bit, the other nested flags will carry an irqs-off flag - and
the nested irq_restore() will restore to irqs-off state.

this is how it has worked in the past 10 years or so.

but i've added this description to the cli-sti guide :-) Check out the -D7
patch:
 
  http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-D7

	Ingo

