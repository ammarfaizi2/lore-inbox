Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261376AbSKGS5r>; Thu, 7 Nov 2002 13:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbSKGS5r>; Thu, 7 Nov 2002 13:57:47 -0500
Received: from mail2.uklinux.net ([80.84.72.32]:5870 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id <S261376AbSKGS5p>;
	Thu, 7 Nov 2002 13:57:45 -0500
Date: Thu, 7 Nov 2002 19:04:24 +0000 (GMT)
From: Peter Denison <lkml@marshadder.uklinux.net>
X-X-Sender: peterd@marshall.localnet
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE: correct partially initialised hw structures
In-Reply-To: <Pine.LNX.4.10.10211031308240.27918-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.44.0211071845350.6917-100000@marshall.localnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002, Andre Hedrick wrote:

> No major issues here; however does it not stomp on the preloaded defaults?

Well, the patch cleans up the fact that preloaded defaults are stomped on
by uninitialised data. Now they are stomped on by 0 !! Gradual
improvement.

Actually, if the patch that moves ide_init_default_hwifs() is applied then
maybe this isn't strictly necessary. The whole area needs cleaning up, but
I was loathe to start doing major changes. I've done large parts of the
call tree for the ide driver, and I _still_ don't fully understand what
should be called when. Just as a sample, there's:
	ide_init_data
	ide_init_default_hwifs
	ide_init_hwif_ports
	init_hwif_data
	ideprobe_init
	probe_hwif_init
	hwif_init
	etc.
with little or no explanation as to what they do, but more crucially, when
they should be called. You can work out what they each do, but an idea of
the initialisation architecture would really help sort out if there are
branches that can now be got rid of.

> On Sun, 27 Oct 2002, Peter Denison wrote:
>
> > Summary: Initialise all parts of hw_regs_t structures before passing them
> > to ide_register_hw
> >
> > The hw structure (specifically the hw->chipset field) held uninitialised
> > data.  This (before the initialisation order fixup recently posted) meant
> > that no chipset could ever get selected by an idex=<chipset> commandline
> > (silently!).
> >
> > Only occurs on non-PCI platforms. All ARM platforms have already been
> > fixed - though slightly differently.


-- 
Peter Denison <peterd at marshadder dot uklinux dot net>
Please use the address above only for personal mail, not copied to any lists
that are gatewayed to news or web pages unless the addresses are removed.

