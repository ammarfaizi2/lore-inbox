Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265978AbUIESQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUIESQg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 14:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbUIESQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 14:16:36 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:63716 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265978AbUIESQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 14:16:32 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org
In-Reply-To: <20040905140249.GA23502@elte.hu>
References: <20040903120957.00665413@mango.fruits.de>
	 <20040904195141.GA6208@elte.hu>  <20040905140249.GA23502@elte.hu>
Content-Type: text/plain
Message-Id: <1094408203.4445.5.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 05 Sep 2004 14:16:44 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-05 at 10:02, Ingo Molnar wrote:
> i've released -R5:
>  
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk12-R5
> 
> 2.6.9-rc1-bk12 patching order is:
> 
>    http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
>  + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc1.bz2
>  + http://redhat.com/~mingo/voluntary-preempt/patch-2.6.9-rc1-bk12.bz2
> 

Ok, first new one in a while.  This was with -R0, but I haven't seen
anyone else report it.  Let me know if you need the complete trace.

preemption latency trace v1.0.2
-------------------------------
 latency: 511 us, entries: 951 (951)
    -----------------
    | task: dbench/4810, uid:1000 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: kill_pg_info+0x10/0x50
 => ended at:   kill_pg_info+0x2e/0x50
=======>
00000001 0.000ms (+0.000ms): kill_pg_info (sys_kill)
00000001 0.000ms (+0.000ms): __kill_pg_info (kill_pg_info)
00000001 0.000ms (+0.000ms): find_pid (__kill_pg_info)
00000001 0.001ms (+0.000ms): group_send_sig_info (__kill_pg_info)
00000001 0.001ms (+0.000ms): check_kill_permission (group_send_sig_info)
00000001 0.002ms (+0.000ms): dummy_task_kill (check_kill_permission)
00000002 0.002ms (+0.000ms): __group_send_sig_info (group_send_sig_info)
00000002 0.003ms (+0.000ms): handle_stop_signal (__group_send_sig_info)
00000002 0.003ms (+0.000ms): rm_from_queue (handle_stop_signal)
00000002 0.004ms (+0.000ms): rm_from_queue (handle_stop_signal)
00000002 0.004ms (+0.000ms): wake_up_state (handle_stop_signal)
00000002 0.005ms (+0.000ms): try_to_wake_up (wake_up_state)
00000002 0.005ms (+0.000ms): task_rq_lock (try_to_wake_up)
00000002 0.006ms (+0.000ms): next_thread (handle_stop_signal)
00000002 0.006ms (+0.000ms): sig_ignored (__group_send_sig_info)
00000002 0.007ms (+0.000ms): send_signal (__group_send_sig_info)
00000002 0.008ms (+0.000ms): kmem_cache_alloc (send_signal)
00000002 0.009ms (+0.001ms): memcpy (send_signal)

[...]

00000002 0.496ms (+0.000ms): kmem_cache_alloc (send_signal)
00000002 0.497ms (+0.000ms): memcpy (send_signal)
00000002 0.498ms (+0.000ms): __group_complete_signal (__group_send_sig_info)
00000002 0.498ms (+0.000ms): task_curr (__group_complete_signal)
00000001 0.498ms (+0.000ms): preempt_schedule (group_send_sig_info)
00000001 0.499ms (+0.000ms): group_send_sig_info (__kill_pg_info)
00000001 0.499ms (+0.000ms): check_kill_permission (group_send_sig_info)
00000001 0.499ms (+0.000ms): dummy_task_kill (check_kill_permission)
00000002 0.500ms (+0.000ms): __group_send_sig_info (group_send_sig_info)
00000002 0.500ms (+0.000ms): handle_stop_signal (__group_send_sig_info)
00000002 0.501ms (+0.000ms): rm_from_queue (handle_stop_signal)
00000002 0.501ms (+0.000ms): rm_from_queue (handle_stop_signal)
00000002 0.502ms (+0.000ms): wake_up_state (handle_stop_signal)
00000002 0.502ms (+0.000ms): try_to_wake_up (wake_up_state)
00000002 0.503ms (+0.000ms): task_rq_lock (try_to_wake_up)
00000003 0.503ms (+0.000ms): activate_task (try_to_wake_up)
00000003 0.503ms (+0.000ms): sched_clock (activate_task)
00000003 0.504ms (+0.000ms): recalc_task_prio (activate_task)
00000003 0.505ms (+0.000ms): effective_prio (recalc_task_prio)
00000003 0.505ms (+0.000ms): enqueue_task (activate_task)
00000002 0.505ms (+0.000ms): preempt_schedule (try_to_wake_up)
00000002 0.506ms (+0.000ms): next_thread (handle_stop_signal)
00000002 0.506ms (+0.000ms): sig_ignored (__group_send_sig_info)
00000002 0.507ms (+0.000ms): send_signal (__group_send_sig_info)
00000002 0.507ms (+0.000ms): kmem_cache_alloc (send_signal)
00000002 0.508ms (+0.000ms): cache_alloc_refill (kmem_cache_alloc)
00000002 0.509ms (+0.001ms): preempt_schedule (cache_alloc_refill)
00000002 0.510ms (+0.000ms): memcpy (send_signal)
00000002 0.510ms (+0.000ms): __group_complete_signal (__group_send_sig_info)
00000002 0.511ms (+0.000ms): task_curr (__group_complete_signal)
00000001 0.511ms (+0.000ms): preempt_schedule (group_send_sig_info)
00000001 0.512ms (+0.001ms): sub_preempt_count (kill_pg_info)
00000001 0.513ms (+0.000ms): update_max_trace (check_preempt_timing)
00000001 0.513ms (+0.000ms): _mmx_memcpy (update_max_trace)
00000001 0.514ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)

Lee

