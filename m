Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132262AbQKWQIB>; Thu, 23 Nov 2000 11:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129091AbQKWQHv>; Thu, 23 Nov 2000 11:07:51 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:2566 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S132262AbQKWQHe>; Thu, 23 Nov 2000 11:07:34 -0500
Date: Thu, 23 Nov 2000 07:37:27 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries.Brouwer@cwi.nl
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: {PATCH} isofs stuff
In-Reply-To: <UTC200011230350.EAA138908.aeb@aak.cwi.nl>
Message-ID: <Pine.LNX.4.10.10011230727310.7927-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Nov 2000 Andries.Brouwer@cwi.nl wrote:
> 
> I never read assembler, but looking at the code produced
> by gcc (2.95.2) it seemed peculiar, maybe an attempt to
> optimize something combining the
> 	if (filp->f_pos >= inode->i_size)
> with the
> 	while (filp->f_pos < inode->i_size)
> slightly later.

Can you send me the code in question? I don't have gcc-2.95.2, and I don't
want to install it. If this is truly a compiler bug, I'd like to see it
and verify it and get it reported to the gcc lists asap, as these kinds of
things are so damn nasty to find.

> I have seen that there were discussions on the right compiler to use.
> Is 2.95.2 wrong? Have other things to do tomorrow, so it will be
> 24 hours before I can look at this again.

2.95.2 should have been reasonably ok, but egcs-2.91.66 is probably
considered the most stable compiler right now.

Note that gcc has always had problems with "long long" variables. Very few
people use them as they aren't standard, and the code generation can be
much trickier, so bugs are much more likely. This (along with performance
issues) was why I refused the original LFS patches - they put "long long"
code all over the place.

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
