Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264402AbUGHNE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264402AbUGHNE6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 09:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbUGHNEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 09:04:11 -0400
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:20382 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id S264402AbUGHNCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 09:02:14 -0400
Message-ID: <313680C9A886D511A06000204840E1CF08F42FE6@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'Peter Williams'" <pwil3058@bigpond.net.au>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Mike Galbraith'" <efault@gmx.de>, "'akpm@osdl.org'" <akpm@osdl.org>,
       "'rml@tech9.net'" <rml@tech9.net>, "'Ingo Molnar'" <mingo@elte.hu>,
       "'Con Kolivas'" <kernel@kolivas.org>, "'Elladan'" <elladan@eskimo.com>,
       "'Chris Siebenmann'" <cks@utcc.utoronto.ca>
Subject: RE:  Re: Maximum frequency of re-scheduling (minimum time quantum
	) que stio n
Date: Thu, 8 Jul 2004 09:01:20 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

>By freeing "time slice"s from their involvement in active/expired 
>priority array switching etc., the various single priority array 
>schedulers (e.g. Con Kolivas's staircase scheduler and my SPA "pb" and 
>"eb" schedulers) that are under development raise the possibility of 
>allowing the time slice for SCHED_RR tasks to be different to that of 
>ordinary tasks or even for it to be set separately for each SCHED_RR 
>task.  Whether this is desirable or not is another question.

IMHO (I am new in Linux),- if this functionality could be either optionally
configured at compile time or be optionally invokable at run time (or
combination of both) - why not to have it ? - this addition enhances choices
of scheduling,
which is good.

Is there a chance such functionality will make into Linux 2.6 as a patch (at
some later time) ?

By the way - what is the "mechanism" of decision making process (among Linux
kernel developers) on such things ?

Thanks,
Best Regards,
Alex
-----Original Message-----
From: Peter Williams [mailto:pwil3058@bigpond.net.au]
Sent: Monday, July 05, 2004 7:27 PM
To: Povolotsky, Alexander
Cc: 'linux-kernel@vger.kernel.org'; 'Mike Galbraith'
Subject: Re: Maximum frequency of re-scheduling (minimum time quantum)
que stio n


Povolotsky, Alexander wrote:
> Hello Mike,
> 
> Thanks for replying/answering !
> 
> 
>>but as noted, wakeup of higher priority 
>>threads can preempt current at (almost) any time, so a slice may be spread

>>over an indeterminate amount of time.  
> 
> 
> Mike - the part of my original question was - what is the minimum
"measure"
> (in time ticks or is fraction of the time tick ?) of that "(almost) any
time
> ? In another words, assuming what is the latency between the moment, when
> the higher priority process (or thread ) is becoming available  to run
(and
> assuming that "schedule()" system call is not explicitly called at that
time
> ...)and the moment when the scheduler STARTS (I am not including context
> switch time into the question here) the process of preemtion (start of the
> context switch). Is this time  settable (at compile time ) ? 
> 
> 
>>If you're looking for an interface into the scheduler that allows you to 
>>twiddle slice length 
> 
> 
> you mean at the run time (vs compile time), I assume ?
> 
> 
>>, there is none.
> 
> 
> Thanks,
> Alex(ander) Povolotsky
> 
> -----Original Message-----
> From: Mike Galbraith [mailto:efault@gmx.de]
> Sent: Monday, July 05, 2004 9:39 AM
> To: Povolotsky, Alexander
> Subject: Re: Maximum frequency of re-scheduling (minimum time quantum)
> questio n
> 
> 
> At 04:13 AM 7/5/2004 -0400, you wrote:
> 
>>Hello,
>>
>>In Linux 2.6 kernel, configured with SCHED_RR, - could rescheduling be set
>>to be attempted (and executed when appropriate) at EVERY CLOCK TICK, thus
>>allowing the "other" process/thread (if available and ready at the moment)
>>with the higher (highest at that time) priority or, otherwise, with the
> 
> same
> 
>>priority (the "next" process/thread in the same Round Robin queue, from
>>which the "current" process/thread was "picked" ) to preempt the "current"
>>process/thread ?
> 
> 
> Well, you _could_ set (albeit only at compile time) the maximum timeslice 
> to be 1 ms if you so desired, that would do the rapid round robin between 
> peer threads thing you want.  Note however, that this won't give you a 
> predictable 1 ms of cpu though, since a thread of higher priority, once 
> awakened, will preempt anything of lower priority, and repeatedly receive 
> renewed slices as long as it wants cpu and has not exhausted it's priority

> bonus... lower priority threads can starve.
> 
> 
>>If EVERY CLOCK TICK is not conceptually possible (please note, that I am
> 
> not
> 
>>claiming that frequent rescheduling is "good", I am just asking to what
>>measure it is possible ...) - then what is the minimum "rescheduling" time
>>quantum (measured in clock ticks) is settable/possible ?
>>
>>What is the default value (which I presume was chosen as "optimal" ?) ?
> 
> 
> Timeslices are normally 100ms, but as noted, wakeup of higher priority 
> threads can preempt current at (almost) any time, so a slice may be spread

> over an indeterminate amount of time.  Also note that SCHED_FIFO tasks 
> _have_ no slice, so queue rotation only happens at sleep time for this 
> class of tasks.
> 
> If you're looking for an interface into the scheduler that allows you to 
> twiddle slice length, there is none.

By freeing "time slice"s from their involvement in active/expired 
priority array switching etc., the various single priority array 
schedulers (e.g. Con Kolivas's staircase scheduler and my SPA "pb" and 
"eb" schedulers) that are under development raise the possibility of 
allowing the time slice for SCHED_RR tasks to be different to that of 
ordinary tasks or even for it to be set separately for each SCHED_RR 
task.  Whether this is desirable or not is another question.

If there is a genuine desire to experiment with such features let me 
know and I can produce an experimental scheduler with this functionality 
for you to play with?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
