Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129761AbQL1A1L>; Wed, 27 Dec 2000 19:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129778AbQL1A1A>; Wed, 27 Dec 2000 19:27:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56588 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129761AbQL1A0w>;
	Wed, 27 Dec 2000 19:26:52 -0500
Date: Wed, 27 Dec 2000 23:55:33 +0000
From: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Dan Aloni <karrde@callisto.yi.org>,
        Zlatko Calusic <zlatko@iskon.hr>, "Marco d'Itri" <md@Linux.IT>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: innd mmap bug in 2.4.0-test12
Message-ID: <20001227235533.T21944@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <Pine.LNX.4.21.0012271717230.14052-100000@duckman.distro.conectiva> <Pine.LNX.4.10.10012271537260.10485-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.10.10012271537260.10485-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Dec 27, 2000 at 03:41:04PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2000 at 03:41:04PM -0800, Linus Torvalds wrote:
> It must be wrong.
> 
> If we have a dirty page on the LRU lists, that page _must_ have a mapping.

What about pages with a mapping but without a writepage function ? or pages
whose writepage function fails ?  The current code seems to simply put the
page onto the active list in that case, which seems just as wrong to me.

> The bug is somewhere else, and your patch is just papering it over. We
> should not have a page without a mapping on the LRU lists in the first
> place, except if the page has anonymous buffers (and such a page cannot

So is there any legal reason we could ever get to page_active ?  Removing
that code (or replacing it with BUG()) certainly would make page_launder
more readable.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
