Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbVK2Oue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbVK2Oue (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 09:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbVK2Oue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 09:50:34 -0500
Received: from mx1.suse.de ([195.135.220.2]:26538 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751361AbVK2Oud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 09:50:33 -0500
Date: Tue, 29 Nov 2005 15:50:22 +0100
From: Andi Kleen <ak@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       acpi-devel@lists.sourceforge.net, len.brown@intel.com,
       nando@ccrma.Stanford.EDU, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, kr@cybsft.com,
       tglx@linutronix.de, pluto@agmk.net, john.cooper@timesys.com,
       bene@linutronix.de, dwalker@mvista.com, trini@kernel.crashing.org,
       george@mvista.com, akpm@osdl.org
Subject: Re: [RFC][PATCH] Runtime switching of the idle function [take 2]
Message-ID: <20051129145022.GE19515@wotan.suse.de>
References: <20051124150731.GD2717@elte.hu> <1132952191.24417.14.camel@localhost.localdomain> <20051126130548.GA6503@elte.hu> <1133232503.6328.18.camel@localhost.localdomain> <20051128190253.1b7068d6.akpm@osdl.org> <1133235740.6328.27.camel@localhost.localdomain> <20051128200108.068b2dcd.akpm@osdl.org> <20051129064420.GA15374@elte.hu> <p73mzjngwim.fsf@verdi.suse.de> <1133273971.6328.49.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133273971.6328.49.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 09:19:31AM -0500, Steven Rostedt wrote:
> > And in practice the CPU will run so hot that only benchmarkers like it.
> 
> Why would it run hot?  What's the difference between polling and doing
> other things.  How many transistors does it take to poll?

It will prevent the CPU from going into sleep states and essentially
keep most of it enabled.  

> 
> > 
> > I think switching idle is the wrong way to do. We should rather
> > fix the various problems.
> > 
> > For fixing the TSC issue it is 100% the wrong approach Imho.
> 
> I would only say 80% the wrong approach, but that's me ;-)
> 
> > Basically software has to live with TSCs being unsynchronized
> > and gettimeofday should do the right thing (and if not it should be fixed)
> 
> I guess the biggest complaint most have is that the rdtsc _is_ the
> fastest way to read a clock.  If it isn't reliable, then what good is

It's the fastest way to read something which needs quite complex
knowledge to turn into a reliable clock value. In general only
the kernel has this knowledge. 

And gettimeofday is optimized to give you the fatest reliable
clock. 

> it?  It's unfortunate that Intel didn't solidify the clock usage. Yes,
> use HPET, or something else, but those are slower, and may not be on all
> systems.  Every system that I owned had a tsc but for critical systems
> it isn't up to par (what a shame).

Just use gettimeofday. It shields you from all that and when
the hardware supports it is quite fast too.

> > > system has been idle for some time. E.g. cpufreqd could sample idle time 
> > > and turn on/off idle=poll. High-performance setups could enable it all 
> > > the time.
> > 
> > And upgrade their server air condition or issue additional ear protection
> > to the desktop user? Most likely you will just drive the CPUs into
> > thermal throttle at some point with that, not get more performance anyways.
> 
> Again, what would make it so hot?  It is a waste of CPU cycles, and does
> waste energy that way, but does it really heat up the CPU that much?

Yes it does.

-Andi
