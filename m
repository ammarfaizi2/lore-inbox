Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278989AbRJVWUK>; Mon, 22 Oct 2001 18:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278996AbRJVWTZ>; Mon, 22 Oct 2001 18:19:25 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:43790 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S278989AbRJVWRm>; Mon, 22 Oct 2001 18:17:42 -0400
Date: Mon, 22 Oct 2001 18:12:52 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] A nicer nice scheduling
In-Reply-To: <Pine.LNX.4.10.10110221644570.25216-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.3.96.1011022175924.23660D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001, Mark Hahn wrote:

> > kernels. But such an aggressive nice does have a downside as given, it
> > can result in a process in memory which doesn't get scheduled. 
> 
> why would it be "in memory"?  idle pages get reclaimed/swapped.

In the long run that's true, but there's nothing to preferentially swap
that page set, so they don't go away any faster than any other pages. If
the idle process were another thing instead of just a low priority
process, it could be treated in some special ways WRT memory management.

We have two people actively working on VM, please let them comment on what
could be done. I would think about swapping the idle process
preferentially if it didn't get run for some realtime, and perhaps doing
{something_else} fancy otherwise. At the rate the VM code is getting
complex I expect to see standard deviation and FFTs in 2.5. Only half
kidding, both VMs are working better with every refinement, complexity is
not bad if it produces better results. I always thought per-process page
fault rates would be useful, if some weighted attention to that would
reduce the total system i/o rate.

Anyway, that was my thinking, if the load is high a true idle process
could be treated as a special case, including running a small number of
them instead of having a lot of low priority processes doing not much if
too many were started. I can remember batch processing, and for real idle
jobs that's not a bad thing.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

