Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUBOLVs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 06:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbUBOLVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 06:21:48 -0500
Received: from witte.sonytel.be ([80.88.33.193]:62949 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261731AbUBOLVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 06:21:47 -0500
Date: Sun, 15 Feb 2004 12:21:40 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Peter Osterlund <petero2@telia.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3-rc3
In-Reply-To: <m2k72o4nvk.fsf@p4.localdomain>
Message-ID: <Pine.GSO.4.58.0402151220530.22078@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org>
 <m2znbk4s8j.fsf@p4.localdomain> <1076838882.6957.48.camel@gaston>
 <1076840755.6949.50.camel@gaston> <m2k72o4nvk.fsf@p4.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Feb 2004, Peter Osterlund wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> > BTW. This is the reason I left the "old" driver in, you can still
> > build it if the new ones goes wrong.
>
> Yes, you can still build the old driver, but it doesn't work unless
> you also apply this patch:
>
> --- linux/drivers/video/fbmem.c.old	2004-02-15 11:47:26.000000000 +0100
> +++ linux/drivers/video/fbmem.c	2004-02-15 11:43:42.000000000 +0100
> @@ -222,6 +222,9 @@
>  #ifdef CONFIG_FB_RADEON
>  	{ "radeonfb", radeonfb_init, radeonfb_setup },
>  #endif
> +#ifdef CONFIG_FB_RADEON_OLD
> +	{ "radeonfb_old", radeonfb_init, radeonfb_setup },
> +#endif
>  #ifdef CONFIG_FB_CONTROL
>  	{ "controlfb", control_init, control_setup },
>  #endif

IMHO you'd better keep one single entry for radeonfb and use

    #if defined(CONFIG_FB_RADEON) || defined(CONFIG_FB_RADEON_OLD)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
