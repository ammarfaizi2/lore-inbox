Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbRAICzs>; Mon, 8 Jan 2001 21:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRAICzj>; Mon, 8 Jan 2001 21:55:39 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:64519 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129534AbRAICzW>; Mon, 8 Jan 2001 21:55:22 -0500
Date: Mon, 8 Jan 2001 18:54:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@linuxcare.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cramfs is ro only, so honour this in inode->mode 
In-Reply-To: <E14FnXz-0000oy-00@halfway>
Message-ID: <Pine.LNX.4.10.10101081849220.1371-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Jan 2001, Rusty Russell wrote:
> In message <Pine.LNX.4.10.10101080930410.3750-100000@penguin.transmeta.com> you
>  write:
> > I've been thinking of doing a cramfs2, and the only thing I'd change is
> > (a) slightly bigger blocksize (maybe 8k or 16k) and (b) re-order the
> > meta-data and the real data so that I could easily compress the metadata
> > too. cramfs doesn't have any traditional meta-data (no bitmap blocks or
> > anything like that), but it wouldn't be that hard to put the directory
> > structure in the page cache and just compress the directories the same way
> > the real data is compressed.
> 
> And you'd still be worse than compressed loopback w/32k blocks, and
> more complex.  Now most of the loopback bugs seem fixed in 2.4, I'll
> port the cloop stuff, and we can compare.

If you compare, make sure that you don't compare the way some people seem
to compare. They see how well the ext2 image compresses, and ignore the
fact that the ext2 image itself has a lot of extraneous stuff (alignment,
bitmaps, very compressible meta-data etc).

The only valid comparison is how big the actual image file is for the same
trees. Also, you should take into account the size of the ext2 module and
cloop. I don't think you'd win.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
