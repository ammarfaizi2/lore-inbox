Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265045AbTF1DoX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 23:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265059AbTF1DoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 23:44:23 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:62472 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265045AbTF1DoW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 23:44:22 -0400
Date: Fri, 27 Jun 2003 23:51:43 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Mike Galbraith <efault@gmx.de>
cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: O(1) scheduler & interactivity improvements
In-Reply-To: <5.2.0.9.2.20030627110106.00cf6068@pop.gmx.net>
Message-ID: <Pine.LNX.3.96.1030627234408.25848A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jun 2003, Mike Galbraith wrote:


> (simple?  decode stack, find out where he was sleeping, and then have to 
> decide what to do based upon that after _every sleep_?  sprinkle scheduling 
> decisions around every place that does wakeups?... i can just imagine Al's 
> reaction to someone suggesting that for the VFS... someone better run fast 
> and hide well:)

I'm quoting the above to show I've read you objection, but I think you
have it backward.
> 
> >A pipe wakeup can be handled by taking a look at the other end.
> >If the other process has interactivity bonus, grab half of
> >it.  (And halve the bonus belonging to that process.)
> >No bonus is created in this case, so no risk of DOS.
> >It is merely redistributed.
> >
> >And it is simple - there is one thing that woke the
> >process up - so only one thing to check.
> 
> How?


> >Hard corner cases can be avoided.  Perhaps bunch of pipes,
> >files, devices, sockets and page-ins becomes ready
> >simultaneosly.  A detailed priority calculation is clearly
> >pointless, so just use one of the things - or none.
> >
> >>Until someone demonstrates that the DoS/abuse scenarios I might be 
> >>imagining are real, in C, I think I'll do the smart thing: try to stop 
> >>worrying about it and stick to very very simple stuff.
> >
> >I thought the Irman thing was what killed the previous attempt
> >at redistributing priorities?
> What I think kills the priority redistribution idea is _massive_ 
> complexity.  I don't see anything simple.  You would have to build the 
> logical connections between tasks, which currently doesn't exist.  Wakeups 
> and task switches are extremely light weight operations, and no decision 
> you make at wakeup time has a ghost of a chance of not hurting like 
> hell.  Just using the monotonic_clock() in the wakeup/schedule paths is 
> fairly painful.  There is just no way you can run around looking for and 
> processing "who shot JR" information in those paths (no way _I_ can imagine 
> anyway) without absolutely destroying performance.

Why do it at wakeup. Is it easier to just decide at the time of the
processes blocking to decisde there if it is blocking on an interactive
transaction? Is it that easy or is it really necessary to make the process
perfect?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

