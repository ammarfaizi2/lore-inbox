Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129776AbQLaPoa>; Sun, 31 Dec 2000 10:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129870AbQLaPoU>; Sun, 31 Dec 2000 10:44:20 -0500
Received: from hermes.cs.kuleuven.ac.be ([134.58.40.3]:29395 "EHLO
	hermes.cs.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S129776AbQLaPoB>; Sun, 31 Dec 2000 10:44:01 -0500
Date: Sat, 30 Dec 2000 14:24:06 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre5
In-Reply-To: <Pine.LNX.4.10.10012281459150.995-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10012301422310.581-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2000, Linus Torvalds wrote:
> On Thu, 28 Dec 2000, Andi Kleen wrote:
> > - Instead of having a zone pointer mask use a 8 or 16 byte index into a 
> > zone table. On a modern CPU it is much cheaper to do the and/shifts than
> > to do even a single cache miss during page aging. On a lot of systems 
> > that zone index could be hardcoded to 0 anyways, giving better code.
> > - Instead of using 4/8 bytes for the age use only 16bit (FreeBSD which
> > has the same swapping algorithm even only uses 8bit) 
> 
> This would be good, but can be hard.
> 
> FreeBSD doesn't try to be portable any more, but Linux does, and there are
> architectures where 8- and 16-bit accesses aren't atomic but have to be
> done with read-modify-write cycles.
> 
> And even for fields like "age", where we don't care whether the age itself
> is 100% accurate, we _do_ care that the fields close-by don't get strange
> effects from updating "age". We used to have exactly this problem on alpha
> back in the 2.1.x timeframe.
> 
> This is why a lot of fields are 32-bit, even though we wouldn't need more
> than 8 or 16 bits of them.

What about defining new types for this? Like e.g. `x8', being `u8' on platforms
were that's OK, and `u32' on platforms where that's more efficient?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
