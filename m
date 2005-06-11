Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVFKXBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVFKXBE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 19:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVFKXBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 19:01:04 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:62454 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261171AbVFKXA4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 19:00:56 -0400
Subject: Re: [PATCH] local_irq_disable removal
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.OSF.4.05.10506112214240.2917-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10506112214240.2917-100000@da410.phys.au.dk>
Content-Type: text/plain
Date: Sat, 11 Jun 2005 15:59:40 -0700
Message-Id: <1118530780.5593.154.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-11 at 22:23 +0200, Esben Nielsen wrote:
> > 
> No because it correctly leaves irqs on but not preemption on. 
> 

I see your worries now. See below.

> > > The worry is local_irq_disable() (and preempt_disable()). I can undefine
> > > it and therefore find where it is used. I can then look at the code, make
> > > it into raw_local_irq_disable() or try to make a lock.
> > > In many cases the raw-irq disable is the best and simplest when I am only
> > > worried about task-latencies. But now Daniel and Sven wants to use the
> > > distingtion between raw_local_irq_disable() and local_irq_disable() to
> > > make irqs fast. 
> > 
> > We aim to make IRQ latencies deterministic. This affects preemption
> > latency in a positive way. 
> > 
> No. If you leave preemption off but irqs on, which is what is done here,
> you get good, deterministic IRQ latencies but nothing for task-latencies -
> actually slightly (unmeassureable I agree) worse due to the extra step
> you have to go from the physical interrupt to the task-switch is
> completed.
> 

If its unmeasurable, what is the BIG deal? Don't make me say again that
we need real data here.

> > Anywhere in the kernel that IRQs are disabled, preemption is impossible.
> > (you can't interrupt the CPU when irqs are disabled)
> > 
> For me it is the _same_ thing. Equally bad. If preemption is off I don't
> care if irqs are off. 
> 

So if its the same thing, why are you concerned with the improvement as
is?

> > But you said you are worried about overhead. You have to incur overhead
> > to make task response deterministic.
> > 
> > Are you sure you are not just trying to make it FAST?
> > 
> Certainly not. I was pressing for priority inheritance forinstance. That
> thing does certainly not make it fast, but it makes use of locks 
> deterministic.
> 

PI is already in there. I think you are missing some basic concepts here, 
for example that IRQs can happen ANYTIME, not just when we happen to enable 
interrupts where they have previously been disabled.

I am going to stop responding to this thread until you back up your concerns 
with real data, or throw some code out there, that you can back up with real data.

Regards,

Sven

