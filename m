Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVFKTar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVFKTar (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 15:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVFKTaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 15:30:46 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:8957 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261772AbVFKTaO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 15:30:14 -0400
Subject: Re: [PATCH] local_irq_disable removal
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.OSF.4.05.10506111851240.2917-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10506111851240.2917-100000@da410.phys.au.dk>
Content-Type: text/plain
Date: Sat, 11 Jun 2005 12:29:00 -0700
Message-Id: <1118518141.5593.8.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-11 at 19:16 +0200, Esben Nielsen wrote:
> On Sat, 11 Jun 2005, Sven-Thorsten Dietrich wrote:
> 
> > On Sat, 2005-06-11 at 16:32 +0200, Esben Nielsen wrote:
> > 
> > > > > The more I think about it the more dangerous I think it is. What does 
> > > > > local_irq_disable() protect against? All local threads as well as 
> > > > > irq-handlers. If these sections keeped mutual exclusive but preemtible 
> > > > > we will not have protected against a irq-handler.
> > > >  
> > The more Dangerous you perieve it to be. Can you point to real damage?
> > After all this is experimental code.
> > 
> > > That is exactly my point: We can't make a per-cpu mutex to replace
> > > local_irq_disable(). We have to make real lock for each subsystem now
> > > relying on local_irq_disable(). A global lock will not work. We could have
> > > a temporary lock all non-RT can share but that would be a hack similar to
> > > BKL.
> > > 
> > 
> > Why do we need any of this?
> 
> If we want deterministic task-latencies without worrying about
> proof-reading the code of every subsystem which might be using
> local_irq_disable() in some non-deterministic way, we need to make another
> locking mechanism.

Why would you want to encourage oddball approaches to driver
development? 

If a driver is causing problems this way, it should be looked at from a
design perspective, because that sort of coding style usually causes
problems with SMP as well.

> > 
> > > The current soft-irq states only gives us better hard-irq latency but
> > > nothing else. I think the overhead runtime and the complication of the
> > > code is way too big for gaining only that. 
> > 
> > 
> > Real numbers please, not speculation! Science, not religion.
> > 
> Well, isn't enough to see that the code contains more instructions and
> looks somewhat more complicated?
> 

It clarifies design aspects of the kernel, and identifies code that has
different behavior assumptions associated with it, than other code that
disables IRQs.  Its a good thing to separate that out, because then you
know what you are looking at, rather than having to assume it.


