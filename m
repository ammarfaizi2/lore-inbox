Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318252AbSGWUpK>; Tue, 23 Jul 2002 16:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318253AbSGWUpK>; Tue, 23 Jul 2002 16:45:10 -0400
Received: from holomorphy.com ([66.224.33.161]:48013 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318252AbSGWUpJ>;
	Tue, 23 Jul 2002 16:45:09 -0400
Date: Tue, 23 Jul 2002 13:47:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: george anzinger <george@mvista.com>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: odd memory corruption in 2.5.27?
Message-ID: <20020723204745.GM919@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	george anzinger <george@mvista.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207231053190.32636-100000@linux-box.realnet.co.sz> <3D3DBD4B.4EFD3543@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D3DBD4B.4EFD3543@mvista.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 01:32:11PM -0700, george anzinger wrote:
> I just spent a month tracking down this issue.  It comes
> down to the slab allocater using per cpu data structures and
> protecting them with a combination of interrupt disables and
> spin_locks.  Preemption is allowed (incorrectly) if
> interrupts are off and preempt_count goes to zero on the
> spin_unlock.  I will wager that this is an SMP machine. 
> After the preemption interrupts will be on (schedule() does
> that) AND you could be on a different cpu.  Either of these
> is a BAD thing.
> The proposed fix is to catch the attempted preemption in
> preempt_schedule() and just return if the interrupt system
> is off.  (Of course there is more that this to it, but I do
> believe that the problem is known.  You could blow this
> assertion out of the water by asserting that the machine is
> NOT smp.)

I've been seeing the slab allocator race like mad already (i.e.
BUG at slab.c:1947 and slab.c:1961. I'll test this fix.


Thanks,
Bill
