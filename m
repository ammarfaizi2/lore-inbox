Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264254AbUE2LST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264254AbUE2LST (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 07:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbUE2LST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 07:18:19 -0400
Received: from mail006.syd.optusnet.com.au ([211.29.132.63]:38825 "EHLO
	mail006.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264254AbUE2LSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 07:18:16 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [RFC][PATCH][2.6.6] Replacing CPU scheduler active and expired with a single array
Date: Sat, 29 May 2004 21:17:55 +1000
User-Agent: KMail/1.6.1
Cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <40B81F24.9080405@bigpond.net.au>
In-Reply-To: <40B81F24.9080405@bigpond.net.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405292117.56089.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 May 2004 15:27, Peter Williams wrote:
> Con Kolivas wrote:
>  > On Fri, 28 May 2004 19:24, Peter Williams wrote:
>  > > Ingo Molnar wrote:
>  > > > just try it - run a task that runs 95% of the time and sleeps 5%
>  > > > of the time, and run a (same prio) task that runs 100% of the
>  > > > time. With the current scheduler the slightly-sleeping task gets
>  > > > 45% of the CPU, the looping one gets 55% of the CPU. With your
>  > > > patch the slightly-sleeping process can easily monopolize 90% of
>  > > > the CPU!
>  > >
>  > > This does, of course, not take into account the interactive bonus.
>  > > If the task doing the shorter CPU bursts manages to earn a larger
>  > > interactivity bonus than the other then it will get more CPU but
>  > > isn't that the intention of the interactivity bonus?
>  >
>  > No. Ideally the interactivity bonus should decide what goes first
>  > every time to decrease the latency of interactive tasks, but the cpu
>  > percentage should remain close to the same for equal "nice" tasks.
>
> There are at least two possible ways of viewing "nice": one of these is
> that it is an indicator of the tasks entitlement to CPU resource (which
> is more or less the view you describe) and another that it is an
> indicator of the task's priority with respect to access to CPU resources.
>
> If you wish the system to take the first of these views then the
> appropriate solution to the scheduling problem is to use an entitlement
> based scheduler such as EBS (see
> <http://sourceforge.net/projects/ebs-linux/>) which is also much simpler
> than the current O(1) scheduler and has the advantage that it gives
> pretty good interactive responsiveness without treating interactive
> tasks specially (although some modification in this regard may be
> desirable if very high loads are going to be encountered).
>
> If you want the second of these then this proposed modification is a
> simple way of getting it (with the added proviso that starvation be
> avoided).
>
> Of course, there can be other scheduling aims such as maximising
> throughput where different scheduler paradigms need to be used.  As a
> matter of interest these tend to have not very good interactive response.
>
> If the system is an interactive system then all of these models (or at
> least two of them) need to be modified to "break the rules" as far as
> interactive tasks are concerned and give them higher priority in order
> not to try human patience.
>
>  > Interactive tasks need low scheduling latency and short bursts of high
>  > cpu usage; not more cpu usage overall. When the cpu percentage
>
> differs > significantly from this the logic has failed.
>
> The only way this will happen is if the interactive bonus mechanism
> misidentifies a CPU bound task as an interactive task and gives it a
> large bonus.  This seems to be the case as tasks with a 95% CPU demand
> rate are being given a bonus of 9 (out of 10 possible) points.

This is all a matter of semantics and I have no argument with it.

I think your aims of simplifying the scheduler are admirable but I hope you 
don't suffer the quagmire that is manipulating the interactivity stuff. 
Changing one value and saying it has no apparent effect is almost certainly 
wrong; surely it was put there for a reason - or rather I put it there for a 
reason.

Con
