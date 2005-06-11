Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVFKSmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVFKSmA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 14:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVFKSmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 14:42:00 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:25335 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261426AbVFKSlv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 14:41:51 -0400
Subject: Re: [PATCH] local_irq_disable removal
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: tglx@linutronix.de
Cc: Daniel Walker <dwalker@mvista.com>, Esben Nielsen <simlo@phys.au.dk>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1118510817.13312.88.camel@tglx.tec.linutronix.de>
References: <Pine.LNX.4.10.10506110930050.27294-100000@godzilla.mvista.com>
	 <1118510817.13312.88.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Date: Sat, 11 Jun 2005 11:40:36 -0700
Message-Id: <1118515236.9519.92.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-11 at 19:26 +0200, Thomas Gleixner wrote:
> On Sat, 2005-06-11 at 09:36 -0700, Daniel Walker wrote:
> > 
> > On Sat, 11 Jun 2005, Esben Nielsen wrote:
> > 
> > > For me it is perfectly ok if RCU code, buffer caches etc use
> > > raw_local_irq_disable(). I consider that code to be "core" code.
> > 
> > This distinction seem completly baseless to me. Core code doesn't
> > carry any weight . The question is , can the code be called from real
> > interrupt context ? If not then don't protect it.
> > 
> > > 
> > > The current soft-irq states only gives us better hard-irq latency but
> > > nothing else. I think the overhead runtime and the complication of the
> > > code is way too big for gaining only that. 
> > 
> > Interrupt response is massive, check the adeos vs. RT numbers . They did
> > one test which was just interrupt latency.
> 
> Performance on RT systems is more than IRQ latencies. 
> 
> The wide spread misbelief that 
>   "Realtime == As fast as possible" 
> 
> seems to be still stuck in peoples mind.
> 
>   "Realtime == As fast as specified"
> is the correct equation.
> 

I think Daniel was referring to the deviations, but it is always good to
point that out.

> There is always a tradeoff between interrupt latencies and other
> performance values, as you have to invent new mechanisms to protect
> critical sections. In the end, they can be less effective than the gain
> on irq latencies.
> 

Basically you are investing effort to maintain predictability. 

In order to do that, you somethimes have to put a stitch in before the
deadline ("in time..."), the effort increases the work = overhead. 

But if you look at overall time the tasks are waiting you can implement
optimal scheduling, and maximize throughput.

This is too complex to argue about here.

For every example I can find you a corner case.
 
It depends on the application, and you need to decide how to configure
our kernel if it really matters to what you are doing with Linux.

We are merely working to provide alternatives that improve performance.

Sven






