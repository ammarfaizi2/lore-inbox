Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132061AbQL1A6P>; Wed, 27 Dec 2000 19:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132105AbQL1A6F>; Wed, 27 Dec 2000 19:58:05 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:57101 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132061AbQL1A54>; Wed, 27 Dec 2000 19:57:56 -0500
Date: Wed, 27 Dec 2000 16:27:06 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
cc: Rik van Riel <riel@conectiva.com.br>, Dan Aloni <karrde@callisto.yi.org>,
        Zlatko Calusic <zlatko@iskon.hr>, "Marco d'Itri" <md@Linux.IT>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <20001227235533.T21944@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.10.10012271626040.10569-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Dec 2000, Philipp Rumpf wrote:

> On Wed, Dec 27, 2000 at 03:41:04PM -0800, Linus Torvalds wrote:
> > It must be wrong.
> > 
> > If we have a dirty page on the LRU lists, that page _must_ have a mapping.
> 
> What about pages with a mapping but without a writepage function ? or pages
> whose writepage function fails ?  The current code seems to simply put the
> page onto the active list in that case, which seems just as wrong to me.

ramfs. It doesn't have a writepage() function, as there is no backing
store.

> > The bug is somewhere else, and your patch is just papering it over. We
> > should not have a page without a mapping on the LRU lists in the first
> > place, except if the page has anonymous buffers (and such a page cannot
> 
> So is there any legal reason we could ever get to page_active ?  Removing
> that code (or replacing it with BUG()) certainly would make page_launder
> more readable.

Apart from the "we have no backing store", there is no legal reason to put
it back on the active list that I can see.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
