Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135556AbRAHRiC>; Mon, 8 Jan 2001 12:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135195AbRAHRhp>; Mon, 8 Jan 2001 12:37:45 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:12299 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135469AbRAHRha>; Mon, 8 Jan 2001 12:37:30 -0500
Date: Mon, 8 Jan 2001 09:37:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Shane Nay <shane@agendacomputing.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cramfs is ro only, so honour this in inode->mode
In-Reply-To: <20010108152904.K10035@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.10.10101080930410.3750-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2001, Ingo Oeser wrote:

> On Mon, Jan 08, 2001 at 12:13:39PM +0000, Shane Nay wrote:
> > This may not initially seem like such a great thing..., but imagine a base 
> > distro being distributed as a cramfs file.  Copy the thing over to your HD 
> > and you're done, otherwise the distro packaging has to keep track of 
> > permisions for each file, etc.
> 
> You can use (GNU-)tar for this. It even keeps track of other bits like
> ext2fs attributes, AFAIK.

Ehh.. And how were you going to mount it?

The advantage of cramfs is that you can make a cramfs CD-ROM, and you can
_run_ off that CD while you unpack it to your harddisk.

Using "tar" is not very practical. Doing a "tarfs" is probably not that
bad, but doing a "compressed-tar-fs" is a horrible pain in the neck
without big double buffers etc.

The advantage of cramfs is that it actually is a reasonably efficient
filesystem - becasue of the fairly small compression block-size it doesn't
compress as well as doing a bzip2 on a tar-file, but that small
compression block is also what makes random-access easy. And that's what
makes it easy to use cramfs as a "live" filesystem, very much unlike some
compressed tar-balls.

I've been thinking of doing a cramfs2, and the only thing I'd change is
(a) slightly bigger blocksize (maybe 8k or 16k) and (b) re-order the
meta-data and the real data so that I could easily compress the metadata
too. cramfs doesn't have any traditional meta-data (no bitmap blocks or
anything like that), but it wouldn't be that hard to put the directory
structure in the page cache and just compress the directories the same way
the real data is compressed.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
