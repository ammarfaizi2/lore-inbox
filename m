Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129638AbRCHUPs>; Thu, 8 Mar 2001 15:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129623AbRCHUPj>; Thu, 8 Mar 2001 15:15:39 -0500
Received: from aeon.tvd.be ([195.162.196.20]:51420 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S129618AbRCHUP2>;
	Thu, 8 Mar 2001 15:15:28 -0500
Date: Thu, 8 Mar 2001 21:12:32 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [PATCH] Penguin logos
Message-ID: <Pine.LNX.4.05.10103082052340.432-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes some issues with the frame buffer device penguin logo code.

Bug list:
  - The colors for the 16 color logo are wrong. We used a hack to give the logo
    its own color palette, but this no longer works as a side effect of a
    console color map bug being fixed a while ago. The solution is to replace
    the logo with a new one that uses the standard VGA console palette.
  - There are still some politically-incorrect (PI) logos of a penguin holding
    a glass of beer or wine (or perhaps even worse? :-).

Changes:
 1. Update the frame buffer console code to no longer change the palette when
    displaying the 16 color logo. Remove the tricks to load the logo palette
    in unused palette entries on displays with >= 32 colors.
 2. Replace the PI 16 color Penguin-with-beer logo by a new one, derived from
    the 224 color logo.
 3. Remove a superfluous include from drivers/char/console.c. The logo code was
    moved to drivers/video/fbcon.c a long time ago.
 4. Replace the PI black & white Penguin-with-beer logo by a new one, derived
    from the PostScript version on Larry Ewing's webpage.
 5. Remove drivers/sgi/char/linux_logo.h (containing a PI 224 color
    Penguin-with-beer logo) since it's no longer used.
 6. Remove the PI black & white Penguin-with-wine logo used on SPARC and
    SPARC64. Use the generic logo instead.
 7. Move linux_logo_* prototypes to <linux/linux_logo.h>.
 8. Simplify the logo selection logic in arch-specific <asm-xxx/linux_logo.h>.
    If you want to have an arch-specific logo, #define ARCH_LINUX_LOGO* and
    declare your data (if INCLUDE_LINUX_LOGO_DATA is defined).

Changes 1, 2 and 3 are already present in Alan's tree.
Change 5 is already present in the Linux/MIPS CVS tree.

Patches (for both 2.4.3-pre3 and 2.4.2-ac14) can be downloaded from:

    http://home.tvd.be/cr26864/Linux/fbdev/logo.html

This page also shows the old and new logos, and includes a tool to extract
logos in PNM format from the kernel sources (in case you don't trust me :-).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

