Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293527AbSBZFTL>; Tue, 26 Feb 2002 00:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293525AbSBZFTC>; Tue, 26 Feb 2002 00:19:02 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:39185 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S293521AbSBZFSs>; Tue, 26 Feb 2002 00:18:48 -0500
Date: Tue, 26 Feb 2002 00:14:13 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Larry McVoy <lm@bitmover.com>
cc: lse-tech@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] NUMA scheduling
In-Reply-To: <20020225120242.F22497@work.bitmover.com>
Message-ID: <Pine.LNX.3.96.1020226000515.20055C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002, Larry McVoy wrote:

> On Mon, Feb 25, 2002 at 02:49:40PM -0500, Bill Davidsen wrote:
> >   Unfortunately this is an overly simple view of how SMP works. The only
> > justification for CPU latency is to preserve cache contents. Trying to
> > express this as a single number is bound to produce suboptimal results.
> 
> And here is the other side of the coin.  Remember what we are doing.
> We're in the middle of a context switch, trying to figure out where we
> should run this process.  We would like context switches to be fast.

I hope we're not in the middle of a context switch... hopefully any
decision to move a process is done either (a) during load balancing, or
(b) when you have an idle CPU which needs work to do. Otherwise why
consider changing CPU?

I would think the place to do the work is when it needs doing, not on
every context switch. The CPU selection is costly, as opposed to "which
process to run." Of course when a process moves from blocked to ready it
might be time to consider how long it's been waiting and if anything in
the cache is worth using.

> Any work we do here is at direct odds with our goals.  SGI took the
> approach that your statements would imply,

I wasn't really implying anything except the problem being more complex
than "set the affinity to 500ms and tune." You can't tune, the system will
be unresponsive. Since complex decisions would be made infrequently, it
should be better to do them right than to do the wrong thing quickly.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

