Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbVC3GzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVC3GzN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 01:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVC3GzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 01:55:13 -0500
Received: from mx1.elte.hu ([157.181.1.137]:3518 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261775AbVC3GzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 01:55:07 -0500
Date: Wed, 30 Mar 2005 08:54:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-10
Message-ID: <20050330065426.GB18417@elte.hu>
References: <20050325145908.GA7146@elte.hu> <1111790009.23430.19.camel@mindpipe> <20050325223959.GA24800@elte.hu> <1111814065.24049.21.camel@mindpipe> <20050327085814.GA23082@elte.hu> <1112159812.5598.17.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112159812.5598.17.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
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

> > could you run a bit with tracing disabled (in the .config) on the C3?  
> > (but wakeup timing still enabled) It may very well be tracing overhead 
> > that makes those latencies that high.  Also, we'd thus have some hard 
> > data on how much overhead tracing is in such a situation, on that CPU.
> 
> I have not left it to run overnight yet with the swappiness set to 
> 100, which triggers the biggest latencies as my entire desktop is 
> swapped out, but so far it looks like the problem was tracing 
> overhead.  With timing enabled but tracing disabled the longest 
> latency on the C3 so far is 270 usecs.
> 
> An important giveaway is that with tracing enabled the same code path 
> only triggers ~200 usec latencies on the K7 but ~2ms on the C3.  Since 
> the longest latency with PREEMPT_DESKTOP is normally more a function 
> of memory bandwidth than processor speed, and the machines differ much 
> more in the latter, this agrees with the theory that the overhead is 
> the problem.

besides cycle overhead, function tracing increases cache footprint - and 
with a CPU that has smaller caches (such as the C3) it can tip a loop 
over the edge, and can make it cache-trashing, while it would fit into 
the cache before. In such a situation the difference can be dramatic.

(on CPUs with larger caches similar artifacts can happen too, but it 
needs a 'fatter' loop, which are apparently rarer.)

	Ingo
