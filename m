Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265939AbSLIRpf>; Mon, 9 Dec 2002 12:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265960AbSLIRpe>; Mon, 9 Dec 2002 12:45:34 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:31933 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265939AbSLIRpe>; Mon, 9 Dec 2002 12:45:34 -0500
Subject: Re: /proc/pci deprecation?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard Henderson <rth@twiddle.net>, Patrick Mochel <mochel@osdl.org>,
       Willy Tarreau <willy@w.ods.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com
In-Reply-To: <Pine.LNX.4.44.0212090854510.3397-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0212090854510.3397-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Dec 2002 18:29:37 +0000
Message-Id: <1039458577.10470.49.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-09 at 17:00, Linus Torvalds wrote:
> On 9 Dec 2002, Alan Cox wrote:
> > I wonder if this is why we have all these problems with VIA chipset
> > interrupt handling. According to VIA docs they _do_ use
> > PCI_INTERRUPT_LINE on integrated devices to select the IRQ routing
> > between APIC and PCI/ISA etc, as well as 0 meaning "IRQ disabled"
> 
> Whee.. That sounds like a load of crock in the first place, since the
> PCI_INTERRUPT_LINE thing should be just a scratch register as far as I
> know. However, it doesn't really matter - we definitely should never write
> to it anyway, so the VIA behaviour while strange should still be
> acceptable.

Tested and verified. If I leave it alone non apic mode works. To use
APIC mode I have to write the new IRQ value into that register. I've
shoved that into the driver for now, since its a demented chip specific
horror.

