Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265609AbUBKPRe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 10:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265636AbUBKPRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 10:17:33 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:56485 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265507AbUBKPR1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 10:17:27 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andre Hedrick <andre@linux-ide.org>
Subject: Re: [PATCH] make __ide_dma_off() generic and remove ide_hwif_t->ide_dma_off
Date: Wed, 11 Feb 2004 16:22:52 +0100
User-Agent: KMail/1.5.3
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10402110417270.11954-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10402110417270.11954-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200402111622.52889.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 of February 2004 13:19, Andre Hedrick wrote:
> Bartlomiej,
>
> __ide_dma_count
>
> This is for VDMA, PIO over DMA.

This *supposes* to be for VDMA, but since its introduction in kernel 2.5.35
(released on 15-Sep-2002!) it does *nothing*.

> When the transport moves to only MMIO, PIO operations are tunneled.
> Just a little hit.
>
> Andre Hedrick
> LAD Storage Consulting Group
>
> On Mon, 9 Feb 2004, Bartlomiej Zolnierkiewicz wrote:
> > Incremental to "[PATCH] remove __ide_dma_count() and
> > ide_hwif_t->ide_dma_count".
> >
> > Move ide-dma.c:__ide_dma_off() outside of #ifdef
> > CONFIG_BLK_DEV_IDEDMA_PCI, so it can be used for all DMA capable hosts. 
> > Remove ide_hwif_t->ide_dma_off.

>From the previous mail:

[PATCH] remove __ide_dma_count() and ide_hwif_t->ide_dma_count

Incremental to "[PATCH] remove ide_dma_{good,bad}_drive from ide_hwif_t".

->ide_dma_count() was introduced in kernel 2.5.35 and was meant to add support
for host FIFO counters (for VDMA), but is only a wrapper for ->ide_dma_begin()
(even for siimage.c b/c SIIMAGE_VIRTUAL_DMAPIO is undefined).

Moreover it should be possible to add VDMA code directly to ->ide_dma_begin().

