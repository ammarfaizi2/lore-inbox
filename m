Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270649AbRHJVbR>; Fri, 10 Aug 2001 17:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270650AbRHJVbI>; Fri, 10 Aug 2001 17:31:08 -0400
Received: from wireless-folk-35-95.campsite.hal2001.org ([217.155.35.95]:63616
	"EHLO thefinal.cern.ch") by vger.kernel.org with ESMTP
	id <S270649AbRHJVbB>; Fri, 10 Aug 2001 17:31:01 -0400
Date: Mon, 6 Aug 2001 19:41:20 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/<n>/maps getting _VERY_ long
Message-ID: <20010806194120.A5803@thefinal.cern.ch>
In-Reply-To: <20010805171202.A20716@weta.f00f.org> <20010805204143.A18899@alcove.wittsend.com> <9kkq9k$829$1@penguin.transmeta.com> <9kkr7r$mov$1@cesium.transmeta.com> <9kl6aa$87l$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9kl6aa$87l$1@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Aug 06, 2001 at 04:26:50AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> >Do you count applications which selectively mprotect()'s memory (to
> >trap SIGSEGV and maintain coherency with on-disk data structures) as
> >"broken applications"?
> >
> >Such applications *can* use large amounts of mprotect()'s.
> 
> Note that such applications tend to not get any advantage from merging -
> it does in fact only slow things down (because then the next mprotect
> just has to split the thing again).
> 
> No, they aren't broken, but they should know that the use of lots of
> small memory segments (even if it is a design goal) can and will slow
> down page faulting, and use more memory for MM management for example. 
> 
> Linux does have a log(n) vma lookup, so the slowdown isn't huge.

There are garbage collectors that use mprotect() and SEGV trapping per
page.  It would be nice if there was a way to change the protections per
page without requiring a VMA for each one.

Btw, Linux has pretty fast SIGSEGV handling (the fastest of any
OS/machine combination that I measured), so it's a good platform for
this sort of thing.  I measured 7.75 microseconds per page for SEGV
trapping followed by mprotect() in the handler, on a particular test on
a 600MHz Pentium III.

-- Jamie
