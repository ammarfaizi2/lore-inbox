Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265341AbSJaSng>; Thu, 31 Oct 2002 13:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265342AbSJaSnf>; Thu, 31 Oct 2002 13:43:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8204 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265341AbSJaSnd>; Thu, 31 Oct 2002 13:43:33 -0500
Date: Thu, 31 Oct 2002 10:49:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Wedgwood <cw@f00f.org>
cc: Jeff Garzik <jgarzik@pobox.com>, Dax Kelson <dax@gurulabs.com>,
       Rik van Riel <riel@conectiva.com.br>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: What's left over.
In-Reply-To: <20021031181252.GB24027@tapu.f00f.org>
Message-ID: <Pine.LNX.4.44.0210311040080.1526-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Oct 2002, Chris Wedgwood wrote:
> 
> It's synchronous and assume everything is synchronous.  Lots of
> hardware (most) doesn't work that way.

Think of it another way: many users will likely _require_ atomic
encryption / decryption (done in softirq contexts etc), and thus a 
synchronous interface. Also, it simplifies the code and makes it more 
efficient.

Any hardware that needs to go off and think about how to encrypt something
sounds like it's so slow as to be unusable. I suspect that anything that
is over the PCI bus is already so slow (even if it adds no extra cycles of
its own) that you're better off using the CPU for the encryption rather
than some external hardware.

In short, from what I can tell, there is no huge actual reason to ever
allow a asynchronous interface. Such interfaces are likely fine for things
like network cards that can do encryption on their own on outgoing or
incoming packets, but that is not a general-purpose encryption engine, and
would not merit being part of an encryption library anyway.

[ Such a card is just a way to _avoid_ using the encryption library - the
  same way we can avoid using the checksumming stuff for network cards 
  that can do their own checksums ]

We'll see. I'd rather have a simpler interface that works for all relevant
cases today, and then if external crypto chips end up being common and
sufficiently efficient, we can always re-consider. Are the DMA-over-PCI
roundtrip (and resulting cache invalidations) overheads really worth the
extra hardware?

		Linus

