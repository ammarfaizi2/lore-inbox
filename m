Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268924AbUHUJJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268924AbUHUJJY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 05:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268927AbUHUJJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 05:09:23 -0400
Received: from mx2.elte.hu ([157.181.151.9]:8856 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268924AbUHUJJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 05:09:09 -0400
Date: Sat, 21 Aug 2004 11:10:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P6
Message-ID: <20040821091036.GA25864@elte.hu>
References: <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu> <20040820195540.GA31798@elte.hu> <1093059838.854.11.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093059838.854.11.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> Also I have noticed a pattern with the XFree86 schedule() latencies,
> they all have a section like this:
> 
> 04000002 0.003ms (+0.000ms): effective_prio (recalc_task_prio)
> 04000002 0.003ms (+0.000ms): enqueue_task (schedule)
> 00000002 0.006ms (+0.003ms): __switch_to (schedule)
> 00000002 0.088ms (+0.082ms): finish_task_switch (schedule)
> 00010002 0.090ms (+0.001ms): do_IRQ (finish_task_switch)

> I presume the 04000002 -> 00000002 is some interrupt being unmasked
> (or interrupts being globally enabled), then there's a 60-80 usec
> latency in schedule().

0x04000000 is PREEMPT_ACTIVE - which is just a bit we set to make sure
we dont try to preempt recursively.

but the XFree86 latency is interesting indeed. It could be the effect of
the now-enlarged ioperm() bitmap! 80 usecs is excessive.

	Ingo
