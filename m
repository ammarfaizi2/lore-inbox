Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUAEOFL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 09:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264494AbUAEOFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 09:05:10 -0500
Received: from witte.sonytel.be ([80.88.33.193]:43697 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264396AbUAEOFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 09:05:03 -0500
Date: Mon, 5 Jan 2004 15:04:47 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Mueller <d.mueller@elsoft.ch>, Tom Rini <trini@kernel.crashing.org>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: PPC32: Fix the floppy driver, on CONFIG_NOT_COHERENT_CACHE.
In-Reply-To: <200401032002.i03K25Y9024335@hera.kernel.org>
Message-ID: <Pine.GSO.4.58.0401051504050.3740@waterleaf.sonytel.be>
References: <200401032002.i03K25Y9024335@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jan 2004, Linux Kernel Mailing List wrote:
> ChangeSet 1.1356.1.2, 2004/01/02 08:51:54-07:00, trini@kernel.crashing.org
>
> 	PPC32: Fix the floppy driver, on CONFIG_NOT_COHERENT_CACHE.
> 	From David Mueller <d.mueller@elsoft.ch>.
>
>
> # This patch includes the following deltas:
> #	           ChangeSet	1.1356.1.1 -> 1.1356.1.2
> #	include/asm-ppc/floppy.h	1.5     -> 1.6
> #
>
>  floppy.h |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletion(-)
>
>
> diff -Nru a/include/asm-ppc/floppy.h b/include/asm-ppc/floppy.h
> --- a/include/asm-ppc/floppy.h	Sat Jan  3 12:02:06 2004
> +++ b/include/asm-ppc/floppy.h	Sat Jan  3 12:02:06 2004
> @@ -12,7 +12,7 @@
>  #define __ASM_PPC_FLOPPY_H
>
>  #define fd_inb(port)			inb_p(port)
> -#define fd_outb(port,value)		outb_p(port,value)
> +#define fd_outb(value,port)		outb_p(value,port)
>
>  #define fd_enable_dma()         enable_dma(FLOPPY_DMA)
>  #define fd_disable_dma()        disable_dma(FLOPPY_DMA)
> @@ -24,7 +24,11 @@
>  #define fd_set_dma_count(count) set_dma_count(FLOPPY_DMA,count)
>  #define fd_enable_irq()         enable_irq(FLOPPY_IRQ)
>  #define fd_disable_irq()        disable_irq(FLOPPY_IRQ)
> +#if CONFIG_NOT_COHERENT_CACHE
   ^^^
Shouldn't this be #ifdef?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
