Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266926AbRGIBYb>; Sun, 8 Jul 2001 21:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266952AbRGIBYV>; Sun, 8 Jul 2001 21:24:21 -0400
Received: from kullstam.ne.mediaone.net ([66.30.138.48]:58527 "HELO
	kullstam.ne.mediaone.net") by vger.kernel.org with SMTP
	id <S266926AbRGIBYH>; Sun, 8 Jul 2001 21:24:07 -0400
From: "Johan Kullstam" <kullstam@ne.mediaone.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Why Plan 9 C compilers don't have asm("")
In-Reply-To: <20010708155518.A23324@hq2>
Organization: none
Date: 08 Jul 2001 21:22:46 -0400
In-Reply-To: <20010708155518.A23324@hq2>
Message-ID: <m2pubasxp5.fsf@euler.axel.nom>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Victor Yodaiken <yodaiken@fsmlabs.com> writes:

> On Fri, Jul 06, 2001 at 06:44:31PM +0000, Linus Torvalds wrote:
> > On ia64, you probably end up with function calls costing even more than
> > alpha, because not only does the function call end up being a
> > synchronization point for the compiler, it also means that the compiler
> > cannot expose any parallelism, so you get an added hit from there.  At
> 
> That seems amazingly dumb. You'd think a new processor design would
> optimize parallel computation over calls, but what do I know?
> 
> > Most of these "unconditional branches" are indirect, because rather few
> > 64-bit architectures have a full 64-bit branch.  That means that in
> 
> This is something I don't get: I never understood why 32bit risc designers
> were so damn obstinate about "every instruction fits in 32 bits"
> and refused to have "call 32 bit immediate given in next word" not
> to mention a "load 32bit immediate given in next word".
> Note, the superior x86 instruction set has a 5 byte call immediate.

the 32 bit MIPS (R3K series, at least) has a 32 bit instruction which
loads a 16 bit immediate (which fits within the instruction itself).
thus to load a 32 bit number takes two instructions.  since the
instructions are all 32 bits and must live on a multiple of 4 bytes,
this is as compact as you can get given the alignment constraint.

note that x86 is also fussy about alignment in various cases, e.g.,
double-precision floats.

> > There are lots of good arguments for function calls: they improve icache
> > when done right, but if you have some non-C-semantics assembler sequence
> > like "cli" or a spinlock that you use a function call for, that would
> > _decrease_ icache effectiveness simply because the call itself is bigger
> > than the instruction (and it breaks up the instruction sequence so you
> > get padding issues). 
> 
> I think anywhere that you have inner loop or often used operations
> that are short assembler sequences, inline asm is a win - it's easy to
> show for example, that the Linux asm x86  macro semaphore down
> is three times as fast as 
> a called version. I wish, however
> that GCC did not use a horrible overly complex lisplike syntax

lisp syntax is extremely simple.  i am not sure what GCC does to make
it complex.

> and
> that there was a way to inline functions written in .S files.
> 
> And the feature is way too easy to abuse -  same argument here as in
> the threads argument.
> It's a far better thing to not need a semaphore at all than to rely
> on handcoded semaphore down to make your poorly synchronized design
> sort-of perform. 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
J o h a n  K u l l s t a m
[kullstam@ne.mediaone.net]
Don't Fear the Penguin!
