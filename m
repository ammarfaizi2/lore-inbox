Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131983AbRCYDio>; Sat, 24 Mar 2001 22:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131984AbRCYDid>; Sat, 24 Mar 2001 22:38:33 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:17418 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131983AbRCYDi2>; Sat, 24 Mar 2001 22:38:28 -0500
Date: Sat, 24 Mar 2001 19:37:17 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kevin Buhr <buhr@stat.wisc.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
In-Reply-To: <vba7l1ex3o2.fsf@mozart.stat.wisc.edu>
Message-ID: <Pine.LNX.4.31.0103241932330.6710-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 24 Mar 2001, Kevin Buhr wrote:
>
> A huge win for 2.96 and absolutely no benefit whatsoever for 3.0, even
> though it obviously had a 10-fold effect on maps counts.  On the
> positive side, there was no performance *hit* either.

I don't think the system time in 3.0 has anything to do the the mmap size.

The 40 seconds of system time you see is probably mostly something else.
It's not as if gcc _only_ does mmap's.

Do a kernel profile, and I bet that the mmap stuff is pretty low in the
noise, and the 40 seconds are for things like clearing pages in
do_anonymous_page() and for actually reading and writing to the file. Note
how the sys numbers are now all pretty much the same across the board for
different gcc versions - regardless of whether they use mmap  for the
memory management or not.

(Well, gcc-2.95 and 2.96 are the same. Gcc-3.0 is higher, but it was
higher already before, and that's probably not the memory management per
se. I suspect it's because of other things, like bigger memory footprint
or similar. Or maybe the integrated preprocessor tends to do IO in smaller
chunks or something).

		Linus


