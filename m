Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267558AbUH2CD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267558AbUH2CD5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 22:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267565AbUH2CD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 22:03:57 -0400
Received: from gizmo10ps.bigpond.com ([144.140.71.20]:62592 "HELO
	gizmo10ps.bigpond.com") by vger.kernel.org with SMTP
	id S267558AbUH2CDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 22:03:53 -0400
Message-ID: <41313985.3050805@bigpond.net.au>
Date: Sun, 29 Aug 2004 12:03:49 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: spaminos-ker@yahoo.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin	and
 others)
References: <20040828015937.50607.qmail@web13902.mail.yahoo.com> <41312174.40707@bigpond.net.au> <1093739136.7078.1.camel@krustophenia.net> <1093740349.7078.13.camel@krustophenia.net>
In-Reply-To: <1093740349.7078.13.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Sat, 2004-08-28 at 20:25, Lee Revell wrote:
> 
>>On Sat, 2004-08-28 at 20:21, Peter Williams wrote:
>>
>>>spaminos-ker@yahoo.com wrote:
>>>
>>>>--- Peter Williams <pwil3058@bigpond.net.au> wrote:
>>
>>>>    -----------------
>>>> => started at: kernel_fpu_begin+0x21/0x60
>>>> => ended at:   _mmx_memcpy+0x131/0x180
>>>>=======>
>>>>00000001 0.000ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)
>>>>00000001 0.730ms (+0.730ms): sub_preempt_count (_mmx_memcpy)
>>>>00000001 0.730ms (+0.000ms): _mmx_memcpy (check_preempt_timing)
>>>>00000001 0.730ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)
>>>>
>>>
>>>As far as I can see sub_preempt_count() is part of the latency measuring 
>>>component of the voluntary preempt patch so, like you, I'm not sure 
>>>whether this report makes any sense.
>>
>>Is this an SMP machine?  There were problems with that version of the
>>voluntary preemption patches on SMP.  The latest version, Q3, should fix
>>these.
>>
> 
> 
> Hmm, after rereading the entire thread, I am not sure that voluntary
> preemption will help you here.  Voluntary preemption (and preemption in
> general) deals with the situation in which you have a high priority
> task, often the highest priority task on the system, that spends most of
> its time sleeping on some resource, and this task needs to run as soon
> as possible once it becomes runnable.  In that situation the scheduler
> doesn't have a very difficult decision, there is no question that it
> should run this task ASAP.  How long 'ASAP' is depends on how long it
> takes whatever task was running when our high priority task became
> runnable to yield the processor.  The scheduler has a very easy job
> here, there is only one right thing to do.  Also the intervals involved
> are very small, usually less than 1ms, whereas you are talking about a
> variance of several seconds.

My understanding is that it's a very occasional (every few hours) time 
out of several seconds not something with a variance of several seconds. 
  So it seems to fit the characteristics of the type of problem that you 
are hunting i.e. every now and then going through a (rarely exercised) 
code path that hogs the CPU for too long.  But, as you say, the time 
scales are radically different.

> 
> In the situation you describe, you have two tasks running at the same
> base priority, and the scheduler does not seem to be doing a good job
> balancing them.  This is a different situation, and much more dependent
> on the scheduling policy.

The mode in which the scheduler was being used had all priority fiddling 
(except promotion) turned off so the tasks should have been just round 
robinning with each other.  Also, the time outs are fairly rare (every 
few hours according to Nicolas's e-mail) and happen with several 
different schedulers (with ZAPHOD (the one being used by Nicolas) and 
Con's staircase schedulers having less problem than the vanilla 
scheduler) which is why I thought it might be something outside the 
scheduler.  Perhaps it's something outside the kernel?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

