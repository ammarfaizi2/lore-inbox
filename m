Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264531AbUIOKT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbUIOKT7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 06:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUIOKT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 06:19:59 -0400
Received: from mx2.elte.hu ([157.181.151.9]:3817 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264531AbUIOKT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 06:19:57 -0400
Date: Wed, 15 Sep 2004 12:21:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
Message-ID: <20040915102117.GB3538@elte.hu>
References: <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au> <20040914145457.GA13113@elte.hu> <414776CE.5030302@yahoo.com.au> <20040915061922.GA11683@elte.hu> <4147FC14.2010205@yahoo.com.au> <20040915084355.GA29752@elte.hu> <20040915100903.GL9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915100903.GL9106@holomorphy.com>
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


* William Lee Irwin III <wli@holomorphy.com> wrote:

> I don't see deterministic execution time of hardirqs/softirqs
> happening on stock hardware and without serious driver work, and I
> don't see much hard RT ever happening on SMP due to lock contention.
> But maybe that just means it's difficult.

actually, check out what i did to SMP latencies via the
preempt-smp.patch. This patch brings SMP worst-case latencies to UP
levels. E.g. on a dual system the worst-case should be roughly twice the
UP worst-case latency: if both CPUs are trying to execute the same
critical section. But there is no nondeterministic spinning anymore. You
obviously cannot get better than that (other than increasing parallelism
and reducing the number of critical sections).

(not all cases are covered - if some code is not using spinlocks or
rwlocks but some static flag and is emulating spinlocks then it could
spin uncontrollably. Those places show up in the tracer quite easily - i
had to fix only one so far.)

	Ingo
