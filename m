Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130847AbRBFBC0>; Mon, 5 Feb 2001 20:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131532AbRBFBCR>; Mon, 5 Feb 2001 20:02:17 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:2576 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130847AbRBFBCF>; Mon, 5 Feb 2001 20:02:05 -0500
Date: Mon, 5 Feb 2001 17:01:28 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@fh-brandenburg.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Stephen C. Tweedie" <sct@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Christoph Hellwig <hch@caldera.de>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.GSO.4.10.10102060052330.20184-100000@zeus.fh-brandenburg.de>
Message-ID: <Pine.LNX.4.10.10102051658530.31998-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Feb 2001, Roman Zippel wrote:
> > 
> > 	int nr_buffers:
> > 	struct buffer *array;
> > 
> > should be the low-level abstraction. 
> 
> Does it has to be vectors? What about lists?

I'd prefer to avoid lists unless there is some overriding concern, like a
real implementation issue. But I don't care much one way or the other -
what I care about is that the setup and usage time is as low as possible.
I suspect arrays are better for that.

I have this strong suspicion that networking is going to be the most
latency-critical and complex part of this, and the fact that the
networking code wanted arrays is what makes me think that arrays are the
right way to go. But talk to Davem and ank about why they wanted vectors.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
