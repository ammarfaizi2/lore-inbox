Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129826AbRCCWfR>; Sat, 3 Mar 2001 17:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129830AbRCCWfH>; Sat, 3 Mar 2001 17:35:07 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:2319 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S129826AbRCCWe6>; Sat, 3 Mar 2001 17:34:58 -0500
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: changing precision control setting in initial FPU context
In-Reply-To: <200103032004.f23K417447302@saturn.cs.uml.edu>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: "Albert D. Cahalan"'s message of "Sat, 3 Mar 2001 15:04:01 -0500 (EST)"
Date: 03 Mar 2001 16:34:54 -0600
Message-ID: <vbazof2qy5t.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" <acahalan@cs.uml.edu> writes:
> >
> > Well, yes, but I'll try not to cry myself to sleep over it.  I'm
> > tempted to say that someone who chooses to use "float"s has given up
> > all pretense of caring about the answers they get.  And, if they
> > really want to do predictable math with floats they can change the FPU
> > control word from whatever its default is to PC==0.
> 
> There are algorithms which work fine using 32-bit floating-point,
> but which become unstable when you get unpredictable precision.
> It is reasonable to use such an algorithm and some 64-bit math in
> the same program. So there isn't any correct x86 setting.

So what?  Of course there's no "correct" x86 setting for all
situations.  In this particular situation, you will need to change the
PC on a function-by-function basis.  I'm just suggesting there might
be a better *default* PC than the current one.

> That would be an awful idea. There are two main useful behaviors:
> 
> 1. Pure IEEE for 32-bit, 64-bit, and 80-bit floating-point values.
>    The compiler rounds intermediate values by writing to memory
>    or by adjusting the precision control before each operation.
> 
> 2. Extra precision when it comes free. The precision control is set
>    to 80-bit and the compiler tries to keep values in registers.
>    This is usually the more useful behavior, and it performs better.

I find it difficult to believe that anyone would find the second
alternative even remotely comparable in "usefulness" to the first.
The extra precision isn't free; it comes at the expense of predictable
program behavior and compatibility with other i386 and non-i386
architectures.

> What you are suggesting is a gross hybrid. You claim it has something
> to do with IEEE, but it doesn't handle 32-bit math correctly. Your
> proposal is NOT true IEEE math.

What I am suggesting would permit IEEE 64-bit math to be done, in the
default configuration, in any GCC-compiled C program (with or without
optimization) that used only doubles for floating point arithmetic.
The current default PC allows no IEEE compliant GCC-compiled math in
any mode under any circumstances.  It also gives unexpected anamolous
results, *and* these results differ from the behavior under FreeBSD,
NetBSD, and most non-Intel platforms.

> Woah, what kind of crap is that???? You can not get true IEEE math
> by setting the precision control word at startup.

You don't; it turns out linking with "ieee" doesn't change the control
word; at one time it did, but the point was never to change the
precision control, it was to switch from POSIX to IEEE exception
handling.  And it wasn't my idea.

> Check the archives: the x86 Linux ABI specifies 80-bit precision.
> This will never change. The library is supposed to assume this,
> rather than try to allow for a change that will never happen.
> Linus dished out some nice toasty flames for the libc developers
> over this.

Okay, fine.  The Linux ABI can specify whatever the hell it wants.
Then, we should have a way for the library to communicate a preferred
default value to the kernel *WITHOUT* turning on the lazy FPU context
switching for every program.

Kevin <buhr@stat.wisc.edu>
