Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318358AbSHPRIG>; Fri, 16 Aug 2002 13:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318562AbSHPRIF>; Fri, 16 Aug 2002 13:08:05 -0400
Received: from mx2.elte.hu ([157.181.151.9]:9628 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318358AbSHPRIF>;
	Fri, 16 Aug 2002 13:08:05 -0400
Date: Fri, 16 Aug 2002 19:12:45 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: CLONE_DETACHED and exit notification (was user-vm-unlock-2.5.31-A2)
In-Reply-To: <20020816173013.A858@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.44.0208161909050.17364-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Jamie Lokier wrote:

> There's no "lock-counter format", because this isn't a lock -- it's a
> wakeup.  There no need for atomicity either, because the listener only
> reads, it doesn't write.

well, technically a 'wait until value is 0' thing is of course a counter
format ...

> Here's a synchronous thread_join-style waiter; it is architecture-neutral:
> 
> 	while (tid = *tid_address) != 0)
> 		retval = sys_futex (tid_address, FUTEX_WAIT, tid, 0);

yes, this would work. And the current method of setting the counter to 0
is arbitrary (and has a 'format') already, so there's no reason we couldnt
say that the TID cannot be used as a thread-join futex that is zeroed out
by CLONE_CLEARTID, and any (potential) waiters are woken up.

i'll try this and send a patch, it's a nice optimization.

	Ingo

