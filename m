Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313125AbSGDRiJ>; Thu, 4 Jul 2002 13:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSGDRiI>; Thu, 4 Jul 2002 13:38:08 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:20892 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S313125AbSGDRiI>; Thu, 4 Jul 2002 13:38:08 -0400
Date: Thu, 4 Jul 2002 19:40:19 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Russell King <rmk@arm.linux.org.uk>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.24 IDE 97
In-Reply-To: <20020704142938.D11601@flint.arm.linux.org.uk>
Message-ID: <Pine.SOL.4.30.0207041903180.28459-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Jul 2002, Russell King wrote:

> On Wed, Jul 03, 2002 at 12:22:11AM +0200, Bartlomiej Zolnierkiewicz wrote:
> > This patch is a accumulation of ata-hosts-7/8/9/10/11, ata-autodma
> > and ata-ata66_check patches previously posted on LKML.
>
> From a first review only, it looks like this patch prevents the chipset
> drivers from disabling DMA mode on initialisation.  This is Really Bad(tm)
> since some revisions of some chipsets must _never_ be placed into DMA
> mode due to hardware bugs.  Even if the user selects CONFIG_IDEDMA_AUTO.

My intention was to allow drivers decide about DMA and autodma.

> The code in sl82c105.c knows about the chipset revisions that this is
> required for, and it looks like the code in ide-pci.c will override the
> chipset if CONFIG_IDEDMA_AUTO is enabled.

I see, thanks. I will move this code before ->init_dma() call.
But I think that if you really want disable DMA and not only autodma
you should also set dma_base to 0 in your ->init_dma(), other way you
just mess DMA and autodma setups.

Greets.
--
Bartlomiej

> --
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html
>

