Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264032AbRGHV64>; Sun, 8 Jul 2001 17:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265975AbRGHV6q>; Sun, 8 Jul 2001 17:58:46 -0400
Received: from hq2.fsmlabs.com ([209.155.42.199]:32518 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S264032AbRGHV61>;
	Sun, 8 Jul 2001 17:58:27 -0400
Date: Sun, 8 Jul 2001 15:55:18 -0600
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why Plan 9 C compilers don't have asm("")
Message-ID: <20010708155518.A23324@hq2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9i50uf$tla$1@penguin.transmeta.com>
User-Agent: Mutt/1.3.18i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2001 at 06:44:31PM +0000, Linus Torvalds wrote:
> On ia64, you probably end up with function calls costing even more than
> alpha, because not only does the function call end up being a
> synchronization point for the compiler, it also means that the compiler
> cannot expose any parallelism, so you get an added hit from there.  At

That seems amazingly dumb. You'd think a new processor design would
optimize parallel computation over calls, but what do I know?

> Most of these "unconditional branches" are indirect, because rather few
> 64-bit architectures have a full 64-bit branch.  That means that in

This is something I don't get: I never understood why 32bit risc designers
were so damn obstinate about "every instruction fits in 32 bits"
and refused to have "call 32 bit immediate given in next word" not
to mention a "load 32bit immediate given in next word".
Note, the superior x86 instruction set has a 5 byte call immediate.


> There are lots of good arguments for function calls: they improve icache
> when done right, but if you have some non-C-semantics assembler sequence
> like "cli" or a spinlock that you use a function call for, that would
> _decrease_ icache effectiveness simply because the call itself is bigger
> than the instruction (and it breaks up the instruction sequence so you
> get padding issues). 

I think anywhere that you have inner loop or often used operations
that are short assembler sequences, inline asm is a win - it's easy to
show for example, that the Linux asm x86  macro semaphore down
is three times as fast as 
a called version. I wish, however
that GCC did not use a horrible overly complex lisplike syntax and
that there was a way to inline functions written in .S files.

And the feature is way too easy to abuse -  same argument here as in
the threads argument.
It's a far better thing to not need a semaphore at all than to rely
on handcoded semaphore down to make your poorly synchronized design
sort-of perform. 


