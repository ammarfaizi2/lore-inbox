Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbSIXIbA>; Tue, 24 Sep 2002 04:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261613AbSIXIbA>; Tue, 24 Sep 2002 04:31:00 -0400
Received: from holomorphy.com ([66.224.33.161]:35481 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261612AbSIXIa7>;
	Tue, 24 Sep 2002 04:30:59 -0400
Date: Tue, 24 Sep 2002 01:36:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: dipankar@in.ibm.com, mingo@elte.hu, davem@redhat.com,
       jgarzik@mandrakesoft.com, torvalds@transmeta.com
Subject: Re: on 2.5.38-mm2 tbench 64 smptimers shows 30% improvement
Message-ID: <20020924083606.GF6070@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, dipankar@in.ibm.com, mingo@elte.hu,
	davem@redhat.com, jgarzik@mandrakesoft.com, torvalds@transmeta.com
References: <20020924081340.GD6070@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020924081340.GD6070@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As tested on a 32x NUMA-Q with 32GB of RAM. Here is a demonstration of
a 30% throughput improvement with smptimers over mainline for tbench 64.
This gain is substantial enough I believe it a significant motive for
its inclusion in mainline. Furthermore, gains in terms of reduced system
time and general expense of timer manipulations are visible on smaller
systems and less network-intensive workloads.

2.5.38-mm2:
Throughput 17.8123 MB/sec (NB=22.2654 MB/sec  178.123 MBit/sec)  64 procs

2.5.38-mm2-smptimers:
Throughput 23.1864 MB/sec (NB=28.983 MB/sec  231.864 MBit/sec)  64 procs

2.5.38-mm2:
c01238a2 65847916 77.4198     .text.lock.timer
c01053dc 7588393  8.92195     poll_idle
c01228d0 5164192  6.07173     mod_timer
c0226a0c 2100268  2.46936     .text.lock.tcp
c01a25c0 809545   0.951811    csum_partial_copy_generic
c0107e1c 450890   0.530128    apic_timer_interrupt
c01150a0 424906   0.499577    scheduler_tick
c0111788 229026   0.269274    smp_apic_timer_interrupt
c0115454 228764   0.268966    do_schedule
c0233aec 225733   0.265402    tcp_v4_rcv
c0114798 145784   0.171403    try_to_wake_up
c0114c28 133369   0.156807    load_balance
c021d590 123482   0.145182    ip_output
c0223b18 111211   0.130755    tcp_data_wait
c021d6e0 110956   0.130455    ip_queue_xmit
c022275c 88206    0.103707    tcp_sendmsg
c01a2790 83338    0.0979835   __generic_copy_to_user
c010d220 81970    0.0963751   do_gettimeofday
c022b694 76453    0.0898885   tcp_rcv_established
c020d548 76315    0.0897263   process_backlog
c0122eb4 61647    0.0724806   update_one_process
c020cb80 55914    0.0657401   dev_queue_xmit
c01158fc 46404    0.0545588   __wake_up_common

2.5.38-mm2-smptimers:
c01053dc 30936965 41.2616     poll_idle
c020ee62 30635964 40.8601     .text.lock.dev
c0114c08 2499541  3.33371     load_balance
c01175db 2141278  2.85589     .text.lock.sched
c020ce40 2141045  2.85558     dev_queue_xmit
c013a47e 932681   1.24394     .text.lock.page_alloc
c01a2820 918651   1.22523     csum_partial_copy_generic
c01a29f0 800786   1.06803     __generic_copy_to_user
c020d7d8 534417   0.712768    process_backlog
c0115080 513736   0.685185    scheduler_tick
c011f9f0 324792   0.433185    tasklet_hi_action
c0111788 287470   0.383407    smp_apic_timer_interrupt
c0115434 194966   0.260032    do_schedule
c013941c 168449   0.224666    rmqueue
c012284c 149361   0.199207    mod_timer
c021d9b0 129760   0.173065    ip_queue_xmit
c0139100 127051   0.169452    __free_pages_ok
c0123490 122586   0.163497    run_local_timers
c0114778 113811   0.151793    try_to_wake_up
c021d860 110189   0.146962    ip_output
c010d220 89555    0.119442    do_gettimeofday
c0107e1c 87315    0.116455    apic_timer_interrupt
c02099c4 85560    0.114114    skb_release_data
