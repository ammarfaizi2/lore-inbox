Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVFKTfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVFKTfq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 15:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVFKTfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 15:35:44 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:22986 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261772AbVFKTeb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 15:34:31 -0400
Date: Sat, 11 Jun 2005 21:34:13 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       sdietrich@mvista.com
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <20050611191654.GA22301@elte.hu>
Message-Id: <Pine.OSF.4.05.10506112123260.2917-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jun 2005, Ingo Molnar wrote:

> 
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > > The current soft-irq states only gives us better hard-irq latency but
> > > nothing else. I think the overhead runtime and the complication of the
> > > code is way too big for gaining only that. 
> > 
> > Interrupt response is massive, check the adeos vs. RT numbers . They 
> > did one test which was just interrupt latency.
> 
> the jury is still out on the accuracy of those numbers. The test had 
> RT_DEADLOCK_DETECT (and other -RT debugging features) turned on, which 
> mostly work with interrupts disabled. The other question is how were 
> interrupt response times measured.
> 
You would accept a patch where I made this stuff optional?

I have another problem:
I can't hide that my aim is to make task-latencies deterministic.
The worry is local_irq_disable() (and preempt_disable()). I can undefine
it and therefore find where it is used. I can then look at the code, make
it into raw_local_irq_disable() or try to make a lock.
In many cases the raw-irq disable is the best and simplest when I am only
worried about task-latencies. But now Daniel and Sven wants to use the
distingtion between raw_local_irq_disable() and local_irq_disable() to
make irqs fast. 
We do have a clash of notations. Any idea what to do? I mentioned
 local_
 raw_local_
 hard_local_

Would that work?


> 	Ingo

Esben

