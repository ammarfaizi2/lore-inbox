Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318698AbSG0FU5>; Sat, 27 Jul 2002 01:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318699AbSG0FU5>; Sat, 27 Jul 2002 01:20:57 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:45264 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318698AbSG0FU4>;
	Sat, 27 Jul 2002 01:20:56 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [RFC] Scalable statistics counters using kmalloc_percpu 
Cc: linux-kernel@vger.kernel.org, lse <lse-tech@lists.sourceforge.net>,
       riel@conectiva.com.br
In-reply-to: Your message of "Fri, 26 Jul 2002 21:45:07 MST."
             <3D422553.6B126242@zip.com.au> 
Date: Sat, 27 Jul 2002 14:59:04 +1000
Message-Id: <20020727052524.C9A514279@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3D422553.6B126242@zip.com.au> you write:
> Good.  And will it be possible to iterate across all CPUs
> without having to iterate across NR_CPUS?

Hmm, define *all cpus* please?  All online cpus?  All possible CPUs?

Interface discussed with DaveM was: first_cpu(), next_cpu(cpu), which
covers online CPUs, and gives a nice interface for things like irq
balancers which want to snarf the next online cpu.

Like it?

> > Personally, I think that dynamically allocated per-cpu datastructures,
> > like dynamically-allocated brlocks, are something we might need
> > eventually, but look at what a certain driver did with the "make it
> > per-cpu" concept already.  I don't want to rush in that direction.
> 
> What driver is that?

NTFS.

> The is pretty much entirely wasted memory, and it will only get
> worse. Making NR_CPUS compile-time configurable is a lame solution.
> Wasting the memory is out of the question.
> 
> Dynamic allocation is the only thing left, yes?

Um, no!  Here is the plan:

1) change per-cpu data to only allocate data for cpus where
   cpu_possible(i) (add cache coloring and NUMA allocation as desired).

2) Convert non-modular cases to use per-cpu data (once the interface
   changes again, <SIGH>).

We'll end up using *less* memory than before.  We're just doing it in
easy stages.

Feel better now?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
