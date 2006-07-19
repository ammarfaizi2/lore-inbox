Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWGSMRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWGSMRc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 08:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWGSMRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 08:17:32 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:49167 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964801AbWGSMRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 08:17:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=SJ90m+BfM8D1DU8QrJrLTOD8M39R3q+IHsPalQb7aUUn9VlmWRhE1ytT/gaiMPL/0MPol6rmK68lZRB+mGI76+nD9E8Dc95eZgXYBiCoZR5S73sgeSpSU0fE4UcT3SXloR9KI9kv1TnYchEy7SpKkYxkTOE0oNMEUcbjDF1htvs=
Message-ID: <44BE22C8.3010204@gmail.com>
Date: Wed, 19 Jul 2006 20:17:12 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Panagiotis Issaris <takis@lumumba.uhasselt.be>
CC: linux-kernel@vger.kernel.org, len.brown@intel.com, chas@cmf.nrl.navy.mil,
       miquel@df.uba.ar, kkeil@suse.de, benh@kernel.crashing.org,
       video4linux-list@redhat.com, rmk+mmc@arm.linux.org.uk,
       Neela.Kolli@engenio.com, jgarzik@pobox.com, vandrove@vc.cvut.cz,
       adaplas@pol.net, thomas@winischhofer.net, weissg@vienna.at,
       philb@gnu.org, linux-pcmcia@lists.infradead.org, jkmaline@cc.hut.fi,
       paulus@samba.org
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
References: <20060719004659.GA30823@lumumba.uhasselt.be>
In-Reply-To: <20060719004659.GA30823@lumumba.uhasselt.be>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Panagiotis Issaris wrote:
> From: Panagiotis Issaris <takis@issaris.org>
> 
> drivers: Conversions from kmalloc+memset to k(z|c)alloc.
> 
> Signed-off-by: Panagiotis Issaris <takis@issaris.org>
> ---
  
> diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
> index a92a91f..11f8372 100644
> --- a/drivers/video/au1100fb.c
> +++ b/drivers/video/au1100fb.c
> @@ -453,11 +453,10 @@ int au1100fb_drv_probe(struct device *de
>  			return -EINVAL;
>  
>  	/* Allocate new device private */
> -	if (!(fbdev = kmalloc(sizeof(struct au1100fb_device), GFP_KERNEL))) {
> +	if (!(fbdev = kzalloc(sizeof(struct au1100fb_device), GFP_KERNEL))) {
>  		print_err("fail to allocate device private record");
>  		return -ENOMEM;
>  	}
> -	memset((void*)fbdev, 0, sizeof(struct au1100fb_device));
>  
>  	fbdev->panel = &known_lcd_panels[drv_info.panel_idx];
>  
> @@ -534,10 +533,9 @@ #endif
>  	fbdev->info.fbops = &au1100fb_ops;
>  	fbdev->info.fix = au1100fb_fix;
>  
> -	if (!(fbdev->info.pseudo_palette = kmalloc(sizeof(u32) * 16, GFP_KERNEL))) {
> +	if (!(fbdev->info.pseudo_palette = kzalloc(16, sizeof(u32), GFP_KERNEL))) {

typo? kcalloc?

>  		return -ENOMEM;
>  	}
> -	memset(fbdev->info.pseudo_palette, 0, sizeof(u32) * 16);
>  
>  	if (fb_alloc_cmap(&fbdev->info.cmap, AU1100_LCD_NBR_PALETTE_ENTRIES, 0) < 0) {
>  		print_err("Fail to allocate colormap (%d entries)",
> diff --git a/drivers/video/au1200fb.c b/drivers/video/au1200fb.c
> index c6a5f0c..7d0375a 100644
> --- a/drivers/video/au1200fb.c
> +++ b/drivers/video/au1200fb.c
> @@ -1589,11 +1589,10 @@ static int au1200fb_init_fbinfo(struct a
>  		return -EFAULT;
>  	}
>  
> -	fbi->pseudo_palette = kmalloc(sizeof(u32) * 16, GFP_KERNEL);
> +	fbi->pseudo_palette = kzalloc(16, sizeof(u32), GFP_KERNEL);

here also

The rest of drivers/video looks fine.

Tony
