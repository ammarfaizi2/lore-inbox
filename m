Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267065AbTAZXbT>; Sun, 26 Jan 2003 18:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267068AbTAZXbT>; Sun, 26 Jan 2003 18:31:19 -0500
Received: from AMarseille-201-1-1-146.abo.wanadoo.fr ([193.252.38.146]:29042
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267065AbTAZXbS>; Sun, 26 Jan 2003 18:31:18 -0500
Subject: Re: [patch 2.5] VGA IO on systems with multiple PCI IO domains
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Martin Mares <mj@ucw.cz>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, geert@linux-m68k.org,
       Richard Henderson <rth@twiddle.net>,
       "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030126214550.GB6873@ucw.cz>
References: <20030126181326.A799@localhost.park.msu.ru>
	 <20030126214550.GB6873@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043624458.2755.37.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 27 Jan 2003 00:40:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-26 at 22:45, Martin Mares wrote:
> Hi!
> 
> > But on modern systems (titan and marvel), the firmware supports vga
> > on *any* bus. Even worse, marvel doesn't have dedicated "legacy"
> > hose at all.
> 
> > So we have to decode and fix IO port addresses inside our in/out
> > functions, which is awful.
> 
> Is the problem really only with VGA? Shouldn't we introduce
> isa_(in|out)(b|w) instead and remap the whole legacy I/O space?

Each time we discussed this, we came to the conclusion that indeed,
separate macros for ISA would be useful, but not enough.

We probably need to introduce an equivalent of ioremap for IO space. So
far, what we have to deal is:

 - Legacy ISA stuff unrelated to a PCI bus
 - Legacy devies on a given PCI segment (VGA, serial, IDE, ...)

What about some kind of ioport_remap() that would take a pci_bus and an
port range as arguments ? If pci_bus is NULL, that would match a
"legacy" ISA bus (non-PCI machine or default ISA bus for machines where
that makes sense).

What do you think ?

Ben.


