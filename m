Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278685AbRJaA7A>; Tue, 30 Oct 2001 19:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278723AbRJaA6u>; Tue, 30 Oct 2001 19:58:50 -0500
Received: from [208.129.208.52] ([208.129.208.52]:13828 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S278685AbRJaA6m>;
	Tue, 30 Oct 2001 19:58:42 -0500
Date: Tue, 30 Oct 2001 17:06:16 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mike Kravetz <kravetz@us.ibm.com>
cc: Hubertus Franke <frankeh@watson.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>, <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [PATCH][RFC] Proposal For A More Scalable Scheduler
 ...
In-Reply-To: <20011030161106.F1097@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.40.0110301629400.1495-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2001, Mike Kravetz wrote:

> --------------------------------------------------------------------
> reflex - Similar to lat_ctx of LMbench but much more agressive.
>          Keeps more than a single task active.  # active tasks
>          is 1/2 total number of tasks.  Result is 'round trip'
>          time.  Less is better.
> --------------------------------------------------------------------
> # tasks       Vanilla Sched   MQ Sched         Xsched
> --------------------------------------------------------------------
> 2        	 6.521		7.429		8.865
> 4               11.304		8.581		3.187
> 8        	13.501		6.907		2.425
> 16 		15.855		5.299		1.641
> 32 		17.742		3.267		2.049
> 64 		20.613		2.960		2.236
> 128 		26.234		2.983		2.527

Try to use the LatSched kernel patch to get the real cycles spent inside
the scheduler.
Also a schedcnt dump would help.
I'm saying this because I had to reject some tests ( lat_ctx is one ) they
give very different process distributions and hence results.
Looking at the numbers going down with increasing rqlen sounds strange to
me and seems that there're things like different process distribution that
comes into play.
With the cycle counter running on the proposed scheduler I saw numbers
to go up with a little derivate but they went up.



> --------------------------------------------------------------------
> Chat - VolanoMark simulator.  Result is a measure of throughput.
>        Higher is better.
> --------------------------------------------------------------------
> Configuratoin Parms	Vanilla		MQ Sched	Xsched
> --------------------------------------------------------------------
> 10 rooms, 100 messages	 69465		400055		229301
> 10 rooms, 200 messages 	 86868		354468		187775
> 10 rooms, 300 messages 	103715		363141		205799
> 10 rooms, 400 messages 	133385		380603		195987
> 20 rooms, 100 messages 	 50936		396710		216406
> 20 rooms, 200 messages 	 74200		385996		197076
> 20 rooms, 300 messages 	 95509		402232		210225
> 20 rooms, 400 messages 	101305		437776		215118
> 30 rooms, 100 messages 	 42019		376442		247781
> 30 rooms, 200 messages 	 42315		384598		222258
> 30 rooms, 300 messages 	 52948		413984		231298
> 30 rooms, 400 messages 	  6564		 46316		 24879

How does this test work exactly ?
Did You measure the run queue length while this was running ?
I'm going to modify LatSched to output other info like rqlen and
tsk->counter at switch time.
I'd like to have a  schedcnt  dump while this test is running.
Anyway this test shows that what i'm doing now ( working on the balancing
schemes ) is not wasted time :)



> --------------------------------------------------------------------
> lat_ctx - Context switching component of LMbench.  Result is 'round
>           trip' time.  Less is better.
> --------------------------------------------------------------------
> Size/# tasks     Vanilla         MQ Sched         Xsched
> --------------------------------------------------------------------

lat_ctx is ok only on UP machines, try to look at process distribution on
an SMP vanilla kernel.




- Davide




