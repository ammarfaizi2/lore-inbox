Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263020AbUGFEtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbUGFEtK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 00:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbUGFEtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 00:49:10 -0400
Received: from gizmo08ps.bigpond.com ([144.140.71.18]:8363 "HELO
	gizmo08ps.bigpond.com") by vger.kernel.org with SMTP
	id S263020AbUGFEtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 00:49:01 -0400
Message-ID: <40E9E3AA.9090002@bigpond.net.au>
Date: Tue, 06 Jul 2004 09:26:34 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Mike Galbraith'" <efault@gmx.de>
Subject: Re: Maximum frequency of re-scheduling (minimum time quantum) que
 stio n
References: <313680C9A886D511A06000204840E1CF08F42FD4@whq-msgusr-02.pit.comms.marconi.com>
In-Reply-To: <313680C9A886D511A06000204840E1CF08F42FD4@whq-msgusr-02.pit.comms.marconi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
> Mike - the part of my original question was - what is the minimum "measure"
> (in time ticks or is fraction of the time tick ?) of that "(almost) any time
> ? In another words, assuming what is the latency between the moment, when
> the higher priority process (or thread ) is becoming available  to run (and
> assuming that "schedule()" system call is not explicitly called at that time
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

