Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266998AbTA0KDx>; Mon, 27 Jan 2003 05:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267038AbTA0KDx>; Mon, 27 Jan 2003 05:03:53 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:31500 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S266998AbTA0KDw>; Mon, 27 Jan 2003 05:03:52 -0500
Date: Mon, 27 Jan 2003 13:12:42 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Martin Mares <mj@ucw.cz>, geert@linux-m68k.org,
       Richard Henderson <rth@twiddle.net>,
       "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] VGA IO on systems with multiple PCI IO domains
Message-ID: <20030127131242.B2569@jurassic.park.msu.ru>
References: <20030126181326.A799@localhost.park.msu.ru> <20030126214550.GB6873@ucw.cz> <1043624458.2755.37.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1043624458.2755.37.camel@zion.wanadoo.fr>; from benh@kernel.crashing.org on Mon, Jan 27, 2003 at 12:40:59AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 12:40:59AM +0100, Benjamin Herrenschmidt wrote:
> We probably need to introduce an equivalent of ioremap for IO space. So
> far, what we have to deal is:
> 
>  - Legacy ISA stuff unrelated to a PCI bus

Well, actually the ISA stuff *is* related to PCI bus on everything
newer than 486 PCs as it's connected to PCI via PCI-to-ISA bridge.
Even worse, I've found that at least two vendors offer PCI-to-ISA
expansion systems (yes, these systems are limited to IO only
on PCs because it clashes with another ISA bus in the same PCI domain),
but this means that one can have multiple ISA busses on alpha, parisc,
sparc64, ppc etc. One ISA bus per PCI IO domain. Shudder...

>  - Legacy devies on a given PCI segment (VGA, serial, IDE, ...)
> 
> What about some kind of ioport_remap() that would take a pci_bus and an
> port range as arguments ? If pci_bus is NULL, that would match a
> "legacy" ISA bus (non-PCI machine or default ISA bus for machines where
> that makes sense).

The problem is that vgacon driver is special - is starts very early,
before PCI subsystem is probed and initialized. So we don't have pci_bus
at this point.

Ivan.
