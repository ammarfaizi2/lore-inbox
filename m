Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267579AbRG2JZ7>; Sun, 29 Jul 2001 05:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267577AbRG2JZs>; Sun, 29 Jul 2001 05:25:48 -0400
Received: from hood.tvd.be ([195.162.196.21]:62062 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S267579AbRG2JZe>;
	Sun, 29 Jul 2001 05:25:34 -0400
Date: Sun, 29 Jul 2001 11:19:19 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: herbert@gondor.apana.org.au
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Paul Mackerras <paulus@linuxcare.com.au>
Subject: Re: Patch in 2.2.18pre21 breaks fbcon logo
In-Reply-To: <20010728180801.A671@gondor.apana.org.au>
Message-ID: <Pine.LNX.4.05.10107291112320.10841-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, 28 Jul 2001, it was written:
> The following patch that appeared in 2.2.18pre21 breaks the fbcon logo.
> Anyone knows what it was for?

When switching to a new VC, the palette must be set after the switch to the new
VC. This matters for consoles where the palette handling is different for
different video modes and thus depends on the current VC (different VCs may use
a different video mode).

As an example, imagine switching from an 8-color pseudocolor console to a
15-bit directcolor console.

Iff it introduced a problem, are you sure it wasn't fixed in a later 2.2.x
release? If not, please compare with the corresponding 2.4.x console code.

Hmmm... something jumps into my mind. Probably this change means the 16-color
logo must use the VGA palette now, just like on 2.4.x. Fixes for that are on my
webpage:

    http://home.tvd.be/cr26864/Linux/fbdev/logo.html

Linus applied them in recent 2.4.x.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

