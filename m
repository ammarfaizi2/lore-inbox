Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbSJ3VOJ>; Wed, 30 Oct 2002 16:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264922AbSJ3VOJ>; Wed, 30 Oct 2002 16:14:09 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:34063 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264919AbSJ3VOI>; Wed, 30 Oct 2002 16:14:08 -0500
Date: Wed, 30 Oct 2002 16:20:03 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Bernhard Kaindl <bk@suse.de>
cc: linux-kernel@vger.kernel.org,
       Ulrich Weigand <weigand@informatik.uni-erlangen.de>,
       Neale Ferguson <Neale.Ferguson@SoftwareAG-USA.com>
Subject: Re: [PATCH] IPC SMP race: msgrcv may not return before msgsnd is done
In-Reply-To: <Pine.LNX.4.33.0210301800150.2930-100000@wotan.suse.de>
Message-ID: <Pine.LNX.3.96.1021030161328.14229B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2002, Bernhard Kaindl wrote:

> this is targeted to System V message queue Experts and people who
> use System V message queues quite extensively in SMP environments.
> 
> It contains descriptions of a SMP race in sys_msgrcv, a fix for
> it and some questions about the code in question(maybe there is
> a better fix, but I think the proposed one is ok)
> 
> I've already a short feedback from Andi Kleen, he told me that
> the Description and patch seem to be correct as far as he can see.

I'll try it, I have a program which gets a lockup rather than an oops, but
it may be related.
 
> Neale Ferguson from Software AG debugged a SMP race in the message
> queue implementation of the 2.4 Kernel.
> 
> The race was triggered in a time frame of 20 minutes to 14 hours after
> starting a complex application stress test which uses message queues
> quite extensively.

One of the test loads in the responsiveness test creates a ring of Ncpu+1
process which pass tokens in a ring using message queues, passing Ncpu
tokens at a time. I guess that might resemble "quite extensively" ;-) I
also note the tokens/sec going through a single process, that would show
any performance impact of the patch.

However, if this prevents the occasional lockup it will probably go in my
working kernel, unfortunately this is "occasional" so I won't know right
away.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

