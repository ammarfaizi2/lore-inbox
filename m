Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132864AbQL3Drw>; Fri, 29 Dec 2000 22:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132862AbQL3Drm>; Fri, 29 Dec 2000 22:47:42 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:55046 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132152AbQL3Drj>; Fri, 29 Dec 2000 22:47:39 -0500
Date: Fri, 29 Dec 2000 19:16:45 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@innominate.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: test13-pre6
In-Reply-To: <3A4D47B2.D89015CB@innominate.de>
Message-ID: <Pine.LNX.4.10.10012291913350.1722-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Dec 2000, Daniel Phillips wrote:

> Linus Torvalds wrote:
> > 
> > Ok, there's a test13-pre6 out there now, which does a partial sync with
> > Alan, in addition to hopefully fixing the innd shared mapping writeback
> > problem for good.  Thanks to Marcelo Tosatti and others..
> 
> After the page_cache_release at line 574 of vmscan.c the page is
> unlocked and only owned by the page cache - anything could happen.  How
> do you know the set_page_dirty at line 581 is still hitting a valid
> page?

Good question.

It should be safe because of the magic return value from "writepage()".

If "writepage()" returns 1, then that implies that the page is locked down
somehow. But you're right, this is ugly, if not outright buggy (maybe the
locked down state could change after the writepage, who knows?).

Moving the test is probably a good idea.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
