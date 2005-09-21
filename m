Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbVIULdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbVIULdK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 07:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVIULdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 07:33:10 -0400
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:24843 "EHLO
	smtp-vbr1.xs4all.nl") by vger.kernel.org with ESMTP
	id S1750827AbVIULdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 07:33:09 -0400
Date: Wed, 21 Sep 2005 13:32:36 +0200
From: jurriaan <thunder7@xs4all.nl>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: no cursor on nvidiafb console in 2.6.14-rc1-mm1
Message-ID: <20050921113236.GA4461@amd64.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20050919175116.GA8172@amd64.of.nowhere> <432F08C1.8010705@ppp0.net> <432F36B4.8030209@gmail.com> <432FBC93.4040007@ppp0.net> <432FE3E0.3020405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432FE3E0.3020405@gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antonino A. Daplas <adaplas@gmail.com>
Date: Tue, Sep 20, 2005 at 06:26:40PM +0800
> Heh, didn't realize that. drivers/video/nvidia/nvidia.c, actually.
> But just apply this patch instead, as a Kconfig change is also
> needed.
> 
> Signed-off-by: Antonino Daplas <adaplas@pol.net>
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -650,6 +650,7 @@ config FB_NVIDIA
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> +	select FB_SOFT_CURSOR
>  	help
>  	  This driver supports graphics boards with the nVidia chips, TNT
>  	  and newer. For very old chipsets, such as the RIVA128, then use
> diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
> --- a/drivers/video/nvidia/nvidia.c
> +++ b/drivers/video/nvidia/nvidia.c
> @@ -893,7 +893,7 @@ static int nvidiafb_cursor(struct fb_inf
>  	int i, set = cursor->set;
>  	u16 fg, bg;
>  
> -	if (!hwcur || cursor->image.width > MAX_CURS || cursor->image.height > MAX_CURS)
> +	if (cursor->image.width > MAX_CURS || cursor->image.height > MAX_CURS)
>  		return -ENXIO;
>  
>  	NVShowHideCursor(par, 0);
> @@ -1356,6 +1356,9 @@ static int __devinit nvidia_set_fbinfo(s
>  	info->pixmap.size = 8 * 1024;
>  	info->pixmap.flags = FB_PIXMAP_SYSTEM;
>  
> +	if (!hwcur)
> +	    info->fbops->fb_cursor = soft_cursor;
> +
>  	info->var.accel_flags = (!noaccel);
>  
>  	switch (par->Architecture) {
> 

Thanks, this fixes my problem.

Jurriaan
-- 
Pine - the outlook of Unix.
        Erik Hensema in xs4all.general
Debian (Unstable) GNU/Linux 2.6.14-rc1-mm1 5404 bogomips load 0.58
