Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312146AbSCRAdc>; Sun, 17 Mar 2002 19:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312153AbSCRAdW>; Sun, 17 Mar 2002 19:33:22 -0500
Received: from slip-202-135-75-217.ca.au.prserv.net ([202.135.75.217]:4501
	"EHLO wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S312146AbSCRAdE>; Sun, 17 Mar 2002 19:33:04 -0500
Date: Sun, 17 Mar 2002 17:50:09 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Martin Wirth <martin.wirth@dlr.de>
Cc: pwaechtler@loewe-komp.de, linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
Message-Id: <20020317175009.4f4954a0.rusty@rustcorp.com.au>
In-Reply-To: <3C932B2E.90709@dlr.de>
In-Reply-To: <E16m1oK-0006oy-00@wagner.rustcorp.com.au>
	<3C932B2E.90709@dlr.de>
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2002 12:23:26 +0100
Martin Wirth <martin.wirth@dlr.de> wrote:
> Rusty Russell wrote:
> >The solution I was referring to before, using full semaphores, would
> >look like so:

[snip]

> In principle that works. But one of  things that's less nice with 
> pthread_cond_wait is
> that you sometimes have a (most of the time) unnecessary schedule 
> ping-pong, and with the
> approach above you always have this (due to ack).

Only vs. pthread_cond_broadcast.  And if you're using that you probably
have some other performance issues anyway?

> And secondly if 
> futex_up(&f, N) for N > 1
> relies on the chained wakeup in the kernels futex_up routine the 
> broadcast may take a while to
> complete (the lowest priority waiter penalizes all others queued behind 
> him). A semaphore simply is no full replacement for a waitqueue with 
> wake_all.

Yes, we could have a "wake N" variant, which would be more efficient here.

Hope that clarifies,
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
