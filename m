Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316757AbSFUS64>; Fri, 21 Jun 2002 14:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316759AbSFUS6z>; Fri, 21 Jun 2002 14:58:55 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:48911 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S316757AbSFUS6y>;
	Fri, 21 Jun 2002 14:58:54 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Fri, 21 Jun 2002 12:46:34 -0600
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Larry McVoy <lm@bitmover.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux, the microkernel (was Re: latest linus-2.5 BK broken)
Message-ID: <20020621124634.H13628@host110.fsmlabs.com>
References: <Pine.LNX.4.44.0206201003500.8225-100000@home.transmeta.com> <m1r8j1rwbp.fsf@frodo.biederman.org> <20020621105055.D13973@work.bitmover.com> <3D136BEF.3030509@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D136BEF.3030509@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Jun 21, 2002 at 02:09:51PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's not a microkernel design philosophy, it's a good OS design
philosophy.  If it doesn't _have_ to be in the kernel, it generally
shouldn't be.

I agree with you that Linux is already a loosely connected yet highly
inter-dependent set of asynchronous tasks.  That makes for a very difficult
to analyze system.

I don't see Linux being in serious jeopardy in the short-term of becoming
solaris.  It only aims at running on 1-4 processors and does a pretty good
job of that.  Most sane people realize, as Larry points out, that the
current design will not scale to 64 processors and beyond.  That's obvious,
it's not an alarmist or deep statement.  The key is to realize that it's
not _meant_ to scale that high right now.

I've done a little work with Larry's suggestion for scaling Linux and it's
very smart in that it solves the problem in a very simple and elegant way.
DEC did the same thing with Galaxy some time ago but they layered it with
so much of their cluster software and OpenVMS that it lost all the
performance that it had gained by being clever.  If you want a simple
description of the idea (the way I am working on it), it's a software
version of NORMA.

Linux's sweet spot is 2-4 processors and probably shouldn't try to change.
It's a very hard problem going higher.  Many systems have failed in exactly
the same way trying to do that sort of thing.  Just cluster a bunch of
those 2-4 processor Linux's (room full of boxes, large 64-way IBM server or
some hybrid) and you have a clean solution.

} Oh, I don't mean the strict definition of microkernel, we are continuing 
} to push the dogma of "do it in userspace" or "do it in process context" 
} (IOW userspace in the kernel).
} 
} Look at the kernel now -- the current kernel is not simply an 
} event-driven, monolithic program [the tradition kernel design].  Linux 
} also depends on a number of kernel threads to perform various 
} asynchronous tasks.  We have had userspace agents managing bits of 
} hardware for a while now, and that trend is only going to be reinforced 
} with Al's initramfs.
} 
} IMO, the trend of the kernel is towards a collection of asynchronous 
} tasks, which lends itself to high parallelism.  Hardware itself is 
} trending towards playing friendly with other hardware in the system 
} (examples: TCQ-driven bus release and interrupt coalescing), another 
} element of parallelism.
} 
} I don't see the future of Linux as a twisted nightmare of spinlocks.
