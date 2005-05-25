Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbVEYFGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVEYFGN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 01:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVEYFGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 01:06:13 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:13667 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262267AbVEYFGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 01:06:04 -0400
Message-ID: <429407B6.1000105@yahoo.com.au>
Date: Wed, 25 May 2005 15:05:58 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Sven Dietrich <sdietrich@mvista.com>
CC: "'Lee Revell'" <rlrevell@joe-job.com>, "'Andrew Morton'" <akpm@osdl.org>,
       dwalker@mvista.com, bhuey@lnxw.com, mingo@elte.hu, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <005801c560da$ec624f50$c800a8c0@mvista.com>
In-Reply-To: <005801c560da$ec624f50$c800a8c0@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Dietrich wrote:

>>Are you serious? Even at 10ms, the monitor refresh rate would 
>>have to be over 100Hz for anyone to "notice" anything, 
>>right?... What sort of numbers are you talking when you say several?
>>
>>
>
>Even without numbers, the IDE IRQ, when run in a thread, 
>competes with tasks at process level, so that other
>tasks can make some progress. Especially if those tasks are
>high priority.
>
>With multiple disks on a chain, you can see transients that
>lock up the CPU in IRQ mode for human-perceptible time,
>especially on slower CPUs... 
>
>

I'm fairly sure this isn't going to happen. Unless you're telling me
that irqs run for 50ms plus.

What is more likely is that you are seeing some starvation from simply
too much CPU usage by interrupts (note this has nothing to do with latency).
*This* is the reason ksoftirqd exists.

ie. you are seeing a throughput issue rather than a latency issue.

>This is part of the reason why SoftIRQd exists: to act as
>a governor for bottom halves that run over and over again.
>SoftIRQd handles those bursty bottom halves in task space.
>
>

ksoftirq doesn't alleviate any kind of latencies anywhere AFAIKS.

>So with that, you already have bottom halves in threads.
>
>

softirqs won't normally run in another thread though, right?

>Then we are just talking about the concept of running the
>top-half in a thread as well.
>
>

Yeah I don't think it is anything close to the same concept of
softirqs though. But yeah, "just" running top half in threads
sounds like one of the issues that will come up for discussion ;)

Send instant messages to your online friends http://au.messenger.yahoo.com 
