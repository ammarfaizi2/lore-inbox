Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293554AbSBZJie>; Tue, 26 Feb 2002 04:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293555AbSBZJiZ>; Tue, 26 Feb 2002 04:38:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54540 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293554AbSBZJiT>; Tue, 26 Feb 2002 04:38:19 -0500
Subject: Re: [PATCH][RFC] ServerWorks autodma behavior
To: brownfld@irridia.com (Ken Brownfield)
Date: Tue, 26 Feb 2002 09:52:57 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020226032629.A930@asooo.flowerfire.com> from "Ken Brownfield" at Feb 26, 2002 03:26:29 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16feI5-0008WC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a lot of ServerWorks OSB4 IDE hardware, which has the annoyingly
> suboptimal behavior of corrupting filesystems when DMA is active.

With newer kernels you should get a panic because we spot the "I'm going
to get 4 bytes stuck in the FIFO and DMA your inodes shifted 4 bytes down the
disk behaviour" - at least in the cases I could study

What set up do you have ?

> Unfortunately, serverworks.c (in recent 2.4, at least) does not honor
> the CONFIG_IDEDMA_AUTO config option -- it turns dma on only unless
> "ide=nodma" is set on the kernel command line.

You actually really to just turn off UDMA from experience.

>  	if (hwif->dma_base) {
> +#ifdef CONFIG_IDEDMA_AUTO
>  		if (!noautodma)
>  			hwif->autodma = 1;
> +#endif

I would have expected this to be a fix in the core code to ignore
hwif->autodma but I'll admit I've not looked to see if that is practical.
