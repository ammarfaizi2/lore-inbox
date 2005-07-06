Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262301AbVGGAXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbVGGAXK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbVGFUBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:01:02 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:12735 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S262334AbVGFQ4Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 12:56:24 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Wed, 6 Jul 2005 17:56:20 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <20050706162457.GA24728@elte.hu> <200507061737.18322.s0348365@sms.ed.ac.uk>
In-Reply-To: <200507061737.18322.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_00AzC1Ead3/f7x9"
Message-Id: <200507061756.20861.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_00AzC1Ead3/f7x9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 06 Jul 2005 17:37, Alistair John Strachan wrote:
[big snip]
> >
> > could you try the patch below (or the -51-05 patch that i just
> > uploaded), does it fix this latency?
> >
> > 	Ingo
>
> I'm beginning to understand the issue, and I see why you think the proposed
> patch fixes it. I'll compile and boot V0.7.51-05 now.

Indeed, this seems to have fixed it.

( softirq-timer/0-3    |#0): new 8 us maximum-latency wakeup.
( softirq-timer/0-3    |#0): new 9 us maximum-latency wakeup.
( softirq-timer/0-3    |#0): new 9 us maximum-latency wakeup.
( softirq-timer/0-3    |#0): new 9 us maximum-latency wakeup.
( softirq-timer/0-3    |#0): new 10 us maximum-latency wakeup.
( softirq-timer/0-3    |#0): new 14 us maximum-latency wakeup.

Find attached another trace (only 33us this time).

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.

--Boundary-00=_00AzC1Ead3/f7x9
Content-Type: text/plain;
  charset="iso-8859-1";
  name="trace3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="trace3"

preemption latency trace v1.1.4 on 2.6.12-RT-V0.7.51-05
--------------------------------------------------------------------
 latency: 38 us, #27/27, CPU#0 | (M:rt VP:0, KP:1, SP:1 HP:1 #P:1)
    -----------------
    | task: softirq-timer/0-3 (uid:0 nice:-10 policy:0 rt_prio:0)
    -----------------

                 _------=> CPU#            
                / _-----=> irqs-off        
               | / _----=> need-resched    
               || / _---=> hardirq/softirq 
               ||| / _--=> preempt-depth   
               |||| /                      
               |||||     delay             
   cmd     pid ||||| time  |   caller      
      \   /    |||||   \   |   /           
   <...>-3485  0dnh3    0us!: <6f6f726b> (<616d6974>)
   <...>-3485  0dnh3    1us : __trace_start_sched_wakeup (try_to_wake_up)
   <...>-3485  0dnh3    1us : __trace_start_sched_wakeup <softirq--3> (69 0)
   <...>-3485  0dnh2    2us : try_to_wake_up <softirq--3> (69 76)
   <...>-3485  0dnh1    2us : preempt_schedule (try_to_wake_up)
   <...>-3485  0dnh1    3us : wake_up_process (trigger_softirqs)
   <...>-3485  0dnh1    3us : local_irq_restore (do_softirq)
   <...>-3485  0Dnh1    4us+: preempt_schedule (do_softirq)
   <...>-3485  0Dnh.    7us : __schedule (work_resched)
   <...>-3485  0Dnh.    8us : profile_hit (__schedule)
   <...>-3485  0Dnh1    8us+: sched_clock (__schedule)
   <...>-3485  0Dnh2   12us : dequeue_task (__schedule)
   <...>-3485  0Dnh2   13us : recalc_task_prio (__schedule)
   <...>-3485  0Dnh2   13us : effective_prio (recalc_task_prio)
   <...>-3485  0Dnh2   13us : enqueue_task (__schedule)
   <...>-3485  0Dnh2   14us+: trace_array (__schedule)
   <...>-3485  0Dnh2   18us : trace_array <softirq--3> (69 6e)
   <...>-3485  0Dnh2   18us : trace_array <<...>-3485> (76 78)
   <...>-3485  0Dnh2   20us+: trace_array (__schedule)
softirq--3     0Dnh2   28us+: __switch_to (__schedule)
softirq--3     0Dnh2   31us : __schedule <<...>-3485> (76 69)
softirq--3     0Dnh2   31us : finish_task_switch (__schedule)
softirq--3     0Dnh1   32us : trace_stop_sched_switched (finish_task_switch)
softirq--3     0Dnh2   33us+: trace_stop_sched_switched <softirq--3> (69 0)
softirq--3     0Dnh2   35us : trace_stop_sched_switched (finish_task_switch)


vim:ft=help

--Boundary-00=_00AzC1Ead3/f7x9--
