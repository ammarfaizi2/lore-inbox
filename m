Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268840AbUHUDo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268840AbUHUDo1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 23:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268841AbUHUDo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 23:44:27 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:28873 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268840AbUHUDn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 23:43:59 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P6
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <20040820195540.GA31798@elte.hu>
References: <20040816034618.GA13063@elte.hu>
	 <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu>
	 <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu>
	 <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net>
	 <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu>
	 <20040820133031.GA13105@elte.hu>  <20040820195540.GA31798@elte.hu>
Content-Type: text/plain
Message-Id: <1093059838.854.11.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 23:43:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-20 at 15:55, Ingo Molnar wrote:
> i've uploaded the -P6 patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P6
> 

Here's a 171 usec latency from ext3_free_blocks:

preemption latency trace v1.0.1
-------------------------------
 latency: 171 us, entries: 2 (2)
    -----------------
    | task: evolution/863, uid:1000 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: ext3_free_blocks+0x1d0/0x4b0
 => ended at:   ext3_free_blocks+0x229/0x4b0
=======>
00000001 0.000ms (+0.000ms): ext3_free_blocks (ext3_free_data)
00000001 0.167ms (+0.167ms): sub_preempt_count (ext3_free_blocks)

Also I have noticed a pattern with the XFree86 schedule() latencies,
they all have a section like this:

04000002 0.003ms (+0.000ms): effective_prio (recalc_task_prio)
04000002 0.003ms (+0.000ms): enqueue_task (schedule)
00000002 0.006ms (+0.003ms): __switch_to (schedule)
00000002 0.088ms (+0.082ms): finish_task_switch (schedule)
00010002 0.090ms (+0.001ms): do_IRQ (finish_task_switch)
00010003 0.091ms (+0.000ms): mask_and_ack_8259A (do_IRQ)

04000002 0.002ms (+0.000ms): effective_prio (recalc_task_prio)
04000002 0.002ms (+0.000ms): enqueue_task (schedule)
00000002 0.005ms (+0.002ms): __switch_to (schedule)
00000002 0.067ms (+0.062ms): finish_task_switch (schedule)
00010002 0.068ms (+0.001ms): do_IRQ (finish_task_switch)
00010003 0.069ms (+0.000ms): mask_and_ack_8259A (do_IRQ)

I presume the 04000002 -> 00000002 is some interrupt being unmasked (or
interrupts being globally enabled), then there's a 60-80 usec latency in
schedule().

Lee


