Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266125AbUGEOSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266125AbUGEOSu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 10:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266126AbUGEOSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 10:18:50 -0400
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:30130 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id S266125AbUGEOSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 10:18:46 -0400
Message-ID: <313680C9A886D511A06000204840E1CF08F42FD4@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'Mike Galbraith'" <efault@gmx.de>
Subject: RE: Maximum frequency of re-scheduling (minimum time quantum) que
	stio n
Date: Mon, 5 Jul 2004 10:18:42 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mike,

Thanks for replying/answering !

>but as noted, wakeup of higher priority 
>threads can preempt current at (almost) any time, so a slice may be spread 
>over an indeterminate amount of time.  

Mike - the part of my original question was - what is the minimum "measure"
(in time ticks or is fraction of the time tick ?) of that "(almost) any time
? In another words, assuming what is the latency between the moment, when
the higher priority process (or thread ) is becoming available  to run (and
assuming that "schedule()" system call is not explicitly called at that time
...)and the moment when the scheduler STARTS (I am not including context
switch time into the question here) the process of preemtion (start of the
context switch). Is this time  settable (at compile time ) ? 

>If you're looking for an interface into the scheduler that allows you to 
>twiddle slice length 

you mean at the run time (vs compile time), I assume ?

> , there is none.

Thanks,
Alex(ander) Povolotsky

-----Original Message-----
From: Mike Galbraith [mailto:efault@gmx.de]
Sent: Monday, July 05, 2004 9:39 AM
To: Povolotsky, Alexander
Subject: Re: Maximum frequency of re-scheduling (minimum time quantum)
questio n


At 04:13 AM 7/5/2004 -0400, you wrote:
>Hello,
>
>In Linux 2.6 kernel, configured with SCHED_RR, - could rescheduling be set
>to be attempted (and executed when appropriate) at EVERY CLOCK TICK, thus
>allowing the "other" process/thread (if available and ready at the moment)
>with the higher (highest at that time) priority or, otherwise, with the
same
>priority (the "next" process/thread in the same Round Robin queue, from
>which the "current" process/thread was "picked" ) to preempt the "current"
>process/thread ?

Well, you _could_ set (albeit only at compile time) the maximum timeslice 
to be 1 ms if you so desired, that would do the rapid round robin between 
peer threads thing you want.  Note however, that this won't give you a 
predictable 1 ms of cpu though, since a thread of higher priority, once 
awakened, will preempt anything of lower priority, and repeatedly receive 
renewed slices as long as it wants cpu and has not exhausted it's priority 
bonus... lower priority threads can starve.

>If EVERY CLOCK TICK is not conceptually possible (please note, that I am
not
>claiming that frequent rescheduling is "good", I am just asking to what
>measure it is possible ...) - then what is the minimum "rescheduling" time
>quantum (measured in clock ticks) is settable/possible ?
>
>What is the default value (which I presume was chosen as "optimal" ?) ?

Timeslices are normally 100ms, but as noted, wakeup of higher priority 
threads can preempt current at (almost) any time, so a slice may be spread 
over an indeterminate amount of time.  Also note that SCHED_FIFO tasks 
_have_ no slice, so queue rotation only happens at sleep time for this 
class of tasks.

If you're looking for an interface into the scheduler that allows you to 
twiddle slice length, there is none.

         -Mike 
