Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317205AbSFNLsp>; Fri, 14 Jun 2002 07:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317895AbSFNLsp>; Fri, 14 Jun 2002 07:48:45 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:15240 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S317205AbSFNLso>;
	Fri, 14 Jun 2002 07:48:44 -0400
Date: Fri, 14 Jun 2002 13:48:37 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: George Foot <gfoot@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug in matrox fb vsync code
Message-ID: <20020614114837.GA24388@vana.vc.cvut.cz>
In-Reply-To: <20020614001513.C1220@sutra.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2002 at 12:15:13AM +0100, George Foot wrote:
> I tried to mail this to Petr Vandrovec <vandrove@vc.cvut.cz> but
> the domain does not resolve.
> 
>     static int matroxfb_get_vblank(CPMINFO struct fb_vblank *vblank)
>     {
>         unsigned int sts1;
>     
>         memset(vblank, 0, sizeof(*vblank));
>         vblank->flags = FB_VBLANK_HAVE_VCOUNT | FB_VBLANK_HAVE_VSYNC |
>                 FB_VBLANK_HAVE_VBLANK | FB_VBLANK_HAVE_HBLANK;
>         sts1 = mga_inb(M_INSTS1);
>         vblank->vcount = mga_inl(M_VCOUNT);
>         /* BTW, on my PIII/450 with G400, reading M_INSTS1
>            byte makes this call about 12% slower (1.70 vs. 2.05 us
>            per ioctl()) */
>         if (sts1 & 1)
>             vblank->flags |= FB_VBLANK_HBLANKING;
>         if (sts1 & 8)
>             vblank->flags |= FB_VBLANK_VSYNCING;
> ****    if (vblank->count >= ACCESS_FBINFO(currcon_display)->var.yres)
>             vblank->flags |= FB_VBLANK_VBLANKING;

It should be vblank->vcount. It is fixed in mga-2.5.20-tvout.gz
at ftp://platan.vc.cvut.cz/pub/linux/matrox-latest. Obviously
this patch does not apply to 2.4.x.

> The line in question (marked ****) reads from vblank->count
> which is zeroed by the memset and not changed since then.  I
> believe it should be reading from vblank->vcount instead.

Yes.

> I'm sorry not to have checked whether this has been fixed; I
> found that some Matrox bugs were fixed since 2.4.18 in the
> 2.4.19 prerelease changelog, but my Internet connection is only
> a 56k modem so I can't afford to download either the prerelease
> patch or the latest development branch.

AFAIK it is not fixed even in latest 2.4.x prepatches.

> I'd also be interested to know if there's any documentation of
> the difference between VSYNC and VBLANK in the context of the
> fbdev code -- I haven't found any references in the kernel
> documentation, perhaps there's some resource online?

linux-fbdev.sourceforge.net maybe have some documentation.
I wrote implementation according to flags names...
					Petr Vandrovec
					vandrove@vc.cvut.cz
