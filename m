Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbUAEPlu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 10:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUAEPlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 10:41:49 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:44018 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S263452AbUAEPls
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 10:41:48 -0500
Date: Mon, 5 Jan 2004 08:41:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Mueller <d.mueller@elsoft.ch>,
       Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: PPC32: Fix the floppy driver, on CONFIG_NOT_COHERENT_CACHE.
Message-ID: <20040105154146.GB2415@stop.crashing.org>
References: <200401032002.i03K25Y9024335@hera.kernel.org> <Pine.GSO.4.58.0401051504050.3740@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0401051504050.3740@waterleaf.sonytel.be>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 03:04:47PM +0100, Geert Uytterhoeven wrote:
> On Fri, 2 Jan 2004, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1356.1.2, 2004/01/02 08:51:54-07:00, trini@kernel.crashing.org
> >
> > 	PPC32: Fix the floppy driver, on CONFIG_NOT_COHERENT_CACHE.
> > 	From David Mueller <d.mueller@elsoft.ch>.
> >
> >
> > # This patch includes the following deltas:
> > #	           ChangeSet	1.1356.1.1 -> 1.1356.1.2
> > #	include/asm-ppc/floppy.h	1.5     -> 1.6
> > #
> >
> >  floppy.h |    6 +++++-
> >  1 files changed, 5 insertions(+), 1 deletion(-)
> >
> >
> > diff -Nru a/include/asm-ppc/floppy.h b/include/asm-ppc/floppy.h
> > --- a/include/asm-ppc/floppy.h	Sat Jan  3 12:02:06 2004
> > +++ b/include/asm-ppc/floppy.h	Sat Jan  3 12:02:06 2004
> > @@ -12,7 +12,7 @@
> >  #define __ASM_PPC_FLOPPY_H
> >
> >  #define fd_inb(port)			inb_p(port)
> > -#define fd_outb(port,value)		outb_p(port,value)
> > +#define fd_outb(value,port)		outb_p(value,port)
> >
> >  #define fd_enable_dma()         enable_dma(FLOPPY_DMA)
> >  #define fd_disable_dma()        disable_dma(FLOPPY_DMA)
> > @@ -24,7 +24,11 @@
> >  #define fd_set_dma_count(count) set_dma_count(FLOPPY_DMA,count)
> >  #define fd_enable_irq()         enable_irq(FLOPPY_IRQ)
> >  #define fd_disable_irq()        disable_irq(FLOPPY_IRQ)
> > +#if CONFIG_NOT_COHERENT_CACHE
>    ^^^
> Shouldn't this be #ifdef?

Yes, but I don't believe that any gcc that you're supposed to use on 2.4
complains about that...

... not a good way to start a week. :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
