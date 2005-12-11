Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbVLKXpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbVLKXpR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 18:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbVLKXpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 18:45:17 -0500
Received: from ozlabs.org ([203.10.76.45]:45953 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750916AbVLKXpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 18:45:15 -0500
Subject: Re: Semantics of smp_mb() [was : Re: [PATCH] Fix RCU race in
	access of nohz_cpu_mask ]
From: Rusty Russell <rusty@rustcorp.com.au>
To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
Cc: vatsa@in.ibm.com, Oleg Nesterov <oleg@tv-sign.ru>,
       linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200512111621.20365.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
References: <439889FA.BB08E5E1@tv-sign.ru> <439B24A7.E2508AAE@tv-sign.ru>
	 <20051211174114.GA4883@in.ibm.com>
	 <200512111621.20365.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 10:45:16 +1100
Message-Id: <1134344716.5937.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-11 at 16:21 -0500, Andrew James Wade wrote:
> On Sunday 11 December 2005 12:41, Srivatsa Vaddagiri wrote:
> > [Changed the subject line to be more generic in the interest of wider audience]
> > 
> > We seem to be having some confusion over the exact semantics of smp_mb().
> > 
> > Specifically, are all stores preceding smp_mb() guaranteed to have finished
> > (committed to memory/corresponding cache-lines on other CPUs invalidated) 
> > *before* successive loads are issued?
> 
> I doubt it. That's definitely not true of smp_wmb(), which boils down to
> __asm__ __volatile__ ("": : :"memory") on SMP i386 (which the constrains
> how the compiler orders write instructions, but is otherwise a nop. i386
> has in-order writes.).
> 
> And it makes sense that wmb() wouldn't wait for writes: RCU needs
> constraints on the order in which writes become visible, but has very week
> constraints on when they do. Waiting for writes to flush would hurt
> performance.

On the contrary.  I did some digging and asking and thinking about this
for the Unreliable Guide to Kernel Locking, years ago:

wmb() means all writes preceeding will complete before any writes
following are started.
rmb() means all reads preceeding will complete before any reads
following are started.
mb() means all reads and writes preceeding will complete before any
reads and writes following are started.

This does not map to all the possibilities, nor does it take advantage
of all architectures, but it's generally sufficient without getting
insanely complex.

Hope that clarifies,
Rusty.
-- 
 ccontrol: http://ozlabs.org/~rusty/ccontrol

