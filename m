Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265329AbSJRR2U>; Fri, 18 Oct 2002 13:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265234AbSJRR1s>; Fri, 18 Oct 2002 13:27:48 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:45292 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265329AbSJRRRl>; Fri, 18 Oct 2002 13:17:41 -0400
Date: Fri, 18 Oct 2002 10:16:46 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHS] fbdev updates.
In-Reply-To: <Pine.GSO.4.21.0210151109180.25245-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.33.0210181012560.10832-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So the generic part of the code should behave like this:
>
>   if (info->fbops->fb_blank && info->fbops->fb_blank(blank_flag)) {
>       /* use hardware blanking */
>   } else if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR ||
> 	     info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
>       /* use software blanking */
>   } else {
>       /* no blanking possible, except for filling the screen with black, which
> 	 is not appropriate (unless we save/restore the contents?) */
>   }
>
> Is that OK for you?

I was thinking more like

   if (info->fbops->fb_blank && info->fbops->fb_blank(blank_flag)) {
       /* use hardware blanking */
   } else if (info->var.accel_flags) {
	/* Use hardware fillrect to blank the screen */
 	info->fbops->fb_fillrect(info, whole_screen);
   } else {
	/* Nothing avaiable. Use set the colormap to black */
   }

What do you think?

