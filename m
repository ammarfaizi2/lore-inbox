Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbTE0JAx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 05:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbTE0JAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 05:00:53 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:63618
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S262872AbTE0JAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 05:00:08 -0400
Date: Tue, 27 May 2003 05:03:00 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Ted.Wen@ite.com.tw
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ITE_887x parport and serial driver
In-Reply-To: <DC62C613C2F7274C9D361EA476413476392C25@itemail1.internal.ite.com.tw>
Message-ID: <Pine.LNX.4.50.0305270430471.2265-100000@montezuma.mastecende.com>
References: <DC62C613C2F7274C9D361EA476413476392C25@itemail1.internal.ite.com.tw>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 May 2003 Ted.Wen@ite.com.tw wrote:

> --- parport_serial.c	2002-08-03 08:39:44.000000000 +0800
> +++ parport_serial_887x.c	2003-05-27 14:25:49.000000000 +0800
> @@ -29,8 +29,160 @@
>  
>  #include <asm/serial.h>
>  
> +// ITE8872 ITE8872

I don't mean to nitpick, but please use normal C (I know they are valid 
C99) comments.

> +int ite8872parportnum,ite8872comnum,ITEBOARDNUMBER;
> +u32 ITE8872_INTC[8];
> +u8 ITE8872_IRQ[8];
> +
> +void ite8872_requestirq(int irq,void *dev_id,struct pt_regs *regs){

For 2.5 there is now a return value for interrupt handlers (irqreturn_t)

> +	result = request_irq(ITE8872_IRQ[ITEBOARDNUMBER],ite8872_requestirq,SA_SHIRQ,"ite8872",pcidev);

Which PCI device function is this for?

> +if ((dev->vendor==0x1283 && dev->device==0x8872) && ite8872comnum == 0)
> +return 0;
>        priv->ser = *board;
>        if (board->init_fn && ((board->init_fn) (dev, board, 1) != 0))
>                return 1;
> @@ -308,6 +466,8 @@
>            cards[i].preinit_hook (dev, PARPORT_IRQ_NONE, PARPORT_DMA_NONE))
>                return -ENODEV;
>
> +if ((dev->vendor==0x1283 && dev->device==0x8872) && ite8872parportnum == 0)
> +return 0;
>        for (n = 0; n < cards[i].numports; n++) {
>                struct parport *port;
>                int lo = cards[i].addr[n].lo;

These exceptions look really ugly, how come you need a custom interrupt 
handler?

	Zwane
-- 
function.linuxpower.ca
