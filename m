Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267309AbTA0WJr>; Mon, 27 Jan 2003 17:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267313AbTA0WJr>; Mon, 27 Jan 2003 17:09:47 -0500
Received: from [195.208.223.248] ([195.208.223.248]:12928 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267309AbTA0WIo>; Mon, 27 Jan 2003 17:08:44 -0500
Date: Tue, 28 Jan 2003 01:17:10 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Martin Mares <mj@ucw.cz>,
       geert@linux-m68k.org, Richard Henderson <rth@twiddle.net>,
       "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] VGA IO on systems with multiple PCI IO domains
Message-ID: <20030128011710.A638@localhost.park.msu.ru>
References: <20030126181326.A799@localhost.park.msu.ru> <20030126214550.GB6873@ucw.cz> <1043624458.2755.37.camel@zion.wanadoo.fr> <20030127094645.GD604@ucw.cz> <20030127134010.C2569@jurassic.park.msu.ru> <1043690104.2756.42.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1043690104.2756.42.camel@zion.wanadoo.fr>; from benh@kernel.crashing.org on Mon, Jan 27, 2003 at 06:55:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 06:55:04PM +0100, Benjamin Herrenschmidt wrote:
> Well, your example clearly limits us to one IO space for VGA, which
> might not be what we want. The problem also exist for some fbdev drivers
> which might need to tap the VGA IOs of a given PCI card (thus getting
> access to the "legacy" IOs of the bus the card is on).

You are right, I've already realized that. :-)
The struct pci_bus * arg to legacy_ioport_remap (maybe better
pci_legacy_ioport_remap) is really good idea, and it's perfectly
ok to pass NULL in the vgacon case - we are limited to only one
VGA console anyway.
After the PCI setup is done, pci_legacy_ioport_remap(pbus, &legacy_resource)
would solve any problem I can think of, including multiple ISA bridges.

Ivan.
