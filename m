Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135180AbRECUUN>; Thu, 3 May 2001 16:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135181AbRECUUD>; Thu, 3 May 2001 16:20:03 -0400
Received: from aeon.tvd.be ([195.162.196.20]:40773 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S135180AbRECUTu>;
	Thu, 3 May 2001 16:19:50 -0400
Date: Thu, 3 May 2001 22:16:55 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] Penguin logos
In-Reply-To: <Pine.LNX.4.05.10103082052340.432-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.05.10105032105310.28685-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Finally I found some time to incorporate the very nice logos contributed by
Simon Budig. Thank you Simon!

Patches (for both 2.4.5-pre1 and 2.4.4-ac4) can be downloaded from:

    http://home.tvd.be/cr26864/Linux/fbdev/logo.html

This page also shows the curent, old and new logos, and includes a tool to
extract logos in PNM format from the kernel sources (in case you don't trust me
:-) and a (NEW!) tool to convert logos in PNM format to C source suitable for
inclusion in the kernel.

I hope these are OK for all of you, so we can finally have politically correct
and good looking boot logos!

Changelog:

  - 2001/05/03:

      o Use the logos from Simon Budig.
      o Add pnmtologo.
      o Rename ARCH_LINUX_LOGO to __HAVE_ARCH_LINUX_LOGO*.

  - 2001/03/08:

      o This patch fixes some issues with the frame buffer device penguin logo
	code.

      o Bug list:
	  - The colors for the 16 color logo are wrong. We used a hack to give
	    the logo its own color palette, but this no longer works as a side
	    effect of a console color map bug being fixed a while ago. The
	    solution is to replace the logo with a new one that uses the
	    standard VGA console palette.
	  - There are still some politically-incorrect (PI) logos of a penguin
	    holding a glass of beer or wine (or perhaps even worse? :-).

      o Changes:
	 1. Update the frame buffer console code to no longer change the
	    palette when displaying the 16 color logo. Remove the tricks to
	    load the logo palette in unused palette entries on displays with >=
	    32 colors.
	 2. Replace the PI 16 color Penguin-with-beer logo by a new one,
	    derived from the 224 color logo.
	 3. Remove a superfluous include from drivers/char/console.c. The logo
	    code was moved to drivers/video/fbcon.c a long time ago.
	 4. Replace the PI black & white Penguin-with-beer logo by a new one,
	    derived from the PostScript version on Larry Ewing's webpage.
	 5. Remove drivers/sgi/char/linux_logo.h (containing a PI 224 color
	    Penguin-with-beer logo) since it's no longer used.
	 6. Remove the PI black & white Penguin-with-wine logo used on SPARC
	    and SPARC64. Use the generic logo instead.
	 7. Move linux_logo_* prototypes to <linux/linux_logo.h>.
	 8. Simplify the logo selection logic in arch-specific
	    <asm-xxx/linux_logo.h>.  If you want to have an arch-specific logo,
	    #define ARCH_LINUX_LOGO* and declare your data (if
	    INCLUDE_LINUX_LOGO_DATA is defined).

      o Changes 1, 2 and 3 are already present in Alan's tree.
	Change 5 is already present in the Linux/MIPS CVS tree.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

