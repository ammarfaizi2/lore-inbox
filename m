Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289761AbSAJWva>; Thu, 10 Jan 2002 17:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289758AbSAJWvU>; Thu, 10 Jan 2002 17:51:20 -0500
Received: from mx2.elte.hu ([157.181.151.9]:48846 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289761AbSAJWvM>;
	Thu, 10 Jan 2002 17:51:12 -0500
Date: Fri, 11 Jan 2002 01:48:36 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Anton Blanchard <anton@samba.org>, george anzinger <george@mvista.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] O(1) scheduler, -G1, 2.5.2-pre10, 2.4.17 (fwd)
In-Reply-To: <20020110135758.C15171@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.33.0201110142160.12174-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Jan 2002, Mike Kravetz wrote:

> If I run 3 cpu-hog tasks on a 2 CPU system, then 1 task will get an
> entire CPU while the other 2 tasks share the other CPU (easily
> verified by a simple test program). On previous versions of the
> scheduler 'balancing' this load was achieved by the global nature of
> time slices. No task was given a new time slice until the time slices
> of all runnable tasks had expired.  In the current scheduler, the
> decision to replenish time slices is made at a local (pre-CPU) level.
> I assume the load balancing code should take care of the above
> workload?  OR is this the behavior we desire? [...]

Arguably this is the most extreme situation - every other distribution
(2:3, 3:4) is much less problematic. Will this cause problems? We could
make the fairness-balancer more 'sharp' so that it will oscillate the
length of the two runqueues at a slow pace, but it's still caching loss.

> We certainly have optimal cache use.

indeed. The question is, should we migrate processes around just to get
100% fairness in 'top' output? The (implicit) cost of a task migration
(caused by the destruction & rebuilding of cache state) can be 10
milliseconds easily on a system with big caches.

	Ingo

