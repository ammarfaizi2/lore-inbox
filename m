Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284507AbRLMSEJ>; Thu, 13 Dec 2001 13:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284500AbRLMSEA>; Thu, 13 Dec 2001 13:04:00 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:405 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S284507AbRLMSDw>; Thu, 13 Dec 2001 13:03:52 -0500
Date: Thu, 13 Dec 2001 10:03:12 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Repost: could ia32 mmap() allocations grow downward?
In-Reply-To: <BE42B9D5208@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.33.0112130945410.19658-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2001, Petr Vandrovec wrote:

> Maybe we should move to bug-glibc instead, as there is no way to force
> stdio to not ignore mallopt() parameters, it still insist on using
> mmap, and I think that it is a glibc2.2 bug.

OK, that makes sense for the glibc2 subthread of this discussion.  Would
you mind submitting the bug report, as you have a better command of the
issues than I do?  Or if you want, I can do it and just quote you.  :-)

> P.S.: I did some testing, and about 95% of mremap() allocations is
> targeted to last VMA, so no VMA move is needed for them. But no Java
> was part of picture, only c/c++ programs I use - gcc, mc, perl.

Ah, so this is important data.  It shows that the mmap() grows downward
strategy will hurt the common case.  I don't have any handle on the
magnitude of this effect, but if it is significant, then I would have to
agree that supporting the legacy brk() apps is not as important as keeping
mremap() of the last VMA cheap.  How expensive is moving a VMA, and how
often do programs mremap()?

How about the idea of modifying brk() (or adding an alternative) to move
VMAs out of the way as necessary?  This way the negative impact (of moving
VMAs) is only borne by the legacy brk() using app.  Or is there some other
downside that I am missing?

Wayne



