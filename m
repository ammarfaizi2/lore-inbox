Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318020AbSIOLqp>; Sun, 15 Sep 2002 07:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318022AbSIOLqp>; Sun, 15 Sep 2002 07:46:45 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:2718 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S318020AbSIOLqo>; Sun, 15 Sep 2002 07:46:44 -0400
Date: Sun, 15 Sep 2002 07:51:39 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: David Howells <dhowells@redhat.com>
cc: arjanv@redhat.com, <dwmw2@redhat.com>, <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] per-interrupt stacks - try 2 
In-Reply-To: <15885.1031830472@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.44.0209150747510.19045-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Sep 2002, David Howells wrote:

> > per-CPU per-IRQ i mean, of course. It's a basic performance issue, on
> > SMP we do not want dirty IRQ stacks to bounce between CPUs ...
> 
> Do you have benchmarks or something to show that is this actually a
> _significant_ problem?

you need benchmarks to tell that pure per-IRQ stacks are bad for SMP
performance?

per-IRQ+per-CPU and pure per-CPU IRQ stacks should perform rougly equally
well on SMP - with per-CPU IRQ stacks having lower runtime setup cost.

> After all, unless you bind the interrupts to particular IRQs, loads of
> data - including the irq_desc[] table - are going to be bouncing too.

there's a difference between bouncing 1-2 cachelines and bouncing a *full,
dirtied stack*. The irq_desc[] bouncing is pretty much unavoidable (IRQs
do need some global state) - the stack bouncing is just plain stupid and
perfectly avoidable.

	Ingo

