Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318265AbSGXIBB>; Wed, 24 Jul 2002 04:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318266AbSGXIBB>; Wed, 24 Jul 2002 04:01:01 -0400
Received: from holomorphy.com ([66.224.33.161]:22928 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318265AbSGXIBB>;
	Wed, 24 Jul 2002 04:01:01 -0400
Date: Wed, 24 Jul 2002 01:03:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
       george anzinger <george@mvista.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] irqlock patch -G3. [was Re: odd memory corruptionin2.5.27?]
Message-ID: <20020724080329.GB25038@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>, Ingo Molnar <mingo@elte.hu>,
	Robert Love <rml@tech9.net>, george anzinger <george@mvista.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <3D3E1B66.F17D8B9E@zip.com.au> <Pine.LNX.4.44.0207240932430.2193-100000@localhost.localdomain> <3D3E5E80.EA769517@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D3E5E80.EA769517@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>> Code that relies on
>> cli/sti for atomicity should be pretty rare and limited, there's 1 known
>> case so far where it leads to bugs.

On Wed, Jul 24, 2002 at 01:00:00AM -0700, Andrew Morton wrote:
> Are you implying that all code which does spin_unlock() inside
> local_irq_disable() needs to be converted to use _raw_spin_unlock()?
> If so then, umm, ugh.  I hope that the debug check is working
> for CONFIG_PREEMPT=n.
> BTW, what is the situation with spin_unlock_irq[restore]()?  Seems
> that these will schedule inside local_irq_disable() quite a lot?

Since we're on the subject of preempt_schedule() being done at
inappropriate times, I'm seeing it being called and panicking the
machine before the per-cpu GDT, IDT, TSS, and LDT are loaded in
cpu_init() and suspect that may be a wee bit too early to be sane.


Cheers,
Bill
