Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVC3FQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVC3FQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 00:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVC3FQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 00:16:57 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:38086 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261538AbVC3FQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 00:16:53 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-10
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <20050327085814.GA23082@elte.hu>
References: <20050325145908.GA7146@elte.hu>
	 <1111790009.23430.19.camel@mindpipe> <20050325223959.GA24800@elte.hu>
	 <1111814065.24049.21.camel@mindpipe>  <20050327085814.GA23082@elte.hu>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 00:16:52 -0500
Message-Id: <1112159812.5598.17.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-27 at 10:58 +0200, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Running for several days with PREEMPT_DESKTOP, on the Athlon XP the 
> > worst latency I am seeing is ~150 usecs!  But on the C3 its about 4ms:
> 
> could you run a bit with tracing disabled (in the .config) on the C3?  
> (but wakeup timing still enabled) It may very well be tracing overhead 
> that makes those latencies that high.  Also, we'd thus have some hard 
> data on how much overhead tracing is in such a situation, on that CPU.
> 

I have not left it to run overnight yet with the swappiness set to 100,
which triggers the biggest latencies as my entire desktop is swapped
out, but so far it looks like the problem was tracing overhead.  With
timing enabled but tracing disabled the longest latency on the C3 so far
is 270 usecs.

An important giveaway is that with tracing enabled the same code path
only triggers ~200 usec latencies on the K7 but ~2ms on the C3.  Since
the longest latency with PREEMPT_DESKTOP is normally more a function of
memory bandwidth than processor speed, and the machines differ much more
in the latter, this agrees with the theory that the overhead is the
problem.

Lee

