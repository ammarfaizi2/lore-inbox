Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318968AbSHSSDq>; Mon, 19 Aug 2002 14:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318969AbSHSSDq>; Mon, 19 Aug 2002 14:03:46 -0400
Received: from mx2.elte.hu ([157.181.151.9]:44974 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318968AbSHSSDp>;
	Mon, 19 Aug 2002 14:03:45 -0400
Date: Mon, 19 Aug 2002 20:08:10 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) sys_exit(), threading, scalable-exit-2.5.31-A6
In-Reply-To: <Pine.LNX.4.44.0208191036040.11842-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208192004110.30255-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Aug 2002, Linus Torvalds wrote:

> I'd be happy to apply this patch (well, your fixed version), but I think
> I'd prefer even more to make the whole reparenting go away, and keep the
> child list valid all through the lifetime of a process.  How painful
> could that be?

the problem is that the tracing task wants to do a wait4() on all traced
children, and the only way to get that is to have the traced tasks in the
child list. Eg. strace -f traces a random number of tasks, and after the
PTRACE_CONTINUE call, the wait4 done by strace must be able to 'get
events' from pretty much any of the traced tasks. So unless the ptrace
interface is reworked in an incompatible way, i cannot see how this would
work. wait4 could perhaps somehow search the whole tasklist, but that
could be a pretty big pain even for something like strace.

	Ingo

