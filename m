Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266680AbUIVTIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266680AbUIVTIR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 15:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266679AbUIVTIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 15:08:16 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:45761 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266680AbUIVTIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 15:08:02 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S3
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@Raytheon.com
In-Reply-To: <20040922103340.GA9683@elte.hu>
References: <20040907092659.GA17677@elte.hu>
	 <20040907115722.GA10373@elte.hu>
	 <1094597988.16954.212.camel@krustophenia.net>
	 <20040908082050.GA680@elte.hu> <1094683020.1362.219.camel@krustophenia.net>
	 <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu>
	 <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu>
	 <20040921074426.GA10477@elte.hu>  <20040922103340.GA9683@elte.hu>
Content-Type: text/plain
Message-Id: <1095880080.1758.2.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 22 Sep 2004 15:08:01 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-22 at 06:33, Ingo Molnar wrote:
>    http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm1-S3

The rt_garbage_collect latency is back:

preemption latency trace v1.0.7 on 2.6.9-rc2-mm1-VP-S3
-------------------------------------------------------
 latency: 2040 us, entries: 2321 (2321)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: ksoftirqd/0/2, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: netif_receive_skb+0x6a/0x1d0
 => ended at:   netif_receive_skb+0x125/0x1d0
=======>
00000001 0.000ms (+0.001ms): netif_receive_skb (process_backlog)
00000001 0.001ms (+0.000ms): packet_rcv_spkt (netif_receive_skb)
00000001 0.002ms (+0.000ms): skb_clone (packet_rcv_spkt)
00000001 0.002ms (+0.001ms): kmem_cache_alloc (skb_clone)
00000001 0.004ms (+0.001ms): memcpy (skb_clone)
00000001 0.006ms (+0.001ms): strlcpy (packet_rcv_spkt)
00000002 0.007ms (+0.003ms): sk_run_filter (packet_rcv_spkt)
00000001 0.011ms (+0.000ms): __kfree_skb (packet_rcv_spkt)
00000001 0.012ms (+0.000ms): kfree_skbmem (__kfree_skb)
00000001 0.012ms (+0.000ms): skb_release_data (kfree_skbmem)
00000001 0.012ms (+0.000ms): kmem_cache_free (kfree_skbmem)
00000001 0.013ms (+0.001ms): ip_rcv (netif_receive_skb)
00000001 0.015ms (+0.000ms): ip_route_input (ip_rcv)
00000001 0.015ms (+0.003ms): rt_hash_code (ip_route_input)
00000001 0.019ms (+0.001ms): ip_route_input_slow (ip_rcv)
00000001 0.021ms (+0.001ms): rt_hash_code (ip_route_input_slow)
00000001 0.022ms (+0.002ms): fn_hash_lookup (ip_route_input_slow)
00000002 0.024ms (+0.002ms): fib_semantic_match (fn_hash_lookup)
00000001 0.027ms (+0.000ms): fib_validate_source (ip_route_input_slow)
00000001 0.028ms (+0.001ms): fn_hash_lookup (fib_validate_source)
00000001 0.029ms (+0.001ms): fn_hash_lookup (fib_validate_source)
00000002 0.031ms (+0.001ms): fib_semantic_match (fn_hash_lookup)
00000001 0.032ms (+0.000ms): __fib_res_prefsrc (fib_validate_source)
00000001 0.033ms (+0.002ms): inet_select_addr (__fib_res_prefsrc)
00000001 0.035ms (+0.000ms): dst_alloc (ip_route_input_slow)
00000001 0.036ms (+0.002ms): rt_garbage_collect (dst_alloc)
00000102 0.039ms (+0.001ms): rt_may_expire (rt_garbage_collect)
00000101 0.040ms (+0.000ms): local_bh_enable (rt_garbage_collect)
00000102 0.041ms (+0.001ms): rt_may_expire (rt_garbage_collect)
00000101 0.042ms (+0.000ms): local_bh_enable (rt_garbage_collect)
00000102 0.043ms (+0.000ms): rt_may_expire (rt_garbage_collect)
00000101 0.044ms (+0.000ms): local_bh_enable (rt_garbage_collect)
00000102 0.045ms (+0.001ms): rt_may_expire (rt_garbage_collect)
00000102 0.046ms (+0.001ms): rt_may_expire (rt_garbage_collect)
00000101 0.047ms (+0.000ms): local_bh_enable (rt_garbage_collect)
00000102 0.048ms (+0.001ms): rt_may_expire (rt_garbage_collect)

[these 2 repeat hundreds of times]

00000101 1.875ms (+0.000ms): local_bh_enable (rt_garbage_collect)
00000102 1.876ms (+0.000ms): rt_may_expire (rt_garbage_collect)
00000102 1.877ms (+0.000ms): rt_may_expire (rt_garbage_collect)
00000101 1.877ms (+0.000ms): local_bh_enable (rt_garbage_collect)
00000102 1.878ms (+0.000ms): rt_may_expire (rt_garbage_collect)
00000102 1.879ms (+0.000ms): rt_may_expire (rt_garbage_collect)
00000101 1.880ms (+0.001ms): local_bh_enable (rt_garbage_collect)
00000001 1.881ms (+0.001ms): kmem_cache_alloc (dst_alloc)
00000001 1.882ms (+0.003ms): cache_alloc_refill (kmem_cache_alloc)

[some other stuff]

Lee

