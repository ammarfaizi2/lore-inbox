Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVCVRNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVCVRNm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 12:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbVCVRNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 12:13:42 -0500
Received: from witte.sonytel.be ([80.88.33.193]:15060 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261457AbVCVRN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 12:13:27 -0500
Date: Tue, 22 Mar 2005 18:13:17 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Jeff Garzik <jgarzik@pobox.com>, Linux/m68k <linux-m68k@vger.kernel.org>,
       Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Jazzsonic driver updates
In-Reply-To: <200503070210.j272ARii023023@hera.kernel.org>
Message-ID: <Pine.LNX.4.62.0503221807160.20753@numbat.sonytel.be>
References: <200503070210.j272ARii023023@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005, Linux Kernel Mailing List wrote:
> ChangeSet 1.1986, 2005/01/28 00:12:28-05:00, ralf@linux-mips.org
> 
> 	[PATCH] Jazzsonic driver updates
> 	
> 	 o Resurrect the Jazz SONIC driver after years of it not having been tested
> 	 o Convert from Space.c initialization to module_init / platform device.
> 	
> 	Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

> --- a/drivers/net/sonic.c	2005-03-06 18:10:39 -08:00
> +++ b/drivers/net/sonic.c	2005-03-06 18:10:39 -08:00
> @@ -116,7 +116,7 @@
>  	/*
>  	 * Map the packet data into the logical DMA address space
>  	 */
> -	if ((laddr = vdma_alloc(PHYSADDR(skb->data), skb->len)) == ~0UL) {
> +	if ((laddr = vdma_alloc(CPHYSADDR(skb->data), skb->len)) == ~0UL) {
                                ^^^^^^^^^
This part broke compilation for Mac/m68k.

>  		printk("%s: no VDMA entry for transmit available.\n",
>  		       dev->name);
>  		dev_kfree_skb(skb);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
