Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWA3KWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWA3KWr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 05:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWA3KWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 05:22:46 -0500
Received: from witte.sonytel.be ([80.88.33.193]:33186 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751270AbWA3KWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 05:22:46 -0500
Date: Mon, 30 Jan 2006 11:22:05 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Andrew Morton <akpm@osdl.org>, Ingo Oeser <ioe-lkml@rameria.de>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@hansmi.ch
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev: Fix usage of blank value
 passed to fb_blank
In-Reply-To: <43DD510E.9090404@gmail.com>
Message-ID: <Pine.LNX.4.62.0601301121250.18565@pademelon.sonytel.be>
References: <20060127231314.GA28324@hansmi.ch> <20060127.204645.96477793.davem@davemloft.net>
 <43DB0839.6010703@gmail.com> <200601282106.21664.ioe-lkml@rameria.de>
 <43DC25EB.1040005@gmail.com> <20060129144228.GA22425@sci.fi>
 <43DD510E.9090404@gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-1435854487-1138616525=:18565"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1435854487-1138616525=:18565
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 30 Jan 2006, Antonino A. Daplas wrote:
> Ville Syrjälä wrote:
> > On Sun, Jan 29, 2006 at 10:18:19AM +0800, Antonino A. Daplas wrote:
> >> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> >> index d2dede6..5bed0fb 100644
> >> --- a/drivers/video/fbmem.c
> >> +++ b/drivers/video/fbmem.c
> >> @@ -843,6 +843,19 @@ fb_blank(struct fb_info *info, int blank
> >>  {	
> >>   	int ret = -EINVAL;
> >>  
> >> +	/*
> >> +	 * The framebuffer core supports 5 blanking levels (FB_BLANK), whereas
> >> +	 * VESA defined only 4.  The extra level, FB_BLANK_NORMAL, is a
> >> +	 * console invention and is not related to power management.
> >> +	 * Unfortunately, fb_blank callers, especially X, pass VESA constants
> >> +	 * leading to undefined behavior.
> > 
> > Since when? X.Org uses numbers 0,2,3,4 which match the FB_BLANK 
> > constants not the VESA constants.
> > 
> 
> How about if we silently convert FB_BLANK_NORMAL requests to
> FB_BLANK_VSYNC_SUSPEND, would that work?

Do all (old, pre-VESA) monitors like it when vsync goes away?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
---584337861-1435854487-1138616525=:18565--
