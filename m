Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261890AbSJNIZg>; Mon, 14 Oct 2002 04:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261933AbSJNIZg>; Mon, 14 Oct 2002 04:25:36 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:27277 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261890AbSJNIZf>;
	Mon, 14 Oct 2002 04:25:35 -0400
Date: Mon, 14 Oct 2002 10:30:32 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: fbdev changes.
In-Reply-To: <20021013225159.GB5348@ppc.vc.cvut.cz>
Message-ID: <Pine.GSO.4.21.0210141020550.9580-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2002, Petr Vandrovec wrote:
> On Sun, Oct 13, 2002 at 01:27:08PM -0700, James Simmons wrote:
> > Second change!! We need a uiversal cursor api. I purposed some time ago a
> > api but nothing happend.I like to resolve this final part to remove th
> > last bit of console crude from the fbdev layer.

  [...]

> And what is meaning of image when mask is 1? For b&w cursors
> we need 0, 1, transparent and inverse.

Note that not all hardware supports inverse.
And on some hardware the cursor palette is shared with the screen palette,
that's why I had fb_fix_cursorinfo.crsr_color[12] in the original cursor API.

E.g. Amiga graphics don't have inverse. There are 8 sprites, each can have 3
colors (+ transparency). The colors are shared with the screen palette (unless
your screen has at most 16 colors):
  - sprites 0 and 1: transparent, palette[17], palette[18], palette[19]
  - sprites 2 and 3: transparent, palette[21], palette[22], palette[23]
  - sprites 4 and 5: transparent, palette[25], palette[26], palette[27]
  - sprites 6 and 7: transparent, palette[29], palette[30], palette[31]
There's also a special mode to combine an even an odd sprite to form a 15-color
(+ transparency) sprite.

Yes, it can be difficult to find a _good_ API ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

