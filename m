Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319475AbSH3HsC>; Fri, 30 Aug 2002 03:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319476AbSH3HsC>; Fri, 30 Aug 2002 03:48:02 -0400
Received: from mx2.elte.hu ([157.181.151.9]:31134 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319475AbSH3HsB>;
	Fri, 30 Aug 2002 03:48:01 -0400
Date: Fri, 30 Aug 2002 09:55:54 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] scheduler fixes, 2.5.32-BK
In-Reply-To: <Pine.LNX.4.44.0208300939030.8227-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208300948320.8448-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  - changes the migration code to use struct completion. Andrew pointed out
>    that there might be a small window in where the up() touches the
>    semaphore while the waiting task goes on and frees its stack. And
>    completion is more suited for this kind of stuff anyway.

actually, i think the race does not exist. up() is perfectly safely done
on the on-stack semaphore, because both the wake_up() done by __up() and
the __down() path takes the waitqueue spinlock, so i cannot see where the
up() touches the semaphore after the down()-ed task has been woken up.

the second argument still holds though - a completion is probably slightly
cheaper in this case.

	Ingo

