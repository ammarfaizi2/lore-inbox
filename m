Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbTLMDRX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 22:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263221AbTLMDRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 22:17:22 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:11395
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263166AbTLMDRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 22:17:20 -0500
Date: Fri, 12 Dec 2003 22:16:24 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [DOCUMENTATION] Revised Unreliable Kernel Locking Guide
In-Reply-To: <20031212193559.GA1614@us.ibm.com>
Message-ID: <Pine.LNX.4.58.0312122203090.23752@montezuma.fsmlabs.com>
References: <20031212052812.E80972C085@lists.samba.org> <20031212193559.GA1614@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few comments on top of Paul's and another seperate one;

On Fri, 12 Dec 2003, Paul E. McKenney wrote:

> o	Hardware Interrupt / Hardware IRQ: How does in_irq()
> 	know that interrupts have been blocked?  The local_irq_disable()
> 	does not seem to mess with the counter, and preempt_disable()
> 	just does the standard inc/dec stuff...
>
> 	o	in_irq() is hardirq_count().
> 	o	hardirq_count() is (preempt_count() & HARDIRQ_MASK).
> 	o	preempt_count is an integer, HARDIRQ_MASK is a constant that
> 		is out of the normal inc/dec range.
>
> 	I see how an interrupt handler causes in_irq() to do its thing
> 	via the irq_enter() and irq_exit() macros, but I don't see how
> 	masking interrupts makes this happen.
>
> 	Probably just my confusion, but...
>
> 	Ditto for "in_interrupt()".  That would be for both the
> 	analysis and the probable confusion on my part.

I'd have to agree, it would require OR'ing with irqs_disabled(). And
another addendum would be that in_interrupt() also returns true when in a
softirq handler.

>
> o	Software Interrupt / softirq: formatting botch "of'software".
> 	This would be "o'software", right?
>
> o	Preemption: Would it be worth changing the first bit
> 	of the second sentence to read something like: "In 2.5.4
> 	and later, when CONFIG_PREEMPT is set, this changes:"?

I think he could also add that local_irq_disable() also disables
preemption implicitely.

User Context
The kernel executing on behalf of a particular process (ie. a system
call or trap) or kernel thread. You can tell which process with the
current() macro.) Not to be confused with userspace. Can be interrupted by
software or hardware interrupts.

Small nit, it's 'current'
