Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261467AbSIWW4Z>; Mon, 23 Sep 2002 18:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261468AbSIWW4Z>; Mon, 23 Sep 2002 18:56:25 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:46977 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S261467AbSIWW4Y>; Mon, 23 Sep 2002 18:56:24 -0400
Date: Mon, 23 Sep 2002 16:01:22 -0700
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Peter W?chtler <pwaechtler@mac.com>, Ingo Molnar <mingo@elte.hu>,
       Larry McVoy <lm@bitmover.com>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020923230122.GA3642@gnuppy.monkey.org>
References: <Pine.LNX.4.44.0209232233250.2343-100000@localhost.localdomain> <3D8F82E5.90A64E8@mac.com> <20020923184423.B26887@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020923184423.B26887@mark.mielke.cc>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 06:44:23PM -0400, Mark Mielke wrote:
> Think of it this way... two threads are blocked on different resources...
> The currently executing thread reaches a point where it blocks.
> 
>     OS threads:
>         1) thread#1 invokes a system call
>         2) OS switches tasks to thread#2 and returns from blocking
> 
>     user-space threads:
>         1) thread#1 invokes a system call
>         2) thread#1 returns from system call, EWOULDBLOCK

>         3) thread#1 invokes poll(), select(), ioctl() to determine state
>         4) thread#1 returns from system call

More like the UTS blocks the thread and waits for an IO upcall to notify
the change of state in the kernel. It's equivalent to a single in overhead,
something like a SIGIO, or async IO notification.

Delete 3 and 4. It's certainly much faster than select() and family.

>         5) thread#1 switches stack pointer to be thread#2 upon determination
>            that the resource thread#2 was waiting on is ready.

Right, then marks it running and runs it.

> Certainly the above descriptions are not fully accurate, or complete,
> and it is possible that the M:N threading would make a fair compromise
> between OS thread sand user-space threads, however, if user-space threads
> requires all this extra work, and M:N threads requires some extra work,
> some less work, and extra book keeping and system calls, why couldn't
> OS threads by themselves be more efficient?

Crazy synchronization by non-web-server like applications. Who knows. I
personally can't think up really clear example at this time since I don't
do that kind of programming, but I'm sure concurrency experts can...

I'm just not one of those people.

bill

