Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318432AbSHPOoT>; Fri, 16 Aug 2002 10:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318435AbSHPOoT>; Fri, 16 Aug 2002 10:44:19 -0400
Received: from mx2.elte.hu ([157.181.151.9]:23183 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318432AbSHPOoS>;
	Fri, 16 Aug 2002 10:44:18 -0400
Date: Fri, 16 Aug 2002 16:48:46 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: CLONE_DETACHED and exit notification (was user-vm-unlock-2.5.31-A2)
In-Reply-To: <20020816151911.A590@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.44.0208161639150.29243-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Jamie Lokier wrote:

> You've said that pthread_exit() _always_ notifies a sibling thread using
> a futex.

yes.

> Well, can we please move the futex wakeup into the kernel?  That is all
> I ask.  It will make pthread_exit() _faster_, and me happy because all
> exits are notified.

(well, now you have reduced your point to the question of pure a
performance optimisation, dropping allegations of "pthreadizm" or
"inability to support different threading libraries because there's no
polite exit", thus so far we are in agreement.)

there are some practical problems with making the notification a futex,
not a simple flag. Eg. futexes right now do not force any lock-counter
format upon userspace. Futexes can be used as mutexes, conditional
variables, read-write locks, all of which have different atomic counter
formats and uses. By doing the TID-release notification via a futex the
actual format of the lock is forced, which is a cleanliness problem. Just
writing $0 to the TID pointer is a robust thing on the other hand.

	Ingo

ps. (you have not replied to 90% of the email i wrote. Does this mean
agreement or disagreement?)

