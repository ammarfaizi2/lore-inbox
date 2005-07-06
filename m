Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262531AbVGFWQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbVGFWQo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 18:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbVGFWQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 18:16:09 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:38326 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S262546AbVGFWPG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 18:15:06 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Wed, 6 Jul 2005 23:15:07 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507062200.08924.s0348365@sms.ed.ac.uk> <20050706210249.GA2017@elte.hu>
In-Reply-To: <20050706210249.GA2017@elte.hu>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rfFzCe6g1DZ1X1t"
Message-Id: <200507062315.07536.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_rfFzCe6g1DZ1X1t
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 06 Jul 2005 22:02, Ingo Molnar wrote:
> * Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > This is a completely unrelated question, but now we've got everything
> > under control.. how do I make "quiet" actually do something on the RT
> > patchset?
> >
> > Currently I flag it on the kernel cmdline, but I still get everything
> > spewed to my primary VT.
>
> do you have CONFIG_PRINTK_IGNORE_LOGLEVEL enabled perhaps?

Good idea, but nope. Find attached the config I'm using, and here's the output 
from /proc/cmdline:

[alistair] 23:07 [~] cat /proc/cmdline
BOOT_IMAGE=2.6.12rt ro root=301 acpi_sleep=s3_bios lapic quiet

[alistair] 23:07 [~] uname -r
2.6.12-RT-V0.7.51-06

What I see are the kernel messages pre-init not suppressed (like I think they 
should be with quiet) and spurious noise from usb, etc. as the system boots 
up. sysklogd starts up but the messages are still duplicated on the console.

Maybe my configuration is subtlely broken. Is anybody else experiencing this?

By the way, I've been hammering the machine with the RT fixups and so far I've 
only been able to get a ~50us maximum; everything seems to be working fine. 
Find attached a final trace with the minimum kernel options enabled to get 
it.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.

--Boundary-00=_rfFzCe6g1DZ1X1t
Content-Type: text/plain;
  charset="iso-8859-1";
  name="trace"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="trace"

preemption latency trace v1.1.4 on 2.6.12-RT-V0.7.51-06
--------------------------------------------------------------------
 latency: 54 us, #93/93, CPU#0 | (M:rt VP:0, KP:1, SP:1 HP:1 #P:1)
    -----------------
    | task: softirq-net-rx/-5 (uid:0 nice:-10 policy:0 rt_prio:0)
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
   <...>-3142  0dnh2    0us!: <5f6f696b> (<70747468>)
   <...>-3142  0dnh2    0us : __trace_start_sched_wakeup (try_to_wake_up)
   <...>-3142  0dnh2    0us : __trace_start_sched_wakeup <softirq--5> (69 0)
   <...>-3142  0dnh1    1us+: try_to_wake_up <softirq--5> (69 76)
   <...>-3142  0dnh.    4us : do_IRQ (c0117743 0 0)
   <...>-3142  0dnh.    5us : __local_irq_save (__do_IRQ)
   <...>-3142  0dnh1    5us+: mask_and_ack_8259A (__do_IRQ)
   <...>-3142  0dnh1   12us : preempt_schedule (__do_IRQ)
   <...>-3142  0dnh1   12us : redirect_hardirq (__do_IRQ)
   <...>-3142  0dnh.   13us : preempt_schedule (__do_IRQ)
   <...>-3142  0dnh.   13us : handle_IRQ_event (__do_IRQ)
   <...>-3142  0dnh.   14us : timer_interrupt (handle_IRQ_event)
   <...>-3142  0dnh1   14us : mark_offset_tsc (timer_interrupt)
   <...>-3142  0dnh1   16us : preempt_schedule (mark_offset_tsc)
   <...>-3142  0dnh1   16us : preempt_schedule (mark_offset_tsc)
   <...>-3142  0dnh1   16us : do_timer (timer_interrupt)
   <...>-3142  0dnh1   17us : update_process_times (timer_interrupt)
   <...>-3142  0dnh1   17us : account_system_time (update_process_times)
   <...>-3142  0dnh1   18us : update_mem_hiwater (update_process_times)
   <...>-3142  0dnh1   19us : run_local_timers (update_process_times)
   <...>-3142  0dnh1   19us : raise_softirq (update_process_times)
   <...>-3142  0dnh1   20us : rcu_check_callbacks (update_process_times)
   <...>-3142  0dnh1   21us : idle_cpu (rcu_check_callbacks)
   <...>-3142  0dnh1   21us : __tasklet_schedule (update_process_times)
   <...>-3142  0dnh1   21us : scheduler_tick (update_process_times)
   <...>-3142  0dnh1   22us : sched_clock (scheduler_tick)
   <...>-3142  0dnh1   22us : preempt_schedule (scheduler_tick)
   <...>-3142  0dnh1   23us : softlockup_tick (timer_interrupt)
   <...>-3142  0dnh.   23us : preempt_schedule (timer_interrupt)
   <...>-3142  0dnh1   24us : note_interrupt (__do_IRQ)
   <...>-3142  0dnh1   24us : end_8259A_irq (__do_IRQ)
   <...>-3142  0dnh1   25us+: enable_8259A_irq (__do_IRQ)
   <...>-3142  0dnh1   28us : preempt_schedule (__do_IRQ)
   <...>-3142  0dnh.   28us : preempt_schedule (__do_IRQ)
   <...>-3142  0dnh.   28us : local_irq_restore (__do_IRQ)
   <...>-3142  0dnh.   29us : irq_exit (do_IRQ)
   <...>-3142  0dnh1   29us : do_softirq (irq_exit)
   <...>-3142  0dnh1   29us : __local_irq_save (do_softirq)
   <...>-3142  0dnh1   30us : __do_softirq (do_softirq)
   <...>-3142  0dnh1   30us : trigger_softirqs (do_softirq)
   <...>-3142  0dnh1   30us : wakeup_softirqd (trigger_softirqs)
   <...>-3142  0dnh1   31us : wake_up_process (trigger_softirqs)
   <...>-3142  0dnh1   31us : try_to_wake_up (wake_up_process)
   <...>-3142  0dnh1   31us : activate_task (try_to_wake_up)
   <...>-3142  0dnh1   32us : sched_clock (activate_task)
   <...>-3142  0dnh1   32us : recalc_task_prio (activate_task)
   <...>-3142  0dnh1   33us : effective_prio (recalc_task_prio)
   <...>-3142  0dnh1   33us : activate_task <<...>-3> (69 4)
   <...>-3142  0dnh1   33us : enqueue_task (activate_task)
   <...>-3142  0dnh1   34us : __trace_start_sched_wakeup (try_to_wake_up)
   <...>-3142  0dnh1   34us : preempt_schedule (try_to_wake_up)
   <...>-3142  0dnh1   34us : try_to_wake_up <<...>-3> (69 76)
   <...>-3142  0dnh1   35us : preempt_schedule (try_to_wake_up)
   <...>-3142  0dnh1   35us : wake_up_process (trigger_softirqs)
   <...>-3142  0dnh1   36us : wakeup_softirqd (trigger_softirqs)
   <...>-3142  0dnh1   36us : wakeup_softirqd (trigger_softirqs)
   <...>-3142  0dnh1   36us : wake_up_process (trigger_softirqs)
   <...>-3142  0dnh1   36us : try_to_wake_up (wake_up_process)
   <...>-3142  0dnh1   37us : activate_task (try_to_wake_up)
   <...>-3142  0dnh1   37us : sched_clock (activate_task)
   <...>-3142  0dnh1   38us : recalc_task_prio (activate_task)
   <...>-3142  0dnh1   38us : effective_prio (recalc_task_prio)
   <...>-3142  0dnh1   38us : activate_task <<...>-7> (69 5)
   <...>-3142  0dnh1   38us : enqueue_task (activate_task)
   <...>-3142  0dnh1   39us : __trace_start_sched_wakeup (try_to_wake_up)
   <...>-3142  0dnh1   39us : preempt_schedule (try_to_wake_up)
   <...>-3142  0dnh1   39us : try_to_wake_up <<...>-7> (69 76)
   <...>-3142  0dnh1   40us : preempt_schedule (try_to_wake_up)
   <...>-3142  0dnh1   40us : wake_up_process (trigger_softirqs)
   <...>-3142  0dnh1   40us : local_irq_restore (do_softirq)
   <...>-3142  0dnh.   41us < (2097760)
   <...>-3142  0dn..   42us : preempt_schedule (try_to_wake_up)
   <...>-3142  0dn..   42us : wake_up_process (trigger_softirqs)
   <...>-3142  0dn..   43us : local_irq_restore (netif_rx)
   <...>-3142  0dn..   43us : get_sample_stats (netif_rx)
   <...>-3142  0dn..   43us : local_irq_restore (netif_rx)
   <...>-3142  0Dn..   44us : preempt_schedule (netif_rx)
   <...>-3142  0Dn..   44us : irqs_disabled (preempt_schedule)
   <...>-3142  0Dnh.   44us : __schedule (preempt_schedule)
   <...>-3142  0Dnh.   45us : profile_hit (__schedule)
   <...>-3142  0Dnh1   45us : sched_clock (__schedule)
   <...>-3142  0Dnh2   46us : dequeue_task (__schedule)
   <...>-3142  0Dnh2   46us : recalc_task_prio (__schedule)
   <...>-3142  0Dnh2   47us : effective_prio (recalc_task_prio)
   <...>-3142  0Dnh2   47us : enqueue_task (__schedule)
softirq--5     0Dnh2   49us : __switch_to (__schedule)
softirq--5     0Dnh2   50us : __schedule <<...>-3142> (76 69)
softirq--5     0Dnh2   50us : finish_task_switch (__schedule)
softirq--5     0Dnh1   51us : trace_stop_sched_switched (finish_task_switch)
softirq--5     0Dnh2   51us : trace_stop_sched_switched <softirq--5> (69 0)
softirq--5     0Dnh2   52us : trace_stop_sched_switched (finish_task_switch)


vim:ft=help

--Boundary-00=_rfFzCe6g1DZ1X1t
Content-Type: application/x-gzip;
  name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config.gz"

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
OKnFcooAAA==

--Boundary-00=_rfFzCe6g1DZ1X1t--
