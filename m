Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVG1QCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVG1QCq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 12:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVG1P6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 11:58:16 -0400
Received: from witte.sonytel.be ([80.88.33.193]:15591 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261573AbVG1P5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 11:57:16 -0400
Date: Thu, 28 Jul 2005 17:56:40 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jon Smirl <jonsmirl@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] fbdev: colormap fixes
In-Reply-To: <9e473391050728074573e40038@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0507281755350.24391@numbat.sonytel.be>
References: <200507280031.j6S0V3L3016861@hera.kernel.org> 
 <Pine.LNX.4.62.0507280952140.24391@numbat.sonytel.be>
 <9e473391050728074573e40038@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005, Jon Smirl wrote:
> Can you review this fix for the issues below? I fixed things to
> automatically adjust the number of entries to whatever fits in
> PAGE_SIZE.

Looks OK, but...

> @@ -317,18 +317,18 @@ static ssize_t show_cmap(struct class_de
>  	   !fb_info->cmap.green)
>  		return -EINVAL;
>  
> -	if (PAGE_SIZE < 4096)
> +	if (fb_info->cmap.len > PAGE_SIZE / 16)
>  		return -EINVAL;

... perhaps you want to just return the first PAGE_SIZE/16 entries, instead of
failing?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
