Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265717AbSJTAwv>; Sat, 19 Oct 2002 20:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265722AbSJTAwv>; Sat, 19 Oct 2002 20:52:51 -0400
Received: from mnh-1-30.mv.com ([207.22.10.62]:41733 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S265717AbSJTAwu>;
	Sat, 19 Oct 2002 20:52:50 -0400
Message-Id: <200210200203.VAA04444@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andi Kleen <ak@muc.de>, john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0 
In-Reply-To: Your message of "Sun, 20 Oct 2002 02:15:40 +0200."
             <20021020001540.GR23930@dualathlon.random> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 19 Oct 2002 21:03:09 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andrea@suse.de said:
> What I suggested is an arch specific syscall to shutdown vsyscalls
> enterely for the current task and its childs, 

Then I misunderstood.

> the vsyscall will call
> into the real syscall with sysenter, and you will be able to
> revirtualize gettimeofday/time like you do on x86 with ptrace. 

And the task-specific fixmap entry would point to a page that makes the normal
system call?

> what do you mean that uml needs the vsyscalls more than the other
> archs? 

Because its system calls are much slower than the host's.  It would benefit
more from vsyscalls.

> I much prefer you to keep trapping the gettimeofday and time with
> ptrace after shutting down the vsyscalls for the current task, it's so
> much cleaner. 

And so much slower.

> The overhead of ptrace cannot be your point, if that
> overhead is a showstopper uml isn't an option in the first place.

I don't plan on using ptrace forever.  That overhead is going to shrink, and
vsyscalls are one way to make it shrink.

I intend to make UML perform by grabbing whatever improvements from wherever
I can get them, and if I can't get vsyscalls because they're not virtualizable,
then, from my point of view, their design is broken.

				Jeff

