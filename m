Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbVFKTqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVFKTqX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 15:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVFKTqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 15:46:23 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:41212 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261807AbVFKTpo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 15:45:44 -0400
Subject: Re: [PATCH] local_irq_disable removal
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.OSF.4.05.10506112123260.2917-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10506112123260.2917-100000@da410.phys.au.dk>
Content-Type: text/plain
Date: Sat, 11 Jun 2005 12:44:26 -0700
Message-Id: <1118519067.5593.22.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-11 at 21:34 +0200, Esben Nielsen wrote:
> On Sat, 11 Jun 2005, Ingo Molnar wrote:
> 
> > 
> > * Daniel Walker <dwalker@mvista.com> wrote:
> > 
> > > > The current soft-irq states only gives us better hard-irq latency but
> > > > nothing else. I think the overhead runtime and the complication of the
> > > > code is way too big for gaining only that. 
> > > 
> > > Interrupt response is massive, check the adeos vs. RT numbers . They 
> > > did one test which was just interrupt latency.
> > 
> > the jury is still out on the accuracy of those numbers. The test had 
> > RT_DEADLOCK_DETECT (and other -RT debugging features) turned on, which 
> > mostly work with interrupts disabled. The other question is how were 
> > interrupt response times measured.
> > 
> You would accept a patch where I made this stuff optional?
> 

Daniel's original patch MADE it optional. Its just that the code is
apparently more complex looking that way, so its cleaner to do what Ingo
did.

> I have another problem:
> I can't hide that my aim is to make task-latencies deterministic.

Then this will help you.

> The worry is local_irq_disable() (and preempt_disable()). I can undefine
> it and therefore find where it is used. I can then look at the code, make
> it into raw_local_irq_disable() or try to make a lock.
> In many cases the raw-irq disable is the best and simplest when I am only
> worried about task-latencies. But now Daniel and Sven wants to use the
> distingtion between raw_local_irq_disable() and local_irq_disable() to
> make irqs fast. 

We aim to make IRQ latencies deterministic. This affects preemption
latency in a positive way. 

Anywhere in the kernel that IRQs are disabled, preemption is impossible.
(you can't interrupt the CPU when irqs are disabled)

But you said you are worried about overhead. You have to incur overhead
to make task response deterministic.

Are you sure you are not just trying to make it FAST?

But then - even if you do, this is still in your interest.

Let's wait for some numbers.

> We do have a clash of notations. Any idea what to do? I mentioned
>  local_

The following two are the same. The former is an earlier implementation,
and has been superseded by the latter. The former is NLA.
>  raw_local_
>  hard_local_

Sven


