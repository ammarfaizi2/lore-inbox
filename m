Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932549AbVHIOSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbVHIOSO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 10:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbVHIOSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 10:18:13 -0400
Received: from fsmlabs.com ([168.103.115.128]:33250 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S932549AbVHIOSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 10:18:13 -0400
Date: Tue, 9 Aug 2005 08:22:53 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Tony Lindgren <tony@atomide.com>
cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org,
       tuukka.tikkanen@elektrobit.com, george@mvista.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
In-Reply-To: <20050808152008.GI28070@atomide.com>
Message-ID: <Pine.LNX.4.61.0508090818170.28588@montezuma.fsmlabs.com>
References: <200508031559.24704.kernel@kolivas.org> <20050805123754.GA1262@in.ibm.com>
 <20050808072600.GE28070@atomide.com> <20050808145421.GB4738@in.ibm.com>
 <20050808152008.GI28070@atomide.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2005, Tony Lindgren wrote:

> As far as I remember enabling AMD stop grant disconnects all cpus. This
> means the system won't be able to do any work until the dyntick timer
> interrupt wakes up the system.
> 
> > Both requirements (idling all CPUs together vs individually) I think
> > will make the patch more complex.  Are such systems (which require having to 
> > idle all CPUs together) pretty common that we have to care about?!
> 
> Probably all AMD SMP based systems? Somebody with better knowledge should
> verify this.

It would be the K7 only.

> > But that may be too late on some CPUs. If dyn_tick->skip = 100, all
> > CPUs skip 100 ticks. However some CPUs may have timers that need to be
> > service much before that.
> 
> Not in the current case, as the system is completely idle until some
> interrupt wakes up the system. Of course it would be different if you make
> it per-CPU.

I once did a weekend version of this with SMP support and for the PIT, i 
had the last cpu to enter idle turn reprogram the PIT. Unfortunately this 
means waiting for all processors and isn't as effective as a result.

> Well we need to be able to do various things in the idle loop depending on
> the length of the estimated sleep. For example, if next_timer_interrupt is
> 2 jiffies away, we cannot do much. But if next_timer_interrupt is 2 seconds
> away, we can idle pretty much all devices.
> 
> > > But in any case on P4 systems the APIC timer is not the bottleneck as
> > > stopping or reprogramming PIT also kills APIC. (This does not happen on P3
> > > systems). So the bottleneck most likely is the length of PIT.
> > 
> > On these systems, do you disabled APIC (dyntick=noapic)?
> 
> Yeah. It only seems to work on P3 systems.

Odd, does reprogramming the APIC at that point get it going again?

	Zwane

