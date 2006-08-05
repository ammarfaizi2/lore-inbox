Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWHFWAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWHFWAF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 18:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWHFWAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 18:00:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40461 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750730AbWHFWAD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 18:00:03 -0400
Date: Sat, 5 Aug 2006 21:26:39 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: use persistent allocation for cursor blinking.
Message-ID: <20060805212639.GF5417@ucw.cz>
References: <20060801185618.GS22240@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801185618.GS22240@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Every time the console cursor blinks, we do a kmalloc/kfree pair.
> This patch turns that into a single allocation.
> 
> This allocation was the most frequent kmalloc I saw on my test box.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> 
> --- linux-2.6.14/drivers/video/console/softcursor.c~	2005-12-28 18:40:08.000000000 -0500
> +++ linux-2.6.14/drivers/video/console/softcursor.c	2005-12-28 18:45:50.000000000 -0500
> @@ -23,7 +23,9 @@ int soft_cursor(struct fb_info *info, st
>  	unsigned int buf_align = info->pixmap.buf_align - 1;
>  	unsigned int i, size, dsize, s_pitch, d_pitch;
>  	struct fb_image *image;
> -	u8 *dst, *src;
> +	u8 *dst;
> +	static u8 *src=NULL;
> +	static int allocsize=0;
>  

Spaces around = ? And perhaps it does not need to be initialized when
it is static?

							Pavel
-- 
Thanks for all the (sleeping) penguins.
