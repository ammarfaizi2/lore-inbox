Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266466AbUIABnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266466AbUIABnw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 21:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266479AbUIABnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 21:43:52 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:61061 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266466AbUIABnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 21:43:46 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Schmitt <pnambic@unu.nu>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <20040830090608.GA25443@elte.hu>
References: <1093715573.8611.38.camel@krustophenia.net>
	 <20040828194449.GA25732@elte.hu> <200408282210.03568.pnambic@unu.nu>
	 <20040828203116.GA29686@elte.hu>
	 <1093727453.8611.71.camel@krustophenia.net>
	 <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net>
	 <1093737080.1385.2.camel@krustophenia.net>
	 <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu>
	 <20040830090608.GA25443@elte.hu>
Content-Type: text/plain
Message-Id: <1094003017.3404.44.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 31 Aug 2004 21:43:38 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-30 at 05:06, Ingo Molnar wrote:
> i've uploaded -Q5 to:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q5

This is with netdev_max_backlog = 1:

preemption latency trace v1.0.2
-------------------------------
 latency: 386 us, entries: 328 (328)
    -----------------
    | task: ksoftirqd/0/2, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: tcp_delack_timer+0x1c/0x1d0
 => ended at:   tcp_delack_timer+0x127/0x1d0
=======>
00000001 0.000ms (+0.000ms): tcp_delack_timer (run_timer_softirq)
00000001 0.000ms (+0.000ms): __sk_stream_mem_reclaim (tcp_delack_timer)
00000001 0.004ms (+0.003ms): tcp_v4_do_rcv (tcp_delack_timer)
00000001 0.005ms (+0.001ms): tcp_rcv_established (tcp_v4_do_rcv)
00000001 0.007ms (+0.001ms): __tcp_checksum_complete_user (tcp_rcv_established)
00000001 0.008ms (+0.000ms): skb_checksum (__tcp_checksum_complete_user)
00000001 0.018ms (+0.010ms): tcp_ack (tcp_rcv_established)
00000001 0.019ms (+0.001ms): tcp_ack_update_window (tcp_ack)
00000001 0.021ms (+0.001ms): tcp_urg (tcp_rcv_established)
00000001 0.021ms (+0.000ms): tcp_data_queue (tcp_rcv_established)
00000001 0.023ms (+0.001ms): sk_stream_mem_schedule (tcp_data_queue)

...

00000103 0.377ms (+0.000ms): skb_release_data (kfree_skbmem)
00000103 0.378ms (+0.000ms): kfree (kfree_skbmem)
00000103 0.379ms (+0.000ms): kmem_cache_free (kfree_skbmem)
00000103 0.383ms (+0.004ms): qdisc_restart (dev_queue_xmit)
00000103 0.384ms (+0.000ms): pfifo_fast_dequeue (qdisc_restart)
00000102 0.384ms (+0.000ms): local_bh_enable (dev_queue_xmit)
00000001 0.386ms (+0.001ms): sub_preempt_count (tcp_delack_timer)
00000001 0.387ms (+0.000ms): _mmx_memcpy (check_preempt_timing)
00000001 0.387ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)

Also, I do not get the packet loss/timeout problems that another poster
reported when setting this to 1.  The network works normally, it just
does not affect the latency at all.

Full trace:

http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q5#/var/www/2.6.9-rc1-Q5/trace5.txt

Lee

