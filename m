Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291480AbSBMJrY>; Wed, 13 Feb 2002 04:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291484AbSBMJrO>; Wed, 13 Feb 2002 04:47:14 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:63506 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S291480AbSBMJrA>; Wed, 13 Feb 2002 04:47:00 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-cpu areas 
In-Reply-To: Your message of "Tue, 12 Feb 2002 10:28:52 +0530."
             <20020212102852.I32236@in.ibm.com> 
Date: Wed, 13 Feb 2002 20:48:53 +1100
Message-Id: <E16aw22-0005wa-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020212102852.I32236@in.ibm.com> you write:
> > +static void __init setup_per_cpu_areas(void)
> > +{
> > +	unsigned long size, i;
> > +	char *ptr;
> > +	/* Created by linker magic */
> > +	extern char __per_cpu_start[], __per_cpu_end[];
> > +
> > +	/* Copy section for each CPU (we discard the original) */
> > +	size = ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES);
> > +	ptr = alloc_bootmem(size * NR_CPUS);
> 
> Would it be possible to free up NR_CPUS - smp_num_cpus worth of memory 
> after smp_init? .... 

Yes, but memory is cheap, and writing a special "partial free"
function for this is icky.  Maybe in 2 years when the per-cpu area is
100MB. 8)

We're better off reducing NR_CPUs to the maxmimum possible value of
smp_num_cpus() on that machine, IMHO.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
