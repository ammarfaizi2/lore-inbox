Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTECRJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 13:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263357AbTECRJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 13:09:28 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:21204 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263355AbTECRJ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 13:09:27 -0400
Date: Sat, 3 May 2003 19:21:42 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Reserving an ATA interface
In-Reply-To: <1051981705.7818.63.camel@gaston>
Message-ID: <Pine.SOL.4.30.0305031912510.10296-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 3 May 2003, Benjamin Herrenschmidt wrote:

> > Such an interface can't really know what slot will be
> > picked by ide_register_hw() and can't "prepare" the HWIF with
> > special iops, so it won't be much harmed by the fact we are
> > calling init_hwif_data, but still, we should ultimately think
> > about splitting completely the fact of allocating an hwif slot,
> > setting it up, and triggering a probe on it. Those are 3 different
> > things that are currently mixed in bad ways. I don't beleive
> > fixing that fits in the 2.6 timeframe though.
>
> I just though about another possible crap, though I haven't looked
> enough to be sure, but PCI interfaces with no device will trigger
> a similar problem as "empty" ide-pmac interfaces in that sense that
> they will change dma ops, possibly mmio ops, etc.... If they hold
> no device, their hwif->present will not be set, and thus the hwif
> slot can possibly get re-used by thing like ide-cs (or anybody else
> that rely on ide_register_hw() to allocate a new slot) without
> those changes to hwif done by the PCI interface beeing cleared.
>
> So my patch may actually fix some cases there too.

No, look at ide_match_hwif() in setup-pci.c .
PCI grabs only ide_unknown interfaces.

btw, I think the only real long-term solution for all ordering issues
     is customizable device mapper... 2.7?
--
Bartlomiej

> Ben.

