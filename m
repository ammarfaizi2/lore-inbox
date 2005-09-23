Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbVIWPVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbVIWPVY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 11:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbVIWPVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 11:21:24 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:44162 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751080AbVIWPVX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 11:21:23 -0400
Date: Fri, 23 Sep 2005 08:21:41 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
Message-ID: <20050923152141.GA29941@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de> <Pine.LNX.4.61.0509201247190.3743@scrub.home> <1127342485.24044.600.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0509221816030.3728@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509221816030.3728@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 01:09:46AM +0200, Roman Zippel wrote:
> On Thu, 22 Sep 2005, Thomas Gleixner wrote:

[ . . . ]

> > > The main difference between them is that the latter is user 
> > > programmable. 
> > 
> > wallclock is reprogrammable too and it introduces a bunch of horrible
> > functions in posix-timers.c. grep for abs_list. I explained why its
> > horrible already.
> 
> I said _user_ programmable, wallclock time is usually NTP controlled.

I believe Thomas is concerned about workloads that need a short-term
stable timebase.  For example, a process-control application might need
to accurately measure a (say) 1500-millisecond time interval.  Both
user-programmability and NTP adjustments to a given timebase could
destroy the needed measurement accuracy.

Such a workload does not need the long-term tie to wallclock time that
NTP provides, but it does need the accurate short-term timekeeping that
NTP cannot provide -- NTP sacrifices short-term accuracy in order to
adjust the clock as needed to gain long-term stability.

Thomas, John, please jump in if I am missing the point here.

						Thanx, Paul
