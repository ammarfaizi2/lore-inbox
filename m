Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285861AbRLHHho>; Sat, 8 Dec 2001 02:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285866AbRLHHha>; Sat, 8 Dec 2001 02:37:30 -0500
Received: from [144.137.80.17] ([144.137.80.17]:56965 "EHLO wagner")
	by vger.kernel.org with ESMTP id <S285861AbRLHHhX>;
	Sat, 8 Dec 2001 02:37:23 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: dipankar@in.ibm.com
Cc: Andrew Morton <akpm@zip.com.au>, riel@conectiva.com.br, kiran@in.ibm.com,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Scalable Statistics Counters 
In-Reply-To: Your message of "Fri, 07 Dec 2001 18:22:14 +0530."
             <20011207182214.D15810@in.ibm.com> 
Date: Sat, 08 Dec 2001 18:38:09 +1100
Message-Id: <E16Cc3l-0001eR-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20011207182214.D15810@in.ibm.com> you write:
> On Thu, Dec 06, 2001 at 02:18:26PM +1100, Rusty Russell wrote:
> > On Wed, 05 Dec 2001 12:08:57 -0800
> > Andrew Morton <akpm@zip.com.au> wrote:
> > 
> > > http://www.zipworld.com.au/~akpm/linux/2.4/2.4.7/
> > 
> > Oops, guess I should have read this thread first (still catching up on mail
).
> > 
> > Please see my per-cpu patch (just posted under [PATCH] 2.5.1-pre5: per-cpu
> > areas), and my previous /proc patch.  Combining the two into convenient for
m
> > is left as an exercise for the reader...
> 
> Hi Rusty,
> 
> Your per-cpu area patch looks like a good solution with a very simple
> implementation. BTW, some OSes map the per-cpu data areas
> to the same virtual address for each CPU avoiding the per-cpu data
> array lookup. I am not sure if this really saves much, we are ourselves
> trying to understand the overhead of such array lookup with 
> statctrs. 

I'd be interested in the results: it'd certainly be neater.  Another
option would be to use the per-cpu region pointer where architectures
currently hold smp_processor_id(), and derive the current CPU from the
per-CPU area instead of vice versa.

> IIUC, we can declare statically allocated per-cpu data using 
> this allocator (kstat, apic_timer_irqs etc.). For things that
> are a part of dynamically allocated structure, we would still
> need to use a dynamic per-cpu allocator, right ?

Yep... Someone Else's Problem 8)

> Another interesting question is how we can load different
> per-cpu sections to different areas in memory. I would suspect
> that for NUMA, we would want to locate the per-cpu sections closest
> to the corresponding CPUs.

It could possibly be done with linker tricks in vmlinux.lds, and yes,
definitely worth doing.

> I couldn't find the /proc patch. Any pointers ?

Hmm... I'm working on a rewrite, but the interface should stay the
same:
	http://lists.insecure.org/linux-kernel/2001/Nov/0087.html

Cheers!
Rusty.
--
  Anyone who quotes me is an idiot. -- Rusty Russell.
