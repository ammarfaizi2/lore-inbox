Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137014AbRAHHuq>; Mon, 8 Jan 2001 02:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137125AbRAHHuh>; Mon, 8 Jan 2001 02:50:37 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:59340 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S137014AbRAHHu1>;
	Mon, 8 Jan 2001 02:50:27 -0500
Date: Mon, 8 Jan 2001 02:50:26 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Stefan Traby <stefan@hello-penguin.com>, linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
In-Reply-To: <E14EvNX-0001Ac-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0101080244560.2221-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Jan 2001, Alan Cox wrote:

> > > > Add UnlockPage(page) at the end of ramfs_writepage().
> > > Shit. You are quite fast. Works.
> > 
> > 	Sure, especially considering the fact that patch was sent to
> > Linus about a month ago (several times, actually)... ;-/
> 
> Its in all the -ac trees 8)
> 
> BTW Al: We have another general vfs/fs problem to handle - which is exceeding
> max file sizes on limited file systems. Pretty much nobody is getting it
> right. Ext2 can be tricked to go past the limit, sys5 1k sits there emitting
> printk messages etc.
 
> Any objections to me putting max file size for an fs (in pages) into the
> superblock ? An fs can still implement weird rules by putting large values
> in that and doing its own checks.

Alan, it doesn't work that way. Maximal size depends on the type of object,
for one thing. Moreover, it's not always a multiple of page size, so you
still need foo_get_block() to be aware of the problem (it should return
-EFBIG). Besides, we need to take care of the situations when some of
get_block() calls fail in prepare_write() - that can happen due to other
problems. I've fixed all that stuff for ext2 (check the patches posted on
l-k after 12-pre6). We need to propagate it into other filesystems, but
I don't think that max size in pages is really worth the trouble.

I can pull these patches out of the mix and send them to you. ACK?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
