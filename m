Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319022AbSHSVXa>; Mon, 19 Aug 2002 17:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319023AbSHSVXa>; Mon, 19 Aug 2002 17:23:30 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26636 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319022AbSHSVX3>; Mon, 19 Aug 2002 17:23:29 -0400
Date: Mon, 19 Aug 2002 14:29:08 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Dave McCracken <dmccr@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) sys_exit(), threading, scalable-exit-2.5.31-A6
In-Reply-To: <Pine.LNX.4.44.0208192251540.2201-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0208191427220.1484-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Aug 2002, Ingo Molnar wrote:
> 
> the problem is that the debugger wants to do a wait4 as well, to receive
> the SIGSTOP result. Now if the original parent 'steals' the wait4 result,
> what will happen?

If a child has a debugger, it clearly is never "stopped" or "zombie" as 
far as the parent is concerned, so the parent should either block, or it 
should return -EAGAIN.

> this whole mess can only be fixed by decoupling the ptrace() mechanism
> from signals and wait4 completely

No, you only need to make debugged children slightly pecial in wait4(), in
that the parent must never see their state, only the fact that they are
there (as if they were still running, in short, regardless of their _real_
state)

		Linus

