Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316882AbSHOM7X>; Thu, 15 Aug 2002 08:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316878AbSHOM7X>; Thu, 15 Aug 2002 08:59:23 -0400
Received: from mx2.elte.hu ([157.181.151.9]:33766 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S316882AbSHOM7X>;
	Thu, 15 Aug 2002 08:59:23 -0400
Date: Thu, 15 Aug 2002 15:03:33 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <20020815113148.A28398@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.44.0208151502001.7855-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Aug 2002, Jamie Lokier wrote:

>    - intercept all the system calls that might call mmput(); that is,
>      exit() and execve()), just so it can move the thread-specific data
>      (including the stack) onto the "potentially free list".

(there's no need to intercept anything - glibc *is* the only legitimate
code that might call the raw sys_execve() & sys_exit() system-calls.)

>    - free the stack memory as soon as possible after a thread has died,
>      _without_ depending on garbage collection.  What if all the other
>      threads are compute-bound?  There's a lump of unnecessary stack
>      taking up memory for an indefinite time.
> 
> It seems that you're using a futex anyway -- so why not eliminate that
> pesky system call _and_ make sure pthread_join() work if some library
> you're linked to exits without calling pthread_exit()..

so how would it work exactly? My prediction is that you wont be able to
suggest any better methods than what i outlined in the original email, so
the best (and fastest) solution is some (minimal) kernel help.

	Ingo

