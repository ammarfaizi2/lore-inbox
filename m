Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265542AbTIDVHG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 17:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265529AbTIDVFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 17:05:16 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:40692 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265528AbTIDVDl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 17:03:41 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: MAtias Alejo Garcia <kernel@matiu.com.ar>
Subject: Re: [PATCH] ide_cs w/TCQ
Date: Thu, 4 Sep 2003 23:04:30 +0200
User-Agent: KMail/1.5
Cc: Kernel <linux-kernel@vger.kernel.org>
References: <1062710823.1794.30.camel@runner>
In-Reply-To: <1062710823.1794.30.camel@runner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309042304.30885.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 of September 2003 23:27, MAtias Alejo Garcia wrote:
> Hi Bart,

Hi,

> I reported I problem (Unable to handle kernel NULL pointer...) when
> inserting a CF card in a PCMCIA adapter in 2.6.0test1. The problem
> continues in test4 (log below, when inserting a card).
>
> The problem only is present when  BLK_DEV_TCQ_DEFAULT is enabled. It
> seems that ide_cs (or ide, don't know) does not correctly initialize
> hwif->ide_dma_queued_on() ...I don't know how this should be fixed if
> the driver doesn't use DMA:

Yes, thanks!

> 1) Not calling ide_dma_queued_on
> or
> 2) Initializind ide_dma_queued_on to a dummy function
>
> I tried 1) and it works...

3) initialize ide_dma_queued_on to __ide_dma_queued_on()

because drive->using_dma is checked inside __ide_dma_queud_on,
but that looks stupid to assign it in DMA-unaware driver :-).

> Here is the patch...be gentle is my first contribution :-)
>
> Thanks!
> matias

--bartlomiej

