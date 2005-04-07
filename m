Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262372AbVDGBmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbVDGBmI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 21:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbVDGBmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 21:42:08 -0400
Received: from bay10-f59.bay10.hotmail.com ([64.4.37.59]:51611 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262372AbVDGBl5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 21:41:57 -0400
Message-ID: <BAY10-F593A133679EB2005D70E1FD93E0@phx.gbl>
X-Originating-IP: [68.62.239.65]
X-Originating-Email: [getarunsri@hotmail.com]
From: "Arun Srinivas" <getarunsri@hotmail.com>
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: scheduler/SCHED_FIFO behaviour
Date: Thu, 07 Apr 2005 07:11:56 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 07 Apr 2005 01:41:56.0642 (UTC) FILETIME=[FB980020:01C53B12]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not sure if my question was clear enough or I couldnt interpret you 
answer correctly.(If it was the case I apologise for that).

My question is, as I said I am measuring the schedule time difference 
between my 2 of my SCHED_FIFO process in schedule() .But, I get only one set 
of readings (i.e., schedule() is being called once which implies my process 
is being scheduled only once and run till completion)

Also, as I said my interrupts are being processed during this time.I 
inspected /proc/interrupts for this.So, my question was if interrupts heve 
been processed several times the 2 SCHED_FIFO process which has been 
interrupted must have been resecheduled several times and for this upon 
returning from the interrupt handler the schedule() function must have been 
called  several times to schedule the 2 process which were running.But, as I 
said I get only one reading??

>From your reply, I come to understand that when an interrupt interrupts my 
user process.....it runs straight way ....but upon return from the interrupt 
handler does it not call schedule() to again resume my interrupted process? 
Please help.

Thanks
arun



>From: Steven Rostedt <rostedt@goodmis.org>
>To: Arun Srinivas <getarunsri@hotmail.com>
>CC: juhl-lkml@dif.dk, LKML <linux-kernel@vger.kernel.org>
>Subject: Re: scheduler/SCHED_FIFO behaviour
>Date: Mon, 04 Apr 2005 23:33:05 -0400
>
>On Tue, 2005-04-05 at 07:46 +0530, Arun Srinivas wrote:
>
> >
> > So, what I want from the above code is whenever process1 or process2 is
> > being scheduled measure the time and print the timedifference. But, when 
>I
> > run my 2 processes as SCHED_FIFO processes i get only one set of
> > readings....indicating they have been scheduled only once and run till
> > completion.
> >
> > But, as we saw above if interrupts have been processed they must have 
>been
> > scheduled several times(i.e., schedule() called several times). Is my
> > measurement procedure not correct?
>
>No! Interrupts are not scheduled. When an interrupt goes off, the
>interrupt service routine (ISR) is executed. It doesn't need to be
>scheduled. It runs right where it interrupted the CPU. That's why you
>need to be careful about protecting data that ISRs manipulate with
>spin_lock_irqsave. This not only protects against multiple CPUs, but
>turns off interrupts so that an interrupt wont be called and one of the
>ISRs modify the data you need to be atomic.
>
>Your tasks are running and will be interrupted by an ISR, on return from
>the routine, a check is made to see if your tasks should be preempted.
>But since they are the highest running tasks and in FIFO mode, the check
>determines that schedule should not be called.  So you will not see any
>schedules while your tasks are running.
>
>Now, if you where running Ingo's RT patch with PREEMPT_HARDIRQ enabled,
>and your tasks were of lower priority than the ISR thread handlers, then
>you would see the scheduling. Maybe that is what you want?
>
>-- Steve
>
>

_________________________________________________________________
Send money to India 
http://ads.mediaturf.net/event.ng/Type=click&FlightID=17307&AdID=44925&TargetID=9763&Targets=9763&Values=414,868,1093,2385&Redirect=http:%2F%2Fwww.icicibanknripromotions.com%2Fm2i_feb%2Fnri_M2I_feb.jsp%3Fadid%3D44925%26siteid%3D1093%26flightid%3D17307 
Get a FREE 30 minute India Calling Card.

