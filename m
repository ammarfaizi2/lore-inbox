Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317359AbSGDHob>; Thu, 4 Jul 2002 03:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317361AbSGDHoa>; Thu, 4 Jul 2002 03:44:30 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:19444 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317359AbSGDHo1>;
	Thu, 4 Jul 2002 03:44:27 -0400
Message-ID: <3D23FD5F.19C0DDDC@mvista.com>
Date: Thu, 04 Jul 2002 00:46:39 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Xinwen - Fu <xinwenfu@cs.tamu.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel timers vs network card interrupt
References: <Pine.LNX.3.95.1020703143207.1862A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Wed, 3 Jul 2002, Xinwen - Fu wrote:
> 
> > Hi, all,
> >       I'm curious that if a network card interrupt happens at the same
> > time as the kernel timer expires, what will happen?
> >
> >       It's said the kernel timer is guaranteed accurate. But if
> > interrupts are not masked off, the network interrupt also should get
> > response when a kernel timer expires. So I don't know who will preempt
> > who.
> >
> >       Thanks for information!
> >
> > Xinwen Fu
> 
> The highest priority interrupt will get serviced first. It's the timer.
> Interrupts are serviced in priority-order. Hardware "remembers" which
> ones are pending so none are lost if some driver doesn't do something
> stupid.

That is true as far as it goes, HOWEVER, timers are serviced
by bottom half code which is run at the end of the
interrupt, WITH THE INTERRUPT SYSTEM ON.  Therefore, timer
servicing can be interrupted by an interrupt and thus be
delayed.
 
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
