Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318991AbSHQC2N>; Fri, 16 Aug 2002 22:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319117AbSHQC2N>; Fri, 16 Aug 2002 22:28:13 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:58351 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318991AbSHQC2M>;
	Fri, 16 Aug 2002 22:28:12 -0400
Date: Fri, 16 Aug 2002 22:32:10 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Larry McVoy <lm@bitmover.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
Subject: Re: IDE?
In-Reply-To: <Pine.LNX.4.44.0208161822130.1674-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0208162211030.14493-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Aug 2002, Linus Torvalds wrote:

> Good luck, but I think those init rules etc are really horribly subtle.

They are, but there is a buttload of amazingly convoluted C on top of them.
And I'd like to shave _that_ off.  After that we'll be left with real
complexity imposed by hardware - $DEITY witness, there's enough of it to
make the things nasty; no need to further complicate control flow...

Let me put it another way: I feel that a lot of things can be un-obfuscated
by pure equivalent transformations that would treat almost all driver as
block box - making sure that same functions are called with the same
arguments in the same order and not even thinking about possible
reordering/changes inside the "payload" part.

IOW, there is high-level logics that
	(a) is sufficiently separate from the guts
	(b) would be worth IOCCC submission if it passed the size limit
	(c) manages to mask and obfuscate _real_ complexity present in there.

And yes, I'd like that to be gone.  After that... at the very least we will
see what's really going on in there.  I'm rather sceptical about IDE-TNG -
grand rewrites _might_ be necessary at some point, but right now the mess
in the interfaces and in the way top-level code is organized is the worst
problem.  Any work with real guts of the driver is complicated by that and
IMO any decisions on what to do with the guts should wait until we _see_
said guts.

