Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262372AbUKZXjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbUKZXjF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263160AbUKZXjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 18:39:02 -0500
Received: from smtp-out.hotpop.com ([38.113.3.61]:48528 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S262372AbUKZXfk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 18:35:40 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: "Mario Gaucher" <zadiglist@zadig.ca>, adaplas@pol.net
Subject: Re: [PATCH] fbdev: Fix crash if fb_set_var() called before register_framebuffer()
Date: Sat, 27 Nov 2004 07:35:19 +0800
User-Agent: KMail/1.5.4
Cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
References: <200411250115.50895.adaplas@hotpop.com> <200411260845.04618.adaplas@hotpop.com> <20041126231251.M19516@zadig.ca>
In-Reply-To: <20041126231251.M19516@zadig.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411270735.21546.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 November 2004 07:17, Mario Gaucher wrote:
> From: "Antonino A. Daplas" <adaplas@hotpop.com>
>
> > > but I still has some problem with my Matrox Millenium PCI card using
> > > matroxfb driver... the kernel boot... but I get corrupted characters on
> > > the console... X load ok and display ok...
> >
> > Try this first.
> >
> > 1. Open drivers/video/matrox/matrofb_accel.c
> > 2. At the end of the file is this function:
> >
> > static void matroxfb_imageblit(struct fb_info* info, const struct
>
> fb_image* image) {
>
> > 	MINFO_FROM_INFO(info);
> >
> > 	DBG_HEAVY(__FUNCTION__);
> >
> > 	if (image->depth == 1) {
> > 		u_int32_t fgx, bgx;
> >
> > 		fgx = ((u_int32_t*)info->pseudo_palette)[image->fg_color];
> > 		bgx = ((u_int32_t*)info->pseudo_palette)[image->bg_color];
> > 		matroxfb_1bpp_imageblit(PMINFO fgx, bgx, image->data, image->width,
>
> image->height, image->dy, image->dx);
>
> > 	} else {
> > 		/* Danger! image->depth is useless: logo painting code always
> > 		   passes framebuffer color depth here, although logo data are
> > 		   always 8bpp and info->pseudo_palette is changed to contain
> > 		   logo palette to be used (but only for true/direct-color... sic...).
> > 		   So do it completely in software... */
> > 		cfb_imageblit(info, image);
> > 	}
> > }
> >
> > 3. Replace the above function to use software drawing so it becomes like
>
> this:
> > static void matroxfb_imageblit(struct fb_info* info, const struct
>
> fb_image* image) {
>
> > 	cfb_imageblit(info, image);
> > }
>
> this patch works fine on my PowerMac 7300 with my Matrox Millenium PCI
> card...
>
> so I think that both patch you sent me should be included in the kernel...

No, this modification is for testing purposes only.  It means that hardware
color expansion in matroxfb for powerpc's got broken.  CC'ed Petr.

Tony


