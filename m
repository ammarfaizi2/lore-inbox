Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVFFI5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVFFI5r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 04:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVFFI5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 04:57:46 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:53217 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261237AbVFFI5n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 04:57:43 -0400
Date: Mon, 6 Jun 2005 10:57:12 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Daniel Walker <dwalker@mvista.com>, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch] Real-Time Preemption, plist fixes
In-Reply-To: <20050606073229.GA9143@elte.hu>
Message-Id: <Pine.OSF.4.05.10506061050050.4252-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2005, Ingo Molnar wrote:

> 
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> > Sorted lists works deterministicly O(1) on UP if no owner of the lock 
> > blocks while having the lock. On SMP or worse if an owner blocks in 
> > the lock, the wait list can grow very long. Thus insertion of new 
> > elements takes a long time - with preemption disabled :-(
> 
> the wait list can grow only as long as the max # of RT tasks is. Sorted 
> lists become 'O(1)' if we added some code that globally limits the 
> number of RT tasks to say 50. E.g. /proc/sys/kernel/max_nr_RT_tasks. A 
> user can override it if he needs more RT tasks. There can be an 
> arbitrary number of SCHED_OTHER tasks.
> 
> (note that on Linux there is a RAM-dependent 'max # of tasks' ulimit 
> which is never 'infinity', so theoretically the sorted lists are "O(1)" 
> too. But this is nitpicking.)
> 
> > If this is supposed to be used for user-space PI as well I would say 
> > it would have to be completely bounded, i.e. plists are certainly 
> > needed. [...]
> 
> yes, it's supposed to be used for user-space PI too. What do you mean by 
> 'completely bounded'. Do you consider the current worst-case O(100) 
> property of plists a 'completely bounded' solution?
> 
> i dont think fusyn's should be made available to non-RT tasks. If this 
> restriction is preserved then fusyn's would become O(max_nr_RT_tasks) 
> too.
> 

My pragmatic side agrees with you. My sense of beauty does not. I think
you make 2 small hacks here:
1) Adding a limit like above smells wrong.
2) Making PI only apply to RT tasks isn't beautifull either.

On the other hand the plists are "beautifull". It would sadden me if they
are thrown away.

As I said in an earlier mail, I think you should agree on an interface
between the rt_mutex code and list structure. Then Daniel can implement
and test his plist in user space, somebody else can implement and test
the sorted list in userspace and the transition can happen with a switch
of a macro and a recompilation.

I hope I will get some time to help out from next weekend. I am taking
exams right now.

> 	Ingo
> 

Esben

