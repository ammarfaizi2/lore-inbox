Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293560AbSBZKTx>; Tue, 26 Feb 2002 05:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293561AbSBZKTn>; Tue, 26 Feb 2002 05:19:43 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:22975 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S293560AbSBZKTc>; Tue, 26 Feb 2002 05:19:32 -0500
Date: Tue, 26 Feb 2002 04:19:24 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] ServerWorks autodma behavior
Message-ID: <20020226041924.B930@asooo.flowerfire.com>
In-Reply-To: <20020226032629.A930@asooo.flowerfire.com> <E16feI5-0008WC-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16feI5-0008WC-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Feb 26, 2002 at 09:52:57AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 09:52:57AM +0000, Alan Cox wrote:
| > I have a lot of ServerWorks OSB4 IDE hardware, which has the annoyingly
| > suboptimal behavior of corrupting filesystems when DMA is active.
| 
| With newer kernels you should get a panic because we spot the "I'm going
| to get 4 bytes stuck in the FIFO and DMA your inodes shifted 4 bytes down the
| disk behaviour" - at least in the cases I could study
| 
| What set up do you have ?

These machines are Tyan Thunder LE (S2510) non-SCSI boards with Seagate
drives.  Dual-P3.

| > Unfortunately, serverworks.c (in recent 2.4, at least) does not honor
| > the CONFIG_IDEDMA_AUTO config option -- it turns dma on only unless
| > "ide=nodma" is set on the kernel command line.
| 
| You actually really to just turn off UDMA from experience.

Yeah -- but I'd like to be able to enable it if I need the performance
on a more DMA-able motherboard.  Turning it off entirely would have
worked, of course.

| >  	if (hwif->dma_base) {
| > +#ifdef CONFIG_IDEDMA_AUTO
| >  		if (!noautodma)
| >  			hwif->autodma = 1;
| > +#endif
| 
| I would have expected this to be a fix in the core code to ignore
| hwif->autodma but I'll admit I've not looked to see if that is practical.

That may be -- I was sticking with the obvious, least-invasive, least
IDE-core-clued evaluation. :)  This is also the same treatment of
noautodma found in the VIA driver.  The autodma setting from ide-pci
does seem to be correct -- deleting the code segment produces the same
DMA end-results, in the end, for ServerWorks.

Thanks much,
-- 
Ken.
brownfld@irridia.com

