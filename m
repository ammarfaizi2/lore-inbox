Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281239AbRKRIiR>; Sun, 18 Nov 2001 03:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281298AbRKRIiG>; Sun, 18 Nov 2001 03:38:06 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:28940 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S281239AbRKRIh6>; Sun, 18 Nov 2001 03:37:58 -0500
Date: Sun, 18 Nov 2001 08:51:52 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: VM-related Oops: 2.4.15pre1
Message-ID: <20011118085152.D25232@athlon.random>
In-Reply-To: <20011118051023.A25232@athlon.random> <Pine.LNX.4.33.0111172220300.1290-100000@penguin.transmeta.com> <20011118073730.C25232@athlon.random> <200111180731.fAI7VFa01371@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200111180731.fAI7VFa01371@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Nov 17, 2001 at 11:31:15PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2001 at 11:31:15PM -0800, Linus Torvalds wrote:
> No. It would be a _gcc_ bug if gcc did things to "page->flags" that the
> code did not ask it to do. And that is _regardless_ of any notions of
> "strictly conforming C code". The fact is, that if gcc were to clear a
> bit that the code never clears, that is a HUGE AND GAPING GCC BUG.

I see what you mean of course (the usual problem is that we never know
if gcc could make such decision for whatever subtle optimization, asm
optimizations are all but intuitional). But I just giveup also about the
other thing of reading from C variables that can change under us. So I'm ok
assuming gcc does what we expect here too, even if I'd prefer not to.

> The fact is, if we write code that leaves a certain bit unmodified, gcc
> MUST NOT modify that bit. If gcc generated code that temporarily
> modifies the bit, I can show user-level code that would break with
> signals. See "sig_atomic_t" and friends - the compiler simply _has_ to
> guarantee that the semantics you write in C code are actually upheld.

There should be proper macros to handle those userspace sig_atomic_t
because of that. Anyways I certainly believe there is code playing with
those types from C by hand :).

Andrea
