Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268955AbUHUJhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268955AbUHUJhc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 05:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268956AbUHUJhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 05:37:32 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:36227 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268955AbUHUJha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 05:37:30 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <20040821093152.GB27273@elte.hu>
References: <20040816120933.GA4211@elte.hu>
	 <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu>
	 <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu>
	 <1093058602.854.5.camel@krustophenia.net> <20040821091338.GA25931@elte.hu>
	 <1093079726.854.80.camel@krustophenia.net> <20040821091804.GA26622@elte.hu>
	 <1093080202.854.94.camel@krustophenia.net> <20040821093152.GB27273@elte.hu>
Content-Type: text/plain
Message-Id: <1093081049.854.101.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 21 Aug 2004 05:37:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-21 at 05:31, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Sorry, I was thinking of this one:
> > 
> > http://krustophenia.net/testresults.php?dataset=2.6.8.1-P6#/var/www/2.6.8.1-P6/trace10.txt
> 
> ok, reduced the zap block size to 8 pages a time. It should not be a big
> issue to have this at a low value because we dont retry anything and we
> do a full TLB flush only once. (subsequent flushes are caught by the
> tlb->need_flush optimization.)
> 

This one is interesting.  What is going on here?

preemption latency trace v1.0.1
-------------------------------
 latency: 146 us, entries: 45 (45)
    -----------------
    | task: pdflush/33, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: find_get_pages_tag+0x19/0x90
 => ended at:   find_get_pages_tag+0x61/0x90
=======>
00000001 0.000ms (+0.000ms): find_get_pages_tag (pagevec_lookup_tag)
00000001 0.000ms (+0.000ms): radix_tree_gang_lookup_tag (find_get_pages_tag)
00000001 0.001ms (+0.000ms): __lookup_tag (radix_tree_gang_lookup_tag)
00000001 0.007ms (+0.005ms): __lookup_tag (radix_tree_gang_lookup_tag)

[ 20-30 more of these ]

00000001 0.119ms (+0.003ms): __lookup_tag (radix_tree_gang_lookup_tag)
00000001 0.125ms (+0.005ms): __lookup_tag (radix_tree_gang_lookup_tag)
00010001 0.132ms (+0.007ms): do_IRQ (find_get_pages_tag)
00010002 0.133ms (+0.000ms): mask_and_ack_8259A (do_IRQ)
00010002 0.137ms (+0.004ms): generic_redirect_hardirq (do_IRQ)
00010002 0.138ms (+0.000ms): wake_up_process (generic_redirect_hardirq)
00010002 0.138ms (+0.000ms): try_to_wake_up (wake_up_process)
00010002 0.138ms (+0.000ms): task_rq_lock (try_to_wake_up)
00010003 0.139ms (+0.000ms): activate_task (try_to_wake_up)
00010003 0.139ms (+0.000ms): sched_clock (activate_task)
00010003 0.140ms (+0.000ms): recalc_task_prio (activate_task)
00010003 0.141ms (+0.000ms): effective_prio (recalc_task_prio)
00010003 0.141ms (+0.000ms): enqueue_task (activate_task)
00010002 0.141ms (+0.000ms): preempt_schedule (try_to_wake_up)
00010001 0.142ms (+0.000ms): preempt_schedule (do_IRQ)
00000001 0.143ms (+0.001ms): sub_preempt_count (find_get_pages_tag)

Lee

