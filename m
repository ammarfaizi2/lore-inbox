Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271499AbTGQPYM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 11:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271503AbTGQPXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 11:23:54 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:32922 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S271499AbTGQPVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 11:21:52 -0400
Date: Thu, 17 Jul 2003 17:36:25 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Fix IDE initialization when we don't probe for interrupts.
In-Reply-To: <Pine.LNX.4.44.0307091520570.16947-100000@home.osdl.org>
Message-ID: <Pine.GSO.4.21.0307171733080.10372-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jul 2003, Linus Torvalds wrote:
> On Wed, 9 Jul 2003, Jeff Garzik wrote:
> > I'm curious where interrupts are re-enabled, though?
> 
> The low-level drivers seem to do it at every IO. Don't ask me why. But it 
> gets done automatically by any code that does
> 
> 	hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
> 
> which is pretty common (just grep for "IDE_CONTROL_REG" and you'll see 
> what I mean).
> 
> I note that I should have made this "disable irq" be dependent on 
> IDE_CONTROL_REG being non-zero. Although I don't see when that register 
> _can_ be zero, it would be a major bummer not to have access to the 
> control register.
> 
> (Obviously it must be zero for some architecture, though, or those
> conditionals woulnd't make sense. Alan?  Bartlomiej? What kind of sick
> pseudo-IDE controller doesn't have a control register?).

IDE can live without the control register (what do you _really_ need it for?).
Hence some hardware doesn't provide it, by leaving out the second bank of 8 IDE
registers.

Another trick is the `IDE doubler' for Amiga (but I guess you can make it work
on any IDE interface): with a few diodes you can map the second bank of 8 IDE
registers to a second IDE chain, doubling the number of devices you can
attach.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

