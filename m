Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266295AbSLIXUY>; Mon, 9 Dec 2002 18:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266330AbSLIXUX>; Mon, 9 Dec 2002 18:20:23 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:7387 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S266295AbSLIXUX>;
	Mon, 9 Dec 2002 18:20:23 -0500
Date: Tue, 10 Dec 2002 00:27:29 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Richard Henderson <rth@twiddle.net>,
       Patrick Mochel <mochel@osdl.org>, Willy Tarreau <willy@w.ods.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com
Subject: Re: /proc/pci deprecation?
Message-ID: <20021210002729.A22719@ucw.cz>
References: <1039443067.10475.19.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0212090854510.3397-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0212090854510.3397-100000@home.transmeta.com>; from torvalds@transmeta.com on Mon, Dec 09, 2002 at 09:00:44AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2002 at 09:00:44AM -0800, Linus Torvalds wrote:

> On 9 Dec 2002, Alan Cox wrote:
> >
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

I can confirm that on most builtin VIA southbridge devices (namely USB)
the register isn't just a scratch register and that indeed it is used by
the interrupt router.

> Anyway, to get back on the original discussion, I think we should remove
> the writing, and then make sure that /sbin/lspci (or some other tool) can

I guess only the irq re-routing code specific to VIA would then write
those values, because it has to if the BIOS didn't set them up correctly.

> be made to easily show either the kernel irq mapping value _or_ the
> "original PCI config space" value. At that point I'd agree that /proc/pci
> has outlived its usefulness.
> 
> (Although I still think the name database is nice to have - I certainly
> prefer it over having a lot of drivers having their _own_ name databases
> for printout purposes).

It definitely made many drivers simpler.

-- 
Vojtech Pavlik
SuSE Labs
