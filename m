Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVBWSI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVBWSI7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 13:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVBWSI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 13:08:59 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:41698 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261539AbVBWSHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 13:07:45 -0500
Subject: More latency regressions with 2.6.11-rc4-RT-V0.7.39-02
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-SNszk3XLAvNKzD7yGRtn"
Date: Wed, 23 Feb 2005 13:07:41 -0500
Message-Id: <1109182061.16201.6.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SNszk3XLAvNKzD7yGRtn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Ingo,

Did something change recently in the VM that made copy_pte_range and
clear_page_range a lot more expensive?  I noticed a reference in the
"Page Table Iterators" thread to excessive overhead introduced by
aggressive page freeing.  That sure looks like what is going on in
trace2.  trace1 and trace3 look like big fork latencies associated with
copy_pte_range.

This is all with PREEMPT_DESKTOP.

Lee 

--=-SNszk3XLAvNKzD7yGRtn
Content-Disposition: attachment; filename=trace1.txt
Content-Type: text/plain; name=trace1.txt; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit

preemption latency trace v1.1.4 on 2.6.11-rc4-RT-V0.7.39-02
--------------------------------------------------------------------
 latency: 323 탎, #22/22, CPU#0 | (M:preempt VP:0, KP:1, SP:1 HP:1 #P:1)
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
(T1/#0)     valgrind.bin 15934 0 9 00000002 00000000 [0032064022903959] 0.000ms (+3534259.157ms): <676c6176> (<646e6972>)
(T1/#2)     valgrind.bin 15934 0 9 00000002 00000002 [0032064022904377] 0.000ms (+0.000ms): __trace_start_sched_wakeup+0x96/0xc0 <c012cbe6> (try_to_wake_up+0x81/0x150 <c010f911>)
(T1/#3)     valgrind.bin 15934 0 9 00000000 00000003 [0032064022904934] 0.001ms (+0.000ms): wake_up_process+0x1c/0x30 <c010f9fc> (do_softirq+0x4b/0x60 <c01042fb>)
(T6/#4) valgrind-15934 0dn.2    2탎!< (1)
(T1/#5)     valgrind.bin 15934 0 2 00000001 00000005 [0032064023088406] 0.307ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (copy_pte_range+0xb7/0x1c0 <c0142ad7>)
(T1/#6)     valgrind.bin 15934 0 2 00000001 00000006 [0032064023088847] 0.308ms (+0.000ms): __cond_resched_raw_spinlock+0x8/0x50 <c0111398> (copy_pte_range+0xa7/0x1c0 <c0142ac7>)
(T1/#7)     valgrind.bin 15934 0 2 00000000 00000007 [0032064023089269] 0.308ms (+0.001ms): __cond_resched+0x9/0x70 <c0111329> (__cond_resched_raw_spinlock+0x3d/0x50 <c01113cd>)
(T1/#8)     valgrind.bin 15934 0 3 00000000 00000008 [0032064023089903] 0.309ms (+0.000ms): __schedule+0xe/0x630 <c027c98e> (__cond_resched+0x45/0x70 <c0111365>)
(T1/#9)     valgrind.bin 15934 0 3 00000000 00000009 [0032064023090288] 0.310ms (+0.000ms): profile_hit+0x9/0x50 <c0115749> (__schedule+0x3a/0x630 <c027c9ba>)
(T1/#10)     valgrind.bin 15934 0 3 00000001 0000000a [0032064023090866] 0.311ms (+0.001ms): sched_clock+0xe/0xe0 <c010c3ae> (__schedule+0x62/0x630 <c027c9e2>)
(T1/#11)     valgrind.bin 15934 0 3 00000002 0000000b [0032064023091857] 0.313ms (+0.000ms): dequeue_task+0xa/0x50 <c010f4ea> (__schedule+0x1ab/0x630 <c027cb2b>)
(T1/#12)     valgrind.bin 15934 0 3 00000002 0000000c [0032064023092280] 0.313ms (+0.000ms): recalc_task_prio+0xc/0x1a0 <c010f64c> (__schedule+0x1c5/0x630 <c027cb45>)
(T1/#13)     valgrind.bin 15934 0 3 00000002 0000000d [0032064023092690] 0.314ms (+0.000ms): effective_prio+0x8/0x50 <c010f5f8> (recalc_task_prio+0xa6/0x1a0 <c010f6e6>)
(T1/#14)     valgrind.bin 15934 0 3 00000002 0000000e [0032064023093035] 0.315ms (+0.001ms): enqueue_task+0xa/0x80 <c010f53a> (__schedule+0x1cc/0x630 <c027cb4c>)
(T4/#15) [ =>     valgrind.bin ] 0.316ms (+0.001ms)
(T1/#16)            <...>     2 0 1 00000002 00000010 [0032064023094748] 0.317ms (+0.001ms): __switch_to+0xb/0x1a0 <c0100f5b> (__schedule+0x2bd/0x630 <c027cc3d>)
(T3/#17)    <...>-2     0d..2  319탎 : __schedule+0x2ea/0x630 <c027cc6a> <valgrind-15934> (7d 69): 
(T1/#18)            <...>     2 0 1 00000002 00000012 [0032064023095766] 0.319ms (+0.000ms): finish_task_switch+0xc/0x90 <c010fdec> (__schedule+0x2f6/0x630 <c027cc76>)
(T1/#19)            <...>     2 0 1 00000001 00000013 [0032064023096192] 0.320ms (+0.000ms): trace_stop_sched_switched+0xa/0x150 <c012cc1a> (finish_task_switch+0x43/0x90 <c010fe23>)
(T3/#20)    <...>-2     0d..1  320탎 : trace_stop_sched_switched+0x42/0x150 <c012cc52> <<...>-2> (69 0): 
(T1/#21)            <...>     2 0 1 00000001 00000015 [0032064023097511] 0.322ms (+0.000ms): trace_stop_sched_switched+0xfe/0x150 <c012cd0e> (finish_task_switch+0x43/0x90 <c010fe23>)


vim:ft=help

--=-SNszk3XLAvNKzD7yGRtn
Content-Disposition: attachment; filename=trace2.txt
Content-Type: text/plain; name=trace2.txt; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit

preemption latency trace v1.1.4 on 2.6.11-rc4-RT-V0.7.39-02
--------------------------------------------------------------------
 latency: 361 탎, #289/289, CPU#0 | (M:preempt VP:0, KP:1, SP:1 HP:1 #P:1)
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
(T1/#0)        evolution 16047 0 9 00000002 00000000 [0032772517080312] 0.000ms (+3483891.566ms): <6c6f7665> (<6f697475>)
(T1/#2)        evolution 16047 0 9 00000002 00000002 [0032772517080803] 0.000ms (+0.000ms): __trace_start_sched_wakeup+0x96/0xc0 <c012cbe6> (try_to_wake_up+0x81/0x150 <c010f911>)
(T1/#3)        evolution 16047 0 9 00000000 00000003 [0032772517081392] 0.001ms (+0.000ms): wake_up_process+0x1c/0x30 <c010f9fc> (do_softirq+0x4b/0x60 <c01042fb>)
(T6/#4) evolutio-16047 0dn.2    2탎 < (1)
(T1/#5)        evolution 16047 0 2 00000002 00000005 [0032772517082355] 0.003ms (+0.001ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#6)        evolution 16047 0 2 00000002 00000006 [0032772517082977] 0.004ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#7)        evolution 16047 0 2 00000002 00000007 [0032772517083332] 0.005ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#8)        evolution 16047 0 2 00000002 00000008 [0032772517083589] 0.005ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#9)        evolution 16047 0 2 00000002 00000009 [0032772517083937] 0.006ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#10)        evolution 16047 0 2 00000002 0000000a [0032772517084750] 0.007ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#11)        evolution 16047 0 2 00000002 0000000b [0032772517085209] 0.008ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#12)        evolution 16047 0 2 00000002 0000000c [0032772517085614] 0.008ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bb89> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#13)        evolution 16047 0 2 00000002 0000000d [0032772517085996] 0.009ms (+0.000ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#14)        evolution 16047 0 2 00000002 0000000e [0032772517086537] 0.010ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#15)        evolution 16047 0 2 00000002 0000000f [0032772517086869] 0.010ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#16)        evolution 16047 0 2 00000002 00000010 [0032772517087171] 0.011ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#17)        evolution 16047 0 2 00000002 00000011 [0032772517087540] 0.012ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#18)        evolution 16047 0 2 00000002 00000012 [0032772517088332] 0.013ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#19)        evolution 16047 0 2 00000002 00000013 [0032772517088800] 0.014ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#20)        evolution 16047 0 2 00000002 00000014 [0032772517089160] 0.014ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bb89> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#21)        evolution 16047 0 2 00000002 00000015 [0032772517089620] 0.015ms (+0.000ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#22)        evolution 16047 0 2 00000002 00000016 [0032772517090190] 0.016ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#23)        evolution 16047 0 2 00000002 00000017 [0032772517090529] 0.017ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#24)        evolution 16047 0 2 00000002 00000018 [0032772517090829] 0.017ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#25)        evolution 16047 0 2 00000002 00000019 [0032772517091189] 0.018ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#26)        evolution 16047 0 3 00000003 0000001a [0032772517091761] 0.019ms (+0.001ms): free_pages_bulk+0xe/0x200 <c0138fde> (free_hot_cold_page+0x103/0x130 <c01395d3>)
(T1/#27)        evolution 16047 0 3 00000004 0000001b [0032772517092489] 0.020ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#28)        evolution 16047 0 3 00000004 0000001c [0032772517092884] 0.020ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#29)        evolution 16047 0 3 00000004 0000001d [0032772517093678] 0.022ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#30)        evolution 16047 0 3 00000004 0000001e [0032772517094096] 0.022ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#31)        evolution 16047 0 3 00000004 0000001f [0032772517094674] 0.023ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#32)        evolution 16047 0 3 00000004 00000020 [0032772517095137] 0.024ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#33)        evolution 16047 0 3 00000004 00000021 [0032772517095623] 0.025ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#34)        evolution 16047 0 3 00000004 00000022 [0032772517096307] 0.026ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#35)        evolution 16047 0 3 00000004 00000023 [0032772517096766] 0.027ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#36)        evolution 16047 0 3 00000004 00000024 [0032772517097495] 0.028ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#37)        evolution 16047 0 3 00000004 00000025 [0032772517097968] 0.029ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#38)        evolution 16047 0 3 00000004 00000026 [0032772517098688] 0.030ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#39)        evolution 16047 0 3 00000004 00000027 [0032772517099138] 0.031ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#40)        evolution 16047 0 3 00000004 00000028 [0032772517099961] 0.032ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#41)        evolution 16047 0 3 00000004 00000029 [0032772517100452] 0.033ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#42)        evolution 16047 0 3 00000004 0000002a [0032772517101122] 0.034ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#43)        evolution 16047 0 3 00000004 0000002b [0032772517101568] 0.035ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#44)        evolution 16047 0 3 00000004 0000002c [0032772517102283] 0.036ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#45)        evolution 16047 0 3 00000004 0000002d [0032772517102729] 0.037ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#46)        evolution 16047 0 3 00000004 0000002e [0032772517103453] 0.038ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#47)        evolution 16047 0 3 00000004 0000002f [0032772517103899] 0.039ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#48)        evolution 16047 0 3 00000004 00000030 [0032772517104601] 0.040ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#49)        evolution 16047 0 3 00000004 00000031 [0032772517105060] 0.041ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#50)        evolution 16047 0 3 00000004 00000032 [0032772517105618] 0.042ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#51)        evolution 16047 0 3 00000004 00000033 [0032772517106081] 0.042ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#52)        evolution 16047 0 3 00000004 00000034 [0032772517106581] 0.043ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#53)        evolution 16047 0 3 00000004 00000035 [0032772517107359] 0.045ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#54)        evolution 16047 0 3 00000004 00000036 [0032772517107818] 0.045ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#55)        evolution 16047 0 3 00000004 00000037 [0032772517108498] 0.046ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#56)        evolution 16047 0 3 00000004 00000038 [0032772517108948] 0.047ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#57)        evolution 16047 0 3 00000004 00000039 [0032772517109609] 0.048ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#58)        evolution 16047 0 3 00000004 0000003a [0032772517110055] 0.049ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#59)        evolution 16047 0 3 00000004 0000003b [0032772517110779] 0.050ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#60)        evolution 16047 0 3 00000004 0000003c [0032772517111229] 0.051ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#61)        evolution 16047 0 3 00000003 0000003d [0032772517111877] 0.052ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (free_pages_bulk+0x1e5/0x200 <c01391b5>)
(T1/#62)        evolution 16047 0 2 00000002 0000003e [0032772517112404] 0.053ms (+0.001ms): preempt_schedule+0xa/0x70 <c027d0ca> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#63)        evolution 16047 0 2 00000002 0000003f [0032772517113047] 0.054ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#64)        evolution 16047 0 2 00000002 00000040 [0032772517113493] 0.055ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bb89> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#65)        evolution 16047 0 2 00000002 00000041 [0032772517113952] 0.056ms (+0.001ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#66)        evolution 16047 0 2 00000002 00000042 [0032772517114564] 0.057ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#67)        evolution 16047 0 2 00000002 00000043 [0032772517114937] 0.057ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#68)        evolution 16047 0 2 00000002 00000044 [0032772517115266] 0.058ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#69)        evolution 16047 0 2 00000002 00000045 [0032772517115612] 0.058ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#70)        evolution 16047 0 2 00000002 00000046 [0032772517116422] 0.060ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#71)        evolution 16047 0 2 00000002 00000047 [0032772517116886] 0.060ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#72)        evolution 16047 0 2 00000002 00000048 [0032772517117322] 0.061ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bb89> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#73)        evolution 16047 0 2 00000002 00000049 [0032772517117813] 0.062ms (+0.001ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#74)        evolution 16047 0 2 00000002 0000004a [0032772517118416] 0.063ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#75)        evolution 16047 0 2 00000002 0000004b [0032772517118785] 0.064ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#76)        evolution 16047 0 2 00000002 0000004c [0032772517119113] 0.064ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#77)        evolution 16047 0 2 00000002 0000004d [0032772517119469] 0.065ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#78)        evolution 16047 0 2 00000002 0000004e [0032772517120247] 0.066ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#79)        evolution 16047 0 2 00000002 0000004f [0032772517120715] 0.067ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#80)        evolution 16047 0 2 00000002 00000050 [0032772517121156] 0.068ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bb89> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#81)        evolution 16047 0 2 00000002 00000051 [0032772517121606] 0.068ms (+0.001ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#82)        evolution 16047 0 2 00000002 00000052 [0032772517122214] 0.069ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#83)        evolution 16047 0 2 00000002 00000053 [0032772517122578] 0.070ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#84)        evolution 16047 0 2 00000002 00000054 [0032772517122911] 0.070ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#85)        evolution 16047 0 2 00000002 00000055 [0032772517123271] 0.071ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#86)        evolution 16047 0 2 00000002 00000056 [0032772517124081] 0.072ms (+0.037ms): preempt_schedule+0xa/0x70 <c027d0ca> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#87)        evolution 16047 0 2 00000002 00000057 [0032772517146379] 0.110ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#88)        evolution 16047 0 2 00000002 00000058 [0032772517146815] 0.110ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bb89> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#89)        evolution 16047 0 2 00000002 00000059 [0032772517147234] 0.111ms (+0.000ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#90)        evolution 16047 0 2 00000002 0000005a [0032772517147832] 0.112ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#91)        evolution 16047 0 2 00000002 0000005b [0032772517148201] 0.113ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#92)        evolution 16047 0 2 00000002 0000005c [0032772517148530] 0.113ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#93)        evolution 16047 0 2 00000002 0000005d [0032772517148885] 0.114ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#94)        evolution 16047 0 2 00000002 0000005e [0032772517149677] 0.115ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#95)        evolution 16047 0 2 00000002 0000005f [0032772517150150] 0.116ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#96)        evolution 16047 0 2 00000002 00000060 [0032772517150595] 0.117ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bb89> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#97)        evolution 16047 0 2 00000002 00000061 [0032772517151041] 0.117ms (+0.001ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#98)        evolution 16047 0 2 00000002 00000062 [0032772517151653] 0.118ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#99)        evolution 16047 0 2 00000002 00000063 [0032772517152017] 0.119ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#100)        evolution 16047 0 2 00000002 00000064 [0032772517152359] 0.120ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#101)        evolution 16047 0 2 00000002 00000065 [0032772517152719] 0.120ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#102)        evolution 16047 0 2 00000002 00000066 [0032772517153507] 0.121ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#103)        evolution 16047 0 2 00000002 00000067 [0032772517153975] 0.122ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#104)        evolution 16047 0 2 00000002 00000068 [0032772517154407] 0.123ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bb89> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#105)        evolution 16047 0 2 00000002 00000069 [0032772517154879] 0.124ms (+0.001ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#106)        evolution 16047 0 2 00000002 0000006a [0032772517155482] 0.125ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#107)        evolution 16047 0 2 00000002 0000006b [0032772517155842] 0.125ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#108)        evolution 16047 0 2 00000002 0000006c [0032772517156171] 0.126ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#109)        evolution 16047 0 2 00000002 0000006d [0032772517156517] 0.127ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#110)        evolution 16047 0 2 00000002 0000006e [0032772517157291] 0.128ms (+0.001ms): preempt_schedule+0xa/0x70 <c027d0ca> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#111)        evolution 16047 0 2 00000002 0000006f [0032772517158029] 0.129ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#112)        evolution 16047 0 2 00000002 00000070 [0032772517158466] 0.130ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bb89> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#113)        evolution 16047 0 2 00000002 00000071 [0032772517158929] 0.131ms (+0.001ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#114)        evolution 16047 0 2 00000002 00000072 [0032772517159532] 0.132ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#115)        evolution 16047 0 2 00000002 00000073 [0032772517159910] 0.132ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#116)        evolution 16047 0 2 00000002 00000074 [0032772517160243] 0.133ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#117)        evolution 16047 0 2 00000002 00000075 [0032772517160590] 0.133ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#118)        evolution 16047 0 2 00000002 00000076 [0032772517161377] 0.135ms (+0.075ms): preempt_schedule+0xa/0x70 <c027d0ca> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#119)        evolution 16047 0 2 00000002 00000077 [0032772517206701] 0.210ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#120)        evolution 16047 0 2 00000002 00000078 [0032772517207133] 0.211ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bb89> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#121)        evolution 16047 0 2 00000002 00000079 [0032772517207574] 0.212ms (+0.000ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#122)        evolution 16047 0 2 00000002 0000007a [0032772517208173] 0.213ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#123)        evolution 16047 0 2 00000002 0000007b [0032772517208537] 0.213ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#124)        evolution 16047 0 2 00000002 0000007c [0032772517208866] 0.214ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#125)        evolution 16047 0 2 00000002 0000007d [0032772517209221] 0.214ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#126)        evolution 16047 0 2 00000002 0000007e [0032772517209995] 0.216ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#127)        evolution 16047 0 2 00000002 0000007f [0032772517210567] 0.217ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#128)        evolution 16047 0 2 00000002 00000080 [0032772517211012] 0.217ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bb89> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#129)        evolution 16047 0 2 00000002 00000081 [0032772517211462] 0.218ms (+0.001ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#130)        evolution 16047 0 2 00000002 00000082 [0032772517212065] 0.219ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#131)        evolution 16047 0 2 00000002 00000083 [0032772517212430] 0.220ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#132)        evolution 16047 0 2 00000002 00000084 [0032772517212763] 0.220ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#133)        evolution 16047 0 2 00000002 00000085 [0032772517213114] 0.221ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#134)        evolution 16047 0 2 00000002 00000086 [0032772517213892] 0.222ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#135)        evolution 16047 0 2 00000002 00000087 [0032772517214365] 0.223ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#136)        evolution 16047 0 2 00000002 00000088 [0032772517214833] 0.224ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bb89> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#137)        evolution 16047 0 2 00000002 00000089 [0032772517215328] 0.225ms (+0.001ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#138)        evolution 16047 0 2 00000002 0000008a [0032772517215944] 0.226ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#139)        evolution 16047 0 2 00000002 0000008b [0032772517216304] 0.226ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#140)        evolution 16047 0 2 00000002 0000008c [0032772517216633] 0.227ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#141)        evolution 16047 0 2 00000002 0000008d [0032772517216988] 0.227ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#142)        evolution 16047 0 2 00000002 0000008e [0032772517217767] 0.229ms (+0.001ms): preempt_schedule+0xa/0x70 <c027d0ca> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#143)        evolution 16047 0 2 00000002 0000008f [0032772517218428] 0.230ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#144)        evolution 16047 0 2 00000002 00000090 [0032772517218860] 0.230ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bb89> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#145)        evolution 16047 0 2 00000002 00000091 [0032772517219279] 0.231ms (+0.001ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#146)        evolution 16047 0 2 00000002 00000092 [0032772517219882] 0.232ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#147)        evolution 16047 0 2 00000002 00000093 [0032772517220246] 0.233ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#148)        evolution 16047 0 2 00000002 00000094 [0032772517220606] 0.233ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#149)        evolution 16047 0 2 00000002 00000095 [0032772517221027] 0.234ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#150)        evolution 16047 0 2 00000002 00000096 [0032772517221808] 0.235ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#151)        evolution 16047 0 2 00000002 00000097 [0032772517222276] 0.236ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#152)        evolution 16047 0 2 00000002 00000098 [0032772517222721] 0.237ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bb89> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#153)        evolution 16047 0 2 00000002 00000099 [0032772517223176] 0.238ms (+0.001ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#154)        evolution 16047 0 2 00000002 0000009a [0032772517223779] 0.239ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#155)        evolution 16047 0 2 00000002 0000009b [0032772517224143] 0.239ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#156)        evolution 16047 0 2 00000002 0000009c [0032772517224476] 0.240ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#157)        evolution 16047 0 2 00000002 0000009d [0032772517224823] 0.240ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#158)        evolution 16047 0 2 00000002 0000009e [0032772517225606] 0.242ms (+0.001ms): preempt_schedule+0xa/0x70 <c027d0ca> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#159)        evolution 16047 0 2 00000002 0000009f [0032772517226227] 0.243ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#160)        evolution 16047 0 2 00000002 000000a0 [0032772517226668] 0.243ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bb89> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#161)        evolution 16047 0 2 00000002 000000a1 [0032772517227113] 0.244ms (+0.000ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#162)        evolution 16047 0 2 00000002 000000a2 [0032772517227712] 0.245ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#163)        evolution 16047 0 2 00000002 000000a3 [0032772517228072] 0.246ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#164)        evolution 16047 0 2 00000002 000000a4 [0032772517228400] 0.246ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#165)        evolution 16047 0 2 00000002 000000a5 [0032772517228751] 0.247ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#166)        evolution 16047 0 2 00000002 000000a6 [0032772517229539] 0.248ms (+0.001ms): preempt_schedule+0xa/0x70 <c027d0ca> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#167)        evolution 16047 0 2 00000002 000000a7 [0032772517230209] 0.249ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#168)        evolution 16047 0 2 00000002 000000a8 [0032772517230646] 0.250ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bb89> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#169)        evolution 16047 0 2 00000002 000000a9 [0032772517231064] 0.251ms (+0.001ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#170)        evolution 16047 0 2 00000002 000000aa [0032772517231667] 0.252ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#171)        evolution 16047 0 2 00000002 000000ab [0032772517232041] 0.252ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#172)        evolution 16047 0 2 00000002 000000ac [0032772517232374] 0.253ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#173)        evolution 16047 0 2 00000002 000000ad [0032772517232734] 0.254ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#174)        evolution 16047 0 2 00000002 000000ae [0032772517233521] 0.255ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#175)        evolution 16047 0 2 00000002 000000af [0032772517234102] 0.256ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#176)        evolution 16047 0 2 00000002 000000b0 [0032772517234534] 0.257ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bb89> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#177)        evolution 16047 0 2 00000002 000000b1 [0032772517235087] 0.257ms (+0.001ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#178)        evolution 16047 0 2 00000002 000000b2 [0032772517235695] 0.258ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#179)        evolution 16047 0 2 00000002 000000b3 [0032772517236064] 0.259ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#180)        evolution 16047 0 2 00000002 000000b4 [0032772517236392] 0.260ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#181)        evolution 16047 0 2 00000002 000000b5 [0032772517236739] 0.260ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#182)        evolution 16047 0 2 00000002 000000b6 [0032772517237517] 0.262ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#183)        evolution 16047 0 2 00000002 000000b7 [0032772517238093] 0.262ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#184)        evolution 16047 0 2 00000002 000000b8 [0032772517238543] 0.263ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bb89> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#185)        evolution 16047 0 2 00000002 000000b9 [0032772517238998] 0.264ms (+0.001ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#186)        evolution 16047 0 2 00000002 000000ba [0032772517239614] 0.265ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#187)        evolution 16047 0 2 00000002 000000bb [0032772517239988] 0.266ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#188)        evolution 16047 0 2 00000002 000000bc [0032772517240330] 0.266ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#189)        evolution 16047 0 2 00000002 000000bd [0032772517240690] 0.267ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#190)        evolution 16047 0 3 00000003 000000be [0032772517241338] 0.268ms (+0.001ms): free_pages_bulk+0xe/0x200 <c0138fde> (free_hot_cold_page+0x103/0x130 <c01395d3>)
(T1/#191)        evolution 16047 0 3 00000004 000000bf [0032772517242121] 0.269ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#192)        evolution 16047 0 3 00000004 000000c0 [0032772517242566] 0.270ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#193)        evolution 16047 0 3 00000004 000000c1 [0032772517243291] 0.271ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#194)        evolution 16047 0 3 00000004 000000c2 [0032772517243736] 0.272ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#195)        evolution 16047 0 3 00000004 000000c3 [0032772517244461] 0.273ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#196)        evolution 16047 0 3 00000004 000000c4 [0032772517244915] 0.274ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#197)        evolution 16047 0 3 00000004 000000c5 [0032772517245653] 0.275ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#198)        evolution 16047 0 3 00000004 000000c6 [0032772517246099] 0.276ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#199)        evolution 16047 0 3 00000004 000000c7 [0032772517246738] 0.277ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#200)        evolution 16047 0 3 00000004 000000c8 [0032772517247188] 0.278ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#201)        evolution 16047 0 3 00000004 000000c9 [0032772517247939] 0.279ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#202)        evolution 16047 0 3 00000004 000000ca [0032772517248398] 0.280ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#203)        evolution 16047 0 3 00000004 000000cb [0032772517249163] 0.281ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#204)        evolution 16047 0 3 00000004 000000cc [0032772517249622] 0.282ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#205)        evolution 16047 0 3 00000004 000000cd [0032772517250338] 0.283ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#206)        evolution 16047 0 3 00000004 000000ce [0032772517250788] 0.284ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#207)        evolution 16047 0 3 00000004 000000cf [0032772517251499] 0.285ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#208)        evolution 16047 0 3 00000004 000000d0 [0032772517251944] 0.286ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#209)        evolution 16047 0 3 00000004 000000d1 [0032772517252574] 0.287ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#210)        evolution 16047 0 3 00000004 000000d2 [0032772517253020] 0.287ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#211)        evolution 16047 0 3 00000004 000000d3 [0032772517253735] 0.289ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#212)        evolution 16047 0 3 00000004 000000d4 [0032772517254190] 0.289ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#213)        evolution 16047 0 3 00000004 000000d5 [0032772517254923] 0.291ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#214)        evolution 16047 0 3 00000004 000000d6 [0032772517255373] 0.291ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#215)        evolution 16047 0 3 00000004 000000d7 [0032772517256089] 0.292ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#216)        evolution 16047 0 3 00000004 000000d8 [0032772517256539] 0.293ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#217)        evolution 16047 0 3 00000004 000000d9 [0032772517257218] 0.294ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#218)        evolution 16047 0 3 00000004 000000da [0032772517257700] 0.295ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#219)        evolution 16047 0 3 00000004 000000db [0032772517258402] 0.296ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#220)        evolution 16047 0 3 00000004 000000dc [0032772517258852] 0.297ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#221)        evolution 16047 0 3 00000004 000000dd [0032772517259648] 0.298ms (+0.000ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0xc0/0x200 <c0139090>)
(T1/#222)        evolution 16047 0 3 00000004 000000de [0032772517260098] 0.299ms (+0.001ms): bad_range+0xb/0x60 <c0138eeb> (free_pages_bulk+0x114/0x200 <c01390e4>)
(T1/#223)        evolution 16047 0 3 00000003 000000df [0032772517260737] 0.300ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (free_pages_bulk+0x1e5/0x200 <c01391b5>)
(T1/#224)        evolution 16047 0 2 00000002 000000e0 [0032772517261268] 0.301ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#225)        evolution 16047 0 2 00000002 000000e1 [0032772517261732] 0.302ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#226)        evolution 16047 0 2 00000002 000000e2 [0032772517262177] 0.303ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bb89> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#227)        evolution 16047 0 2 00000002 000000e3 [0032772517262627] 0.303ms (+0.000ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#228)        evolution 16047 0 2 00000002 000000e4 [0032772517263226] 0.304ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#229)        evolution 16047 0 2 00000002 000000e5 [0032772517263595] 0.305ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#230)        evolution 16047 0 2 00000002 000000e6 [0032772517263977] 0.306ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#231)        evolution 16047 0 2 00000002 000000e7 [0032772517264328] 0.306ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#232)        evolution 16047 0 2 00000002 000000e8 [0032772517265129] 0.308ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#233)        evolution 16047 0 2 00000002 000000e9 [0032772517265606] 0.308ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#234)        evolution 16047 0 2 00000002 000000ea [0032772517266056] 0.309ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bb89> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#235)        evolution 16047 0 2 00000002 000000eb [0032772517266547] 0.310ms (+0.001ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#236)        evolution 16047 0 2 00000002 000000ec [0032772517267150] 0.311ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#237)        evolution 16047 0 2 00000002 000000ed [0032772517267514] 0.312ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#238)        evolution 16047 0 2 00000002 000000ee [0032772517267852] 0.312ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#239)        evolution 16047 0 2 00000002 000000ef [0032772517268207] 0.313ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#240)        evolution 16047 0 2 00000002 000000f0 [0032772517268995] 0.314ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#241)        evolution 16047 0 2 00000002 000000f1 [0032772517269458] 0.315ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#242)        evolution 16047 0 2 00000002 000000f2 [0032772517269890] 0.315ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bb89> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#243)        evolution 16047 0 2 00000002 000000f3 [0032772517270331] 0.316ms (+0.000ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#244)        evolution 16047 0 2 00000002 000000f4 [0032772517270930] 0.317ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#245)        evolution 16047 0 2 00000002 000000f5 [0032772517271290] 0.318ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#246)        evolution 16047 0 2 00000002 000000f6 [0032772517271618] 0.318ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#247)        evolution 16047 0 2 00000002 000000f7 [0032772517271965] 0.319ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#248)        evolution 16047 0 2 00000002 000000f8 [0032772517272739] 0.320ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#249)        evolution 16047 0 2 00000002 000000f9 [0032772517273216] 0.321ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#250)        evolution 16047 0 2 00000002 000000fa [0032772517273670] 0.322ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bb89> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#251)        evolution 16047 0 2 00000002 000000fb [0032772517274111] 0.322ms (+0.001ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#252)        evolution 16047 0 2 00000002 000000fc [0032772517274723] 0.324ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#253)        evolution 16047 0 2 00000002 000000fd [0032772517275097] 0.324ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#254)        evolution 16047 0 2 00000002 000000fe [0032772517275439] 0.325ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#255)        evolution 16047 0 2 00000002 000000ff [0032772517275790] 0.325ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#256)        evolution 16047 0 2 00000002 00000100 [0032772517276568] 0.327ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#257)        evolution 16047 0 2 00000002 00000101 [0032772517277041] 0.327ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#258)        evolution 16047 0 2 00000002 00000102 [0032772517277486] 0.328ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bb89> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#259)        evolution 16047 0 2 00000002 00000103 [0032772517277923] 0.329ms (+0.001ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#260)        evolution 16047 0 2 00000002 00000104 [0032772517278530] 0.330ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#261)        evolution 16047 0 2 00000002 00000105 [0032772517278899] 0.330ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#262)        evolution 16047 0 2 00000002 00000106 [0032772517279327] 0.331ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#263)        evolution 16047 0 2 00000002 00000107 [0032772517279673] 0.332ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#264)        evolution 16047 0 2 00000002 00000108 [0032772517280456] 0.333ms (+0.005ms): preempt_schedule+0xa/0x70 <c027d0ca> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#265)        evolution 16047 0 2 00000002 00000109 [0032772517283989] 0.339ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#266)        evolution 16047 0 2 00000002 0000010a [0032772517284425] 0.340ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bb89> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#267)        evolution 16047 0 2 00000002 0000010b [0032772517284871] 0.340ms (+0.001ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#268)        evolution 16047 0 2 00000002 0000010c [0032772517285474] 0.341ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#269)        evolution 16047 0 2 00000002 0000010d [0032772517285838] 0.342ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#270)        evolution 16047 0 2 00000002 0000010e [0032772517286171] 0.343ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#271)        evolution 16047 0 2 00000002 0000010f [0032772517286531] 0.343ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#272)        evolution 16047 0 2 00000002 00000110 [0032772517287314] 0.345ms (+0.001ms): preempt_schedule+0xa/0x70 <c027d0ca> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#273)        evolution 16047 0 2 00000001 00000111 [0032772517288385] 0.346ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (exit_mmap+0x164/0x1b0 <c01480a4>)
(T1/#274)        evolution 16047 0 2 00000000 00000112 [0032772517288876] 0.347ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (exit_mmap+0x15d/0x1b0 <c014809d>)
(T1/#275)        evolution 16047 0 3 00000000 00000113 [0032772517289389] 0.348ms (+0.000ms): __schedule+0xe/0x630 <c027c98e> (preempt_schedule+0x4f/0x70 <c027d10f>)
(T1/#276)        evolution 16047 0 3 00000000 00000114 [0032772517289753] 0.349ms (+0.001ms): profile_hit+0x9/0x50 <c0115749> (__schedule+0x3a/0x630 <c027c9ba>)
(T1/#277)        evolution 16047 0 3 00000001 00000115 [0032772517290390] 0.350ms (+0.001ms): sched_clock+0xe/0xe0 <c010c3ae> (__schedule+0x62/0x630 <c027c9e2>)
(T1/#278)        evolution 16047 0 3 00000002 00000116 [0032772517291265] 0.351ms (+0.000ms): dequeue_task+0xa/0x50 <c010f4ea> (__schedule+0x1ab/0x630 <c027cb2b>)
(T1/#279)        evolution 16047 0 3 00000002 00000117 [0032772517291697] 0.352ms (+0.000ms): recalc_task_prio+0xc/0x1a0 <c010f64c> (__schedule+0x1c5/0x630 <c027cb45>)
(T1/#280)        evolution 16047 0 3 00000002 00000118 [0032772517292107] 0.352ms (+0.000ms): effective_prio+0x8/0x50 <c010f5f8> (recalc_task_prio+0xa6/0x1a0 <c010f6e6>)
(T1/#281)        evolution 16047 0 3 00000002 00000119 [0032772517292503] 0.353ms (+0.001ms): enqueue_task+0xa/0x80 <c010f53a> (__schedule+0x1cc/0x630 <c027cb4c>)
(T4/#282) [ =>        evolution ] 0.354ms (+0.001ms)
(T1/#283)            <...>     2 0 1 00000002 0000011b [0032772517293976] 0.356ms (+0.001ms): __switch_to+0xb/0x1a0 <c0100f5b> (__schedule+0x2bd/0x630 <c027cc3d>)
(T3/#284)    <...>-2     0d..2  357탎 : __schedule+0x2ea/0x630 <c027cc6a> <evolutio-16047> (77 69): 
(T1/#285)            <...>     2 0 1 00000002 0000011d [0032772517294976] 0.357ms (+0.000ms): finish_task_switch+0xc/0x90 <c010fdec> (__schedule+0x2f6/0x630 <c027cc76>)
(T1/#286)            <...>     2 0 1 00000001 0000011e [0032772517295421] 0.358ms (+0.000ms): trace_stop_sched_switched+0xa/0x150 <c012cc1a> (finish_task_switch+0x43/0x90 <c010fe23>)
(T3/#287)    <...>-2     0d..1  359탎 : trace_stop_sched_switched+0x42/0x150 <c012cc52> <<...>-2> (69 0): 
(T1/#288)            <...>     2 0 1 00000001 00000120 [0032772517296501] 0.360ms (+0.000ms): trace_stop_sched_switched+0xfe/0x150 <c012cd0e> (finish_task_switch+0x43/0x90 <c010fe23>)


vim:ft=help

--=-SNszk3XLAvNKzD7yGRtn
Content-Disposition: attachment; filename=trace3.txt
Content-Type: text/plain; name=trace3.txt; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit

preemption latency trace v1.1.4 on 2.6.11-rc4-RT-V0.7.39-02
--------------------------------------------------------------------
 latency: 327 탎, #22/22, CPU#0 | (M:preempt VP:0, KP:1, SP:1 HP:1 #P:1)
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
(T1/#0)             dpkg 16229 0 9 00000002 00000000 [0034184390920878] 0.000ms (+3535970.095ms): <676b7064> (<00746500>)
(T1/#2)             dpkg 16229 0 9 00000002 00000002 [0034184390921351] 0.000ms (+0.000ms): __trace_start_sched_wakeup+0x96/0xc0 <c012cbe6> (try_to_wake_up+0x81/0x150 <c010f911>)
(T1/#3)             dpkg 16229 0 9 00000000 00000003 [0034184390921935] 0.001ms (+0.000ms): wake_up_process+0x1c/0x30 <c010f9fc> (do_softirq+0x4b/0x60 <c01042fb>)
(T6/#4)     dpkg-16229 0dn.2    2탎!< (1)
(T1/#5)             dpkg 16229 0 2 00000001 00000005 [0034184391106965] 0.310ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0ca> (copy_pte_range+0xb7/0x1c0 <c0142ad7>)
(T1/#6)             dpkg 16229 0 2 00000001 00000006 [0034184391107405] 0.310ms (+0.000ms): __cond_resched_raw_spinlock+0x8/0x50 <c0111398> (copy_pte_range+0xa7/0x1c0 <c0142ac7>)
(T1/#7)             dpkg 16229 0 2 00000000 00000007 [0034184391107918] 0.311ms (+0.001ms): __cond_resched+0x9/0x70 <c0111329> (__cond_resched_raw_spinlock+0x3d/0x50 <c01113cd>)
(T1/#8)             dpkg 16229 0 3 00000000 00000008 [0034184391108602] 0.312ms (+0.000ms): __schedule+0xe/0x630 <c027c98e> (__cond_resched+0x45/0x70 <c0111365>)
(T1/#9)             dpkg 16229 0 3 00000000 00000009 [0034184391109088] 0.313ms (+0.000ms): profile_hit+0x9/0x50 <c0115749> (__schedule+0x3a/0x630 <c027c9ba>)
(T1/#10)             dpkg 16229 0 3 00000001 0000000a [0034184391109573] 0.314ms (+0.001ms): sched_clock+0xe/0xe0 <c010c3ae> (__schedule+0x62/0x630 <c027c9e2>)
(T1/#11)             dpkg 16229 0 3 00000002 0000000b [0034184391110546] 0.316ms (+0.000ms): dequeue_task+0xa/0x50 <c010f4ea> (__schedule+0x1ab/0x630 <c027cb2b>)
(T1/#12)             dpkg 16229 0 3 00000002 0000000c [0034184391110969] 0.316ms (+0.000ms): recalc_task_prio+0xc/0x1a0 <c010f64c> (__schedule+0x1c5/0x630 <c027cb45>)
(T1/#13)             dpkg 16229 0 3 00000002 0000000d [0034184391111383] 0.317ms (+0.000ms): effective_prio+0x8/0x50 <c010f5f8> (recalc_task_prio+0xa6/0x1a0 <c010f6e6>)
(T1/#14)             dpkg 16229 0 3 00000002 0000000e [0034184391111775] 0.318ms (+0.001ms): enqueue_task+0xa/0x80 <c010f53a> (__schedule+0x1cc/0x630 <c027cb4c>)
(T4/#15) [ =>             dpkg ] 0.319ms (+0.001ms)
(T1/#16)            <...>     2 0 1 00000002 00000010 [0034184391113480] 0.321ms (+0.001ms): __switch_to+0xb/0x1a0 <c0100f5b> (__schedule+0x2bd/0x630 <c027cc3d>)
(T3/#17)    <...>-2     0d..2  322탎 : __schedule+0x2ea/0x630 <c027cc6a> <dpkg-16229> (74 69): 
(T1/#18)            <...>     2 0 1 00000002 00000012 [0034184391114743] 0.323ms (+0.000ms): finish_task_switch+0xc/0x90 <c010fdec> (__schedule+0x2f6/0x630 <c027cc76>)
(T1/#19)            <...>     2 0 1 00000001 00000013 [0034184391115178] 0.323ms (+0.000ms): trace_stop_sched_switched+0xa/0x150 <c012cc1a> (finish_task_switch+0x43/0x90 <c010fe23>)
(T3/#20)    <...>-2     0d..1  324탎 : trace_stop_sched_switched+0x42/0x150 <c012cc52> <<...>-2> (69 0): 
(T1/#21)            <...>     2 0 1 00000001 00000015 [0034184391116385] 0.325ms (+0.000ms): trace_stop_sched_switched+0xfe/0x150 <c012cd0e> (finish_task_switch+0x43/0x90 <c010fe23>)


vim:ft=help

--=-SNszk3XLAvNKzD7yGRtn--

