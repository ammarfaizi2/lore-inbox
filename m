Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbVEYHIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbVEYHIw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 03:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVEYHGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 03:06:48 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:13744 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262295AbVEYHAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 03:00:44 -0400
Message-ID: <4294228D.1040809@yahoo.com.au>
Date: Wed, 25 May 2005 17:00:29 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: Sven Dietrich <sdietrich@mvista.com>,
       "'Lee Revell'" <rlrevell@joe-job.com>,
       "'Andrew Morton'" <akpm@osdl.org>, dwalker@mvista.com, mingo@elte.hu,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance (scheduler)
References: <005801c560da$ec624f50$c800a8c0@mvista.com> <429407B6.1000105@yahoo.com.au> <20050525060919.GA25959@nietzsche.lynx.com>
In-Reply-To: <20050525060919.GA25959@nietzsche.lynx.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) wrote:
> On Wed, May 25, 2005 at 03:05:58PM +1000, Nick Piggin wrote:
> 
>>What is more likely is that you are seeing some starvation from simply
>>too much CPU usage by interrupts (note this has nothing to do with latency).
>>*This* is the reason ksoftirqd exists.
>>
>>ie. you are seeing a throughput issue rather than a latency issue.
> 
> 
> That's presumptuous. It's more likely that it's flakey hardware
> or a missed interrupt that would cause something like that. I've
> seen that happen.
> 

Err, no. Please read what was written.

"With multiple disks on a chain, you can see transients that
lock up the CPU in IRQ mode for human-perceptible time,
especially on slower CPUs... "

I was pointing out that this will be a throughput rather than
latency issue. Unless you're saying that an interrupt handler
will run for 30ms or more?

> 
>>ksoftirq doesn't alleviate any kind of latencies anywhere AFAIKS.
> 
> 
> Ksoftirq is used to support the concurrency model in the RT patch
> so that irq-threads and {spin,read,write}_irq_{un,}lock can be
> correct yet preemptible.
> 

That has nothing to do with what I said. I said ksoftirq doesn't
alleviate latencies.

> 
>>softirqs won't normally run in another thread though, right?
> 
>  
> 
>>Yeah I don't think it is anything close to the same concept of
>>softirqs though. But yeah, "just" running top half in threads
>>sounds like one of the issues that will come up for discussion ;)
> 
> 
> This is not an issue for the regular kernel since they can run
> along side with the IRQ at interrupt time. It's only compile time
> relevant to the RT. 
> 

It is relevant because code complexity is relevant. Have you
been reading what has been said? Don't take my word for it, read
what Andrew is saying.

> And please don't take a chunk of the patch out of context and FUD it.
> There's enough uncertainty regarding this track as is without additional
> misunderstanding or misrepresentations.
> 

I haven't looked at *any* part of *any* patch, nor commented on
any patch. I described the type of discussion and acceptance
that needs to happen before a large patch (like this) gets merged.

I also backed up Andrew's assertion that better interrupt latencies
wouldn't really help interactivity (the scheduler is a *far* bigger
factor here)

> The stuff that is directly relevant to you and your work is the
> scheduler changes needed to support RT and the possibility that
> it would conflict with the sched domain stuff for NUMA boxes.
> The needs are sufficiently different that in the long run something
> like "sched-plugin" might be needed to simplify kernel development
> and permit branched development.
> 

I don't know what you're talking about, sorry.

Why are people so touchy about this subject? I didn't even anywhere
criticize anyone's patches or any approach or idea!! :\

The best way to get anything to happen is to get a common
understanding going through constructive discussion. Please stick to
that. Thanks.
Send instant messages to your online friends http://au.messenger.yahoo.com 
