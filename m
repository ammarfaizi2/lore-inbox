Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbSIRGgY>; Wed, 18 Sep 2002 02:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265459AbSIRGgY>; Wed, 18 Sep 2002 02:36:24 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:31628 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S265457AbSIRGgX>;
	Wed, 18 Sep 2002 02:36:23 -0400
Date: Wed, 18 Sep 2002 08:40:22 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk, ak@suse.de,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com,
       anton.wilson@camotion.com
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
Message-ID: <20020918084022.A67562@ucw.cz>
References: <p73vg54tjpl.fsf@oldwotan.suse.de> <1032298092.20498.21.camel@irongate.swansea.linux.org.uk> <20020917.141806.49377410.davem@redhat.com> <200209171502.04524.jamesclv@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200209171502.04524.jamesclv@us.ibm.com>; from jamesclv@us.ibm.com on Tue, Sep 17, 2002 at 03:02:04PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2002 at 03:02:04PM -0700, James Cleverdon wrote:
> On Tuesday 17 September 2002 02:18 pm, David S. Miller wrote:
> >    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> >    Date: 17 Sep 2002 22:28:12 +0100
> >
> >    A bus clock - but things like the x440 have more than one bus clock. Its
> >    NUMA. Also the bus clock and rdtsc clock are different - rdtsc is
> >    dependant on the multiplier. Shove a celeron 300 and a celeron 450 in a
> >    BP6 board with tsc on and enjoy
> >
> > That's mostly my point.
> >
> > If the bus clocks differ, then great create some system wide crystal
> > oscillator.  That's a detail, the important bit is that you don't need
> > to go out to the system bus to read the tick value, it must be cpu
> > local to be effective and without serious performance impact.
> > -
> 
> It's more than just a detail.  Sequent's last NUMA system (_not_ the NUMA-Q;  
> never released) did exactly what you suggest.  The midplane card generated 
> the bus clock for all quad modules.  We had requested this feature because it 
> was such a pain dealing with clock drift between nodes in the OS.
> 
> The HW guys were able to give us synchronized bus clocks on a 16-way box, but 
> warned us that it would not be practical on the 256-way.  Too much clock skew 
> at those speeds, or something like that.  I suppose you could trade off 
> interconnect rate for clock sync, but then performance would suffer.
> 
> I don't know how Sun and SGI manage with their larger systems.  Either they 
> don't do clock sync, or they may have to make expensive tradeoffs.
> 
> Interestingly, Intel's IA64 manual does not guarantee that the CPU clock (and 
> thus its TSC register) has anything to do with the bus clock rate.  Maybe 
> they want to dabble with asynchronous logic or multiple clock domains in 
> future CPUs.

The point here is: You don't need a synchronized bus clock. You don't
need synchronized CPU clocks. You need a synchronized system-wide clock
that doesn't drive any bus or CPU, just a simple counter in every CPU
that you can read from inside the CPU. You can pull that pretty far and
to many CPUs. That's what I understand Sun does.

-- 
Vojtech Pavlik
SuSE Labs
