Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317434AbSGDQHq>; Thu, 4 Jul 2002 12:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317435AbSGDQHq>; Thu, 4 Jul 2002 12:07:46 -0400
Received: from pophost.cs.tamu.edu ([128.194.130.106]:27355 "EHLO cs.tamu.edu")
	by vger.kernel.org with ESMTP id <S317434AbSGDQHp>;
	Thu, 4 Jul 2002 12:07:45 -0400
Date: Thu, 4 Jul 2002 11:10:16 -0500 (CDT)
From: Xinwen - Fu <xinwenfu@cs.tamu.edu>
To: george anzinger <george@mvista.com>
cc: root@chaos.analogic.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel timers vs network card interrupt
In-Reply-To: <3D23FD5F.19C0DDDC@mvista.com>
Message-ID: <Pine.SOL.4.10.10207041109300.12365-100000@dogbert>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        In fact I want a timer (either in user level or kernel level).
This timer (hope it is a periodic timer) must expire at the interval that
I specify. For example, if I
want that the timer expires at 10ms, it should never be fired at
10.0000000001ms or
9.9999999999ms. That is the key part that I want!

        Have an idea?

        Thanks!

Xinwen Fu


On Thu, 4 Jul 2002, george anzinger wrote:

> "Richard B. Johnson" wrote:
> > 
> > On Wed, 3 Jul 2002, Xinwen - Fu wrote:
> > 
> > > Hi, all,
> > >       I'm curious that if a network card interrupt happens at the same
> > > time as the kernel timer expires, what will happen?
> > >
> > >       It's said the kernel timer is guaranteed accurate. But if
> > > interrupts are not masked off, the network interrupt also should get
> > > response when a kernel timer expires. So I don't know who will preempt
> > > who.
> > >
> > >       Thanks for information!
> > >
> > > Xinwen Fu
> > 
> > The highest priority interrupt will get serviced first. It's the timer.
> > Interrupts are serviced in priority-order. Hardware "remembers" which
> > ones are pending so none are lost if some driver doesn't do something
> > stupid.
> 
> That is true as far as it goes, HOWEVER, timers are serviced
> by bottom half code which is run at the end of the
> interrupt, WITH THE INTERRUPT SYSTEM ON.  Therefore, timer
> servicing can be interrupted by an interrupt and thus be
> delayed.
>  
> -- 
> George Anzinger   george@mvista.com
> High-res-timers: 
> http://sourceforge.net/projects/high-res-timers/
> Real time sched:  http://sourceforge.net/projects/rtsched/
> Preemption patch:
> http://www.kernel.org/pub/linux/kernel/people/rml
> 

