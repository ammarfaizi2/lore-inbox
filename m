Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266749AbUHZC3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266749AbUHZC3W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 22:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266756AbUHZC3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 22:29:22 -0400
Received: from web13926.mail.yahoo.com ([66.163.176.51]:26449 "HELO
	web13926.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266749AbUHZC3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 22:29:06 -0400
Message-ID: <20040826023028.39690.qmail@web13926.mail.yahoo.com>
Date: Wed, 25 Aug 2004 19:30:28 -0700 (PDT)
From: <spaminos-ker@yahoo.com>
Reply-To: spaminos-ker@yahoo.com
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin and others)
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <412BC984.6060408@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Peter Williams <pwil3058@bigpond.net.au> wrote:
> You could try Lee Revell's (rlrevell@joe-job.com) latency measuring 
> patches and also try applying Ingo Molnar's (mingo@elte.hu) 
> voluntary-preempt patches.
> 
> Peter

I tried 2.6.8.1 with voluntary-preempt-2.6.8.1-P9 and I am getting latency
messages, they trigger at around the same time I get "delta = 3" messages.

I guess that there is no way to have the latency reporting work with the zaphod
patch?

I hope those messages are giving a clue on what is going on on this box...

Are this kind of latencies normal (reminder this is an Athlon XP 1800+ ie
1.5MHz)?
00010006 0.144ms (+0.000ms): task_rq_lock (try_to_wake_up)
00010007 0.144ms (+0.000ms): activate_task (try_to_wake_up)
00010007 0.144ms (+0.000ms): sched_clock (activate_task)
00010007 0.144ms (+0.000ms): recalc_task_prio (activate_task)
00010007 0.144ms (+0.000ms): effective_prio (recalc_task_prio)
00010007 0.144ms (+0.000ms): enqueue_task (activate_task)

Anyway, here are the full messages:
Aug 25 19:10:01 localhost kernel: (ksoftirqd/0/3): new 163 us maximum-latency
critical section.
Aug 25 19:10:01 localhost kernel:  => started at:
<netif_receive_skb+0x81/0x1e0>
Aug 25 19:10:01 localhost kernel:  => ended at:  
<netif_receive_skb+0x167/0x1e0>
Aug 25 19:10:01 localhost kernel:  [<c013eec7>]
check_preempt_timing+0x1c7/0x230
Aug 25 19:10:01 localhost kernel:  [<c031ae57>] netif_receive_skb+0x167/0x1e0
Aug 25 19:10:01 localhost kernel:  [<c031ae57>] netif_receive_skb+0x167/0x1e0
Aug 25 19:10:01 localhost kernel:  [<c013f074>] sub_preempt_count+0x54/0x60
Aug 25 19:10:01 localhost kernel:  [<c013f074>] sub_preempt_count+0x54/0x60
Aug 25 19:10:01 localhost kernel:  [<c031ae57>] netif_receive_skb+0x167/0x1e0
Aug 25 19:10:01 localhost kernel:  [<c0310008>] sock_release+0xf8/0x110
Aug 25 19:10:01 localhost kernel:  [<c031af5a>] process_backlog+0x8a/0x150
Aug 25 19:10:01 localhost kernel:  [<c031b0ae>] net_rx_action+0x8e/0x120
Aug 25 19:10:01 localhost kernel:  [<c01248a2>] ___do_softirq+0xa2/0xb0
Aug 25 19:10:01 localhost kernel:  [<c012492e>] _do_softirq+0xe/0x20
Aug 25 19:10:01 localhost kernel:  [<c0124eb5>] ksoftirqd+0xa5/0x110
Aug 25 19:10:01 localhost kernel:  [<c013723c>] kthread+0xbc/0xd0
Aug 25 19:10:01 localhost kernel:  [<c0124e10>] ksoftirqd+0x0/0x110
Aug 25 19:10:01 localhost kernel:  [<c0137180>] kthread+0x0/0xd0
Aug 25 19:10:01 localhost kernel:  [<c01044b9>] kernel_thread_helper+0x5/0xc


preemption latency trace v1.0.2
-------------------------------
 latency: 163 us, entries: 194 (194)
    -----------------
    | task: ksoftirqd/0/3, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: netif_receive_skb+0x81/0x1e0
 => ended at:   netif_receive_skb+0x167/0x1e0
=======>
00000001 0.000ms (+0.000ms): netif_receive_skb (process_backlog)
00000001 0.001ms (+0.001ms): ip_rcv (netif_receive_skb)
00000001 0.005ms (+0.003ms): nf_hook_slow (ip_rcv)
00000002 0.006ms (+0.001ms): nf_iterate (nf_hook_slow)
00000002 0.007ms (+0.001ms): ip_conntrack_defrag (nf_iterate)
00000002 0.008ms (+0.000ms): ip_conntrack_in (nf_iterate)
00000002 0.008ms (+0.000ms): ip_ct_find_proto (ip_conntrack_in)
00000103 0.009ms (+0.000ms): __ip_ct_find_proto (ip_ct_find_proto)
00000102 0.009ms (+0.000ms): local_bh_enable (ip_ct_find_proto)
00000002 0.010ms (+0.000ms): get_tuple (ip_conntrack_in)
00000002 0.010ms (+0.000ms): tcp_pkt_to_tuple (get_tuple)
00000002 0.011ms (+0.000ms): skb_copy_bits (tcp_pkt_to_tuple)
00000002 0.013ms (+0.001ms): ip_conntrack_find_get (ip_conntrack_in)
00000103 0.013ms (+0.000ms): __ip_conntrack_find (ip_conntrack_find_get)
00000103 0.013ms (+0.000ms): hash_conntrack (__ip_conntrack_find)
00000102 0.015ms (+0.001ms): local_bh_enable (ip_conntrack_find_get)
00000002 0.015ms (+0.000ms): tcp_packet (ip_conntrack_in)
00000002 0.015ms (+0.000ms): skb_copy_bits (tcp_packet)
00000103 0.016ms (+0.000ms): get_conntrack_index (tcp_packet)
00000102 0.017ms (+0.000ms): local_bh_enable (tcp_packet)
00000002 0.017ms (+0.000ms): ip_ct_refresh (tcp_packet)
00000103 0.018ms (+0.000ms): del_timer (ip_ct_refresh)
00000103 0.019ms (+0.001ms): __mod_timer (ip_ct_refresh)
00000105 0.019ms (+0.000ms): internal_add_timer (__mod_timer)
00000102 0.019ms (+0.000ms): local_bh_enable (tcp_packet)
00000002 0.020ms (+0.000ms): ipt_route_hook (nf_iterate)
00000002 0.020ms (+0.000ms): ipt_do_table (ipt_route_hook)
00000102 0.024ms (+0.003ms): local_bh_enable (ipt_do_table)
00000002 0.024ms (+0.000ms): ip_nat_fn (nf_iterate)
00000002 0.024ms (+0.000ms): ip_conntrack_get (ip_nat_fn)
00000002 0.026ms (+0.001ms): do_bindings (ip_nat_fn)
00000102 0.027ms (+0.001ms): local_bh_enable (do_bindings)
00000002 0.029ms (+0.001ms): ip_rcv_finish (nf_hook_slow)
00000002 0.030ms (+0.001ms): ip_route_input (ip_rcv_finish)
00000002 0.030ms (+0.000ms): rt_hash_code (ip_route_input)
00000002 0.035ms (+0.004ms): ip_local_deliver (ip_rcv_finish)
00000002 0.036ms (+0.000ms): nf_hook_slow (ip_local_deliver)
00000003 0.036ms (+0.000ms): nf_iterate (nf_hook_slow)
00000003 0.036ms (+0.000ms): ipt_route_hook (nf_iterate)
00000003 0.036ms (+0.000ms): ipt_do_table (ipt_route_hook)
00000103 0.037ms (+0.001ms): local_bh_enable (ipt_do_table)
00000003 0.038ms (+0.000ms): ipt_hook (nf_iterate)
00000003 0.038ms (+0.000ms): ipt_do_table (ipt_hook)
00000103 0.039ms (+0.001ms): local_bh_enable (ipt_do_table)
00000003 0.040ms (+0.000ms): ip_confirm (nf_iterate)
00000003 0.040ms (+0.000ms): ip_local_deliver_finish (nf_hook_slow)
00000004 0.042ms (+0.002ms): tcp_v4_rcv (ip_local_deliver_finish)
00000004 0.043ms (+0.001ms): tcp_v4_checksum_init (tcp_v4_rcv)
00000004 0.045ms (+0.001ms): skb_checksum (tcp_v4_checksum_init)
00000005 0.053ms (+0.008ms): tcp_v4_do_rcv (tcp_v4_rcv)
00000005 0.054ms (+0.000ms): tcp_rcv_state_process (tcp_v4_do_rcv)
00000005 0.057ms (+0.002ms): tcp_ack (tcp_rcv_state_process)
00000005 0.058ms (+0.001ms): tcp_ack_update_window (tcp_ack)
00000005 0.061ms (+0.002ms): tcp_clean_rtx_queue (tcp_ack)
00000005 0.063ms (+0.002ms): __kfree_skb (tcp_clean_rtx_queue)
00000005 0.064ms (+0.000ms): kfree_skbmem (__kfree_skb)
00000005 0.064ms (+0.000ms): skb_release_data (kfree_skbmem)
00000005 0.066ms (+0.001ms): kfree (kfree_skbmem)
00000005 0.066ms (+0.000ms): kmem_cache_free (kfree_skbmem)
00000005 0.067ms (+0.000ms): tcp_ack_no_tstamp (tcp_clean_rtx_queue)
00000005 0.067ms (+0.000ms): tcp_rtt_estimator (tcp_ack_no_tstamp)
00000005 0.074ms (+0.006ms): tcp_reset_keepalive_timer (tcp_rcv_state_process)
00000005 0.075ms (+0.000ms): sk_reset_timer (tcp_reset_keepalive_timer)
00000005 0.075ms (+0.000ms): mod_timer (sk_reset_timer)
00000005 0.075ms (+0.000ms): __mod_timer (sk_reset_timer)
00000007 0.076ms (+0.000ms): internal_add_timer (__mod_timer)
00000005 0.077ms (+0.000ms): tcp_urg (tcp_rcv_state_process)
00000005 0.077ms (+0.000ms): tcp_data_queue (tcp_rcv_state_process)
00000005 0.080ms (+0.002ms): sk_stream_mem_schedule (tcp_data_queue)
00000005 0.081ms (+0.001ms): tcp_fin (tcp_data_queue)
00000005 0.083ms (+0.001ms): tcp_send_ack (tcp_fin)
00000005 0.083ms (+0.000ms): alloc_skb (tcp_send_ack)
00000005 0.083ms (+0.000ms): kmem_cache_alloc (alloc_skb)
00000005 0.083ms (+0.000ms): __kmalloc (alloc_skb)
00000005 0.084ms (+0.001ms): tcp_transmit_skb (tcp_send_ack)
00000005 0.087ms (+0.003ms): __tcp_select_window (tcp_transmit_skb)
00000005 0.090ms (+0.003ms): tcp_v4_send_check (tcp_transmit_skb)
00000005 0.092ms (+0.001ms): ip_queue_xmit (tcp_transmit_skb)
00000005 0.097ms (+0.005ms): nf_hook_slow (ip_queue_xmit)
00000006 0.097ms (+0.000ms): nf_iterate (nf_hook_slow)
00000006 0.098ms (+0.000ms): ip_conntrack_defrag (nf_iterate)
00000006 0.098ms (+0.000ms): ip_conntrack_local (nf_iterate)
00000006 0.098ms (+0.000ms): ip_conntrack_in (nf_iterate)
00000006 0.099ms (+0.000ms): ip_ct_find_proto (ip_conntrack_in)
00000107 0.099ms (+0.000ms): __ip_ct_find_proto (ip_ct_find_proto)
00000106 0.099ms (+0.000ms): local_bh_enable (ip_ct_find_proto)
00000006 0.099ms (+0.000ms): get_tuple (ip_conntrack_in)
00000006 0.100ms (+0.000ms): tcp_pkt_to_tuple (get_tuple)
00000006 0.100ms (+0.000ms): skb_copy_bits (tcp_pkt_to_tuple)
00000006 0.100ms (+0.000ms): ip_conntrack_find_get (ip_conntrack_in)
00000107 0.100ms (+0.000ms): __ip_conntrack_find (ip_conntrack_find_get)
00000107 0.100ms (+0.000ms): hash_conntrack (__ip_conntrack_find)
00000106 0.101ms (+0.000ms): local_bh_enable (ip_conntrack_find_get)
00000006 0.101ms (+0.000ms): tcp_packet (ip_conntrack_in)
00000006 0.101ms (+0.000ms): skb_copy_bits (tcp_packet)
00000107 0.101ms (+0.000ms): get_conntrack_index (tcp_packet)
00000106 0.101ms (+0.000ms): local_bh_enable (tcp_packet)
00000006 0.102ms (+0.000ms): ip_ct_refresh (tcp_packet)
00000107 0.102ms (+0.000ms): del_timer (ip_ct_refresh)
00000107 0.102ms (+0.000ms): __mod_timer (ip_ct_refresh)
00000109 0.102ms (+0.000ms): internal_add_timer (__mod_timer)
00000106 0.102ms (+0.000ms): local_bh_enable (tcp_packet)
00000006 0.103ms (+0.000ms): ipt_local_hook (nf_iterate)
00000006 0.103ms (+0.000ms): ipt_do_table (ipt_local_hook)
00000106 0.104ms (+0.001ms): local_bh_enable (ipt_do_table)
00000006 0.105ms (+0.000ms): ipt_local_out_hook (nf_iterate)
00000006 0.105ms (+0.000ms): ipt_do_table (ipt_local_out_hook)
00000106 0.107ms (+0.001ms): local_bh_enable (ipt_do_table)
00000006 0.107ms (+0.000ms): dst_output (nf_hook_slow)
00000006 0.108ms (+0.000ms): ip_output (dst_output)
00000006 0.108ms (+0.000ms): ip_finish_output (dst_output)
00000006 0.109ms (+0.000ms): nf_hook_slow (ip_finish_output)
00000007 0.109ms (+0.000ms): nf_iterate (nf_hook_slow)
00000007 0.109ms (+0.000ms): ipt_route_hook (nf_iterate)
00000007 0.109ms (+0.000ms): ipt_do_table (ipt_route_hook)
00000107 0.110ms (+0.000ms): local_bh_enable (ipt_do_table)
00000007 0.110ms (+0.000ms): ip_nat_out (nf_iterate)
00000007 0.111ms (+0.000ms): ip_nat_fn (nf_iterate)
00000007 0.111ms (+0.000ms): ip_conntrack_get (ip_nat_fn)
00000007 0.111ms (+0.000ms): do_bindings (ip_nat_fn)
00000107 0.112ms (+0.000ms): local_bh_enable (do_bindings)
00000007 0.112ms (+0.000ms): ip_refrag (nf_iterate)
00000007 0.112ms (+0.000ms): ip_confirm (ip_refrag)
00000007 0.112ms (+0.000ms): ip_finish_output2 (nf_hook_slow)
00000107 0.114ms (+0.001ms): local_bh_enable (ip_finish_output2)
00000007 0.115ms (+0.000ms): dev_queue_xmit (ip_finish_output2)
00000109 0.116ms (+0.001ms): pfifo_fast_enqueue (dev_queue_xmit)
00000109 0.117ms (+0.000ms): qdisc_restart (dev_queue_xmit)
00000109 0.118ms (+0.000ms): pfifo_fast_dequeue (qdisc_restart)
00000109 0.120ms (+0.001ms): speedo_start_xmit (qdisc_restart)
0000010a 0.122ms (+0.002ms): __const_udelay (speedo_start_xmit)
0000010a 0.123ms (+0.000ms): __delay (speedo_start_xmit)
0000010a 0.123ms (+0.000ms): delay_tsc (__delay)
00000109 0.126ms (+0.002ms): qdisc_restart (dev_queue_xmit)
00000109 0.126ms (+0.000ms): pfifo_fast_dequeue (qdisc_restart)
00000108 0.126ms (+0.000ms): local_bh_enable (dev_queue_xmit)
00000005 0.128ms (+0.001ms): tcp_time_wait (tcp_fin)
00000005 0.129ms (+0.000ms): kmem_cache_alloc (tcp_time_wait)
00000005 0.130ms (+0.001ms): __tcp_tw_hashdance (tcp_time_wait)
00000005 0.134ms (+0.003ms): tcp_tw_schedule (tcp_time_wait)
00000005 0.136ms (+0.001ms): tcp_update_metrics (tcp_time_wait)
00010005 0.138ms (+0.001ms): do_IRQ (tcp_update_metrics)
00010006 0.138ms (+0.000ms): mask_and_ack_8259A (do_IRQ)
00010006 0.143ms (+0.005ms): generic_redirect_hardirq (do_IRQ)
00010006 0.144ms (+0.000ms): wake_up_process (generic_redirect_hardirq)
00010006 0.144ms (+0.000ms): try_to_wake_up (wake_up_process)
00010006 0.144ms (+0.000ms): task_rq_lock (try_to_wake_up)
00010007 0.144ms (+0.000ms): activate_task (try_to_wake_up)
00010007 0.144ms (+0.000ms): sched_clock (activate_task)
00010007 0.144ms (+0.000ms): recalc_task_prio (activate_task)
00010007 0.144ms (+0.000ms): effective_prio (recalc_task_prio)
00010007 0.144ms (+0.000ms): enqueue_task (activate_task)
00000005 0.145ms (+0.000ms): smp_apic_timer_interrupt (tcp_update_metrics)
00010005 0.145ms (+0.000ms): update_process_times (smp_apic_timer_interrupt)
00010005 0.146ms (+0.000ms): update_one_process (update_process_times)
00010005 0.146ms (+0.000ms): run_local_timers (update_process_times)
00010005 0.147ms (+0.000ms): raise_softirq (update_process_times)
00010005 0.147ms (+0.000ms): scheduler_tick (update_process_times)
00010005 0.147ms (+0.000ms): sched_clock (scheduler_tick)
00010006 0.148ms (+0.000ms): __bitmap_weight (scheduler_tick)
00010006 0.148ms (+0.000ms): task_timeslice (scheduler_tick)
00010005 0.148ms (+0.000ms): rebalance_tick (scheduler_tick)
00000006 0.148ms (+0.000ms): do_softirq (smp_apic_timer_interrupt)
00000006 0.148ms (+0.000ms): __do_softirq (do_softirq)
00000005 0.150ms (+0.001ms): tcp_unhash (tcp_time_wait)
00000005 0.151ms (+0.001ms): tcp_put_port (tcp_time_wait)
00000105 0.152ms (+0.000ms): __tcp_put_port (tcp_put_port)
00000106 0.152ms (+0.000ms): tcp_bucket_destroy (__tcp_put_port)
00000105 0.153ms (+0.000ms): local_bh_enable (tcp_time_wait)
00000005 0.153ms (+0.000ms): do_softirq (local_bh_enable)
00000005 0.153ms (+0.000ms): __do_softirq (do_softirq)
00000005 0.153ms (+0.000ms): tcp_clear_xmit_timers (tcp_time_wait)
00000005 0.154ms (+0.000ms): sk_stop_timer (tcp_clear_xmit_timers)
00000005 0.154ms (+0.000ms): del_timer (sk_stop_timer)
00000005 0.155ms (+0.001ms): sk_stop_timer (tcp_clear_xmit_timers)
00000005 0.155ms (+0.000ms): sk_stop_timer (tcp_clear_xmit_timers)
00000005 0.155ms (+0.000ms): del_timer (sk_stop_timer)
00000005 0.156ms (+0.000ms): tcp_destroy_sock (tcp_fin)
00000005 0.157ms (+0.001ms): tcp_v4_destroy_sock (tcp_destroy_sock)
00000005 0.157ms (+0.000ms): tcp_clear_xmit_timers (tcp_v4_destroy_sock)
00000005 0.157ms (+0.000ms): sk_stop_timer (tcp_clear_xmit_timers)
00000005 0.157ms (+0.000ms): sk_stop_timer (tcp_clear_xmit_timers)
00000005 0.158ms (+0.000ms): sk_stop_timer (tcp_clear_xmit_timers)
00000005 0.159ms (+0.001ms): sk_stream_kill_queues (tcp_destroy_sock)
00000005 0.159ms (+0.000ms): __kfree_skb (sk_stream_kill_queues)
00000005 0.159ms (+0.000ms): sk_stream_rfree (__kfree_skb)
00000005 0.160ms (+0.000ms): kfree_skbmem (__kfree_skb)
00000005 0.160ms (+0.000ms): skb_release_data (kfree_skbmem)
00000005 0.160ms (+0.000ms): kfree (kfree_skbmem)
00000005 0.160ms (+0.000ms): kmem_cache_free (kfree_skbmem)
00000005 0.161ms (+0.001ms): __sk_stream_mem_reclaim (sk_stream_kill_queues)
00000001 0.164ms (+0.002ms): sub_preempt_count (netif_receive_skb)
00000001 0.164ms (+0.000ms): _mmx_memcpy (check_preempt_timing)
00000001 0.165ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)

