Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267503AbRGMQid>; Fri, 13 Jul 2001 12:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267504AbRGMQiY>; Fri, 13 Jul 2001 12:38:24 -0400
Received: from sncgw.nai.com ([161.69.248.229]:65259 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S267503AbRGMQiU>;
	Fri, 13 Jul 2001 12:38:20 -0400
Message-ID: <XFMail.20010713094144.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010712173641.C11719@work.bitmover.com>
Date: Fri, 13 Jul 2001 09:41:44 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Larry McVoy <lm@bitmover.com>
Subject: Re: CPU affinity & IPI latency
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
        lse-tech@lists.sourceforge.net, Mike Kravetz <mkravetz@sequent.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 13-Jul-2001 Larry McVoy wrote:
> Be careful tuning for LMbench (says the author :-)
> 
> Especially this benchmark.  It's certainly possible to get dramatically
> better
> SMP numbers by pinning all the lat_ctx processes to a single CPU, because 
> the benchmark is single threaded.  In other words, if we have 5 processes,
> call them A, B, C, D, and E, then the benchmark is passing a token from
> A to B to C to D to E and around again.  
> 
> If the amount of data/instructions needed by all 5 processes fits in the 
> cache and you pin all the processes to the same CPU you'll get much 
> better performance than simply letting them float.
> 
> But making the system do that naively is a bad idea.

Agree.


> 
> This is a really hard area to get right but you can take a page from all
> the failed process migration efforts.  In general, moving stuff is a bad
> idea, it's much better to leave it where it is.  Everything scales better
> if there is a process queue per CPU and the default is that you leave the
> processes on the queue on which they last run.  However, if the load average
> for a queue starts going up and there is another queue with a substantially
> lower load average, then and ONLY then, should you move the process.

I personally think that a standard scheduler/cpu is the way to go for SMP.
I saw the one IBM guys did and I think that the wrong catch there is trying
always to grab the best task to run over all CPUs.
I think that this concept could be relaxed introducing less chains between each
CPU scheduler.
A cheap load balancer should run, "time to time"(tm), to move tasks when a
certain level of unbalancing has been reached.
This will give each scheduler more independence and will make it more scalable,
IMVHO.


> This is an area in which I've done a pile of work and I'd be interested
> in keeping a finger in any efforts to fix up the scheduler.

We've, somehow, understood it :)



- Davide

