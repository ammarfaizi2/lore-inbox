Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVBWCW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVBWCW1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 21:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVBWCW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 21:22:27 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:41442 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261391AbVBWCWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 21:22:16 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050219090312.GA30513@elte.hu>
References: <20050204100347.GA13186@elte.hu>
	 <1108789704.8411.9.camel@krustophenia.net> <20050219090036.GA30456@elte.hu>
	 <20050219090312.GA30513@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 22 Feb 2005 21:22:13 -0500
Message-Id: <1109125334.5737.2.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-02-19 at 10:03 +0100, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > Testing on an all SCSI 1.3Ghz Athlon XP system, I am seeing very long
> > > latencies in the journalling code with 2.6.11-rc4-RT-V0.7.39-02.
> > 
> > could you send me the full trace?
> 

On my other machine this 333us trace is the longest latency reported in
the first few minutes with PREEMPT_DESKTOP.  It seems to be a regression
from earlier versions.  If I read the trace right copy_pte_range is the
problem.

Lee

preemption latency trace v1.1.4 on 2.6.11-rc4-RT-V0.7.39-02
--------------------------------------------------------------------
 latency: 333 탎, #63/63, CPU#0 | (M:preempt VP:0, KP:1, SP:1 HP:1 #P:1)
    -----------------
    | task: XFree86-2593 (uid:0 nice:0 policy:0 rt_prio:0)
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
(T1/#0)             dpkg  4362 0 5 00000006 00000000 [0000380181315825] 0.000ms (+3550398.796ms): <676b7064> (<00746500>)
(T1/#2)             dpkg  4362 0 5 00000006 00000002 [0000380181316227] 0.000ms (+0.000ms): __trace_start_sched_wakeup+0x96/0xc0 <c012cbe6> (try_to_wake_up+0x81/0x150 <c010f911>)
(T1/#3)             dpkg  4362 0 5 00000004 00000003 [0000380181316766] 0.001ms (+0.001ms): wake_up_state+0x1e/0x30 <c010fa5e> (signal_wake_up+0x2d/0x30 <c011f7bd>)
(T1/#4)             dpkg  4362 0 5 00000000 00000004 [0000380181317637] 0.003ms (+0.000ms): __wake_up+0xe/0x70 <c011059e> (mousedev_event+0xd8/0x140 <c0223ac8>)
(T1/#5)             dpkg  4362 0 5 00000001 00000005 [0000380181318080] 0.003ms (+0.001ms): __wake_up_common+0xb/0x70 <c011052b> (__wake_up+0x3b/0x70 <c01105cb>)
(T1/#6)             dpkg  4362 0 5 00000000 00000006 [0000380181318983] 0.005ms (+0.002ms): usb_submit_urb+0xe/0x2c0 <dcabaefe> (hid_irq_in+0x4e/0xe0 <dca7335e>)
(T1/#7)             dpkg  4362 0 5 00000000 00000007 [0000380181320688] 0.008ms (+0.001ms): hcd_submit_urb+0xe/0x200 <dcaba57e> (usb_submit_urb+0x1c6/0x2c0 <dcabb0b6>)
(T1/#8)             dpkg  4362 0 5 00000001 00000008 [0000380181321463] 0.009ms (+0.000ms): usb_get_dev+0x9/0x30 <dcab5939> (hcd_submit_urb+0x1a9/0x200 <dcaba719>)
(T1/#9)             dpkg  4362 0 5 00000001 00000009 [0000380181321943] 0.010ms (+0.000ms): get_device+0x8/0x30 <c02012d8> (usb_get_dev+0x19/0x30 <dcab5949>)
(T1/#10)             dpkg  4362 0 5 00000001 0000000a [0000380181322283] 0.010ms (+0.000ms): kobject_get+0x9/0x30 <c01d7869> (get_device+0x1a/0x30 <c02012ea>)
(T1/#11)             dpkg  4362 0 5 00000001 0000000b [0000380181322691] 0.011ms (+0.001ms): kref_get+0x9/0x60 <c01d8339> (kobject_get+0x19/0x30 <c01d7879>)
(T1/#12)             dpkg  4362 0 5 00000000 0000000c [0000380181323295] 0.012ms (+0.000ms): usb_get_urb+0x9/0x20 <dcabaed9> (hcd_submit_urb+0xc6/0x200 <dcaba636>)
(T1/#13)             dpkg  4362 0 5 00000000 0000000d [0000380181323566] 0.012ms (+0.001ms): kref_get+0x9/0x60 <c01d8339> (usb_get_urb+0x16/0x20 <dcabaee6>)
(T1/#14)             dpkg  4362 0 5 00000000 0000000e [0000380181324216] 0.013ms (+0.000ms): uhci_urb_enqueue+0xe/0x290 <dca6bf4e> (hcd_submit_urb+0x123/0x200 <dcaba693>)
(T1/#15)             dpkg  4362 0 5 00000001 0000000f [0000380181324743] 0.014ms (+0.000ms): uhci_find_urb_ep+0xe/0xb0 <dca6be9e> (uhci_urb_enqueue+0x7a/0x290 <dca6bfba>)
(T1/#16)             dpkg  4362 0 5 00000001 00000010 [0000380181325251] 0.015ms (+0.000ms): uhci_alloc_urb_priv+0xb/0x80 <dca6aebb> (uhci_urb_enqueue+0x87/0x290 <dca6bfc7>)
(T1/#17)             dpkg  4362 0 5 00000001 00000011 [0000380181325582] 0.016ms (+0.001ms): kmem_cache_alloc+0xb/0x70 <c013dc6b> (uhci_alloc_urb_priv+0x1c/0x80 <dca6aecc>)
(T1/#18)             dpkg  4362 0 5 00000001 00000012 [0000380181326332] 0.017ms (+0.000ms): usb_check_bandwidth+0xc/0x140 <dcaba2fc> (uhci_urb_enqueue+0x200/0x290 <dca6c140>)
(T1/#19)             dpkg  4362 0 5 00000001 00000013 [0000380181326926] 0.018ms (+0.001ms): usb_calc_bus_time+0x9/0x270 <dcaba089> (usb_check_bandwidth+0x6b/0x140 <dcaba35b>)
(T1/#20)             dpkg  4362 0 5 00000001 00000014 [0000380181327893] 0.020ms (+0.001ms): uhci_submit_common+0xe/0x380 <dca6b77e> (uhci_urb_enqueue+0x239/0x290 <dca6c179>)
(T1/#21)             dpkg  4362 0 5 00000001 00000015 [0000380181328984] 0.021ms (+0.001ms): uhci_alloc_td+0xb/0x80 <dca6a5bb> (uhci_submit_common+0xf0/0x380 <dca6b860>)
(T1/#22)             dpkg  4362 0 5 00000001 00000016 [0000380181329685] 0.023ms (+0.002ms): dma_pool_alloc+0xe/0x1a0 <c02051fe> (uhci_alloc_td+0x20/0x80 <dca6a5d0>)
(T1/#23)             dpkg  4362 0 5 00000001 00000017 [0000380181331207] 0.025ms (+0.000ms): usb_get_dev+0x9/0x30 <dcab5939> (uhci_alloc_td+0x69/0x80 <dca6a619>)
(T1/#24)             dpkg  4362 0 5 00000001 00000018 [0000380181331544] 0.026ms (+0.000ms): get_device+0x8/0x30 <c02012d8> (usb_get_dev+0x19/0x30 <dcab5949>)
(T1/#25)             dpkg  4362 0 5 00000001 00000019 [0000380181331882] 0.026ms (+0.000ms): kobject_get+0x9/0x30 <c01d7869> (get_device+0x1a/0x30 <c02012ea>)
(T1/#26)             dpkg  4362 0 5 00000001 0000001a [0000380181332215] 0.027ms (+0.000ms): kref_get+0x9/0x60 <c01d8339> (kobject_get+0x19/0x30 <c01d7879>)
(T1/#27)             dpkg  4362 0 5 00000001 0000001b [0000380181332606] 0.027ms (+0.001ms): uhci_add_td_to_urb+0x9/0x30 <dca6af39> (uhci_submit_common+0x10b/0x380 <dca6b87b>)
(T1/#28)             dpkg  4362 0 5 00000001 0000001c [0000380181333448] 0.029ms (+0.000ms): uhci_alloc_qh+0xb/0x70 <dca6a89b> (uhci_submit_common+0x1d7/0x380 <dca6b947>)
(T1/#29)             dpkg  4362 0 5 00000001 0000001d [0000380181333880] 0.030ms (+0.001ms): dma_pool_alloc+0xe/0x1a0 <c02051fe> (uhci_alloc_qh+0x20/0x70 <dca6a8b0>)
(T1/#30)             dpkg  4362 0 5 00000001 0000001e [0000380181334888] 0.031ms (+0.000ms): usb_get_dev+0x9/0x30 <dcab5939> (uhci_alloc_qh+0x60/0x70 <dca6a8f0>)
(T1/#31)             dpkg  4362 0 5 00000001 0000001f [0000380181335311] 0.032ms (+0.000ms): get_device+0x8/0x30 <c02012d8> (usb_get_dev+0x19/0x30 <dcab5949>)
(T1/#32)             dpkg  4362 0 5 00000001 00000020 [0000380181335644] 0.033ms (+0.000ms): kobject_get+0x9/0x30 <c01d7869> (get_device+0x1a/0x30 <c02012ea>)
(T1/#33)             dpkg  4362 0 5 00000001 00000021 [0000380181335972] 0.033ms (+0.000ms): kref_get+0x9/0x60 <c01d8339> (kobject_get+0x19/0x30 <c01d7879>)
(T1/#34)             dpkg  4362 0 5 00000001 00000022 [0000380181336517] 0.034ms (+0.000ms): uhci_insert_tds_in_qh+0xb/0x60 <dca6a76b> (uhci_submit_common+0x1f7/0x380 <dca6b967>)
(T1/#35)             dpkg  4362 0 5 00000001 00000023 [0000380181337025] 0.035ms (+0.001ms): uhci_insert_qh+0xb/0x90 <dca6a9ab> (uhci_submit_common+0x235/0x380 <dca6b9a5>)
(T1/#36)             dpkg  4362 0 5 00000001 00000024 [0000380181337741] 0.036ms (+0.001ms): usb_claim_bandwidth+0x8/0x40 <dcaba438> (uhci_urb_enqueue+0x178/0x290 <dca6c0b8>)
(T1/#37)             dpkg  4362 0 5 00000000 00000025 [0000380181338690] 0.038ms (+0.000ms): usb_free_urb+0x8/0x20 <dcabaeb8> (uhci_finish_urb+0x40/0x60 <dca6c9b0>)
(T1/#38)             dpkg  4362 0 5 00000000 00000026 [0000380181339041] 0.038ms (+0.001ms): kref_put+0xa/0xb0 <c01d839a> (usb_free_urb+0x1a/0x20 <dcabaeca>)
(T1/#39)             dpkg  4362 0 5 00000000 00000027 [0000380181339653] 0.039ms (+0.000ms): __wake_up+0xe/0x70 <c011059e> (uhci_irq+0x1cd/0x200 <dca6cc5d>)
(T1/#40)             dpkg  4362 0 5 00000001 00000028 [0000380181340175] 0.040ms (+0.001ms): __wake_up_common+0xb/0x70 <c011052b> (__wake_up+0x3b/0x70 <c01105cb>)
(T1/#41)             dpkg  4362 0 5 00000001 00000029 [0000380181341026] 0.042ms (+0.000ms): note_interrupt+0xb/0x90 <c01341db> (__do_IRQ+0x148/0x160 <c0133938>)
(T1/#42)             dpkg  4362 0 5 00000001 0000002a [0000380181341399] 0.042ms (+0.000ms): end_8259A_irq+0x8/0x40 <c0107c38> (__do_IRQ+0x110/0x160 <c0133900>)
(T1/#43)             dpkg  4362 0 5 00000001 0000002b [0000380181341746] 0.043ms (+0.002ms): enable_8259A_irq+0xb/0x80 <c0107d1b> (__do_IRQ+0x110/0x160 <c0133900>)
(T1/#44)             dpkg  4362 0 7 00000002 0000002c [0000380181343089] 0.045ms (+0.001ms): irq_exit+0x8/0x50 <c0119fb8> (do_IRQ+0x60/0x80 <c01041f0>)
(T6/#45)     dpkg-4362  0dn.2   46탎!< (1)
(T1/#46)             dpkg  4362 0 2 00000001 0000002e [0000380181504494] 0.314ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (copy_pte_range+0xb7/0x1c0 <c0142ad7>)
(T1/#47)             dpkg  4362 0 2 00000001 0000002f [0000380181504953] 0.315ms (+0.000ms): __cond_resched_raw_spinlock+0x8/0x50 <c0111398> (copy_pte_range+0xa7/0x1c0 <c0142ac7>)
(T1/#48)             dpkg  4362 0 2 00000000 00000030 [0000380181505442] 0.316ms (+0.001ms): __cond_resched+0x9/0x70 <c0111329> (__cond_resched_raw_spinlock+0x3d/0x50 <c01113cd>)
(T1/#49)             dpkg  4362 0 3 00000000 00000031 [0000380181506068] 0.317ms (+0.000ms): __schedule+0xe/0x630 <c027c98e> (__cond_resched+0x45/0x70 <c0111365>)
(T1/#50)             dpkg  4362 0 3 00000000 00000032 [0000380181506442] 0.317ms (+0.001ms): profile_hit+0x9/0x50 <c0115749> (__schedule+0x3a/0x630 <c027c9ba>)
(T1/#51)             dpkg  4362 0 3 00000001 00000033 [0000380181507130] 0.318ms (+0.001ms): sched_clock+0xe/0xe0 <c010c3ae> (__schedule+0x62/0x630 <c027c9e2>)
(T1/#52)             dpkg  4362 0 3 00000002 00000034 [0000380181508079] 0.320ms (+0.000ms): dequeue_task+0xa/0x50 <c010f4ea> (__schedule+0x1ab/0x630 <c027cb2b>)
(T1/#53)             dpkg  4362 0 3 00000002 00000035 [0000380181508503] 0.321ms (+0.000ms): recalc_task_prio+0xc/0x1a0 <c010f64c> (__schedule+0x1c5/0x630 <c027cb45>)
(T1/#54)             dpkg  4362 0 3 00000002 00000036 [0000380181509011] 0.321ms (+0.000ms): effective_prio+0x8/0x50 <c010f5f8> (recalc_task_prio+0xa6/0x1a0 <c010f6e6>)
(T1/#55)             dpkg  4362 0 3 00000002 00000037 [0000380181509402] 0.322ms (+0.001ms): enqueue_task+0xa/0x80 <c010f53a> (__schedule+0x1cc/0x630 <c027cb4c>)
(T4/#56) [ =>             dpkg ] 0.324ms (+0.001ms)
(T1/#57)            <...>  2593 0 1 00000002 00000039 [0000380181511577] 0.326ms (+0.002ms): __switch_to+0xb/0x1a0 <c0100f5b> (__schedule+0x2bd/0x630 <c027cc3d>)
(T3/#58)    <...>-2593  0d..2  328탎 : __schedule+0x2ea/0x630 <c027cc6a> <dpkg-4362> (75 73): 
(T1/#59)            <...>  2593 0 1 00000002 0000003b [0000380181513468] 0.329ms (+0.000ms): finish_task_switch+0xc/0x90 <c010fdec> (__schedule+0x2f6/0x630 <c027cc76>)
(T1/#60)            <...>  2593 0 1 00000001 0000003c [0000380181513919] 0.330ms (+0.000ms): trace_stop_sched_switched+0xa/0x150 <c012cc1a> (finish_task_switch+0x43/0x90 <c010fe23>)
(T3/#61)    <...>-2593  0d..1  330탎 : trace_stop_sched_switched+0x42/0x150 <c012cc52> <<...>-2593> (73 0): 
(T1/#62)            <...>  2593 0 1 00000001 0000003e [0000380181515016] 0.331ms (+0.000ms): trace_stop_sched_switched+0xfe/0x150 <c012cd0e> (finish_task_switch+0x43/0x90 <c010fe23>)


vim:ft=help

