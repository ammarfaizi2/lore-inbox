Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132685AbRAUAd7>; Sat, 20 Jan 2001 19:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132955AbRAUAdt>; Sat, 20 Jan 2001 19:33:49 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:11020 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132685AbRAUAdp>; Sat, 20 Jan 2001 19:33:45 -0500
Date: Sat, 20 Jan 2001 16:33:20 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@fh-brandenburg.de>
cc: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.GSO.4.10.10101202252380.13864-100000@zeus.fh-brandenburg.de>
Message-ID: <Pine.LNX.4.10.10101201629110.10849-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Jan 2001, Roman Zippel wrote:
> 
> On Sat, 20 Jan 2001, Linus Torvalds wrote:
> 
> > But point-to-point also means that you don't get any real advantage from
> > doing things like device-to-device DMA. Because the links are
> > asynchronous, you need buffers in between them anyway, and there is no
> > bandwidth advantage of not going through the hub if the topology is a
> > pretty normal "star" kind of thing. And you _do_ want the star topology,
> > because in the end most of the bandwidth you want concentrated at the
> > point that uses it.
> 
> I agree, but who says, that the buffer always has to be the main memory?

It doesn't _have_ to be.

But think like a good hardware designer.

In 99% of all cases, where do you want the results of a read to end up?
Where do you want the contents of a write to come from?

Right. Memory.

Now, optimize for the common case. Make the common case go as fast as you
can, with as little latency and as high bandwidth as you can.

What kind of hardware would _you_ design for the point-to-point link?

I'm claiming that you'd do a nice DMA engine for each link point. There
wouldn't be any reason to have any other buffers (except, of course,
minimal buffers inside the IO chip itself - not for the whole packet, but
for just being able to handle cases where you don't have 100% access to
the memory bus all the time - and for doing things like burst reads and
writes to memory etc).

I'm _not_ seeing the point for a high-performance link to have a generic
packet buffer. 

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
