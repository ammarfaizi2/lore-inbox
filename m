Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319627AbSH3RUV>; Fri, 30 Aug 2002 13:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319628AbSH3RUV>; Fri, 30 Aug 2002 13:20:21 -0400
Received: from mx2.elte.hu ([157.181.151.9]:27107 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319627AbSH3RUU>;
	Fri, 30 Aug 2002 13:20:20 -0400
Date: Fri, 30 Aug 2002 19:28:03 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] scheduler fixes, 2.5.32-BK
In-Reply-To: <Pine.LNX.4.44.0208301012480.2163-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208301916370.910-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Aug 2002, Linus Torvalds wrote:

> So why couldn't this happen? This is what used to happen before, I don't
> see that consolidating the spinlock had any impact at all.
> 
> 	CPU #0						CPU #1
> 
> 	down()						up()
> 
> 		lock decl (negative)
> 		__down()				lock incl
> 			spinlock()			__up()
> 			atomic_add_negative()
> 				success - break
> 			spinunlock();
> 		}					wake_up()
> 	return - semaphore is now invalid		spin_lock()
> 
> 							BOOM!

hm, indeed, you are right - completions are the only safe method.

i'm starting to wonder whether it's possible at all (theoretically) to
have a mutex design which has the current semaphore implementation's good
fastpath properties, but could also be used on stack.

	Ingo

