Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317537AbSGESr6>; Fri, 5 Jul 2002 14:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317538AbSGESr5>; Fri, 5 Jul 2002 14:47:57 -0400
Received: from clavin.cs.tamu.edu ([128.194.130.106]:45557 "EHLO cs.tamu.edu")
	by vger.kernel.org with ESMTP id <S317537AbSGESr4>;
	Fri, 5 Jul 2002 14:47:56 -0400
Date: Fri, 5 Jul 2002 13:50:30 -0500 (CDT)
From: Xinwen - Fu <xinwenfu@cs.tamu.edu>
To: george anzinger <george@mvista.com>
cc: root@chaos.analogic.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel timers vs network card interrupt
In-Reply-To: <3D2538AD.E255167C@mvista.com>
Message-ID: <Pine.SOL.4.10.10207051344120.21592-100000@dogbert>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
	Do you know if there are existing tools to test the network driver
latency (between time to start the interrupt handler (irq.c) and time to
start tasklet (bh))?

	Thanks!
Xinwen Fu


On Thu, 4 Jul 2002, george anzinger wrote:

> Xinwen - Fu wrote:
> > 
> >         In fact I want a timer (either in user level or kernel level).
> > This timer (hope it is a periodic timer) must expire at the interval that
> > I specify. For example, if I
> > want that the timer expires at 10ms, it should never be fired at
> > 10.0000000001ms or
> > 9.9999999999ms. That is the key part that I want!
> 
> 10 nines!  Lots of luck.  You need to spend a LOT more money
> than I have.  Cesium clocks may be able to do this, but not
> computers...
> 
> But first, please define "fire".  If you mean that the
> interrupt is generated at this rate, well we can do maybe  4
> or 5 nines.  If, on the other hand you mean "your timer
> function gets cpu cycles", I don't think you will find a
> machine that can do much better than one or 2 nines.  Even
> if the timer is the only interrupt, you still have interrupt
> off times and cache indeterminism to contend with.
> 
> If the idea is to to "tickle" some hardware with this
> signal, you will do better to not involve a computer in the
> link.
> 
> The utime project had some software that would schedule a
> timer tick early and then loop reading the TSC until the
> "exact" time.  This still has the problems of interrupts and
> cache misses, but it is probably the only way to approach
> what you want.  Nothing magic, you just figure the worst
> case latency and set your timer to expire early enough to be
> ahead of the appointed time.  Then you loop on the TSC
> waiting for your exact time.
> 
> -g
> > 
> >         Have an idea?
> > 
> >         Thanks!
> > 
> > Xinwen Fu
> > 
> > On Thu, 4 Jul 2002, george anzinger wrote:
> > 
> > > "Richard B. Johnson" wrote:
> > > >
> > > > On Wed, 3 Jul 2002, Xinwen - Fu wrote:
> > > >
> > > > > Hi, all,
> > > > >       I'm curious that if a network card interrupt happens at the same
> > > > > time as the kernel timer expires, what will happen?
> > > > >
> > > > >       It's said the kernel timer is guaranteed accurate. But if
> > > > > interrupts are not masked off, the network interrupt also should get
> > > > > response when a kernel timer expires. So I don't know who will preempt
> > > > > who.
> > > > >
> > > > >       Thanks for information!
> > > > >
> > > > > Xinwen Fu
> > > >
> > > > The highest priority interrupt will get serviced first. It's the timer.
> > > > Interrupts are serviced in priority-order. Hardware "remembers" which
> > > > ones are pending so none are lost if some driver doesn't do something
> > > > stupid.
> > >
> > > That is true as far as it goes, HOWEVER, timers are serviced
> > > by bottom half code which is run at the end of the
> > > interrupt, WITH THE INTERRUPT SYSTEM ON.  Therefore, timer
> > > servicing can be interrupted by an interrupt and thus be
> > > delayed.
> > >
> > > --
> > > George Anzinger   george@mvista.com
> > > High-res-timers:
> > > http://sourceforge.net/projects/high-res-timers/
> > > Real time sched:  http://sourceforge.net/projects/rtsched/
> > > Preemption patch:
> > > http://www.kernel.org/pub/linux/kernel/people/rml
> > >
> 
> -- 
> George Anzinger   george@mvista.com
> High-res-timers: 
> http://sourceforge.net/projects/high-res-timers/
> Real time sched:  http://sourceforge.net/projects/rtsched/
> Preemption patch:
> http://www.kernel.org/pub/linux/kernel/people/rml
> 

