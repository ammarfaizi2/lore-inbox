Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130743AbRBFAuN>; Mon, 5 Feb 2001 19:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132071AbRBFAuE>; Mon, 5 Feb 2001 19:50:04 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:36247 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S130743AbRBFAtq>; Mon, 5 Feb 2001 19:49:46 -0500
Date: Tue, 6 Feb 2001 01:31:12 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Stephen C. Tweedie" <sct@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Christoph Hellwig <hch@caldera.de>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.10.10102051118210.31206-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.10.10102060052330.20184-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 5 Feb 2001, Linus Torvalds wrote:

> This all proves that the lowest level of layering should be pretty much
> noting but the vectors. No callbacks, no crap like that. That's already a
> level of abstraction away, and should not get tacked on. Your lowest level
> of abstraction should be just the "area". Something like
> 
> 	struct buffer {
> 		struct page *page;
> 		u16 offset, length;
> 	};
> 
> 	int nr_buffers:
> 	struct buffer *array;
> 
> should be the low-level abstraction. 

Does it has to be vectors? What about lists? I'm thinking about this for
some time now and I think lists are more flexible. At higher level we can
easily generate a list of pages and in a lower level you can still split
them up as needed. It would be basically the same structure, but you
could use it everywhere with the same kind of operations.

bye, Roman

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
