Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTECQ4s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 12:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTECQ4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 12:56:48 -0400
Received: from AMarseille-201-1-2-221.abo.wanadoo.fr ([193.253.217.221]:10792
	"EHLO gaston") by vger.kernel.org with ESMTP id S263354AbTECQ4s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 12:56:48 -0400
Subject: Re: Reserving an ATA interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1051981168.4107.58.camel@gaston>
References: <Pine.SOL.4.30.0305031805170.10296-100000@mion.elka.pw.edu.pl>
	 <1051981168.4107.58.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051981705.7818.63.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 03 May 2003 19:08:26 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Such an interface can't really know what slot will be
> picked by ide_register_hw() and can't "prepare" the HWIF with
> special iops, so it won't be much harmed by the fact we are
> calling init_hwif_data, but still, we should ultimately think
> about splitting completely the fact of allocating an hwif slot,
> setting it up, and triggering a probe on it. Those are 3 different
> things that are currently mixed in bad ways. I don't beleive
> fixing that fits in the 2.6 timeframe though.

I just though about another possible crap, though I haven't looked
enough to be sure, but PCI interfaces with no device will trigger
a similar problem as "empty" ide-pmac interfaces in that sense that
they will change dma ops, possibly mmio ops, etc.... If they hold
no device, their hwif->present will not be set, and thus the hwif
slot can possibly get re-used by thing like ide-cs (or anybody else
that rely on ide_register_hw() to allocate a new slot) without
those changes to hwif done by the PCI interface beeing cleared.

So my patch may actually fix some cases there too.

Ben.

