Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbVKKKXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbVKKKXU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 05:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVKKKXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 05:23:20 -0500
Received: from witte.sonytel.be ([80.88.33.193]:18096 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751257AbVKKKXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 05:23:20 -0500
Date: Fri, 11 Nov 2005 11:22:42 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Matt Mackall <mpm@selenic.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/15] misc: Make *[ug]id16 support optional
In-Reply-To: <11.282480653@selenic.com>
Message-ID: <Pine.LNX.4.62.0511111121400.3956@numbat.sonytel.be>
References: <11.282480653@selenic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2005, Matt Mackall wrote:
> Configurable 16-bit UID and friends support
> 
> This allows turning off the legacy 16 bit UID interfaces on embedded platforms.
> 
>    text    data     bss     dec     hex filename
> 3330172  529036  190556 4049764  3dcb64 vmlinux-baseline
> 3328268  529040  190556 4047864  3dc3f8 vmlinux
> 
> Signed-off-by: Matt Mackall <mpm@selenic.com>
> 
> Index: 2.6.14-misc/init/Kconfig
> ===================================================================
> --- 2.6.14-misc.orig/init/Kconfig	2005-11-09 11:21:02.000000000 -0800
> +++ 2.6.14-misc/init/Kconfig	2005-11-09 11:22:06.000000000 -0800
> @@ -364,7 +364,16 @@ config SYSENTER
>  	help
>  	  Disabling this feature removes sysenter handling as well as
>  	  vsyscall fixmaps.
> - 
> +
> +config UID16
> +	bool "Enable 16-bit UID system calls" if EMBEDDED
> +	depends !ALPHA && !PPC && !PPC64 && !PARISC && !V850 && !ARCH_S390X

Wouldn't it be better to explicitly list the architectures that support it?
I assume new architectures won't implement it anyway?

> +	depends !X86_64 || IA32_EMULATION
> +	depends !SPARC64 || SPARC32_COMPAT

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
