Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268335AbTBXDTg>; Sun, 23 Feb 2003 22:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269100AbTBXDTg>; Sun, 23 Feb 2003 22:19:36 -0500
Received: from warden3-p.diginsite.com ([208.147.64.186]:31196 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id <S268335AbTBXDTb>; Sun, 23 Feb 2003 22:19:31 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux@horizon.com, linux-kernel@vger.kernel.org
Date: Sun, 23 Feb 2003 19:28:32 -0800 (PST)
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <Pine.LNX.4.44.0302231805240.1690-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302231906360.8609-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

also the RISC argument was started back when the CPU ran at the same speed
as memory and CISC was limited to slow clock speeds, the RISC folks
figured that if they could eliminate the CISC complexity they could
ratchet up the clock speeds and more then make up for the other
inefficiancies.

unfortunantly for them the core CPU speeds became uncoupled from the
memory speeds and skyrocketed up to the point where CISC cores are as fast
or faster then the 'high speed' RISC cores.

so the remaining difference between CISC and RISC really isn't the core
functions, it's where do the optimizations take place.

in CISC they take place on the CPU (either in software or hardware)
in RISC they take place in the compiler

unfortunantly for the RISC folks the optimizations change significantly
from chip to chip and so the code needs to be compiled for each chip (in
many cases each motheboard) to take full advantage of them. while this
could be acceptable in an OpenSource world in the real world of
pre-compiled binaries companies are not interested in shipping a dozen
versions of a program so there is no preasure for the compilers to get
optimized this well (besides the problem of people not wanting to use the
'blessed' compiler), and software development always laggs hardware so the
compilers are never available when the CPUs are (and at the pace of
development by the time they are availabel new CPUs are out) while
on the CISC side of the house these optimizations are done in the CPU by
the designers of the chips and since the performance of the chips is
judged including these optimizations (no way to weasle out by claiming
it's a compiler problem) a lot of attention is paid to this work and it's
out when the chip is released (at this point both the tranemeta and intel
CPUs have the ability to update this code, but it's really only done to
fix major bugs)

the other big claim of the RISC folks was that they didn't waste
transisters on this since it was done in the compiler, but the transister
budget has climbed so high since then that this cost is minimal. I seem to
remember that intel claims that enabling hyperthreading (which not only
duplicates this entire section, but adds even more to keep them straight)
adds less then 10% to the transister count of the CPU. yes it would be
nicer to have those transisters available to be used for other things, but
experiance with RISC has shown that overall the tradeoff isn't worth it

David Lang

 On Sun, 23 Feb 2003, Linus Torvalds wrote:

> Date: Sun, 23 Feb 2003 18:39:09 -0800 (PST)
> From: Linus Torvalds <torvalds@transmeta.com>
> To: linux@horizon.com
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Minutes from Feb 21 LSE Call
>
>
> On 24 Feb 2003 linux@horizon.com wrote:
> >
> > Now wait a minute.  I thought you worked at Transmeta.
> >
> > There were no development and debugging costs associated with getting
> > all those different kinds of gates working, and all the segmentation
> > checking right?
>
> So? The only thing that matters is the end result.
>
> > Wouldn't it have been easier to build the system, and shift the effort
> > where it would really do some good, if you didn't have to support
> > all that crap?
>
> Probably not appreciably. You forget - it's been tried. Over and over
> again. The whole RISC philosophy was all about "wouldn't it perform better
> if you didn't have to support that crap".
>
> The fact is, the "crap" doesn't matter that much. As proven by the fact
> that the "crap" processor family ends up being the one that eats pretty
> much everybody else for lunch on performance issues.
>
> Yes, the "crap" does end up making it a harder market to enter. There's a
> lot of IP involved in knowing what all the rules are, and having literally
> _millions_ of tests that check for conformance to the architecture (and
> much of the "architecture" is a de-facto thing, not really written down in
> architecture manuals).
>
> But clearly even that is not insurmountable, as shown by the fact that not
> only does the x85 perform well, it's also one of the few CPU's that are
> actively worked on by multiple different companies (including Transmeta,
> as you point out - although clearly the "crap" is one reason why the sw
> approach works at all).
>
> > Transmeta's software-decoding is an extreme example of what all modern
> > x86 processors are doing in their L1 caches, namely predecoding the
> > instructions and storing them in expanded form.  This varies from
> > just adding boundary tags (Pentium) and instruction type (K7) through
> > converting them to uops and cacheing those (P4).
>
> But you seem to imply that that is somehow a counter-argument to _my_
> argument. And I don't agree.
>
> I think what Transmeta (and AMD, and VIA etc) show is that the ugliness
> doesn't really matter - there are different ways of handling it, and you
> can either throw hardware at it or software at it, but it's still worth
> doing, because in the end what matters is not the bad parts of it, but the
> good parts.
>
> Btw, the P4 tracecache does pretty much exactly the same thing that
> Transmeta does, except in hardware. It's based on a very simple reality:
> decoding _is_ going to be the bottleneck for _any_ instruction set, once
> you've pushed the rest hard enough. If you're not doing predecoding, that
> only means that you haven't pushed hard enough yet - _regardless_ of your
> archtiecture.
>
> > This exactly undoes any L1 cache size benefits.  The win, of course, is
> > that you don't have as much shifting and aligning on your i-fetch path,
> > which all the fixed-instruction-size architectures already started with.
>
> No. You don't understand what "cold-cache" case really means. It's more
> than just bringing the thing in from memory to the cache. It's also all
> about loading the dang thing from disk.
>
> > So your comments only apply to the L2 cache.
>
> And the disk.
>
> > And for the expense of all the instruction predecoding logic betweeen
> > L2 and L1, don't you think someone could build an instruction compressor
> > to fit more into the die-size-limited L2 cache?
>
> It's been done. See the PPC stuff. I've read the papers (it's been a long
> time, admittedly - it's not something new), and the fact is, it's not
> apparently being used that much. Because it's quite painful, unlike the
> x86 approach.
>
> > > stores - which helps in general.  While the RISC people were off trying
> > > to optimize their compilers to generate loops that used all 32 registers
> > > efficiently, the x86 implementors instead made the chip run fast on
> > > varied loads and used tons of register renaming hardware (and looking at
> > > _memory_ renaming too).
> >
> > I don't disagree that chip designers have managed to do very well with
> > the x86, and there's nothing wrong with making a virtue out of a necessity,
> > but that doesn't make the necessity good.
>
> Actually, you miss my point.
>
> The necessity is good because it _forced_ people to look at what really
> matters. Instead of wasting 15 years and countless PhD's on things that
> are, in the end, just engineering-masturbation (nr of registers etc).
>
> > The low register count *does* affect you when using a high-level language,
> > because if you have too many live variables floating around, you start
> > suffering.  Handling these spills is why you need memory renaming.
>
> Bzzt. Wrong answer.
>
> The right answer is that you need memory renaming and memory alias
> hardware _anyway_, because doing dynamic scheduling of loads vs stores is
> something that is _required_ to get the kind of performance that people
> expect today. And all the RISC stuff that tried to avoid it was just a BIG
> WASTE OF TIME. Because the _only_ thing the RISC approach ended up showing
> was that eventually you have to do the hard stuff anyway, so you might as
> well design for doing it in the first place.
>
> Which is what ia-64 did wrong - and what I mean by doing the same mistakes
> that everybody else did 15 years ago. Look at all the crap that ia64 does
> in order to do compiler-driven loop modulo-optimizations. That's part of
> the whole design, with predication and those horrible register windows.
> Can you say "risc mistakes all over again"?
>
> My strong suspicion (and that makes it a "fact" ;) is that in another 5
> years they'll get to where the x86 has been for the last 10 years, and
> they'll realize that they will need to do out-of-order accesses etc, which
> makes all of that modulo optimization pretty much useless, since the
> hardware pretty much has to do it _anyway_.
>
> > It's true that x86 processors have had fancy architectural features
> > sooner than similar-performance RISCs, but I think there's a fair case
> > that that's because they've *needed* them.
>
> Which is exactly my point. And by the time you implement them, you notice
> that the half-way measures don't mean anything, and in fact make for more
> problems.
>
> For example, that small register state is a pain in the ass, no? But since
> you basically need register renaming _anyway_, the small register state
> actually has some advantages in that it makes it easier to have tons of
> read ports and still keep the register file fast. And once you do renaming
> (including memory state renaming), IT DOESN'T MUCH MATTER.
>
> >				  Why do the P4 and K7/K8 have
> > such enormous reorder buffers, able to keep around 100 instructions
> > in flight at a time?  Because they need it to extract parallelism out
> > of an instruction stream serialized by a miserly register file.
>
> You think this is bad?
>
> Look at it another way: once you have hundreds of instructions in flight,
> you have hardware that automatically
>
>  - executes legacy applications reasonably well, since compilers aren't
>    the most important thing.
>
>    End result: users are happy.
>
>  - you don't need to have compilers that do stupid things like unrolling
>    loops, thus keeping your icache pressure down, since you do loop
>    unrolling in hardware thanks to deep pipelines.
>
> Even the RISC people are doing hundreds of instructions in flight (ie
> Power5), but they started doing it years after the x86 did, because they
> claimed that they could force their users to recompile their binaries
> every few years. And look where it actually got them..
>
> > They've developed some great technology to compensate for the weaknesses,
> > but it's sure nice to dream of an architecture with all that great
> > technology but with fewer initial warts.  (Alpha seemed like the
> > best hope, but *sigh*.  Still, however you apportion blame for its
> > demise, performance was clearly not one of its problems.)
>
> So my premise is that you always end up doing the hard things anyway, and
> the "crap" _really_ doesn't matter.
>
> Alpha was nice, no question about it. But it took them way too long to get
> to the whole OoO thing, because they tried to take a short-cut that in the
> end wasn't the answer. It _looked_ like the answer (the original alpha
> design was done explicitly to not _need_ things like complex out-of-order
> execution), but it was all just wrong.
>
> The thing about the x86 is that hard cold reality (ie millions of
> customers that have existign applications) really _forces_ you to look at
> what matters, and so far it clearly appears that the things you are
> complaining about (registers and segmentation) simply do _not_ matter.
>
> > I think the same claim applies much more powerfully to the ppc32's MMU.
> > It may be stupid, but it is only visible from inside the kernel, and
> > a fairly small piece of the kernel at that.
> >
> > It could be scrapped and replaced with something better without any
> > effect on existing user-level code at all.
> >
> > Do you think you can replace the x86's register problems as easily?
>
> They _have_ been solved. The x86 performs about twice as well as any ppc32
> on the market. End of discussion.
>
> > > The only real major failure of the x86 is the PAE crud.
> >
> > So you think AMD extended the register file just for fun?
>
> I think the AMD register file extension was unnecessary, yes. They did it
> because they could, and it wasn't a big deal. That's not the part that
> makes the architecture interesting. As you should well know.
>
> > Hell, the "PAE crud" is the *same* problem as the tiny register
> > file.  Insufficient virtual address space leading to physical > virtual
> > kludges.
>
> Nope. The small register file is a non-issue. Trust me. I do work for
> transmeta, and we do the register renaming in software, and it doesn't
> matter in the end.
>
> 			Linus
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
