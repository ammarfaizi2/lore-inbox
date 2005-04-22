Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVDVHcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVDVHcw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 03:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVDVHar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 03:30:47 -0400
Received: from vega.lnet.lut.fi ([157.24.109.150]:11530 "EHLO vega.lnet.lut.fi")
	by vger.kernel.org with ESMTP id S262005AbVDVH3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 03:29:03 -0400
Date: Fri, 22 Apr 2005 10:28:58 +0300
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, rth@twiddle.net,
       adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: 2.6.12-rc3 compile failure in tgafb.c
Message-ID: <20050422072858.GU607@vega.lnet.lut.fi>
References: <20050421185034.GS607@vega.lnet.lut.fi> <20050421204354.GF3828@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050421204354.GF3828@stusta.de>
User-Agent: Mutt/1.3.28i
From: lapinlam@vega.lnet.lut.fi (Tomi Lapinlampi)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2005 at 10:43:54PM +0200, Adrian Bunk wrote:
> On Thu, Apr 21, 2005 at 09:50:34PM +0300, Tomi Lapinlampi wrote:
> > 
> > Hi,
> > 
> > 2.6.12-rc3 compile fails in drivers/video/tgafb.c
> > 
> > The system is an Alphastation 600 5/266, system variant Alcor,
> > running Debian Sarge, gcc version 3.3.5 (Debian 1:3.3.5-8)
> > 
> > Btw, the tgafb hasn't really worked on this hardware since 2.6.8.1.
> > I'll be able to run more tests after this one compiles :)
> > 
> > Regards,
> > 
> > Tomi
> > 
> > % make
> >   CHK     include/linux/version.h
> > make[1]: `arch/alpha/kernel/asm-offsets.s' is up to date.
> >   CHK     include/asm-alpha/asm_offsets.h
> >   CHK     include/linux/compile.h
> >   CHK     usr/initramfs_list
> >   CC      drivers/video/tgafb.o
> > drivers/video/tgafb.c:85: error: `tgafb_pci_unregister' undeclared here (not in a function)
> > drivers/video/tgafb.c:85: error: initializer element is not constant
> > drivers/video/tgafb.c:85: error: (near initialization for `tgafb_driver.remove')
> > make[2]: *** [drivers/video/tgafb.o] Error 1
> > make[1]: *** [drivers/video] Error 2
> > make: *** [drivers] Error 2
> >...
> 
> The untested patch below should fix this compile error.

Hi,

This patch worked, tgafb.c now compiles. However, the compile
fails later:

...
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
local symbol 0: discarded in section `.exit.text' from drivers/built-in.o
make: *** [.tmp_vmlinux1] Error 1

This does not happen if I disable CONFIG_FB_TGA.

Tomi


> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.12-rc2-mm3-full/drivers/video/tgafb.c.old	2005-04-21 22:38:42.000000000 +0200
> +++ linux-2.6.12-rc2-mm3-full/drivers/video/tgafb.c	2005-04-21 22:39:36.000000000 +0200
> @@ -45,9 +45,7 @@
>  static void tgafb_copyarea(struct fb_info *, const struct fb_copyarea *);
>  
>  static int tgafb_pci_register(struct pci_dev *, const struct pci_device_id *);
> -#ifdef MODULE
>  static void tgafb_pci_unregister(struct pci_dev *);
> -#endif
>  
>  static const char *mode_option = "640x480@60";
>  
> @@ -1484,7 +1482,6 @@
>  	return ret;
>  }
>  
> -#ifdef MODULE
>  static void __exit
>  tgafb_pci_unregister(struct pci_dev *pdev)
>  {
> @@ -1500,6 +1497,7 @@
>  	kfree(info);
>  }
>  
> +#ifdef MODULE
>  static void __exit
>  tgafb_exit(void)
>  {
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
You can decide: live with free software or with only one evil company left?
