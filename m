Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265854AbSLIQ5l>; Mon, 9 Dec 2002 11:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265865AbSLIQ5l>; Mon, 9 Dec 2002 11:57:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27913 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265854AbSLIQ5k>; Mon, 9 Dec 2002 11:57:40 -0500
Date: Mon, 9 Dec 2002 09:00:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Richard Henderson <rth@twiddle.net>, Patrick Mochel <mochel@osdl.org>,
       Willy Tarreau <willy@w.ods.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <jgarzik@pobox.com>
Subject: Re: /proc/pci deprecation?
In-Reply-To: <1039443067.10475.19.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0212090854510.3397-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 9 Dec 2002, Alan Cox wrote:
>
> I wonder if this is why we have all these problems with VIA chipset
> interrupt handling. According to VIA docs they _do_ use
> PCI_INTERRUPT_LINE on integrated devices to select the IRQ routing
> between APIC and PCI/ISA etc, as well as 0 meaning "IRQ disabled"

Whee.. That sounds like a load of crock in the first place, since the
PCI_INTERRUPT_LINE thing should be just a scratch register as far as I
know. However, it doesn't really matter - we definitely should never write
to it anyway, so the VIA behaviour while strange should still be
acceptable.

Anyway, to get back on the original discussion, I think we should remove
the writing, and then make sure that /sbin/lspci (or some other tool) can
be made to easily show either the kernel irq mapping value _or_ the
"original PCI config space" value. At that point I'd agree that /proc/pci
has outlived its usefulness.

(Although I still think the name database is nice to have - I certainly
prefer it over having a lot of drivers having their _own_ name databases
for printout purposes).

		Linus

