Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266986AbRGIAIm>; Sun, 8 Jul 2001 20:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266981AbRGIAIc>; Sun, 8 Jul 2001 20:08:32 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:55756 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266062AbRGIAIZ>; Sun, 8 Jul 2001 20:08:25 -0400
Date: Sun, 8 Jul 2001 20:08:24 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200107090008.f6908Op07251@devserv.devel.redhat.com>
To: yodaiken@fsmlabs.com, Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why Plan 9 C compilers don't have asm("")
In-Reply-To: <mailman.994629840.17424.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.994629840.17424.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux-kernel, you wrote:
> On Fri, Jul 06, 2001 at 06:44:31PM +0000, Linus Torvalds wrote:
> > On ia64, you probably end up with function calls costing even more than
> > alpha, because not only does the function call end up being a
> > synchronization point for the compiler, it also means that the compiler
> > cannot expose any parallelism, so you get an added hit from there.  At
> 
> That seems amazingly dumb. You'd think a new processor design would
> optimize parallel computation over calls, but what do I know?

Register windows do help some, in that sense ia64 is a big
step forward ofver x86. As I read what Linus wrote, he talked
about a different thing: inside a procedure you do not
know whence you are called, therefore you must start scheduling
anew from the first instruction of the procedure; before your
results hit the writeback stage, a lot of bubbles are in the
pipeline meanwhile. Your only hope is that they are used up
by unfinished computations in the caller. In this, rational
argument passing helps to exploit a possible overlap.

> > Most of these "unconditional branches" are indirect, because rather few
> > 64-bit architectures have a full 64-bit branch.  That means that in
> 
> This is something I don't get: I never understood why 32bit risc designers
> were so damn obstinate about "every instruction fits in 32 bits"
> and refused to have "call 32 bit immediate given in next word" not
> to mention a "load 32bit immediate given in next word".
> Note, the superior x86 instruction set has a 5 byte call immediate.

You must take into account that early riscs had miniscule dies,
for example the first Fujitsu made SPARC had 10,000 gates
all told. An alignment to the next instruction wastes hardware,
and, perhaps, a clock cycle.

-- Pete
