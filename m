Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277766AbRJLQ31>; Fri, 12 Oct 2001 12:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277758AbRJLQ3R>; Fri, 12 Oct 2001 12:29:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64518 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277750AbRJLQ3B>; Fri, 12 Oct 2001 12:29:01 -0400
Date: Fri, 12 Oct 2001 09:28:07 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists
 with insertion
In-Reply-To: <20011012150606.5d522fda.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.33.0110120919130.31677-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 Oct 2001, Rusty Russell wrote:
>
> The PPC manual (thanks Paul M) clearly indicates rmbdd() is not neccessary.
> That they mention it explicitly suggests it's going to happen on more
> architectures: you are correct, we should sprinkle rmbdd() everywhere
> (rmb() is heavy on current PPC) and I'll update the Kernel Locking Guide now
> the rules have changed.[1]

I would suggest re-naming "rmbdd()". I _assume_ that "dd" stands for "data
dependent", but quite frankly, "rmbdd" looks like the standard IBM "we
lost every vowel ever invented" kind of assembly lanaguage to me.

I'm sure that having programmed PPC assembly language, you find it very
natural (IBM motto: "We found five vowels hiding in a corner, and we used
them _all_ for the 'eieio' instruction so that we wouldn't have to use
them anywhere else").

But for us normal people, contractions that have more than 3 letters are
hard to remember. I wouldn't mind making the other memory barriers more
descriptive either, but with something like "mb()" at least you don't have
to look five times to make sure you got all the letters in the right
order..

(IBM motto: "If you can't read our assembly language, you must be
borderline dyslexic, and we don't want you to mess with it anyway").

So how about just going all the way and calling it what it is:
"data_dependent_read_barrier()", with a notice in the PPC docs about how
the PPC cannot speculate reads anyway, so it's a no-op.

(IBM motto: "TEN vowels? Don't you know vowels are scrd?")

And hey, if you want to, feel free to create the regular

	#define read_barrier()		rmb()
	#define write_barrier()		wmb()
	#define memory_barrier()	mb()

too. It's not as if we should ever have that many of them, and when we
_do_ have them, they might as well stand out to make it clear that we're
doing subtle things.. Although that "data-dependent read barrier" is a lot
more subtle than most.

		Linus

