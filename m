Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTEVK1K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 06:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbTEVK1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 06:27:10 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:48369 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262694AbTEVK1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 06:27:08 -0400
Date: Thu, 22 May 2003 16:19:44 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Rusty Russell <rusty@au1.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, David Mosberger-Tang <davidm@hpl.hp.com>
Subject: Re: [PATCH 4/3] Replace dynamic percpu implementation
Message-ID: <20030522104944.GE27614@in.ibm.com>
References: <20030522081423.GC27614@in.ibm.com> <20030522083948.C7F4317DE5@ozlabs.au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030522083948.C7F4317DE5@ozlabs.au.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 06:36:31PM +1000, Rusty Russell wrote:
> In message <20030522081423.GC27614@in.ibm.com> you write:
> > 4. Extra dereferences in alloc_percpu were not significant, but alloc_percpu
> >    was interlaced and kmalloc_percpu_new wasn't.  Insn profile seemed to
> >    indicate extra cost in memory dereferencing of alloc_percpu was
> >    offset by the interlacing/objects sharing the same cacheline part.
> >    but then insn profiles are only indicative...not accurate.
> 
> Interesting: personally I consider the cacheline sharing a feature,
> and unless you've done something special, the static declaration
> should be interlaced too, no?

Yes, the static declartion was interlaced too. What I meant to say is that
cacheline sharing feature helped alloc_percpu/static percpu, compensate
for the small extra memory reference cost in getting __percpu_offset[]
when you compare with kmalloc_percpu_new.

>... 
> Aside: if kmalloc_percpu uses the per-cpu offset too, it probably
> makes sense to make the per-cpu offset to a first class citizen, and
> smp_processor_id to be derived, rather than the other way around as at
> the moment.  This would offer further speedup by removing a level of
> indirection.
> 
> If you're interested I can probably produce such a patch for x86...

Sure, it might help per-cpu data but will it cause performance
regression elsewhere? (other users of smp_processor_id).  I can run it 
through the same tests and find out.  Maybe it'll make good paper material 
for later? ;)


Thanks,
Kiran
