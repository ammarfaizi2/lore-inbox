Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317865AbSFSMH0>; Wed, 19 Jun 2002 08:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317866AbSFSMHZ>; Wed, 19 Jun 2002 08:07:25 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:28807 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S317865AbSFSMHV>; Wed, 19 Jun 2002 08:07:21 -0400
Date: Wed, 19 Jun 2002 13:43:04 +0200
From: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
To: george anzinger <george@mvista.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Replace timer_bh with tasklet
Message-ID: <20020619134303.A1664@linux-m68k.org>
References: <Pine.LNX.4.44.0206172104450.1164-100000@home.transmeta.com> <3D0F76E4.AC6EA257@mvista.com> <20020619004652.D2079@linux-m68k.org> <3D0FBF99.C0A8AD5B@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D0FBF99.C0A8AD5B@mvista.com>; from george@mvista.com on Tue, Jun 18, 2002 at 04:17:45PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2002 at 04:17:45PM -0700, george anzinger wrote:
> Richard Zidlicky wrote:
> > 
> > On Tue, Jun 18, 2002 at 11:07:32AM -0700, george anzinger wrote:
> > 
> > >
> > > I reasoned that the timers, unlike most other I/O, directly drive the system.
> > > For example, the time slice is counted down by the timer BH.  By pushing the
> > > timer out to ksoftirqd, running at nice 19, you open the door to a compute
> > > bound task running over its time slice (admittedly this should be caught on
> > > the next interrupt).
> > 
> > I have had some problems with timers delayed up to 0.06s in 2.4 kernels,
> > could that be this problem?
> > 
> It could be.  Depends on what was going on at the time.  

I have generated high load to test how accurately my genrtc driver will 
work - it turned out that timers added with add_timer occassionally
get delayed by several jiffies. Results were much worse on IO bound 
load, especially IDE drives, CPU intensive userspace apps didn't appear 
to matter.

Using schedule_task() to poll the event seems to work without any 
problems.

> In most cases, however,
> the next interrupt should cause a call to softirq and thus run the timer list.  This
> would seem to indicate at 20ms delay at most (first call busys softirq thru a 10ms tick
> followed by recovery at the next tick).

this was also my impression after looking at the lowlevel interrupt
handling so I am really puzzled.

Richard
