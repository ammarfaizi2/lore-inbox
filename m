Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQJ3WVz>; Mon, 30 Oct 2000 17:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129040AbQJ3WVg>; Mon, 30 Oct 2000 17:21:36 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:53252 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129033AbQJ3WV2>; Mon, 30 Oct 2000 17:21:28 -0500
Date: Mon, 30 Oct 2000 14:21:16 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: test10-pre7
In-Reply-To: <Pine.GSO.4.21.0010301618160.1177-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10010301420050.1085-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Oct 2000, Alexander Viro wrote:
> 
> > I didn't actually miss it, I just looked at the users and decided that it
> > looks like they should never have this issue. But I might have missed
> > something. As far as I can tell, "read_cache_page()" is only used for
> > meta-data like things that cannot be truncated.
> 
> invalidate_inode_pages().

Nope. It checks the page count these days, so it would never kill such a
page from under us (we increment the page count while holding the
pagecache lock).

But yes, I'm starting to agree with you more and more..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
