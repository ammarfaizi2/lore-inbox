Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268192AbRGWLFm>; Mon, 23 Jul 2001 07:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268191AbRGWLFW>; Mon, 23 Jul 2001 07:05:22 -0400
Received: from juicer34.bigpond.com ([139.134.6.86]:7415 "EHLO
	mailin9.bigpond.com") by vger.kernel.org with ESMTP
	id <S268189AbRGWLFS>; Mon, 23 Jul 2001 07:05:18 -0400
Message-Id: <m15Obfk-000CD5C@localhost>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrea Arcangeli <andrea@suse.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7 softirq incorrectness. 
In-Reply-To: Your message of "Mon, 23 Jul 2001 01:34:16 +0200."
             <20010723013416.B23517@athlon.random> 
Date: Mon, 23 Jul 2001 19:06:40 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In message <20010723013416.B23517@athlon.random> you write:
> On Mon, Jul 23, 2001 at 06:44:10AM +1000, Rusty Russell wrote:
> > This current code is bogus.  Consider:
> > 	spin_lock_irqsave(flags);	
> > 	cpu_raise_softirq(this_cpu, NET_RX_SOFTIRQ);
> > 	spin_unlock_irqrestore(flags);
> 
> What kernel are you looking at? There's no such code in 2.4.7, the only

Oh, so it's only a trap *waiting* to happen.  That's OK then!

> The first netif_rx is required to run from interrupt handler (otherwise
> we should have executed cpu_raise_softirq and not
> __cpu_raise_softirq)

Aside: why does it do a local_irq_save() if it's always run from an
interrupt handler?

> I cannot see any problem.

Why not fix all the cases?  Why have this wierd secret rule that
cpu_raise_softirq() should not be called with irqs disabled?

Call me old-fashioned, but why not *fix* the problem, if you're going
to rewrite this code... again...

Rusty.
--
Premature optmztion is rt of all evl. --DK
