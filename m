Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132151AbQL1BQd>; Wed, 27 Dec 2000 20:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132156AbQL1BQW>; Wed, 27 Dec 2000 20:16:22 -0500
Received: from [213.8.206.162] ([213.8.206.162]:20997 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S132151AbQL1BQJ>;
	Wed, 27 Dec 2000 20:16:09 -0500
Date: Thu, 28 Dec 2000 02:43:18 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>, Zlatko Calusic <zlatko@iskon.hr>,
        "Marco d'Itri" <md@Linux.IT>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <20001227235533.T21944@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.21.0012280235240.5692-100000@callisto.yi.org>
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

I noticed the offset of 'mapping' in struct page doesn't match the offset
which get resolved at obsolute address 0x0000000c according to the Oops,
but it does matches the offset of a_ops in struct address_space, which
makes me wonder if it's possible that a_ops == NULL. Suggestions?
 
-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
