Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319613AbSH3Q5H>; Fri, 30 Aug 2002 12:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319614AbSH3Q5H>; Fri, 30 Aug 2002 12:57:07 -0400
Received: from mx2.elte.hu ([157.181.151.9]:64737 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319613AbSH3Q5H>;
	Fri, 30 Aug 2002 12:57:07 -0400
Date: Fri, 30 Aug 2002 19:05:00 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] scheduler fixes, 2.5.32-BK
In-Reply-To: <Pine.LNX.4.44.0208301001400.2163-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208301902570.527-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Aug 2002, Linus Torvalds wrote:

> > actually, i think the race does not exist. up() is perfectly safely done
> > on the on-stack semaphore, because both the wake_up() done by __up() and
> > the __down() path takes the waitqueue spinlock, so i cannot see where
> > the up() touches the semaphore after the down()-ed task has been woken
> > up.
> 
> It touches the _spinlock_.

it touches the waitqueue spinlock - and the __down() path [ie. the process
that gets woken up, which has the semaphore on the stack] takes the
spinlock after waking up. Ie. there's guaranteed synchronization, the
semaphore will not be 'unused' before the __down() path takes the spinlock
- ie. after the __up() path releases the spinlock. What am i missing?

	Ingo

