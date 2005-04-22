Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVDVLVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVDVLVG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 07:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVDVLVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 07:21:05 -0400
Received: from vega.lnet.lut.fi ([157.24.109.150]:27146 "EHLO vega.lnet.lut.fi")
	by vger.kernel.org with ESMTP id S261984AbVDVLUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 07:20:35 -0400
Date: Fri, 22 Apr 2005 14:20:30 +0300
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, rth@twiddle.net,
       adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: 2.6.12-rc3 compile failure in tgafb.c
Message-ID: <20050422112030.GW607@vega.lnet.lut.fi>
References: <20050421185034.GS607@vega.lnet.lut.fi> <20050421204354.GF3828@stusta.de> <20050422072858.GU607@vega.lnet.lut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050422072858.GU607@vega.lnet.lut.fi>
User-Agent: Mutt/1.3.28i
From: lapinlam@vega.lnet.lut.fi (Tomi Lapinlampi)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2005 at 10:28:58AM +0300, Tomi Lapinlampi wrote:

> Hi,
> 
> This patch worked, tgafb.c now compiles. However, the compile
> fails later:
> 
> ...
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> local symbol 0: discarded in section `.exit.text' from drivers/built-in.o
> make: *** [.tmp_vmlinux1] Error 1
> 
> This does not happen if I disable CONFIG_FB_TGA.

Actually, I was able to get a clean compile with the patch from
http://marc.theaimsgroup.com/?l=linux-alpha&m=111392038121433&w=2

Which one is better, this or the one that Adrian sent?

Tomi

> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > --- linux-2.6.12-rc2-mm3-full/drivers/video/tgafb.c.old	2005-04-21 22:38:42.000000000 +0200
> > +++ linux-2.6.12-rc2-mm3-full/drivers/video/tgafb.c	2005-04-21 22:39:36.000000000 +0200
> > @@ -45,9 +45,7 @@
> >  static void tgafb_copyarea(struct fb_info *, const struct fb_copyarea *);
> >  
> >  static int tgafb_pci_register(struct pci_dev *, const struct pci_device_id *);
> > -#ifdef MODULE
> >  static void tgafb_pci_unregister(struct pci_dev *);
> > -#endif
> >  
> >  static const char *mode_option = "640x480@60";
> >  
> > @@ -1484,7 +1482,6 @@
> >  	return ret;
> >  }
> >  
> > -#ifdef MODULE
> >  static void __exit
> >  tgafb_pci_unregister(struct pci_dev *pdev)
> >  {
> > @@ -1500,6 +1497,7 @@
> >  	kfree(info);
> >  }
> >  
> > +#ifdef MODULE
> >  static void __exit
> >  tgafb_exit(void)
> >  {
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -- 
> You can decide: live with free software or with only one evil company left?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
You can decide: live with free software or with only one evil company left?
