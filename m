Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315449AbSHOGlL>; Thu, 15 Aug 2002 02:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315472AbSHOGlL>; Thu, 15 Aug 2002 02:41:11 -0400
Received: from mx2.elte.hu ([157.181.151.9]:34494 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S315449AbSHOGlI>;
	Thu, 15 Aug 2002 02:41:08 -0400
Date: Thu, 15 Aug 2002 08:45:23 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <20020815050343.A27963@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.44.0208150837510.2197-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Aug 2002, Jamie Lokier wrote:

> I wonder if it makes more sense for the release word to be a futex --
> then various ways of actually waiting for the stack are available.

the window for locking is really small (and will always be small), so it's
cheaper for the fastpath to implement this as a spinlock, with the
stack-user being the lock holder.

> It would be nice if the stored word were the exit() code, too.  This
> would remove the need for zombie threads even when an exit status is
> desired.

this is an unrelated issue from the user-vm-unlock thing. pthread_join()  
(the new, futex based variant) already uses a futex (well, internal
pthreads mutex that in turn uses a futex) which also stores the exit code,
so threads are always be created in a detached state. But there are cases
when this is unnecessery, eg. when a thread later on calls
pthread_detach().

	Ingo

