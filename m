Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132513AbRDEB3o>; Wed, 4 Apr 2001 21:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132526AbRDEB3f>; Wed, 4 Apr 2001 21:29:35 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27409 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132513AbRDEB3Z>; Wed, 4 Apr 2001 21:29:25 -0400
Subject: Re: linux 2.4.3 crashed my hard disk
To: ionut@moisil.cs.columbia.edu (Ion Badulescu)
Date: Thu, 5 Apr 2001 02:30:20 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200104050110.f351AMu20890@moisil.dev.hydraweb.com> from "Ion Badulescu" at Apr 04, 2001 06:10:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kybO-0003Bk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> is about the most ominous message one can receive from the IDE driver:
> 
> 1. it's not in English, so it doesn't tell you jack

It tells you the chipset doesnt support an IDE dma timeout handling function
(ie all it can do is reset and retry)

> 2. it's usually a sign of "mkfs + reinstall needed"

Not in my experience. Its just a drive throwing a fit.

> 3. I've had it happen on Intel and VIA chipsets alike, 100% guaranteed
>    non-overclocked

I've only seen it on broken boards that also needed DMA off in 2.2 and
on the VIA stuff before the VIA fixups went in and the new via driver.

> 5. I have yet to see a coherent explanation from Andre as to what the
>    message means, or what causes it.


We issued a DMA, the drive sat their and did nothing. The default handler 
asks the controller handling the request to retry it in PIO mode. Which is
readonable. On the 440BX this uses disable_irq which may also trigger a bug
in the APIC on SMP machines and hang solid unless you have -ac. I dont think
thats statistically likely here.

The code looks correct, its a bit convoluted but it does seem to correctly
reissue the request, although not as PIO. Perhaps Andre can explain why its
ignoring the 'please use pio' hint on the return

Alan

