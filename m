Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262738AbVGMUTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbVGMUTh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 16:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbVGMUTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 16:19:30 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:3714 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262787AbVGMUST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 16:18:19 -0400
Date: Wed, 13 Jul 2005 13:18:44 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, dipankar@in.ibm.com,
       shemminger@osdl.org, rusty@au1.ibm.com
Subject: Re: [RFC] RCU and CONFIG_PREEMPT_RT progress, part 3
Message-ID: <20050713201844.GE1304@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050713184800.GA1983@us.ibm.com> <1121281598.25810.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121281598.25810.14.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 03:06:38PM -0400, Steven Rostedt wrote:
> On Wed, 2005-07-13 at 11:48 -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > Ported to CONFIG_PREEMPT_RT, and it actually boots!  Running tests,
> 
> Good! :)

Hey, it even passed the touch-test (five kernbenches and an LTP).  Now
to start the torture tests...

> > working thus far.  But thought I would post the patch and get feedback
> > in the meantime, since I am not sure that my approach is correct.
> > The questions:
> > 
> > 1.	Is use of spin_trylock() and spin_unlock() in hardirq code
> > 	(e.g., rcu_check_callbacks() and callees) a Bad Thing?
> > 	Seems to result in boot-time hangs when I try it, and switching
> > 	to _raw_spin_trylock() and _raw_spin_unlock() seems to work
> > 	better.  But I don't see why the other primitives hang --
> > 	after all, you can call wakeup functions in irq context in
> > 	stock kernels...
> 
> I never use _raw_spin_*.  I just declare the lock as a raw_spinlock_t
> and the macro's determine to use them instead.  So I just keep the
> spin_lock in the code. Or do you mean that you get problems using the
> spin_locks when the code is already defined as raw_spinlock_t?

Wasn't aware of this possibility, will try it.  Thanks for the tip!

> > 2.	Is _raw_spin_lock_irqsave() intended for general use?  Its
> > 	API differs from that of spin_lock_irqsave(), so am wondering
> > 	if it is internal-use-only or something.  I currently
> > 	use it from process context to acquire locks shared with
> > 	rcu_check_callbacks().
> 
> I would assume not, but Ingo would be better at answering this.

Seems to work, FWIW.  ;-)

						Thanx, Paul
