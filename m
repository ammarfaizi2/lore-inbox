Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269073AbUHMKwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269073AbUHMKwu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 06:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269070AbUHMKwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 06:52:50 -0400
Received: from mx2.elte.hu ([157.181.151.9]:46793 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269073AbUHMKwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 06:52:33 -0400
Date: Fri, 13 Aug 2004 12:54:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
Message-ID: <20040813105406.GJ8135@elte.hu>
References: <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <20040813124249.13066d94@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813124249.13066d94@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> Hmm, should a new report only be generated when the newly measured
> latency is really > than all other ones? I get the feeling that >=
> seems to be enough. Here a dmesg extract:
> 
> (swapper/1): new 6 us maximum-latency critical section.
> (swapper/1): new 8 us maximum-latency critical section.
> (swapper/1): new 9 us maximum-latency critical section.

> Here are two reports with the same maximum-latency (31 us):
> 
> (swapper/1): new 31 us maximum-latency critical section.
> (swapper/1): new 31 us maximum-latency critical section.

the latency tracer tracks latencies in cycle units - but they are
displayed at microsecond accuracy - hence these 'equal' latencies.

to jump-start all those smaller latencies you can do this:

	echo 100 > /proc/sys/kernel/preempt_max_latency
	echo 0 > /proc/sys/kernel/preempt_thresh

this way the maximum-searching only starts at 100 usecs.

> Btw: i do have some regular ca. 300 us latencies.. Here are some traces
> (these happen with an average frequency of ca. 0.3hz):

> (ksoftirqd/0/2): 307 us critical section violates 250 us threshold.
>  => started at: <___do_softirq+0x20/0x90>
>  => ended at: <cond_resched_softirq+0x59/0x70>

this is too opaque - could you try -O7, enable tracing and save a
/proc/latency_trace instance of such a latency? It looks like some sort
of softirq latency - perhaps one particular driver's timer fn causes it
- we'll be able to tell more from the trace.

	Ingo
