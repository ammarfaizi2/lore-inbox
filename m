Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261511AbSJURKA>; Mon, 21 Oct 2002 13:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261514AbSJURKA>; Mon, 21 Oct 2002 13:10:00 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:55512 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261511AbSJURJ6>; Mon, 21 Oct 2002 13:09:58 -0400
Subject: Re: [RFC][PATCH] linux-2.5.34_vsyscall_A0
From: john stultz <johnstul@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stephen Hemminger <shemminger@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Michael Hohnbaum <hbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       george anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1035206302.28189.95.camel@irongate.swansea.linux.org.uk>
References: <1034915132.1681.144.camel@cog> 
	<20021018111442.GH16501@dualathlon.random> 
	<1034957619.5401.8.camel@dell_ss3.pdx.osdl.net> 
	<1035206302.28189.95.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Oct 2002 10:15:57 -0700
Message-Id: <1035220560.26332.17.camel@laptop.cornchips.homelinux.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-21 at 06:18, Alan Cox wrote:
> On Fri, 2002-10-18 at 17:13, Stephen Hemminger wrote:
> > It would be great to rework the whole TSC time of day stuff to work with
> > per cpu data and allow unsychronized TSC's like NUMA. The problem is
> > that for fast user level access, there would need to be some way to find
> 
> The timer isnt even necessarily constant rate. The tsc is a nice tool
> for debugging. Using it as a clock was not in the long run brilliant.
> Don't try and continue it further, we have ACPI and HPET and other
> better solutions in upcoming PC hardware.

Yes, I also feel all this per-cpu TSC stuff is not the way to go (on top
of all this per-cpu mapping, etc. you'd also have to round-robin the
timer interrupt so each cpu has a last_tsc_low value, then if cpus are
varying in freq you have to recalc that occasionally. it just gets
messy.). The current vsyscall implementation uses the TSC because on 99%
of the boxes out there, the TSC is in sync and works fine as time source
(ie: normal gettimeofday uses it). On boxes that don't use the TSC, the
vsyscall shouldn't be mapped in until we have an alternate HPET(equv)
vsyscall solution. 

I'll see if I can clean that up later today. I also didn't mind Andrea's
suggestion for using a /proc entry to disable/check for vsyscalls, so I
might give that a whirl as well. 

thanks for all the feedback, everyone!
-john

