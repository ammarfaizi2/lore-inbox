Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVAXS6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVAXS6y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 13:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVAXS6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 13:58:54 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:12455 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261567AbVAXS6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 13:58:44 -0500
Date: Mon, 24 Jan 2005 19:58:23 +0100
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050124185823.GE1847@ens-lyon.fr>
References: <20050124021516.5d1ee686.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124021516.5d1ee686.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 02:15:16AM -0800, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc1/2.6.11-rc1-mm1/
> 
> 
> - Lots of updates and fixes all over the place.
> 
> - On my test box there is no flashing cursor on the vga console.  Known bug,
>   please don't report it.
> 
>   Binary searching shows that the bug was introduced by
>   cleanup-vc-array-access.patch but that patch is, unfortunately, huge.
> 
> 
> 
> Changes since 2.6.11-rc1-mm2:
>
> [snip]
> 
> +matroxfb_basec-make-some-code-static.patch
> 
>  Little fixes.
> 
It breaks compilation with gcc-4.0

The patch below correct it.

regards,

Benoit

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>

--- linux-clean/drivers/video/matrox/matroxfb_base.h	2005-01-24 12:44:43.000000000 +0100
+++ linux-test/drivers/video/matrox/matroxfb_base.h	2005-01-24 19:49:29.000000000 +0100
@@ -764,7 +764,6 @@ void matroxfb_unregister_driver(struct m
 #define matroxfb_DAC_unlock_irqrestore(flags) spin_unlock_irqrestore(&ACCESS_FBINFO(lock.DAC),flags)
 extern void matroxfb_DAC_out(CPMINFO int reg, int val);
 extern int matroxfb_DAC_in(CPMINFO int reg);
-extern struct list_head matroxfb_list;
 extern void matroxfb_var2my(struct fb_var_screeninfo* fvsi, struct my_timming* mt);
 extern int matroxfb_wait_for_sync(WPMINFO u_int32_t crtc);
 extern int matroxfb_enable_irq(WPMINFO int reenable);
