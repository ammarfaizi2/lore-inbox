Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267978AbTCFJ7c>; Thu, 6 Mar 2003 04:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267977AbTCFJ7b>; Thu, 6 Mar 2003 04:59:31 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:43956 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S267978AbTCFJ7a>;
	Thu, 6 Mar 2003 04:59:30 -0500
Date: Thu, 6 Mar 2003 11:09:09 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ben Collins <bcollins@debian.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix compilation of atyfb
In-Reply-To: <20030306005130.GA419@phunnypharm.org>
Message-ID: <Pine.GSO.4.21.0303061106390.28248-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Mar 2003, Ben Collins wrote:
> I needed this patch in order for mach64 fb support to be compiled.
> 
> --- linux-2.5.64.orig/drivers/video/Makefile	2003-03-05 08:49:48.000000000 -0500
> +++ linux-2.5.64/drivers/video/Makefile	2003-03-05 08:59:41.000000000 -0500
> @@ -57,7 +57,7 @@
>  obj-$(CONFIG_FB_MATROX)		  += matrox/
>  obj-$(CONFIG_FB_RIVA)		  += riva/ cfbimgblt.o vgastate.o 
>  obj-$(CONFIG_FB_SIS)		  += sis/
> -obj-$(CONFIG_FB_ATY)		  += aty/ cfbimgblt.o cfbfillrect.o cfbimgblt.o
> +obj-$(CONFIG_FB_ATY)		  += aty/ cfbimgblt.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
>  obj-$(CONFIG_FB_I810)             += i810/ cfbfillrect.o cfbcopyarea.o \
>  	                             cfbimgblt.o vgastate.o

While you're at it, better remove the duplicate cfbimgblt.o too:

--- linux-2.5.64/drivers/video/Makefile	Wed Mar  5 10:07:24 2003
+++ linux-m68k-2.5.64/drivers/video/Makefile	Wed Mar  5 11:57:44 2003
@@ -57,7 +57,7 @@
 obj-$(CONFIG_FB_MATROX)		  += matrox/
 obj-$(CONFIG_FB_RIVA)		  += riva/ cfbimgblt.o vgastate.o 
 obj-$(CONFIG_FB_SIS)		  += sis/
-obj-$(CONFIG_FB_ATY)		  += aty/ cfbimgblt.o cfbfillrect.o cfbimgblt.o
+obj-$(CONFIG_FB_ATY)		  += aty/ cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_I810)             += i810/ cfbfillrect.o cfbcopyarea.o \
 	                             cfbimgblt.o vgastate.o
 
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

