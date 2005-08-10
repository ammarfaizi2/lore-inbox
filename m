Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbVHJHqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbVHJHqv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 03:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbVHJHqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 03:46:51 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:35784 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S965036AbVHJHqu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 03:46:50 -0400
X-ORBL: [67.117.73.34]
Date: Wed, 10 Aug 2005 00:46:34 -0700
From: Tony Lindgren <tony@atomide.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org,
       tuukka.tikkanen@elektrobit.com, george@mvista.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Message-ID: <20050810074634.GA4140@atomide.com>
References: <200508031559.24704.kernel@kolivas.org> <20050805123754.GA1262@in.ibm.com> <20050808072600.GE28070@atomide.com> <20050808145421.GB4738@in.ibm.com> <20050808152008.GI28070@atomide.com> <Pine.LNX.4.61.0508090818170.28588@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508090818170.28588@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zwane Mwaikambo <zwane@arm.linux.org.uk> [050809 07:17]:
> On Mon, 8 Aug 2005, Tony Lindgren wrote:
> 
> > As far as I remember enabling AMD stop grant disconnects all cpus. This
> > means the system won't be able to do any work until the dyntick timer
> > interrupt wakes up the system.
> > 
> > > Both requirements (idling all CPUs together vs individually) I think
> > > will make the patch more complex.  Are such systems (which require having to 
> > > idle all CPUs together) pretty common that we have to care about?!
> > 
> > Probably all AMD SMP based systems? Somebody with better knowledge should
> > verify this.
> 
> It would be the K7 only.

OK, still quite a few systems.

> > > But that may be too late on some CPUs. If dyn_tick->skip = 100, all
> > > CPUs skip 100 ticks. However some CPUs may have timers that need to be
> > > service much before that.
> > 
> > Not in the current case, as the system is completely idle until some
> > interrupt wakes up the system. Of course it would be different if you make
> > it per-CPU.
> 
> I once did a weekend version of this with SMP support and for the PIT, i 
> had the last cpu to enter idle turn reprogram the PIT. Unfortunately this 
> means waiting for all processors and isn't as effective as a result.
> 
> > Well we need to be able to do various things in the idle loop depending on
> > the length of the estimated sleep. For example, if next_timer_interrupt is
> > 2 jiffies away, we cannot do much. But if next_timer_interrupt is 2 seconds
> > away, we can idle pretty much all devices.
> > 
> > > > But in any case on P4 systems the APIC timer is not the bottleneck as
> > > > stopping or reprogramming PIT also kills APIC. (This does not happen on P3
> > > > systems). So the bottleneck most likely is the length of PIT.
> > > 
> > > On these systems, do you disabled APIC (dyntick=noapic)?
> > 
> > Yeah. It only seems to work on P3 systems.
> 
> Odd, does reprogramming the APIC at that point get it going again?

Hmmm, might be worth trying.

Tony
