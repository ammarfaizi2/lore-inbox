Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751585AbWHAGbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbWHAGbl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 02:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbWHAGbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 02:31:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65182 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751584AbWHAGbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 02:31:40 -0400
Date: Mon, 31 Jul 2006 23:31:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Olaf Hering <olh@suse.de>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix link error in atyfb with backlight disabled
Message-Id: <20060731233134.d7477be8.akpm@osdl.org>
In-Reply-To: <20060731185220.GA5127@suse.de>
References: <20060731185220.GA5127@suse.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 20:52:20 +0200
Olaf Hering <olh@suse.de> wrote:

> 
> aty_bl_set_power is only defined if CONFIG_FB_ATY_BACKLIGHT is enabled.
> 
> Signed-off-by: Olaf Hering <olh@suse.de>
> 
> Index: linux-2.6.18-rc3/drivers/video/aty/atyfb_base.c
> ===================================================================
> --- linux-2.6.18-rc3.orig/drivers/video/aty/atyfb_base.c
> +++ linux-2.6.18-rc3/drivers/video/aty/atyfb_base.c
> @@ -2812,7 +2812,7 @@ static int atyfb_blank(int blank, struct
>  	if (par->lock_blank || par->asleep)
>  		return 0;
>  
> -#ifdef CONFIG_PMAC_BACKLIGHT
> +#if defined(CONFIG_PMAC_BACKLIGHT) && defined(CONFIG_FB_ATY_BACKLIGHT)
>  	if (machine_is(powermac) && blank > FB_BLANK_NORMAL)
>  		aty_bl_set_power(info, FB_BLANK_POWERDOWN);
>  #elif defined(CONFIG_FB_ATY_GENERIC_LCD)
> @@ -2844,7 +2844,7 @@ static int atyfb_blank(int blank, struct
>  	}
>  	aty_st_le32(CRTC_GEN_CNTL, gen_cntl, par);
>  
> -#ifdef CONFIG_PMAC_BACKLIGHT
> +#if defined(CONFIG_PMAC_BACKLIGHT) && defined(CONFIG_FB_ATY_BACKLIGHT)
>  	if (machine_is(powermac) && blank <= FB_BLANK_NORMAL)
>  		aty_bl_set_power(info, FB_BLANK_UNBLANK);
>  #elif defined(CONFIG_FB_ATY_GENERIC_LCD)

Linus merged a patch today (powermac-more-powermac-backlight-fixes.patch)
whcih changes all this stuff.  Its changelog included a mysterious "More
Kconfig fixes".

So can you please see if current -git is indeed fixed?

Thanks.

