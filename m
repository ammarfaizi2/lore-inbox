Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266013AbUHRMCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266013AbUHRMCa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 08:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266069AbUHRMCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 08:02:30 -0400
Received: from mail.gmx.de ([213.165.64.20]:41610 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266013AbUHRMBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 08:01:40 -0400
X-Authenticated: #4399952
Date: Wed, 18 Aug 2004 14:12:31 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Thomas Charbonnel <thomas@undata.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P3
Message-Id: <20040818141231.4bd5ff9d@mango.fruits.de>
In-Reply-To: <20040817080512.GA1649@elte.hu>
References: <20040816032806.GA11750@elte.hu>
	<20040816033623.GA12157@elte.hu>
	<1092627691.867.150.camel@krustophenia.net>
	<20040816034618.GA13063@elte.hu>
	<1092628493.810.3.camel@krustophenia.net>
	<20040816040515.GA13665@elte.hu>
	<1092654819.5057.18.camel@localhost>
	<20040816113131.GA30527@elte.hu>
	<20040816120933.GA4211@elte.hu>
	<1092716644.876.1.camel@krustophenia.net>
	<20040817080512.GA1649@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2004 10:05:12 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > P2 will not boot for me.  It hangs right after detecting my
> > (surprise!) USB mouse.
> 
> i've uploaded -P3 with the IO-APIC changes reverted to -P1:
> 
>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P3
> 
> it has no other changes.
> 
> 	Ingo
> 

Hi, it applied against 2.6.8.1 with some offsets and some buzz [?]. Well anyways it compiled fine and the copy_page_range latency is gone.. Now i also see the extracty entropy thing, too..

Btw: one question: at one point in time the IRQ handlers were in the SCHED_FIFO scheduling class. Why has this changed?

[top extract]:

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND 
   11 root       5 -10     0    0    0 S  0.0  0.0   0:00.00 IRQ 8    


preemption latency trace v1.0
-----------------------------
 latency: 186 us, entries: 275 (275)
 process: ksoftirqd/0/2, uid: 0
 nice: -10, policy: 0, rt_priority: 0
=======>
 0.000ms (+0.000ms): ip_rcv (netif_receive_skb)
 0.001ms (+0.001ms): ip_route_input (ip_rcv)
 0.002ms (+0.000ms): rt_hash_code (ip_route_input)
 0.003ms (+0.001ms): ip_route_input_slow (ip_rcv)
 0.004ms (+0.000ms): rt_hash_code (ip_route_input_slow)
 0.005ms (+0.001ms): fn_hash_lookup (ip_route_input_slow)
 0.006ms (+0.001ms): fib_semantic_match (fn_hash_lookup)
 0.008ms (+0.002ms): fib_validate_source (ip_route_input_slow)
 0.009ms (+0.000ms): fn_hash_lookup (fib_validate_source)
 0.010ms (+0.001ms): fn_hash_lookup (fib_validate_source)
 0.012ms (+0.001ms): fib_semantic_match (fn_hash_lookup)
 0.013ms (+0.000ms): __fib_res_prefsrc (fib_validate_source)
 0.013ms (+0.000ms): inet_select_addr (__fib_res_prefsrc)
 0.015ms (+0.001ms): dst_alloc (ip_route_input_slow)
 0.015ms (+0.000ms): kmem_cache_alloc (dst_alloc)
 0.016ms (+0.000ms): cache_alloc_refill (kmem_cache_alloc)
 0.019ms (+0.003ms): rt_intern_hash (ip_route_input_slow)
 0.020ms (+0.000ms): local_bh_enable (rt_intern_hash)
 0.021ms (+0.001ms): ip_local_deliver (ip_rcv)
 0.022ms (+0.001ms): icmp_rcv (ip_local_deliver)
 0.023ms (+0.000ms): skb_checksum (icmp_rcv)
 0.025ms (+0.001ms): icmp_echo (icmp_rcv)
 0.025ms (+0.000ms): icmp_reply (icmp_echo)
 0.026ms (+0.000ms): ip_options_echo (icmp_reply)
 0.026ms (+0.000ms): icmp_out_count (icmp_reply)
 0.028ms (+0.001ms): ip_route_output_key (icmp_reply)
 0.028ms (+0.000ms): __ip_route_output_key (ip_route_output_key)
 0.028ms (+0.000ms): rt_hash_code (__ip_route_output_key)
 0.029ms (+0.001ms): ip_route_output_slow (ip_route_output_key)
 0.030ms (+0.000ms): ip_dev_find (ip_route_output_slow)
 0.031ms (+0.000ms): fn_hash_lookup (ip_dev_find)
 0.031ms (+0.000ms): fib_semantic_match (fn_hash_lookup)
 0.032ms (+0.000ms): fn_hash_lookup (ip_route_output_slow)
 0.032ms (+0.000ms): fn_hash_lookup (ip_route_output_slow)
 0.032ms (+0.000ms): fib_semantic_match (fn_hash_lookup)
 0.033ms (+0.000ms): fn_hash_select_default (ip_route_output_slow)
 0.035ms (+0.001ms): dst_alloc (ip_route_output_slow)
 0.035ms (+0.000ms): kmem_cache_alloc (dst_alloc)
 0.036ms (+0.001ms): rt_set_nexthop (ip_route_output_slow)
 0.036ms (+0.000ms): memcpy (rt_set_nexthop)
 0.037ms (+0.000ms): set_class_tag (rt_set_nexthop)
 0.037ms (+0.000ms): rt_hash_code (ip_route_output_slow)
 0.037ms (+0.000ms): rt_intern_hash (ip_route_output_slow)
 0.038ms (+0.000ms): arp_bind_neighbour (rt_intern_hash)
 0.038ms (+0.000ms): neigh_lookup (arp_bind_neighbour)
 0.039ms (+0.000ms): arp_hash (neigh_lookup)
 0.040ms (+0.001ms): local_bh_enable (neigh_lookup)
 0.040ms (+0.000ms): local_bh_enable (rt_intern_hash)
 0.040ms (+0.000ms): icmp_push_reply (icmp_reply)
 0.041ms (+0.000ms): ip_append_data (icmp_push_reply)
 0.043ms (+0.002ms): sock_alloc_send_skb (ip_append_data)
 0.043ms (+0.000ms): sock_alloc_send_pskb (sock_alloc_send_skb)
 0.044ms (+0.000ms): alloc_skb (sock_alloc_send_pskb)
 0.044ms (+0.000ms): kmem_cache_alloc (alloc_skb)
 0.044ms (+0.000ms): __kmalloc (alloc_skb)
 0.046ms (+0.002ms): ip_push_pending_frames (icmp_reply)
 0.048ms (+0.001ms): __ip_select_ident (ip_push_pending_frames)
 0.048ms (+0.000ms): rt_bind_peer (__ip_select_ident)
 0.049ms (+0.000ms): inet_getpeer (rt_bind_peer)
 0.049ms (+0.000ms): local_bh_enable (inet_getpeer)
 0.049ms (+0.000ms): kmem_cache_alloc (inet_getpeer)
 0.050ms (+0.000ms): cache_alloc_refill (kmem_cache_alloc)
 0.051ms (+0.001ms): secure_ip_id (inet_getpeer)
 0.052ms (+0.000ms): __check_and_rekey (secure_ip_id)
 0.053ms (+0.000ms): get_random_bytes (__check_and_rekey)
 0.053ms (+0.000ms): extract_entropy (get_random_bytes)
 0.054ms (+0.000ms): extract_entropy (extract_entropy)
 0.055ms (+0.000ms): SHATransform (extract_entropy)
 0.055ms (+0.000ms): memcpy (SHATransform)
 0.058ms (+0.002ms): add_entropy_words (extract_entropy)
 0.059ms (+0.001ms): SHATransform (extract_entropy)
 0.059ms (+0.000ms): memcpy (SHATransform)
 0.061ms (+0.001ms): add_entropy_words (extract_entropy)
 0.061ms (+0.000ms): SHATransform (extract_entropy)
 0.061ms (+0.000ms): memcpy (SHATransform)
 0.063ms (+0.001ms): add_entropy_words (extract_entropy)
 0.063ms (+0.000ms): SHATransform (extract_entropy)
 0.063ms (+0.000ms): memcpy (SHATransform)
 0.065ms (+0.001ms): add_entropy_words (extract_entropy)
 0.065ms (+0.000ms): SHATransform (extract_entropy)
 0.065ms (+0.000ms): memcpy (SHATransform)
 0.066ms (+0.001ms): add_entropy_words (extract_entropy)
 0.067ms (+0.000ms): SHATransform (extract_entropy)
 0.067ms (+0.000ms): memcpy (SHATransform)
 0.068ms (+0.001ms): add_entropy_words (extract_entropy)
 0.068ms (+0.000ms): SHATransform (extract_entropy)
 0.069ms (+0.000ms): memcpy (SHATransform)
 0.070ms (+0.001ms): add_entropy_words (extract_entropy)
 0.070ms (+0.000ms): SHATransform (extract_entropy)
 0.070ms (+0.000ms): memcpy (SHATransform)
 0.072ms (+0.001ms): add_entropy_words (extract_entropy)
 0.073ms (+0.000ms): SHATransform (extract_entropy)
 0.073ms (+0.000ms): memcpy (SHATransform)
 0.074ms (+0.001ms): add_entropy_words (extract_entropy)
 0.074ms (+0.000ms): SHATransform (extract_entropy)
 0.075ms (+0.000ms): memcpy (SHATransform)
 0.076ms (+0.001ms): add_entropy_words (extract_entropy)
 0.076ms (+0.000ms): SHATransform (extract_entropy)
 0.076ms (+0.000ms): memcpy (SHATransform)
 0.078ms (+0.001ms): add_entropy_words (extract_entropy)
 0.078ms (+0.000ms): SHATransform (extract_entropy)
 0.078ms (+0.000ms): memcpy (SHATransform)
 0.080ms (+0.001ms): add_entropy_words (extract_entropy)
 0.080ms (+0.000ms): SHATransform (extract_entropy)
 0.080ms (+0.000ms): memcpy (SHATransform)
 0.082ms (+0.001ms): add_entropy_words (extract_entropy)
 0.082ms (+0.000ms): SHATransform (extract_entropy)
 0.082ms (+0.000ms): memcpy (SHATransform)
 0.084ms (+0.001ms): add_entropy_words (extract_entropy)
 0.084ms (+0.000ms): SHATransform (extract_entropy)
 0.084ms (+0.000ms): memcpy (SHATransform)
 0.086ms (+0.001ms): add_entropy_words (extract_entropy)
 0.086ms (+0.000ms): SHATransform (extract_entropy)
 0.086ms (+0.000ms): memcpy (SHATransform)
 0.088ms (+0.001ms): add_entropy_words (extract_entropy)
 0.088ms (+0.000ms): SHATransform (extract_entropy)
 0.088ms (+0.000ms): memcpy (SHATransform)
 0.090ms (+0.001ms): add_entropy_words (extract_entropy)
 0.090ms (+0.000ms): SHATransform (extract_entropy)
 0.090ms (+0.000ms): memcpy (SHATransform)
 0.091ms (+0.001ms): add_entropy_words (extract_entropy)
 0.092ms (+0.000ms): SHATransform (extract_entropy)
 0.092ms (+0.000ms): memcpy (SHATransform)
 0.093ms (+0.001ms): add_entropy_words (extract_entropy)
 0.094ms (+0.000ms): SHATransform (extract_entropy)
 0.094ms (+0.000ms): memcpy (SHATransform)
 0.095ms (+0.001ms): add_entropy_words (extract_entropy)
 0.095ms (+0.000ms): SHATransform (extract_entropy)
 0.096ms (+0.000ms): memcpy (SHATransform)
 0.097ms (+0.001ms): add_entropy_words (extract_entropy)
 0.097ms (+0.000ms): SHATransform (extract_entropy)
 0.097ms (+0.000ms): memcpy (SHATransform)
 0.099ms (+0.001ms): add_entropy_words (extract_entropy)
 0.099ms (+0.000ms): SHATransform (extract_entropy)
 0.099ms (+0.000ms): memcpy (SHATransform)
 0.101ms (+0.001ms): add_entropy_words (extract_entropy)
 0.101ms (+0.000ms): SHATransform (extract_entropy)
 0.101ms (+0.000ms): memcpy (SHATransform)
 0.103ms (+0.001ms): add_entropy_words (extract_entropy)
 0.103ms (+0.000ms): SHATransform (extract_entropy)
 0.103ms (+0.000ms): memcpy (SHATransform)
 0.105ms (+0.001ms): add_entropy_words (extract_entropy)
 0.105ms (+0.000ms): SHATransform (extract_entropy)
 0.105ms (+0.000ms): memcpy (SHATransform)
 0.107ms (+0.001ms): add_entropy_words (extract_entropy)
 0.107ms (+0.000ms): SHATransform (extract_entropy)
 0.107ms (+0.000ms): memcpy (SHATransform)
 0.109ms (+0.001ms): add_entropy_words (extract_entropy)
 0.109ms (+0.000ms): SHATransform (extract_entropy)
 0.109ms (+0.000ms): memcpy (SHATransform)
 0.110ms (+0.001ms): add_entropy_words (extract_entropy)
 0.111ms (+0.000ms): SHATransform (extract_entropy)
 0.111ms (+0.000ms): memcpy (SHATransform)
 0.112ms (+0.001ms): add_entropy_words (extract_entropy)
 0.112ms (+0.000ms): SHATransform (extract_entropy)
 0.112ms (+0.000ms): memcpy (SHATransform)
 0.114ms (+0.001ms): add_entropy_words (extract_entropy)
 0.114ms (+0.000ms): SHATransform (extract_entropy)
 0.114ms (+0.000ms): memcpy (SHATransform)
 0.116ms (+0.001ms): add_entropy_words (extract_entropy)
 0.116ms (+0.000ms): SHATransform (extract_entropy)
 0.116ms (+0.000ms): memcpy (SHATransform)
 0.118ms (+0.001ms): add_entropy_words (extract_entropy)
 0.118ms (+0.000ms): SHATransform (extract_entropy)
 0.118ms (+0.000ms): memcpy (SHATransform)
 0.120ms (+0.001ms): add_entropy_words (extract_entropy)
 0.120ms (+0.000ms): SHATransform (extract_entropy)
 0.120ms (+0.000ms): memcpy (SHATransform)
 0.122ms (+0.001ms): add_entropy_words (extract_entropy)
 0.122ms (+0.000ms): SHATransform (extract_entropy)
 0.122ms (+0.000ms): memcpy (SHATransform)
 0.124ms (+0.001ms): add_entropy_words (extract_entropy)
 0.124ms (+0.000ms): SHATransform (extract_entropy)
 0.124ms (+0.000ms): memcpy (SHATransform)
 0.125ms (+0.001ms): add_entropy_words (extract_entropy)
 0.126ms (+0.000ms): SHATransform (extract_entropy)
 0.126ms (+0.000ms): memcpy (SHATransform)
 0.127ms (+0.001ms): add_entropy_words (extract_entropy)
 0.127ms (+0.000ms): SHATransform (extract_entropy)
 0.128ms (+0.000ms): memcpy (SHATransform)
 0.129ms (+0.001ms): add_entropy_words (extract_entropy)
 0.129ms (+0.000ms): SHATransform (extract_entropy)
 0.129ms (+0.000ms): memcpy (SHATransform)
 0.131ms (+0.001ms): add_entropy_words (extract_entropy)
 0.131ms (+0.000ms): SHATransform (extract_entropy)
 0.131ms (+0.000ms): memcpy (SHATransform)
 0.133ms (+0.001ms): add_entropy_words (extract_entropy)
 0.133ms (+0.000ms): add_entropy_words (extract_entropy)
 0.136ms (+0.002ms): credit_entropy_store (extract_entropy)
 0.137ms (+0.000ms): __wake_up (extract_entropy)
 0.137ms (+0.000ms): __wake_up_common (__wake_up)
 0.137ms (+0.000ms): SHATransform (extract_entropy)
 0.137ms (+0.000ms): memcpy (SHATransform)
 0.139ms (+0.001ms): add_entropy_words (extract_entropy)
 0.139ms (+0.000ms): SHATransform (extract_entropy)
 0.139ms (+0.000ms): memcpy (SHATransform)
 0.141ms (+0.001ms): add_entropy_words (extract_entropy)
 0.141ms (+0.000ms): SHATransform (extract_entropy)
 0.141ms (+0.000ms): memcpy (SHATransform)
 0.143ms (+0.001ms): add_entropy_words (extract_entropy)
 0.143ms (+0.000ms): SHATransform (extract_entropy)
 0.143ms (+0.000ms): memcpy (SHATransform)
 0.145ms (+0.001ms): add_entropy_words (extract_entropy)
 0.145ms (+0.000ms): SHATransform (extract_entropy)
 0.145ms (+0.000ms): memcpy (SHATransform)
 0.147ms (+0.001ms): add_entropy_words (extract_entropy)
 0.147ms (+0.000ms): SHATransform (extract_entropy)
 0.147ms (+0.000ms): memcpy (SHATransform)
 0.149ms (+0.001ms): add_entropy_words (extract_entropy)
 0.149ms (+0.000ms): SHATransform (extract_entropy)
 0.149ms (+0.000ms): memcpy (SHATransform)
 0.151ms (+0.001ms): add_entropy_words (extract_entropy)
 0.151ms (+0.000ms): SHATransform (extract_entropy)
 0.151ms (+0.000ms): memcpy (SHATransform)
 0.152ms (+0.001ms): add_entropy_words (extract_entropy)
 0.153ms (+0.000ms): SHATransform (extract_entropy)
 0.153ms (+0.000ms): memcpy (SHATransform)
 0.154ms (+0.001ms): add_entropy_words (extract_entropy)
 0.155ms (+0.000ms): SHATransform (extract_entropy)
 0.155ms (+0.000ms): memcpy (SHATransform)
 0.156ms (+0.001ms): add_entropy_words (extract_entropy)
 0.157ms (+0.000ms): local_bh_enable (__check_and_rekey)
 0.157ms (+0.000ms): halfMD4Transform (secure_ip_id)
 0.159ms (+0.001ms): peer_avl_rebalance (inet_getpeer)
 0.160ms (+0.000ms): local_bh_enable (inet_getpeer)
 0.160ms (+0.000ms): local_bh_enable (rt_bind_peer)
 0.161ms (+0.000ms): local_bh_enable (__ip_select_ident)
 0.162ms (+0.000ms): ip_output (ip_push_pending_frames)
 0.162ms (+0.000ms): ip_finish_output (ip_push_pending_frames)
 0.163ms (+0.000ms): dev_queue_xmit (ip_finish_output)
 0.164ms (+0.001ms): pfifo_fast_enqueue (dev_queue_xmit)
 0.165ms (+0.000ms): qdisc_restart (dev_queue_xmit)
 0.165ms (+0.000ms): pfifo_fast_dequeue (qdisc_restart)
 0.166ms (+0.001ms): ppp_start_xmit (qdisc_restart)
 0.167ms (+0.000ms): skb_queue_tail (ppp_start_xmit)
 0.167ms (+0.000ms): ppp_xmit_process (ppp_start_xmit)
 0.167ms (+0.000ms): ppp_push (ppp_xmit_process)
 0.168ms (+0.000ms): skb_dequeue (ppp_xmit_process)
 0.168ms (+0.000ms): ppp_send_frame (ppp_xmit_process)
 0.169ms (+0.001ms): ppp_push (ppp_send_frame)
 0.170ms (+0.000ms): ppp_async_send (ppp_push)
 0.170ms (+0.000ms): ppp_async_push (ppp_async_send)
 0.171ms (+0.000ms): local_bh_enable (ppp_async_push)
 0.171ms (+0.000ms): ppp_async_push (ppp_async_send)
 0.171ms (+0.000ms): ppp_async_encode (ppp_async_push)
 0.173ms (+0.002ms): __kfree_skb (ppp_async_encode)
 0.173ms (+0.000ms): sock_wfree (__kfree_skb)
 0.173ms (+0.000ms): sock_def_write_space (sock_wfree)
 0.174ms (+0.000ms): kfree_skbmem (__kfree_skb)
 0.174ms (+0.000ms): skb_release_data (kfree_skbmem)
 0.174ms (+0.000ms): kfree (kfree_skbmem)
 0.174ms (+0.000ms): kmem_cache_free (kfree_skbmem)
 0.174ms (+0.000ms): pty_write (ppp_async_push)
 0.175ms (+0.000ms): n_tty_receive_room (pty_write)
 0.175ms (+0.000ms): n_tty_receive_buf (pty_write)
 0.177ms (+0.001ms): kill_fasync (n_tty_receive_buf)
 0.177ms (+0.000ms): n_tty_receive_room (n_tty_receive_buf)
 0.177ms (+0.000ms): local_bh_enable (ppp_async_push)
 0.177ms (+0.000ms): local_bh_enable (ppp_send_frame)
 0.177ms (+0.000ms): skb_dequeue (ppp_xmit_process)
 0.178ms (+0.000ms): raise_softirq_irqoff (ppp_xmit_process)
 0.178ms (+0.000ms): local_bh_enable (ppp_start_xmit)
 0.178ms (+0.000ms): qdisc_restart (dev_queue_xmit)
 0.178ms (+0.000ms): pfifo_fast_dequeue (qdisc_restart)
 0.179ms (+0.000ms): local_bh_enable (dev_queue_xmit)
 0.180ms (+0.000ms): icmp_xmit_unlock (icmp_reply)
 0.180ms (+0.000ms): local_bh_enable (icmp_reply)
 0.180ms (+0.000ms): do_softirq (local_bh_enable)
 0.180ms (+0.000ms): __do_softirq (do_softirq)
 0.180ms (+0.000ms): __kfree_skb (icmp_rcv)
 0.180ms (+0.000ms): kfree_skbmem (__kfree_skb)
 0.180ms (+0.000ms): skb_release_data (kfree_skbmem)
 0.181ms (+0.000ms): kfree (kfree_skbmem)
 0.181ms (+0.000ms): kmem_cache_free (kfree_skbmem)
 0.181ms (+0.000ms): check_preempt_timing (sub_preempt_count)



-- 
Palimm Palimm!
http://affenbande.org/~tapas/

