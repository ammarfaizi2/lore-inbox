Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319611AbSH3QwH>; Fri, 30 Aug 2002 12:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319612AbSH3QwH>; Fri, 30 Aug 2002 12:52:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15378 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319611AbSH3QwG>; Fri, 30 Aug 2002 12:52:06 -0400
Date: Fri, 30 Aug 2002 10:03:15 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] scheduler fixes, 2.5.32-BK
In-Reply-To: <Pine.LNX.4.44.0208300948320.8448-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208301001400.2163-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Aug 2002, Ingo Molnar wrote:
> 
> actually, i think the race does not exist. up() is perfectly safely done
> on the on-stack semaphore, because both the wake_up() done by __up() and
> the __down() path takes the waitqueue spinlock, so i cannot see where
> the up() touches the semaphore after the down()-ed task has been woken
> up.

It touches the _spinlock_.

Which may no longer be a spinlock, since the waiter may never have blocked 
on it at all, and may have just succeeded directly with the atomic 
decrement of the counter.

Trust me, semaphores on the stack do not work unless there is some other 
synchronization above the semaphore level (or unless we make semaphores 
much slower, ie we take the spinlock even in the fast path).

		Linus

