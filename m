Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275778AbRJFWgn>; Sat, 6 Oct 2001 18:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275805AbRJFWge>; Sat, 6 Oct 2001 18:36:34 -0400
Received: from smtp6.mindspring.com ([207.69.200.110]:21794 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S275778AbRJFWgS>; Sat, 6 Oct 2001 18:36:18 -0400
Subject: Re: low-latency patches
From: Robert Love <rml@tech9.net>
To: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011006010519.A749@draal.physics.wisc.edu>
In-Reply-To: <20011006010519.A749@draal.physics.wisc.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 06 Oct 2001 18:36:49 -0400
Message-Id: <1002407812.1915.21.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-10-06 at 02:05, Bob McElrath wrote:
> [...]
> Correct me if I'm wrong, but the former uses spinlocks to know when it can
> preempt the kernel, and the latter just tries to reduce latency by adding
> (un)conditional_schedule and placing it at key places in the kernel?

Correct.  The low-latency patch does some other work to try to break up
huge routines, too.
 
> My questions are:
> 1) Which of these two projects has better latency performance?  Has anyone
>     benchmarked them against each other?

I suspect you will find a lower average latency with the preemption
patch.  However, I suspect with the low-latency patch you may see a
lower maximum since it works on some of the terribly long-held lock
situations.

In truth, a combination of the two could prove useful.  I have been
working on finding the worst-case non-preemption regions (longest held
lock regions) in the kernel.

> 2) Will either of these ever be merged into Linus' kernel (2.5?)

I hope :)

> 3) Is there a possibility that either of these will make it to non-x86
>     platforms?  (for me: alpha)  The second patch looks like it would
>     straightforwardly work on any arch, but the config.in for it is only in
>     arch/i386.  Robert Love's patches would need some arch-specific asm...

Andrew's patch should work fine on all platforms, although I think the
configure statement is in the processor section so you will need to move
it to arch/alpha/config.in

The preemption patch has a small amount of arch-independent code but we
are working on supporting all architectures.  2.5...


	Robert Love

