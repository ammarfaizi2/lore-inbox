Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129867AbRAUCxa>; Sat, 20 Jan 2001 21:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131816AbRAUCxU>; Sat, 20 Jan 2001 21:53:20 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:17067 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S129867AbRAUCxN>; Sat, 20 Jan 2001 21:53:13 -0500
Date: Sun, 21 Jan 2001 03:42:46 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.LNX.4.10.10101201629110.10849-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.10.10101210304510.19540-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 20 Jan 2001, Linus Torvalds wrote:

> But think like a good hardware designer.
> 
> In 99% of all cases, where do you want the results of a read to end up?
> Where do you want the contents of a write to come from?
> 
> Right. Memory.
> 
> Now, optimize for the common case. Make the common case go as fast as you
> can, with as little latency and as high bandwidth as you can.
> 
> What kind of hardware would _you_ design for the point-to-point link?
> 
> I'm claiming that you'd do a nice DMA engine for each link point. There
> wouldn't be any reason to have any other buffers (except, of course,
> minimal buffers inside the IO chip itself - not for the whole packet, but
> for just being able to handle cases where you don't have 100% access to
> the memory bus all the time - and for doing things like burst reads and
> writes to memory etc).
> 
> I'm _not_ seeing the point for a high-performance link to have a generic
> packet buffer. 

I completely agree, if we are talking about standard pc hardware. I was
more thinking about some dedicated hardware, where you want to get the
data directly to the correct place. If the hardware does a bit more with
the data you need large buffers. In a standard pc the main cpu does most
of the data processing, but in dedicated hardware you might have several
cards each with it's own logic and memory and here the cpu does manage
that stuff only. You can do all this of course from user space, but this
means you have to copy the data around, what you don't want with such
hardware, when the kernel can help you a bit.

bye, Roman

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
