Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275268AbTHGNcr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 09:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275314AbTHGNcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 09:32:47 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:63654 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S275268AbTHGNco
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 09:32:44 -0400
Date: Thu, 7 Aug 2003 15:32:17 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Ed Cogburn <ecogburn@xtn.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2-(bk6 && mm5)  Build Failure - "ide_setup_dma()" is
 MIA
In-Reply-To: <3F323E4E.8040308@xtn.net>
Message-ID: <Pine.SOL.4.30.0308071523470.20585-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Aug 2003, Ed Cogburn wrote:

> My .config for -bk6 is attached.  The same error occurs with the -mm5 tree
> too.
>
> Update:  Ok, I figured out the problem.  I didn't have "Generic PCI
> bus-master DMA support" enabled.  From reading its description I didn't
> think I needed it because I have no IDE drives on my system (I need IDE for
> 2 ATAPI devices, my hard drive is SCSI).  On reflection, I may not need "PCI
> IDE chipset support" at all either.

You don't want to use DMA on your ATAPI devices?

If you want DMA on ATAPI and have PCI IDE chipset you need
"PCI IDE chipset support" + "Generic PCI bus-master DMA support"
+ driver for you chipset.

> In any event there seems to be a missing dependency here.
>  CONFIG_BLK_DEV_IDEPCI ("PCI IDE chipset support") controls whether
> drivers/ide/setup_pci.c is compiled.  That file calls ide_setup_dma(), but
> this function is in drivers/ide/ide_dma.c which is controlled
> by CONFIG_BLK_DEV_IDEDMA_PCI which is a *suboption* of IDEPCI.  In other
> words, from my understanding of this, the latter config option, IDEDMA_PCI,
> should be automatically *required* if the first config option, IDEPCI,
> is selected.

Yep. Proper fix is to make setup_pci.c independent of ide_dma.c (requires
some more thought and work).

> Of course, I could be reading this wrong, I'm just providing this FWIW.  :)

Thanks for reporting anyway.

--
Bartlomiej


