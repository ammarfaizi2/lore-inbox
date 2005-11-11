Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbVKKLDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbVKKLDb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 06:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbVKKLDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 06:03:31 -0500
Received: from witte.sonytel.be ([80.88.33.193]:54453 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1750823AbVKKLDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 06:03:31 -0500
Date: Fri, 11 Nov 2005 12:03:25 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Matt Mackall <mpm@selenic.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/15] misc: Allow dropping panic text strings from kernel
 image
In-Reply-To: <12.282480653@selenic.com>
Message-ID: <Pine.LNX.4.62.0511111202220.3956@numbat.sonytel.be>
References: <12.282480653@selenic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2005, Matt Mackall wrote:
> Index: 2.6.14-misc/kernel/panic.c
> ===================================================================
> --- 2.6.14-misc.orig/kernel/panic.c	2005-11-09 11:27:15.000000000 -0800
> +++ 2.6.14-misc/kernel/panic.c	2005-11-10 23:26:41.000000000 -0800
> @@ -94,7 +106,11 @@ NORET_TYPE void panic(const char * fmt, 
>  	smp_send_stop();
>  #endif
>  
> +#ifdef CONFIG_FULL_PANIC
>  	notifier_call_chain(&panic_notifier_list, 0, buf);
> +#else
> +	notifier_call_chain(&panic_notifier_list, 0, "");
> +#endif

If you `#define buf ""' above, you can kill this #ifdef.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
