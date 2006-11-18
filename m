Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755972AbWKREdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755972AbWKREdr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 23:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755959AbWKREdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 23:33:47 -0500
Received: from mx2.rowland.org ([192.131.102.7]:55314 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1755972AbWKREdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 23:33:46 -0500
Date: Fri, 17 Nov 2006 23:33:45 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc: Jens Axboe <jens.axboe@oracle.com>, Linus Torvalds <torvalds@osdl.org>,
       Thomas Gleixner <tglx@timesys.com>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>,
       David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, <manfred@colorfullife.com>, <oleg@tv-sign.ru>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
In-Reply-To: <20061118003859.GG2632@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0611172318180.8754-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006, Paul E. McKenney wrote:

> > Perhaps a better approach to the initialization problem would be to assume 
> > that either:
> > 
> >     1.  The srcu_struct will be initialized before it is used, or
> > 
> >     2.  When it is used before initialization, the system is running
> > 	only one thread.
> 
> Are these assumptions valid?  If so, they would indeed simplify things
> a bit.

I don't know.  Maybe Andrew can tell us -- is it true that the kernel runs 
only one thread up through the time the core_initcalls are finished?

If not, can we create another initcall level that is guaranteed to run 
before any threads are spawned?

> For the moment, I cheaped out and used a mutex_trylock.  If this can block,
> I will need to add a separate spinlock to guard per_cpu_ref allocation.

I haven't looked at your revised patch yet...  But it's important to keep 
things as simple as possible.

> Hmmm...  How to test this?  Time for the wrapper around alloc_percpu()
> that randomly fails, I guess.  ;-)

Do you really want things to continue in a highly degraded mode when 
percpu allocation fails?  Maybe it would be better just to pass the 
failure back to the caller.

Alan Stern

