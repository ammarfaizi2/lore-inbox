Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266465AbUBQTEf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 14:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266468AbUBQTEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 14:04:35 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:11712 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266465AbUBQTE0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 14:04:26 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alex Bennee <kernel-hacker@bennee.com>
Subject: Re: Any guides for adding new IDE chipset drivers?
Date: Tue, 17 Feb 2004 20:10:34 +0100
User-Agent: KMail/1.5.3
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
References: <1077028026.31892.153.camel@cambridge.braddahead.com>
In-Reply-To: <1077028026.31892.153.camel@cambridge.braddahead.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402172010.34114.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 of February 2004 15:27, Alex Bennee wrote:
> On Monday 16 of Febuary 2004 09:40:21 PST, Bart wrote:
> >On Monday 16 of February 2004 18:04, Alex Bennee wrote:
> >> Is there a driver that can be held of as an example of good taste and
> >> the "right" way to implement a chipset driver?
> >
> >Yep.  Please take a look at drivers/ide/arm/icside.c.
> >It is well written, quite simple and has DMA support.
>
> Thanks. I'll base my driver on this one as it does seem quite easy
> to follow. However I'm wondering what the point of the begin/end functions
> are. The dma_read/write functions just seem to call dma_count which starts
> the dma requests going.

hwif->ide_dma_count() is gone in 2.6.3-rc4.

ATAPI drivers (ie. ide-cd.c) and TCQ code (ide-tcq.c)
use ->ide_dma_begin() and ->ide_dma_end() directly.

DMA timeout recovery functions also call ->ide_dma_end().

> Am I missing something here? Is all that required from the higher level a
> single call to dma_read/write or should I be expecting a series of calls to
> setup a transfer?

To setup a DMA transfer:

ATA: ->ide_dma_{read,write}() (they call ->ide_dma_begin()) or
     __ide_dma_queued_{read,write}() (they may call ->ide_dma_begin())

ATAPI: ->ide_dma_{read,write}() + ->ide_dma_begin()

Hope this helps.

