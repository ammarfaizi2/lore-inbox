Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281060AbRKTNBi>; Tue, 20 Nov 2001 08:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281059AbRKTNB2>; Tue, 20 Nov 2001 08:01:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:8966 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S280817AbRKTNBS>; Tue, 20 Nov 2001 08:01:18 -0500
Date: Tue, 20 Nov 2001 14:00:59 +0100
From: Jan Hubicka <jh@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>, Jan Hubicka <jh@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: i386 flags register clober in inline assembly
Message-ID: <20011120140059.E16297@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011118020957.A10674@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0111171844001.899-100000@penguin.transmeta.com> <20011120003338.A24717@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011120003338.A24717@twiddle.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Nov 17, 2001 at 06:48:22PM -0800, Linus Torvalds wrote:
> > That sounds pretty ideal - have some way of telling gcc to add a "seta
> > %reg", while at the same time telling gcc that if it can elide the "seta"
> > and use a direct jump instead, do so..
> 
> Hmm.  It appears to be easy to do with machine-dependent builtins.  E.g.
> 
> 	int x;
> 	__asm__ __volatile__(LOCK "subl %1,%0"
> 			     : "=m"(v->counter) : "ir"(i) : "memory");
> 	x = __builtin_ia32_sete();
> 	if (x) {
> 		...
> 	}
> 
> Now, you'd have to be careful in where that __builtin_ia32_sete
> gets placed, but I'd guess that immediately after an asm would
> be relatively safe.  No 100% guarantees on that, unfortunately.
> 
> And the sete _ought_ to get merged with the if test by combine
> or cse with no extra code.
> 
> It wouldn't take too much effort to try this out either...
True. Only obstackle I see is how to make visible that the flags
are set by the asm statement.  I guess we need to replace the clobber
we have by set.  Do you have any idea for nice syntax for this?
Or just to do that by default, as asms are mostly non-single-set anyway?

Honza

> 
> 
> r~
