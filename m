Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935706AbWLCKke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935706AbWLCKke (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 05:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935736AbWLCKke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 05:40:34 -0500
Received: from astra.telenet-ops.be ([195.130.132.58]:32727 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S935706AbWLCKkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 05:40:33 -0500
Date: Sun, 3 Dec 2006 11:40:27 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Yan Burman <burman.yan@gmail.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>, trivial@kernel.org
Subject: Re: [PATCH 2.6.19] m68k: replace kmalloc+memset with kzalloc
In-Reply-To: <1165058964.4523.30.camel@localhost>
Message-ID: <Pine.LNX.4.64.0612031140010.397@anakin>
References: <1165058964.4523.30.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2006, Yan Burman wrote:
> Replace kmalloc+memset with kzalloc 
> 
> Signed-off-by: Yan Burman <burman.yan@gmail.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> diff -rubp linux-2.6.19-rc5_orig/arch/m68k/amiga/chipram.c linux-2.6.19-rc5_kzalloc/arch/m68k/amiga/chipram.c
> --- linux-2.6.19-rc5_orig/arch/m68k/amiga/chipram.c	2006-11-09 12:16:21.000000000 +0200
> +++ linux-2.6.19-rc5_kzalloc/arch/m68k/amiga/chipram.c	2006-11-11 22:44:04.000000000 +0200
> @@ -52,10 +52,9 @@ void *amiga_chip_alloc(unsigned long siz
>  #ifdef DEBUG
>      printk("amiga_chip_alloc: allocate %ld bytes\n", size);
>  #endif
> -    res = kmalloc(sizeof(struct resource), GFP_KERNEL);
> +    res = kzalloc(sizeof(struct resource), GFP_KERNEL);
>      if (!res)
>  	return NULL;
> -    memset(res, 0, sizeof(struct resource));
>      res->name = name;
>  
>      if (allocate_resource(&chipram_res, res, size, 0, UINT_MAX, PAGE_SIZE, NULL, NULL) < 0) {
> 
> diff -rubp linux-2.6.19-rc5_orig/arch/m68k/atari/hades-pci.c linux-2.6.19-rc5_kzalloc/arch/m68k/atari/hades-pci.c
> --- linux-2.6.19-rc5_orig/arch/m68k/atari/hades-pci.c	2006-11-09 12:16:21.000000000 +0200
> +++ linux-2.6.19-rc5_kzalloc/arch/m68k/atari/hades-pci.c	2006-11-11 22:44:04.000000000 +0200
> @@ -375,10 +375,9 @@ struct pci_bus_info * __init init_hades_
>  	 * Allocate memory for bus info structure.
>  	 */
>  
> -	bus = kmalloc(sizeof(struct pci_bus_info), GFP_KERNEL);
> +	bus = kzalloc(sizeof(struct pci_bus_info), GFP_KERNEL);
>  	if (!bus)
>  		return NULL;
> -	memset(bus, 0, sizeof(struct pci_bus_info));
>  
>  	/*
>  	 * Claim resources. The m68k has no separate I/O space, both
> 
> 
> 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
