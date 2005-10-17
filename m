Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbVJQIPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbVJQIPU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 04:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVJQIPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 04:15:20 -0400
Received: from ns.ustc.edu.cn ([202.38.64.1]:22171 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932183AbVJQIPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 04:15:19 -0400
Date: Mon, 17 Oct 2005 16:15:34 +0800
From: WU Fengguang <wfg@mail.ustc.edu.cn>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: 2.6.14-rc4-mm1
Message-ID: <20051017081534.GA4493@mail.ustc.edu.cn>
Mail-Followup-To: WU Fengguang <wfg@mail.ustc.edu.cn>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20051017001321.2358f341.akpm@osdl.org> <1129533808.7620.70.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129533808.7620.70.camel@gaston>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 05:23:27PM +1000, Benjamin Herrenschmidt wrote:
> Does that updated patch fixes it ?
Lots of rejects, so I manually applied the relevant part in nv_proto.h.
It worked, though there were warnings:

drivers/video/nvidia/nv_setup.c: In function `NVCommonSetup':
drivers/video/nvidia/nv_setup.c:408: warning: statement with no effect
drivers/video/nvidia/nv_setup.c:496: warning: statement with no effect
drivers/video/nvidia/nv_setup.c:504: warning: statement with no effect

> +#define nvidia_probe_i2c_connector(p, c, edid) (-1)
> +#define nvidia_probe_of_connector(p, c, edid)  (-1)
Do you mean TRUE/SUCCESS here with (-1)?

> 
> Index: linux-work/drivers/video/nvidia/nv_proto.h
> ===================================================================
> --- linux-work.orig/drivers/video/nvidia/nv_proto.h	2005-10-13 13:46:13.000000000 +1000
> +++ linux-work/drivers/video/nvidia/nv_proto.h	2005-10-17 17:22:28.000000000 +1000
> @@ -31,7 +31,7 @@
>  void NVLockUnlock(struct nvidia_par *par, int);
>  
>  /* in nvidia-i2c.c */
> -#if defined(CONFIG_FB_NVIDIA_I2C) || defined (CONFIG_PPC_OF)
> +#ifdef CONFIG_FB_NVIDIA_I2C
>  void nvidia_create_i2c_busses(struct nvidia_par *par);
>  void nvidia_delete_i2c_busses(struct nvidia_par *par);
>  int nvidia_probe_i2c_connector(struct fb_info *info, int conn,
> @@ -39,10 +39,14 @@
>  #else
>  #define nvidia_create_i2c_busses(...)
>  #define nvidia_delete_i2c_busses(...)
> -#define nvidia_probe_i2c_connector(p, c, edid) \
> -do {                                           \
> -	*(edid) = NULL;                        \
> -} while(0)
> +#define nvidia_probe_i2c_connector(p, c, edid) (-1)
> +#endif
> +
> +#ifdef CONFIG_FB_OF
> +int nvidia_probe_of_connector(struct fb_info *info, int conn,
> +			      u8 ** out_edid);
> +#else
> +#define nvidia_probe_of_connector(p, c, edid)  (-1)
>  #endif

Regards,
Wu Fengguang
