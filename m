Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbVHOQ4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbVHOQ4o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 12:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbVHOQ4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 12:56:44 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:13263 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S964842AbVHOQ4o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 12:56:44 -0400
Message-ID: <1124125002.4300c94a31810@imp5-q.free.fr>
Date: Mon, 15 Aug 2005 18:56:42 +0200
From: mustang4@free.fr
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Hang or stop after uncompressing MPC8245
References: <1124122213.4300be659dc89@imp5-q.free.fr> <20050815155505.GF20363@alpha.home.local>
In-Reply-To: <20050815155505.GF20363@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 57.250.252.246
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Hello,
>
> On Mon, Aug 15, 2005 at 06:10:13PM +0200, mustang4@free.fr wrote:
> >
> > Hello,
> >
> > I try to boot my linux kernel (with 2.4 or 2.6 it's the same problem) on an
> > embeded board (EM04N MenMicro) base on a MPC8245 cpu...
> >
> > When i boot i 've;
> >
> > > Detected PPCBOOT header
> > >     Verifying image CRC...ok
> > >     Uncompressing Multi-File Image ... ok
> > >     Moving initrd...ok
> > >     Passing Kernel parameters: root=ramfs console=ttyS0,9600
> > >     Starting Linux Kernel.
> > >
> > and stop here... i must hard reset the board...
> >
> > Anyone boot a linux kernel on this board ?
> > I heard about UART serial port problem with MPC8245 cpu, but i don't find a
> > working solution for patching kernel or setting up correctly...
>
> Although I don't know this board, here are a few questions :
>   - are you sure that you enabled the correct serial driver and that it is
>     linked to the zImage and not build as a module ?

I enable and build my kernel with driver (staticly):

Multi-IO cards (parallel and serial) (in Device Drivers-> Parallel port support 
)

This is what my board say (in console mode) about serial address:
0x08 COM1             DUART8245    0xfc004500 0x07a12000 0x00000001 0x01effc70
0x09 COM2             DUART8245    0xfc004600 0x07a12000 0x00000001 0x01e107d0


>   - are you sure that you enabled "console on serial port" in the config ?
Yes, i enable " Support for console on virtual terminal" but i enable
"Non-standard serial port support" option too...
So i recompile without the last one... and i recompile "with Serial drivers
--->" "[*]   Console on 8250/16550 and compatible serial port" perhaps it's
that... And i came back to you.
But, perhaps i've allready tested... i ll check.. it's not a default option ?

>   - how can you be certain that the serial will appear on ttyS0 and not ttyS1
>     or another one (the kernel might detect another serial port which it
>     assigns ttyS0)
I pass parameter directly to the kernel;

Another option i set :
 Default bootloader kernel arguments  x x  x x(console=ttyS0,9600 console=tty0


Thanks

Yann.

>   - is it possible that you have trouble with the endianness of the image ?
>     example: little endian image loaded on big endian CPU ?

My image seems to be ok...

>
> Regards,
> Willy
>
> > Anyone can help me ?
> >
> > I use :
> > ELDK kit cross compilation for PPC8245
> > uBoot
> > and official last kernel source...
> >
> > Thanks
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>


