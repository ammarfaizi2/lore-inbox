Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264568AbSIVWIe>; Sun, 22 Sep 2002 18:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264569AbSIVWIe>; Sun, 22 Sep 2002 18:08:34 -0400
Received: from twinlark.arctic.org ([208.44.199.239]:22184 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S264568AbSIVWId>; Sun, 22 Sep 2002 18:08:33 -0400
Date: Sun, 22 Sep 2002 15:13:44 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Bill Davidsen <davidsen@tmr.com>, Bill Huey <billh@gnuppy.monkey.org>,
       Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <m1u1khkgt7.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.44.0209221459040.20541-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Sep 2002, Eric W. Biederman wrote:

> I fail to see why:
>
> /* This is a safe point ... */
> if (needs to be suspended) {
>         save_all_registers_on_the_stack()
>         flag_gc_thread()
>         wait_until_gc_thread_has_what_it_needs()
> }
>
> Needs kernel support.

given that the existing code uses self-modifying-code for the safe-points
i'm guessing there are so many safe-points that the above if statement
would be excessive overhead (and the save/flag/wait stuff would probably
cause a huge amount of code bloat -- but could probably be a subroutine).

there was some really interesting GC work i heard about years ago where
the compiler generated GC code along-side the normal executable code.
the GC code understood the structure of the function and could make much
better choices of GC targets than a generic routine could.  when GC needs
to occur, a walk up the stack in each thread executing the
routine-specific GC stubs would be performed.  (given just the stack
frames you can index into a lookup table for the GC stubs... so there's no
overhead when GC isn't occuring.)  i don't have a reference handy though.

anyhow, this is probably getting off-topic :)

-dean




