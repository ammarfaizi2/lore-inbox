Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289260AbSAVKxQ>; Tue, 22 Jan 2002 05:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289270AbSAVKxG>; Tue, 22 Jan 2002 05:53:06 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:51217 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S289260AbSAVKxB>; Tue, 22 Jan 2002 05:53:01 -0500
Message-ID: <3C4D457C.4E5E2A14@loewe-komp.de>
Date: Tue, 22 Jan 2002 11:57:00 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <Pine.LNX.4.33.0201211418050.17139-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn schrieb:
> 
> > > > To me the benefit is clear enough: ASAP scheduling of IO threads, a
> > > > simple heuristic that improves both throughput and latency.
> > >
> > > I think of "benefit", perhaps naiively, in terms of something that can
> > > be measured or demonstrated rather than just announced.
> >
> > But you see why asap scheduling improves latency/throughput *in theory*,
> > don't you?
> 
> NO, IT DOES NOT. why can't you preempt-ophiles get that through your heads?
> 
>         eager scheduling is NOT optimal in general.
> 
> for instance, suppose my disk can only read a sector at a time.
> scheduling my sequentially-reading process to wake eagerly
> is most definitly PESSIMAL.  laziness is a cardinal virtue!
> this doesn't preclude heuristics to sometimes short-cut the laziness.
> 

Do you think there are no other benefits besides the scheduling latency in
a realtime system?

In a realtime system you want your event handling code (outside of the
interrupt handler [on Linux: bottom halves/tasklets/sorftirq?) get running 
on the CPU as fast as possible. Therefore a realtime kernel is often fully 
preemptible (well, there are always critical sections that has to disable 
interrupts).

So the time between the interrupt handler wanting to schedule a specific 
task/thread and the next scheduling decision is crucial, right? 

I have no hard numbers, but I can imagine that this can also lead to
better IO (in terms of latency AND IO throughput but with the cost of 
cpu cycles [user space CPU throughput]).

I don't know the Linux kernel good enough right now, but if you shorten
the scheduling latency: that could be a win for faster IO. But there's always
a tradeoff: if you spent too much time in scheduling decisions/preparations
the overhead eats the lower latency (especially if your mutexes have to deal
with priority inversion, giving a lock holder at least the same priority as
the lock contender for the period it holds the lock).
