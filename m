Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318702AbSG0GEs>; Sat, 27 Jul 2002 02:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318704AbSG0GEs>; Sat, 27 Jul 2002 02:04:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6924 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318702AbSG0GEr>;
	Sat, 27 Jul 2002 02:04:47 -0400
Message-ID: <3D423AAB.CEA61067@zip.com.au>
Date: Fri, 26 Jul 2002 23:16:11 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org, lse <lse-tech@lists.sourceforge.net>,
       riel@conectiva.com.br
Subject: Re: [RFC] Scalable statistics counters using kmalloc_percpu
References: Your message of "Fri, 26 Jul 2002 21:45:07 MST."
	             <3D422553.6B126242@zip.com.au> <20020727052524.C9A514279@lists.samba.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> In message <3D422553.6B126242@zip.com.au> you write:
> > Good.  And will it be possible to iterate across all CPUs
> > without having to iterate across NR_CPUS?
> 
> Hmm, define *all cpus* please?  All online cpus?  All possible CPUs?

All possible.

> Interface discussed with DaveM was: first_cpu(), next_cpu(cpu), which
> covers online CPUs, and gives a nice interface for things like irq
> balancers which want to snarf the next online cpu.
> 
> Like it?

	for (cpu = first_cpu(); cpu != (what?); cpu = next_cpu(cpu))

that'll work.
 
> ...
> 
> > The is pretty much entirely wasted memory, and it will only get
> > worse. Making NR_CPUS compile-time configurable is a lame solution.
> > Wasting the memory is out of the question.
> >
> > Dynamic allocation is the only thing left, yes?
> 
> Um, no!  Here is the plan:
> 
> 1) change per-cpu data to only allocate data for cpus where
>    cpu_possible(i) (add cache coloring and NUMA allocation as desired).
> 
> 2) Convert non-modular cases to use per-cpu data (once the interface
>    changes again, <SIGH>).
> 
> We'll end up using *less* memory than before.  We're just doing it in
> easy stages.
> 
> Feel better now?

Yup.

-
