Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbSIVXGR>; Sun, 22 Sep 2002 19:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264609AbSIVXGQ>; Sun, 22 Sep 2002 19:06:16 -0400
Received: from mx2.elte.hu ([157.181.151.9]:18387 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S264610AbSIVXGP>;
	Sun, 22 Sep 2002 19:06:15 -0400
Date: Mon, 23 Sep 2002 01:19:04 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: bob <bob@watson.ibm.com>
Cc: Karim Yaghmour <karim@opersys.com>, <okrieg@us.ibm.com>, <trz@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [ltt-dev] Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
In-Reply-To: <15758.19140.200081.346286@k42.watson.ibm.com>
Message-ID: <Pine.LNX.4.44.0209230115270.3792-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 22 Sep 2002, bob wrote:

> However, for sake of argument, the above is still not true.  A global
> lock has a different (worse) performance problem then the lock-free
> atomic operation even given a global queue.  The difference is 1) the
> Linux global lock is very expensive [... and interacts with potential
> other processes, [...]

huh? what is 'the Linux global lock'?

> [...] and 2) you have to hold the lock for the entire duration of
> logging the event; with the atomic operation you are finished once
> you've reserved you space. [...]

you dont have to hold the lock for the duration of saving the event, the
lock could as well protect a 'current entry' index. (Not that those 2-3
cycles saving off the event into a single cacheline counts that much ...)

the tail-atomic method is precisely equivalent to a global spinlock. The
tail of a global event buffer acts precisely as a global spinlock: if one
CPU writes to it in a stream then it performs okay, if two CPUs trace in
parallel then it causes cachelines to bounce like crazy.

> [...] If you didn't use the expensive Linux global lock and just a
> global lock, you could be interrupted in the middle of holding the lock
> and performance would fall off the map.

again, what 'expensive Linux global lock' are you talking about?

	Ingo

