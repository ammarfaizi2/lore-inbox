Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130456AbQKCWFJ>; Fri, 3 Nov 2000 17:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130771AbQKCWE7>; Fri, 3 Nov 2000 17:04:59 -0500
Received: from cr416993-a.ym1.on.wave.home.com ([24.112.193.232]:60424 "EHLO
	cr416993-a.ym1.on.wave.home.com") by vger.kernel.org with ESMTP
	id <S130456AbQKCWEj>; Fri, 3 Nov 2000 17:04:39 -0500
Date: Fri, 3 Nov 2000 17:02:59 -0500 (EST)
From: "D. Hugh Redelmeier" <hugh@mimosa.com>
Reply-To: hugh@mimosa.com
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Tim Riker <Tim@Rikers.org>, Andrea Arcangeli <andrea@suse.de>,
        Andi Kleen <ak@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux?
In-Reply-To: <3A01EB44.924D164A@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0011021800090.8398-100000@redshift.mimosa.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| From: Jeff Garzik <jgarzik@mandrakesoft.com>
| Subject: Re: non-gcc linux?
| 
| "D. Hugh Redelmeier" wrote:
| > Being GCC-dependent is rather parochial.  Being GCC-version-dependent
| > is downright embarrassing.
| > 
| > Summary: spurious GCC-isms are a bad thing.
| 
| Summary:  You have no clue about kernel<->gcc interdependencies and
| issues.

Not a very informative summary.  It may be true, but you ought to
help the reader learn.  A pointer is welcome.

| > - use ISO C 89 when possible (without undue pain)
| > 
| > - use IOS C 99 when advantageous
| > 
| > - use GCCisms for the remainder of appropriate things BUT embed them
| >   in macros defined in header so that they can be systematically
| >   replaced.  Using these macros probably makes the code more readable.
| >   Use of any GCCism should probably be justified in commentary.
| > 
| > This would improve the code *and* make it more portable.
| 
| Why does this improve the code?

In any environment, there are things that accidentally work.  Porting
the code finds those accidents and forces you to make them
intentionally work.

For example, my compiler is intended to find questionable code.  It
finds lots of things that GCC doesn't (or didn't use to -- I haven't
checked recently).  A few years ago, I pushed Midnight Commander
through my compiler and fed a number of suggestions back to Miguel.

|  It gets slower and uglier and more
| difficult to maintain.

I never asked for slower.  If a GCCism is faster, in a way that
matters (and lots of manual optimizations are not worthwhile), then
that is a justification.  So my suggestion allows it.

Well-designed macros improve maintainability.  They make the code more
readable.  And macro expansion happens at compile time, not run time.

| Why does this make the code more portable?  gcc is already highly
| portable, and so it the kernel.  This too gains us nothing.

The word "portable" has several meanings.  Tim clearly would not be
doing this if Lineo didn't think that it would get the kernel
somewhere that GCC didn't go, or at least didn't go as well as some
other compiler.

In the C standard, "maximally portable" is a higher level of language
conformance.

When I use portable, I also mean "avoiding exploitation of arbitrary
characteristics of the particular environment".  This kind of
portability increases robustness in the face of change.
w
Even though the vast majority of LINUX systems run on the x86
architecture, don't you think that we've all been enriched by what has
been learned porting to SPARC, Power PC, 68k, Alpha, HPPA, 390, ARM,
etc.?

Similarly, we'd all benefit by the changes suggested by the experience
of porting the kernel to another compiler.

If you think that the kernel is welded to GCC, it really ought to be
called the GNU/LINUX kernel-and-C-compiler :-)

| Removing gcc-isms without a pragmatic reason -- and no, ISO C compliancy
| is not a pragmatic reason -- is silly, extra work for little or no
| value.

Why?  Conforming to a standard is a Good Thing.  The ISO process of
making a standard is normally more careful, far sighted, and inclusive
than the extensions a particular implementor puts in their compiler.
A standard is a contract between language implementors and users.  We
don't have such a contract with GCC.

There are many resources for C programmers that don't cover GCC
extensions.  For example, course, books, and the ISO Standard itself.
Oh, and other compilers.

As HPA alluded to, the GCC extensions are not the most exercised parts
of the compiler.  They are thus more likely to contain bugs.

Hugh Redelmeier
hugh@mimosa.com  voice: +1 416 482-8253


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
