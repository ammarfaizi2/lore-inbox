Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275877AbSIUD4Y>; Fri, 20 Sep 2002 23:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275878AbSIUD4Y>; Fri, 20 Sep 2002 23:56:24 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:38788 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S275877AbSIUD4W>; Fri, 20 Sep 2002 23:56:22 -0400
Date: Fri, 20 Sep 2002 21:01:21 -0700
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020921040121.GA3895@gnuppy.monkey.org>
References: <20020920231133.GA2599@gnuppy.monkey.org> <Pine.LNX.4.44.0209202033360.22066-100000@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209202033360.22066-100000@twinlark.arctic.org>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 08:38:20PM -0700, dean gaudet wrote:
> SIGSTOP is different from other signals because it will stop the whole
> process group from continuing.  i am completely aware of how much of a
> pain it is to actually trap signals and do something (for apache 2.0's
> design i outlawed the use of signals because of the pains of getting
> things working in 1.3.x :).

There's definitely a need for a pthread_suspend_something() call...

> doesn't the hotspot GC work something like this:
> 
> - stop all threads
> - go read each thread's $pc, and find its nearest "safety point"
> - go overwrite that safety point (YUCK SELF MODIFYING CODE!! :) with
>   something which will stop the thread
> - start the threads and wait for them all to get to their safety points
> - perform gc
> - undo the above mess

+ read the entire ucontext for EAX, etc... so that it can be used for GC
roots. It could be allocating something in an executing method block
that hasn't hit stack or any kind of variable storage known to the GC.

> the only part of that which looks challenging with kernel threads is the
> $pc reading part...  ptrace will certainly get it for you, but that's a
> lot of syscall overhead.

And the entire ucontext.

> or am i missing something?

The ucontext. ;)

bill

