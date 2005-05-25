Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263925AbVEYGEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263925AbVEYGEv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 02:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263927AbVEYGEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 02:04:50 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:50192 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S263925AbVEYGEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 02:04:41 -0400
Date: Tue, 24 May 2005 23:09:19 -0700
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Sven Dietrich <sdietrich@mvista.com>,
       "'Lee Revell'" <rlrevell@joe-job.com>,
       "'Andrew Morton'" <akpm@osdl.org>, dwalker@mvista.com, bhuey@lnxw.com,
       mingo@elte.hu, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance (scheduler)
Message-ID: <20050525060919.GA25959@nietzsche.lynx.com>
References: <005801c560da$ec624f50$c800a8c0@mvista.com> <429407B6.1000105@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429407B6.1000105@yahoo.com.au>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2005 at 03:05:58PM +1000, Nick Piggin wrote:
> What is more likely is that you are seeing some starvation from simply
> too much CPU usage by interrupts (note this has nothing to do with latency).
> *This* is the reason ksoftirqd exists.
> 
> ie. you are seeing a throughput issue rather than a latency issue.

That's presumptuous. It's more likely that it's flakey hardware
or a missed interrupt that would cause something like that. I've
seen that happen.

> ksoftirq doesn't alleviate any kind of latencies anywhere AFAIKS.

Ksoftirq is used to support the concurrency model in the RT patch
so that irq-threads and {spin,read,write}_irq_{un,}lock can be
correct yet preemptible.

> softirqs won't normally run in another thread though, right?
 
> Yeah I don't think it is anything close to the same concept of
> softirqs though. But yeah, "just" running top half in threads
> sounds like one of the issues that will come up for discussion ;)

This is not an issue for the regular kernel since they can run
along side with the IRQ at interrupt time. It's only compile time
relevant to the RT. 

And please don't take a chunk of the patch out of context and FUD it.
There's enough uncertainty regarding this track as is without additional
misunderstanding or misrepresentations.

The stuff that is directly relevant to you and your work is the
scheduler changes needed to support RT and the possibility that
it would conflict with the sched domain stuff for NUMA boxes.
The needs are sufficiently different that in the long run something
like "sched-plugin" might be needed to simplify kernel development
and permit branched development.

bill

