Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262627AbVGMWJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbVGMWJT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 18:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbVGMWGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 18:06:36 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:222 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262717AbVGMWEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 18:04:10 -0400
Date: Wed, 13 Jul 2005 15:04:14 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Bill Huey <bhuey@lnxw.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, dipankar@in.ibm.com,
       rostedt@goodmis.org, shemminger@osdl.org, rusty@au1.ibm.com
Subject: Re: [RFC] RCU and CONFIG_PREEMPT_RT progress, part 3
Message-ID: <20050713220414.GF1304@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050713184800.GA1983@us.ibm.com> <20050713203554.GB27292@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713203554.GB27292@nietzsche.lynx.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 01:35:54PM -0700, Bill Huey wrote:
> On Wed, Jul 13, 2005 at 11:48:01AM -0700, Paul E. McKenney wrote:
> > 1.	Is use of spin_trylock() and spin_unlock() in hardirq code
> > 	(e.g., rcu_check_callbacks() and callees) a Bad Thing?
> > 	Seems to result in boot-time hangs when I try it, and switching
> > 	to _raw_spin_trylock() and _raw_spin_unlock() seems to work
> > 	better.  But I don't see why the other primitives hang --
> > 	after all, you can call wakeup functions in irq context in
> > 	stock kernels...
> 
> The implementation of "printk" does funky stuff like this so I'm assuming it's
> sort of acceptable.
> 
> Some of those function bypass latency tracing and preemption violation checks.
> Don't see a reason why you should be touching those functions unless you're
> going to modify implementation of spinlocks directly. Just use
> spinlock_t/raw_spinlock_t to take advantage of the type parametrics in Ingo's
> spinlock code to determine which lock you're using and you should be fine.

Using raw_spinlock_t along with spin_lock_irqsave() and friends does
seem to be working, thanks to both you and Steve for suggesting it!

							Thanx, Paul
