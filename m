Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135372AbRBEQ50>; Mon, 5 Feb 2001 11:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135389AbRBEQ5Q>; Mon, 5 Feb 2001 11:57:16 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:34314 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135372AbRBEQ5C>; Mon, 5 Feb 2001 11:57:02 -0500
Date: Mon, 5 Feb 2001 08:56:34 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: "Stephen C. Tweedie" <sct@redhat.com>, Christoph Hellwig <hch@caldera.de>,
        Steve Lord <lord@sgi.com>, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
 /notify  + callback chains
In-Reply-To: <3A7E95F3.38B26DC@colorfullife.com>
Message-ID: <Pine.LNX.4.10.10102050851030.30798-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Feb 2001, Manfred Spraul wrote:
> "Stephen C. Tweedie" wrote:
> > 
> > You simply cannot do physical disk IO on
> > non-sector-aligned memory or in chunks which aren't a multiple of
> > sector size.
> 
> Why not?
> 
> Obviously the disk access itself must be sector aligned and the total
> length must be a multiple of the sector length, but there shouldn't be
> any restrictions on the data buffers.

In fact, regular IDE DMA allows arbitrary scatter-gather at least in
theory. Linux has never used it, so I don't know how well it works in
practice - I would not be surprised if it ends up causing no end of nasty 
corner-cases that have bugs. It's not as if IDE controllers always follow 
the documentation ;)

The _total_ length of the buffers have to be a multiple of the sector
size, and there are some alignment issues (each scatter-gather area has to
be at least 16-bit aligned both in physical memory and in length, and
apparently many controllers need 32-bit alignment). And I'd almost be
surprised if there wouldn't be hardware that wanted cache alignment
because they always expect to burst. 

But despite a lot of likely practical reasons why it won't work for
arbitrary sg lists on plain IDE DMA, there is no _theoretical_ reason it
wouldn't. And there are bound to be better controllers that could handle
it.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
