Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262514AbVFJI5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbVFJI5L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 04:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262521AbVFJI5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 04:57:11 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:14208 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S262514AbVFJI44
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 04:56:56 -0400
Date: Fri, 10 Jun 2005 10:56:33 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-Reply-To: <20050609121326.GB17414@elte.hu>
Message-Id: <Pine.OSF.4.05.10506101051100.5132-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does latency tracing work correctly?
After leaving my labtop "working" all night I see the /proc/latency_trace
below. It doesn't look right.  Normally the worst case latency is ~70 us
but this tells me it is 1.1ms!! Looking at the trace it looks like it was
really just < 70 us and just an error in the trace. It does look like 3
irq-off periods have been merged into one long period overestimating the
worst case latency by a huge factor.

Esben

preemption latency trace v1.1.4 on 2.6.12-rc6-RT-V0.7.48-04
--------------------------------------------------------------------
 latency: 1178 us, #121/121, CPU#0 | (M:rt VP:0, KP:1, SP:1 HP:1 #P:1)
    -----------------
    | task: ksoftirqd/0-2 (uid:0 nice:-10 policy:0 rt_prio:0)
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
automoun-9953  0dnh3    0us : <6f747561> (<6e756f6d>)
automoun-9953  0dnh3    0us : __trace_start_sched_wakeup (try_to_wake_up)
automoun-9953  0dnh2    0us : preempt_schedule (try_to_wake_up)
automoun-9953  0dnh2    1us : try_to_wake_up <<...>-2> (73 79)
automoun-9953  0dnh1    1us : preempt_schedule (try_to_wake_up)
automoun-9953  0dnh1    1us : wake_up_process (do_softirq)
automoun-9953  0dnh1    2us : local_irq_restore (do_softirq)
automoun-9953  0dnh1    2us : check_soft_flags (local_irq_restore)
automoun-9953  0dnh.    3us+< (608)
automoun-9953  0dn..   10us : vgacon_dummy (vt_console_print)
automoun-9953  0dn..   11us : lf (vt_console_print)
automoun-9953  0dn..   11us : scrup (lf)
automoun-9953  0dn..   11us!: vgacon_scroll (scrup)
automoun-9953  0dnh.  972us : do_IRQ (c02174dc 0 0)
automoun-9953  0dnh.  973us : __local_irq_save (__do_IRQ)
automoun-9953  0dnh1  973us : mask_and_ack_8259A (__do_IRQ)
automoun-9953  0dnh1  974us : __local_irq_save (mask_and_ack_8259A)
automoun-9953  0dnh1  975us : local_irq_restore (mask_and_ack_8259A)
automoun-9953  0dnh1  976us : check_soft_flags (local_irq_restore)
automoun-9953  0dnh1  976us : preempt_schedule (mask_and_ack_8259A)
automoun-9953  0dnh1  976us : redirect_hardirq (__do_IRQ)
automoun-9953  0dnh.  977us : preempt_schedule (__do_IRQ)
automoun-9953  0dnh.  977us : handle_IRQ_event (__do_IRQ)
automoun-9953  0dnh.  977us : timer_interrupt (handle_IRQ_event)
automoun-9953  0dnh1  978us : mark_offset_tsc (timer_interrupt)
automoun-9953  0dnh2  978us+: __local_irq_save (mark_offset_tsc)
automoun-9953  0dnh2  981us : local_irq_restore (mark_offset_tsc)
automoun-9953  0dnh2  982us : check_soft_flags (local_irq_restore)
automoun-9953  0dnh2  982us : preempt_schedule (mark_offset_tsc)
automoun-9953  0dnh1  983us : preempt_schedule (mark_offset_tsc)
automoun-9953  0dnh1  983us : preempt_schedule (mark_offset_tsc)
automoun-9953  0dnh1  983us : do_timer (timer_interrupt)
automoun-9953  0dnh1  984us : softlockup_tick (timer_interrupt)
automoun-9953  0dnh1  984us : update_process_times (timer_interrupt)
automoun-9953  0dnh1  984us : account_system_time (update_process_times)
automoun-9953  0dnh1  985us : update_mem_hiwater (update_process_times)
automoun-9953  0dnh1  985us : run_local_timers (update_process_times)
automoun-9953  0dnh1  985us : raise_softirq (update_process_times)
automoun-9953  0dnh1  985us : __local_irq_save (raise_softirq)
automoun-9953  0dnh1  986us : local_irq_restore (raise_softirq)
automoun-9953  0dnh1  986us : check_soft_flags (local_irq_restore)
automoun-9953  0dnh1  986us : rcu_check_callbacks (update_process_times)
automoun-9953  0dnh1  987us : idle_cpu (rcu_check_callbacks)
automoun-9953  0dnh1  987us : scheduler_tick (timer_interrupt)
automoun-9953  0dnh1  987us : sched_clock (scheduler_tick)
automoun-9953  0dnh1  988us : preempt_schedule (scheduler_tick)
automoun-9953  0dnh1  988us : profile_hit (timer_interrupt)
automoun-9953  0dnh.  988us : preempt_schedule (timer_interrupt)
automoun-9953  0dnh.  989us : local_irq_disable (handle_IRQ_event)
automoun-9953  0dnh1  989us : note_interrupt (__do_IRQ)
automoun-9953  0dnh1  990us : end_8259A_irq (__do_IRQ)
automoun-9953  0dnh1  990us : enable_8259A_irq (__do_IRQ)
automoun-9953  0dnh1  990us : __local_irq_save (enable_8259A_irq)
automoun-9953  0dnh1  991us : local_irq_restore (enable_8259A_irq)
automoun-9953  0dnh1  991us : check_soft_flags (local_irq_restore)
automoun-9953  0dnh1  992us : preempt_schedule (enable_8259A_irq)
automoun-9953  0dnh.  992us : preempt_schedule (__do_IRQ)
automoun-9953  0dnh.  992us : local_irq_restore (__do_IRQ)
automoun-9953  0dnh.  993us : check_soft_flags (local_irq_restore)
automoun-9953  0dnh.  993us : irq_exit (do_IRQ)
automoun-9953  0dnh1  993us : do_softirq (irq_exit)
automoun-9953  0dnh1  994us : __local_irq_save (do_softirq)
automoun-9953  0dnh1  994us : __do_softirq (do_softirq)
automoun-9953  0dnh1  994us : local_irq_restore (do_softirq)
automoun-9953  0dnh1  995us : check_soft_flags (local_irq_restore)
automoun-9953  0dnh.  995us!< (66144)
automoun-9953  0dn.. 1138us+: __local_irq_save (vgacon_scroll)
automoun-9953  0dn.. 1140us : local_irq_restore (vgacon_scroll)
automoun-9953  0dn.. 1140us : check_soft_flags (local_irq_restore)
automoun-9953  0dn.. 1141us+: preempt_schedule (vgacon_scroll)
automoun-9953  0dn.. 1145us : vgacon_dummy (vt_console_print)
automoun-9953  0dn.. 1145us : lf (vt_console_print)
automoun-9953  0dn.. 1145us : scrup (lf)
automoun-9953  0dn.. 1146us+: vgacon_scroll (scrup)
automoun-9953  0dn.. 1152us : __local_irq_save (vgacon_scroll)
automoun-9953  0dn.. 1154us : local_irq_restore (vgacon_scroll)
automoun-9953  0dn.. 1154us : check_soft_flags (local_irq_restore)
automoun-9953  0dn.. 1154us : preempt_schedule (vgacon_scroll)
automoun-9953  0dn.. 1155us : set_cursor (vt_console_print)
automoun-9953  0dn.. 1155us : add_softcursor (set_cursor)
automoun-9953  0dn.. 1156us : vgacon_cursor (set_cursor)
automoun-9953  0dn.. 1156us : __local_irq_save (vgacon_cursor)
automoun-9953  0dn.. 1157us : local_irq_restore (vgacon_cursor)
automoun-9953  0dn.. 1158us : check_soft_flags (local_irq_restore)
automoun-9953  0dn.. 1158us : preempt_schedule (vgacon_cursor)
automoun-9953  0dn.. 1158us : vgacon_set_cursor_size (vgacon_cursor)
automoun-9953  0dn.. 1159us : _call_console_drivers (call_console_drivers)
automoun-9953  0dn.. 1159us : local_irq_restore (release_console_sem)
automoun-9953  0dn.. 1159us : check_soft_flags (local_irq_restore)
automoun-9953  0Dn.. 1160us : preempt_schedule (release_console_sem)
automoun-9953  0Dn.. 1160us : irqs_disabled (preempt_schedule)
automoun-9953  0Dnh. 1160us : local_irq_disable (preempt_schedule)
automoun-9953  0dnh. 1161us : __schedule (preempt_schedule)
automoun-9953  0dnh. 1161us : profile_hit (__schedule)
automoun-9953  0dnh1 1162us : sched_clock (__schedule)
automoun-9953  0dnh1 1162us : local_irq_disable (__schedule)
automoun-9953  0dnh2 1163us+: trace_array (__schedule)
automoun-9953  0dnh2 1166us : trace_array <<...>-2> (73 6e)
automoun-9953  0dnh2 1167us : trace_array <automoun-9953> (79 74)
automoun-9953  0dnh2 1167us : trace_array <<...>-3278> (7d 78)
automoun-9953  0dnh2 1167us : trace_array <<...>-3155> (7d 78)
automoun-9953  0dnh2 1168us : trace_array <<...>-4062> (7d 78)
automoun-9953  0dnh2 1168us : trace_array <<...>-4562> (7d 78)
automoun-9953  0dnh2 1168us : trace_array <<...>-9929> (7d 78)
automoun-9953  0dnh2 1168us : trace_array <<...>-3282> (7d 78)
automoun-9953  0dnh2 1169us : trace_array <<...>-4787> (7d 78)
automoun-9953  0dnh2 1169us : trace_array <<...>-3269> (7d 78)
automoun-9953  0dnh2 1169us : trace_array <<...>-3443> (7d 78)
automoun-9953  0dnh2 1170us : trace_array <<...>-9949> (7d 78)
automoun-9953  0dnh2 1170us : trace_array <<...>-4633> (7d 78)
automoun-9953  0dnh2 1170us : trace_array <<...>-3105> (7d 78)
automoun-9953  0dnh2 1171us : trace_array <<...>-9946> (7d 78)
automoun-9953  0dnh2 1171us : trace_array <<...>-839> (7d 78)
automoun-9953  0dnh2 1171us : trace_array <<...>-2952> (7d 78)
automoun-9953  0dnh2 1172us+: trace_array (__schedule)
   <...>-2     0dnh2 1176us : __switch_to (__schedule)
   <...>-2     0dnh2 1176us : __schedule <automoun-9953> (79 73)
   <...>-2     0dnh1 1177us : trace_stop_sched_switched (__schedule)
   <...>-2     0dnh1 1177us : trace_stop_sched_switched <<...>-2> (73 0)
   <...>-2     0dnh1 1178us : trace_stop_sched_switched (__schedule)


vim:ft=help


On Thu, 9 Jun 2005, Ingo Molnar wrote:

> 
> * Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:
> 
> > Ingo Molnar wrote:
> > >thanks - i have added it to my tree and have uploaded the -48-03 release 
> > >with your patch included.
> > 
> > This hunk should not be in the patch:
> 
> indeed - new patch uploaded.
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

