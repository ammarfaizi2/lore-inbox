Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135222AbRBETK2>; Mon, 5 Feb 2001 14:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135605AbRBETKS>; Mon, 5 Feb 2001 14:10:18 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:62480 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135222AbRBETKD>; Mon, 5 Feb 2001 14:10:03 -0500
Date: Mon, 5 Feb 2001 11:09:45 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>,
        Christoph Hellwig <hch@caldera.de>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
 /notify + callback chains
In-Reply-To: <20010205184911.A2116@redhat.com>
Message-ID: <Pine.LNX.4.10.10102051101100.31165-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Feb 2001, Stephen C. Tweedie wrote:
> > Thats true for _block_ disk devices but if we want a generic kiovec then
> > if I am going from video capture to network I dont need to force anything more
> > than 4 byte align
> 
> Kiobufs have never, ever required the IO to be aligned on any
> particular boundary.  They simply make the assumption that the
> underlying buffered object can be described in terms of pages with
> some arbitrary (non-aligned) start/offset.  Every video framebuffer
> I've ever seen satisfies that, so you can easily map an arbitrary
> contiguous region of the framebuffer with a kiobuf already.

Stop this idiocy, Stephen. You're _this_ close to be the first person I
ever blacklist from my mailbox. 

Network. Packets. Fragmentation. Or just non-page-sized MTU's. 

It is _not_ a "series of contiguous pages". Never has been. Never will be.
So stop making excuses.

Also, think of protocols that may want to gather stuff from multiple
places, where the boundaries have little to do with pages but are
specified some other way. Imagine doing "writev()" style operations to
disk, gathering stuff from multiple sources into one operation.

Think of GART remappings - you can have multiple pages that show up as one
"linear" chunk to the graphics device behind the AGP bridge, but that are
_not_ contiguous in real memory.

There just is NO excuse for the "linear series of pages" view. And if you
cannot realize that, then I don't know what's wrong with you. Your
arguments are obviously crap, and the stuff you seem unable to argue
against (like networking) you decide to just ignore. Get your act
together.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
