Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275273AbTHMQ1z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 12:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275276AbTHMQ1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 12:27:55 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:50566 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S275273AbTHMQ1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 12:27:53 -0400
Date: Wed, 13 Aug 2003 18:26:27 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Bogus serial port ttyS02
In-Reply-To: <Pine.LNX.4.53.0308131202410.10804@chaos>
Message-ID: <Pine.GSO.4.21.0308131824580.11378-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Aug 2003, Richard B. Johnson wrote:
> On Wed, 13 Aug 2003, Geert Uytterhoeven wrote:
> > Linux always finds 3 serial ports instead of 2:
> >
> > | ttyS00 at 0x03f8 (irq = 4) is a 16550A
> > | ttyS01 at 0x02f8 (irq = 3) is a 16550A
> > | ttyS02 at 0x03e8 (irq = 4) is a 16450
> >
> > The last one is bogus.
> 
> First, this looks like ix86 stuff, not m68k. Drivers for ix86

It's PPC, not m68k. Both PReP and CHRP have PC-style serial ports.

> machines probe the de facto addresses for up to a maximum of
> 4 8250-type UARTS. Those addresses are:
> 
> (0)	0x3f8
> (1)	0x2f8
> (2)	0x3e8
> (3)	0x328
> 
> (from the Phoenix SYSTEM BIOS book)
> 
> Usually, there are several bits that are permanently 0 in
> some of the registers. This is used to "positively" identify
> the chip. Note that many IR devices are also connected
> to 8250-type UARTS.
> 
> I would guess that you have two serial ports, plus another
> UART that's used for IR (maybe a IR keyboard???).

No, the Super I/O has only two serial ports, of which one can be used for IRDA.

> You can do `od /dev/ttyS2` from the root account and see
> what happends.

Nothing, it just waits for data. The same for `echo hello > /dev/ttyS2'. So the
serial driver things it has to wait to accept/send data.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

