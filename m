Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261359AbTC0TW6>; Thu, 27 Mar 2003 14:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261360AbTC0TW6>; Thu, 27 Mar 2003 14:22:58 -0500
Received: from pine.compass.com.ph ([202.70.96.37]:56589 "HELO
	pine.compass.com.ph") by vger.kernel.org with SMTP
	id <S261359AbTC0TW4>; Thu, 27 Mar 2003 14:22:56 -0500
Subject: Re: [Linux-fbdev-devel] Framebuffer fixes.
From: Antonino Daplas <adaplas@pol.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.21.0303271008190.26358-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0303271008190.26358-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1048792155.1109.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Mar 2003 03:15:30 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-27 at 17:09, Geert Uytterhoeven wrote:
> On 27 Mar 2003, Antonino Daplas wrote:
> >        - image->depth should be representative of the data depth
> > (currently, either 8 or 1).  If image->depth == 1, color expansion can
> > now be used to draw the logo, thus there's no need to differentiate
> > between mono logo drawing and monochrome expansion.
> 
> > +	/*
> > +	 * Monochrome expansion and logo drawing functions are the same if
> > +	 * fb_logo.needs_logo == 1.
> > +	 */
> > +	switch (info->fix.visual) {
> > +	case FB_VISUAL_MONO10:
> > +		image.fg_color = (u32) (~(~0UL << fb_logo.depth));
>                                                   ^^^^^^^^^^^^^
> > +		image.bg_color = 0;
> > +		image.depth = 1;
> > +		break;
> > +	case FB_VISUAL_MONO01:
> > +		image.bg_color = (u32) (~(~0UL << fb_logo.depth));
>                                                   ^^^^^^^^^^^^^
> > +		image.fg_color = 0;
> > +		image.depth = 1;
> > +		break;
> 
> Shouldn't these be info->var.bits_per_pixel instead of fb_logo.depth?
> 


Yes, fb_logo.depth == info->var.bits_per_pixel.

Tony

