Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315256AbSEBSh7>; Thu, 2 May 2002 14:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315344AbSEBSh6>; Thu, 2 May 2002 14:37:58 -0400
Received: from mail.sonytel.be ([193.74.243.200]:44507 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S315256AbSEBSh6>;
	Thu, 2 May 2002 14:37:58 -0400
Date: Thu, 2 May 2002 20:35:41 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Andrea Arcangeli <andrea@suse.de>, Ralf Baechle <ralf@uni-koblenz.de>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: discontiguous memory platforms
In-Reply-To: <Pine.LNX.4.21.0205021041570.23113-100000@serv>
Message-ID: <Pine.GSO.4.21.0205022032280.27986-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2002, Roman Zippel wrote:
> On Thu, 2 May 2002, Andrea Arcangeli wrote:
> > What I
> > care about is not to clobber the common code with additional overlapping
> > common code abstractions.
> 
> Just to throw in an alternative: On m68k we map currently everything
> together into a single virtual area. This means the virtual<->physical
> conversion is a bit more expensive and mem_map is simply indexed by the
> the virtual address.
> It works nicely, it just needs two small patches in the initializition
> code, which aren't integrated yet. I think it's very close to what Daniel
> wants, only that the logical and virtual address are identical.

I also want to add that the order (by address) of the virtual chunk is not
necessarily the same as the order (by address) of the physical chunks.

So it's perfect possible to put the kernel in the second physical chunk, in
which case the first physical chunk (with a lower physical address) ends up in
the virtual list behind the first physical chunk.

IIRC (/me no Linux mm whizard), the above reason was the main reason why the
current zone system doesn't work well for m68k boxes (mainly talking about
Amiga).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

