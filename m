Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTEYNf1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 09:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbTEYNf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 09:35:27 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:38099 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262123AbTEYNf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 09:35:26 -0400
Date: Sun, 25 May 2003 15:46:47 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Mackerras <paulus@samba.org>
cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] update valkyriefb driver
In-Reply-To: <16079.23215.864277.374639@argo.ozlabs.ibm.com>
Message-ID: <Pine.GSO.4.21.0305251539340.11403-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 May 2003, Paul Mackerras wrote:
> This patch updates the valkyriefb driver to the new API.  It compiles
> OK, but I haven't been able to test it.  I have simplified the driver
> quite a bit using the knowledge that there can only ever be one
> valkyrie graphics adaptor in a system - it is the built-in graphics
> adaptor on various ancient mac and powermac machines, and we access it
> at a hard-coded address, so we can only handle one.

Thanks! It compiles fine without any warnings on m68k!

However, in addition you want to apply the patch below. macmodes.o is only
there for m68k (but it shouldn't harm for PPC), while you do need the cfb*.o
files on both platforms.

--- linux-2.5.69/drivers/video/Makefile	Tue Apr  8 10:05:26 2003
+++ linux-m68k-2.5.69/drivers/video/Makefile	Sun May 25 15:40:39 2003
@@ -26,7 +26,7 @@
 obj-$(CONFIG_FB_IGA)              += igafb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_CONTROL)          += controlfb.o
 obj-$(CONFIG_FB_PLATINUM)         += platinumfb.o
-obj-$(CONFIG_FB_VALKYRIE)         += valkyriefb.o
+obj-$(CONFIG_FB_VALKYRIE)         += valkyriefb.o macmodes.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_CT65550)          += chipsfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_ANAKIN)           += anakinfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_CLPS711X)         += clps711xfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

