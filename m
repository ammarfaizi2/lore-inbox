Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280042AbRJ3RLP>; Tue, 30 Oct 2001 12:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280041AbRJ3RLG>; Tue, 30 Oct 2001 12:11:06 -0500
Received: from [208.129.208.52] ([208.129.208.52]:38153 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S280035AbRJ3RK5>;
	Tue, 30 Oct 2001 12:10:57 -0500
Date: Tue, 30 Oct 2001 09:19:05 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Hubertus Franke <frankeh@watson.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, <lse-tech@lists.sourceforge.net>
Subject: Re: [PATCH][RFC] Proposal For A More Scalable Scheduler ...
In-Reply-To: <20011030092834.A16050@watson.ibm.com>
Message-ID: <Pine.LNX.4.40.0110300914450.1495-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2001, Hubertus Franke wrote:

> Davide, nice analysis.
> I want to point out that some (not all) of the stuff is already done
> in our scalable MQ scheduler (http://lse.sourceforge.net/scheduling).
>
> What we have:
> -------------
> multiple queues, each protected by their own lock to avoid
> the contention.
> Automatic Loadbalancing across all queues (yes, that creates overhead)
> CPU pooling as configurable mean to get from isolated queues to a fully
> balanced (global scheduling decision) scheduler.
> Also have some initial placement to the least loaded runqueue in the least
> loaded pool
>
> We look at this as a configurable infrastructure....
>
> What we don't have:
> -------------------
>
> The removal of PROC_CHANGE_PENALTY with a time decay cache affinity definition.
>
>
> At ALS: I will be reporting on our experience with what we have
> for a 8-way system and a 4x4-way NUMA system (OSDL)
> wrt early placement, choice of best pool size ?
>
> Are you can get an early start at:
> 	http://lse.sourceforge.net/scheduling/als2001/pmqs.ps

I see the proposed implementation as a decisive cut with the try to have
processes instantly moved across CPUs and stuff like na_goodness, etc..
Inside each CPU the scheduler is _exactly_ the same as the UP one.




> Are you going to be a ALS ? Maybe we can chat about what the pros and cons
> of each approach are and whether we could/should merge things together.
> I am very intriged by the "CPU History Weight" that I see as a major
> add-on to our stuff. What I am not so keen about is the fact
> you seem to only do load-balancing at fork and idle time.
> In a loaded system that can lead to load inbalances
>
> We do a periodic (configurable) call, which has also some drawbacks.
> Another thing that needs to be thought about is the metric used
> to determine <load> on a queue. For simplicity, runqueue length is
> one indication, for fairness, maybe the sum of nice-value would be ok.
> We experimented with both and didn't see to much of a difference, however
> measuring fairness is difficult to do.

Hey, ... that's part of Episode 2 " Balancing the world", where the evil
Mr. MoveSoon fight with Hysteresis for the universe domination :)




- Davide


