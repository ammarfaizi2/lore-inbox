Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268997AbTBWVqO>; Sun, 23 Feb 2003 16:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268998AbTBWVqO>; Sun, 23 Feb 2003 16:46:14 -0500
Received: from holomorphy.com ([66.224.33.161]:54445 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268997AbTBWVqM>;
	Sun, 23 Feb 2003 16:46:12 -0500
Date: Sun, 23 Feb 2003 13:55:21 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030223215521.GH27135@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <E18moa2-0005cP-00@w-gerrit2> <Pine.LNX.4.44.0302222354310.8609-100000@dlang.diginsite.com> <20030223082036.GI10411@holomorphy.com> <b3b6oa$bsj$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3b6oa$bsj$1@penguin.transmeta.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 07:17:30PM +0000, Linus Torvalds wrote:
>> If I didn't know this mattered I wouldn't bother with the barfbags.
>> I just wouldn't deal with it.

On Sun, Feb 23, 2003 at 07:17:30PM +0000, Linus Torvalds wrote:
> The x86 is a hell of a lot nicer than the ppc32, for example.  On the
> x86, you get good performance and you can ignore the design mistakes (ie
> segmentation) by just basically turning them off.

We "basically" turn it off, but I was recently reminded it existed,
as LDT's are apparently wanted by something in userspace. There seem
to be various other unwelcome reminders floating around performance
critical paths as well.

I vaguely remember segmentation being the only way to enforce
execution permissions for mmap(), which we just don't bother doing.


On Sun, Feb 23, 2003 at 07:17:30PM +0000, Linus Torvalds wrote:
> On the ppc32, the MMU braindamage is not something you can ignore, you
> have to write your OS for it and if you turn it off (ie enable soft-fill
> on the ones that support it) you now have to have separate paths in the
> OS for it. 

The hashtables don't bother me very much. They can relatively easily
be front-ended by radix tree pagetables anyway, and if it sucks, well,
no software in the world can save sucky hardware. Hopefully later models
fix it to be fast or disablable. I'm more bothered by x86 lacking ASN's.


On Sun, Feb 23, 2003 at 07:17:30PM +0000, Linus Torvalds wrote:
> And the baroque instruction encoding on the x86 is actually a _good_
> thing: it's a rather dense encoding, which means that you win on icache. 
> It's a bit hard to decode, but who cares? Existing chips do well at
> decoding, and thanks to the icache win they tend to perform better - and
> they load faster too (which is important - you can make your CPU have
> big caches, but _nothing_ saves you from the cold-cache costs). 

I'm not so sure, between things cacheline aligning branch targets and
space/time tradeoffs with smaller instructions running slower than
large sequences of instructions, this stuff gets pretty strange. It
still comes out smaller in the end but by a smaller-than-expected though
probably still significant margin. There's a good chunk of the
instruction set that should probably just be dumped outright, too.


On Sun, Feb 23, 2003 at 07:17:30PM +0000, Linus Torvalds wrote:
> The low register count isn't an issue when you code in any high-level
> language, and it has actually forced x86 implementors to do a hell of a
> lot better job than the competition when it comes to memory loads and
> stores - which helps in general.  While the RISC people were off trying
> to optimize their compilers to generate loops that used all 32 registers
> efficiently, the x86 implementors instead made the chip run fast on
> varied loads and used tons of register renaming hardware (and looking at
> _memory_ renaming too).

Invariably we get stuck diving into assembly anyway. =)

This one is basically me getting irked by looking at disassemblies of
random x86 binaries and seeing vast amounts of register spilling. It's
probably not a performance issue aside from code bloat esp. given the
amount of trickery with the weird L1 cache stack magic and so on.


On Sun, Feb 23, 2003 at 07:17:30PM +0000, Linus Torvalds wrote:
> IA64 made all the mistakes anybody else did, and threw out all the good
> parts of the x86 because people thought those parts were ugly.  They
> aren't ugly, they're the "charming oddity" that makes it do well.  Look
> at them the right way and you realize that a lot of the grottyness is
> exactly _why_ the x86 works so well (yeah, and the fact that they are
> everywhere ;). 

Count me as "not charmed". We've actually tripped over this stuff, and
for the most part you've been personally squashing the super low-level
bugs like the NT flag business and vsyscall segmentation oddities.

IA64 suffers from truly excessive featuritis and there are relatively
good chances some (or all) of them will be every bit as unused and
hated as segmentation if it actually survives.


On Sun, Feb 23, 2003 at 07:17:30PM +0000, Linus Torvalds wrote:
> The only real major failure of the x86 is the PAE crud.  Let's hope
> we'll get to forget it, the same way the DOS people eventually forgot
> about their memory extenders. 

We've not really been able to forget about segments or ISA DMA...
The pessimist in me has more or less already resigned me to PAE as
a fact of life.


On Sun, Feb 23, 2003 at 07:17:30PM +0000, Linus Torvalds wrote:
> (Yeah, and maybe IBM will make their ppc64 chips cheap enough that they
> will matter, and people can overlook the grottiness there. Right now
> Intel doesn't even seem to be interested in "64-bit for the masses", and
> maybe IBM will be. AMD certainly seems to be serious about the "masses"
> part, which in the end is the only part that really matters).

ppc64 is sane in my book (not vendor nepotism, the other "vanilla RISC"
machines get the same rating in my book). No idea about marketing stuff.


-- wli
