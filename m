Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317665AbSFRXSL>; Tue, 18 Jun 2002 19:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317668AbSFRXSK>; Tue, 18 Jun 2002 19:18:10 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:30447 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317665AbSFRXSK>;
	Tue, 18 Jun 2002 19:18:10 -0400
Message-ID: <3D0FBF99.C0A8AD5B@mvista.com>
Date: Tue, 18 Jun 2002 16:17:45 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Replace timer_bh with tasklet
References: <Pine.LNX.4.44.0206172104450.1164-100000@home.transmeta.com> <3D0F76E4.AC6EA257@mvista.com> <20020619004652.D2079@linux-m68k.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Zidlicky wrote:
> 
> On Tue, Jun 18, 2002 at 11:07:32AM -0700, george anzinger wrote:
> 
> >
> > I reasoned that the timers, unlike most other I/O, directly drive the system.
> > For example, the time slice is counted down by the timer BH.  By pushing the
> > timer out to ksoftirqd, running at nice 19, you open the door to a compute
> > bound task running over its time slice (admittedly this should be caught on
> > the next interrupt).
> 
> I have had some problems with timers delayed up to 0.06s in 2.4 kernels,
> could that be this problem?
> 
It could be.  Depends on what was going on at the time.  In most cases, however,
the next interrupt should cause a call to softirq and thus run the timer list.  This
would seem to indicate at 20ms delay at most (first call busys softirq thru a 10ms tick
followed by recovery at the next tick).
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
