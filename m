Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbTEWBdJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 21:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbTEWBdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 21:33:09 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:10743 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S263578AbTEWBcC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 21:32:02 -0400
From: Rusty Russell <rusty@au1.ibm.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       David Mosberger-Tang <davidm@hpl.hp.com>
Subject: Re: [PATCH 4/3] Replace dynamic percpu implementation 
In-reply-to: Your message of "Thu, 22 May 2003 16:19:44 +0530."
             <20030522104944.GE27614@in.ibm.com> 
Date: Fri, 23 May 2003 09:56:01 +1000
Message-Id: <20030523014454.AE3401A0F1@ozlabs.au.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030522104944.GE27614@in.ibm.com> you write:
> On Thu, May 22, 2003 at 06:36:31PM +1000, Rusty Russell wrote:
> > Interesting: personally I consider the cacheline sharing a feature,
> > and unless you've done something special, the static declaration
> > should be interlaced too, no?
> 
> Yes, the static declartion was interlaced too. What I meant to say is that
> cacheline sharing feature helped alloc_percpu/static percpu, compensate
> for the small extra memory reference cost in getting __percpu_offset[]
> when you compare with kmalloc_percpu_new.

Ah, thanks, that clarifies.  Sorry for my misread.

> > Aside: if kmalloc_percpu uses the per-cpu offset too, it probably
> > makes sense to make the per-cpu offset to a first class citizen, and
> > smp_processor_id to be derived, rather than the other way around as at
> > the moment.  This would offer further speedup by removing a level of
> > indirection.
> > 
> > If you're interested I can probably produce such a patch for x86...
> 
> Sure, it might help per-cpu data but will it cause performance
> regression elsewhere? (other users of smp_processor_id).

AFAICT, all the time-critical smp_processor_id() things are basically
for indexing into a per-cpu data array.  Even things like module.h and
percpu_counter.h would benifit from replacing those huge
inside-structure [NR_CPUS] arrays with a dynamic allocation.

> I can run it through the same tests and find out.  Maybe it'll make
> good paper material for later? ;)

I'll try to find time today or early next week.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
