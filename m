Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264706AbTA1J2D>; Tue, 28 Jan 2003 04:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264907AbTA1J2D>; Tue, 28 Jan 2003 04:28:03 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:52131 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S264706AbTA1J2C>;
	Tue, 28 Jan 2003 04:28:02 -0500
Date: Tue, 28 Jan 2003 10:32:53 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Martin Mares <mj@ucw.cz>, Richard Henderson <rth@twiddle.net>,
       "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5] VGA IO on systems with multiple PCI IO domains
In-Reply-To: <20030128011710.A638@localhost.park.msu.ru>
Message-ID: <Pine.GSO.4.21.0301281030590.9269-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2003, Ivan Kokshaysky wrote:
> On Mon, Jan 27, 2003 at 06:55:04PM +0100, Benjamin Herrenschmidt wrote:
> > Well, your example clearly limits us to one IO space for VGA, which
> > might not be what we want. The problem also exist for some fbdev drivers
> > which might need to tap the VGA IOs of a given PCI card (thus getting
> > access to the "legacy" IOs of the bus the card is on).
> 
> You are right, I've already realized that. :-)
> The struct pci_bus * arg to legacy_ioport_remap (maybe better
> pci_legacy_ioport_remap) is really good idea, and it's perfectly
> ok to pass NULL in the vgacon case - we are limited to only one
> VGA console anyway.
> After the PCI setup is done, pci_legacy_ioport_remap(pbus, &legacy_resource)
> would solve any problem I can think of, including multiple ISA bridges.

BTW, we still need a separate isa_request_mem_region(), since right now we
cannot simply call request_mem_region(0xa0000, 0x10000) to request the VGA
memory buffer in ISA memory space. On ia32 the plain request_mem_region() is
OK, but on other archs you need to add the ISA memory space base.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

