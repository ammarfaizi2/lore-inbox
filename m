Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268526AbTBWTMG>; Sun, 23 Feb 2003 14:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268529AbTBWTMF>; Sun, 23 Feb 2003 14:12:05 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57871 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268526AbTBWTME>; Sun, 23 Feb 2003 14:12:04 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Minutes from Feb 21 LSE Call
Date: Sun, 23 Feb 2003 19:17:30 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b3b6oa$bsj$1@penguin.transmeta.com>
References: <E18moa2-0005cP-00@w-gerrit2> <Pine.LNX.4.44.0302222354310.8609-100000@dlang.diginsite.com> <20030223082036.GI10411@holomorphy.com>
X-Trace: palladium.transmeta.com 1046028108 27747 127.0.0.1 (23 Feb 2003 19:21:48 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 23 Feb 2003 19:21:48 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030223082036.GI10411@holomorphy.com>,
William Lee Irwin III  <wli@holomorphy.com> wrote:
>On Sun, Feb 23, 2003 at 12:07:50AM -0800, David Lang wrote:
>> Garrit, you missed the preior posters point. IA64 had the same fundamental
>> problem as the Alpha, PPC, and Sparc processors, it doesn't run x86
>> binaries.
>
>If I didn't know this mattered I wouldn't bother with the barfbags.
>I just wouldn't deal with it.

Why?

The x86 is a hell of a lot nicer than the ppc32, for example.  On the
x86, you get good performance and you can ignore the design mistakes (ie
segmentation) by just basically turning them off.

On the ppc32, the MMU braindamage is not something you can ignore, you
have to write your OS for it and if you turn it off (ie enable soft-fill
on the ones that support it) you now have to have separate paths in the
OS for it. 

And the baroque instruction encoding on the x86 is actually a _good_
thing: it's a rather dense encoding, which means that you win on icache. 
It's a bit hard to decode, but who cares? Existing chips do well at
decoding, and thanks to the icache win they tend to perform better - and
they load faster too (which is important - you can make your CPU have
big caches, but _nothing_ saves you from the cold-cache costs). 

The low register count isn't an issue when you code in any high-level
language, and it has actually forced x86 implementors to do a hell of a
lot better job than the competition when it comes to memory loads and
stores - which helps in general.  While the RISC people were off trying
to optimize their compilers to generate loops that used all 32 registers
efficiently, the x86 implementors instead made the chip run fast on
varied loads and used tons of register renaming hardware (and looking at
_memory_ renaming too).

IA64 made all the mistakes anybody else did, and threw out all the good
parts of the x86 because people thought those parts were ugly.  They
aren't ugly, they're the "charming oddity" that makes it do well.  Look
at them the right way and you realize that a lot of the grottyness is
exactly _why_ the x86 works so well (yeah, and the fact that they are
everywhere ;). 

The only real major failure of the x86 is the PAE crud.  Let's hope
we'll get to forget it, the same way the DOS people eventually forgot
about their memory extenders. 

(Yeah, and maybe IBM will make their ppc64 chips cheap enough that they
will matter, and people can overlook the grottiness there. Right now
Intel doesn't even seem to be interested in "64-bit for the masses", and
maybe IBM will be. AMD certainly seems to be serious about the "masses"
part, which in the end is the only part that really matters).

		Linus

