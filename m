Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266213AbUGJLby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266213AbUGJLby (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 07:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266214AbUGJLby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 07:31:54 -0400
Received: from mx2.elte.hu ([157.181.151.9]:42423 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266213AbUGJLbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 07:31:52 -0400
Date: Sat, 10 Jul 2004 13:15:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <piggin@cyberone.com.au>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Likelihood of rt_tasks
Message-ID: <20040710111528.GA22265@elte.hu>
References: <40EE6CC2.8070001@kolivas.org> <40EF2FF2.6000001@bigpond.net.au> <40EF354F.9090903@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40EF354F.9090903@kolivas.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=0, required 5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> Well I dont think making them unlikely is necessary either, but
> realistically the amount of time added by the unlikely() check will be
> immeasurably small in real terms - and hitting it frequently enough
> will be washed over by the cpu as Ingo said. I dont think the order of
> magnitude of this change is in the same universe as the problem of
> scheduling latency that people are complaining of.

very much so. This is (sub-)nanoseconds stuff, while the scheduling
latencies are tens of milliseconds or more - at least 7 orders of
magnitude difference.

the unlikely() check in rt_task() was mainly done because there was a
steady stream of microoptimizations that added unlikely() to rt_task().
So now we do in everywhere and have removed the unlikely()/likely()
branches from sched.c. It doesnt really matter in real-world terms, but
it will make the common case code (non-RT) a tiny bit more compact. And
i challenge anyone to be able to even measure the difference to an RT
task.

Not to mention that any truly RT-centric/embedded distribution would
compile the kernel for size anyway, at which point the compiler ignores
(or should ignore) the likely/unlikely attributes anyway. So there's
really no harm to anyone and the code got a bit more readable.

	Ingo
