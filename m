Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293180AbSBWTIk>; Sat, 23 Feb 2002 14:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293181AbSBWTIa>; Sat, 23 Feb 2002 14:08:30 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:36108 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S293180AbSBWTIL>;
	Sat, 23 Feb 2002 14:08:11 -0500
Date: Sat, 23 Feb 2002 12:06:48 -0700
From: yodaiken@fsmlabs.com
To: Robert Love <rml@tech9.net>
Cc: yodaiken@fsmlabs.com, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] only irq-safe atomic ops
Message-ID: <20020223120648.A1295@hq.fsmlabs.com>
In-Reply-To: <3C773C02.93C7753E@zip.com.au>, <1014444810.1003.53.camel@phantasy> <3C773C02.93C7753E@zip.com.au> <1014449389.1003.149.camel@phantasy> <3C774AC8.5E0848A2@zip.com.au> <20020223043815.B29874@hq.fsmlabs.com> <1014488408.846.806.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <1014488408.846.806.camel@phantasy>; from rml@tech9.net on Sat, Feb 23, 2002 at 01:20:06PM -0500
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2002 at 01:20:06PM -0500, Robert Love wrote:
> On Sat, 2002-02-23 at 06:38, yodaiken@fsmlabs.com wrote:
> 
> > So without preemption in the kernel
> > 	maybe 4 instructions: calculate cpuid, inc; all local no cache ping
> > 	code is easy to read and understand.
> > 
> > with preemption in the kernel
> > 	a design problem. a slippery synchronization issue that 
> > 	involves the characteristic preemption error - code that works
> > 	most of the time.
> 
> Or not.  The topic of this thread was a micro-optimization.  If we treat
> the variable as anything normal requiring synchronization under SMP, any
> of the standard solutions (atomic ops, etc.) work.  If we want to get

And cause cache ping, possible contention, ...

> fancy, we can disable preemption, use my atomic_irq ops, or just not
> care.

Right. Without preemption it is safe to do
	c = smp_get_cpuid();
       ...
        x = ++local_cache[c]
       ..

       y = ++different_local_cache[c];
      ..

With preemption this turns into a problem that is easier to solve
with a lock or by not having per-cpu caches in the first place -- 
eg by writing worse code. After all, those are just micro-optimizations
and a few percent here, a few percent there, nobody will notice it. -(



-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

