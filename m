Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbQJ3PmQ>; Mon, 30 Oct 2000 10:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129074AbQJ3PmF>; Mon, 30 Oct 2000 10:42:05 -0500
Received: from [195.63.194.11] ([195.63.194.11]:12816 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S129055AbQJ3PmD>; Mon, 30 Oct 2000 10:42:03 -0500
Message-ID: <39FDA365.F16B781D@evision-ventures.com>
Date: Mon, 30 Oct 2000 17:35:49 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Rik van Riel <riel@conectiva.com.br>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: killing read_ahead[]
In-Reply-To: <Pine.LNX.4.10.10010251036010.1337-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 25 Oct 2000, Rik van Riel wrote:
> >
> > OTOH, block-dev readahead makes sense for filesystems where
> > the packing locality is close to the access pattern BUT NOT
> > close to anything the page cache would recognise as being
> > close.
> 
> I dunno. The main reason I'd like to get the block devices into the page
> cache is that right now there is no way to mmap them - something that can
> potentially be _very_ useful, regardless of readahead.
> 
> And quite frankly, the generic file readahead has been pounded upon and
> tested a lot more than the block device read-ahead ever was. I bet it
> performs better if for no other reason.

And then of course the FS is the LOGICAL level of access to the device -
so
if read ahead matters then it's this level where it should happen -
since
this is the place where actual predictability of the next access
(actually
the assumption that the access will happen at least semi-sequentially)
has good
chances to be right. So you are completely right that the page-cache is
the right place where the rahead logic should take place. I have just
filled
the argumentation gap ;-).

-- 
- phone: +49 214 8656 283
- job:   STOCK-WORLD Media AG, LEV .de (MY OPPINNIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort:
ru_RU.KOI8-R
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
