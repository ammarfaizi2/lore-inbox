Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265249AbRH0T26>; Mon, 27 Aug 2001 15:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266263AbRH0T2h>; Mon, 27 Aug 2001 15:28:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58888 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265249AbRH0T2c>; Mon, 27 Aug 2001 15:28:32 -0400
Subject: Re: Oops with 2.4.9
To: bole@falcon.etf.bg.ac.yu (Bosko Radivojevic)
Date: Mon, 27 Aug 2001 20:31:54 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108272056250.11401-200000@falcon.etf.bg.ac.yu> from "Bosko Radivojevic" at Aug 27, 2001 08:59:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15bS70-0004WY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a problem with 2.4.9 (vanilla) and HP NetServer 5/100 LC
> (Pentium 133MHz) with Adaptec AIC 7770 EISA SCSI host adapter.
> 
> The system also has one PCI card - Digital DS21140 Tulip rev 18 NIC.
> 
> Here is the oops output from bootup (in attachment is .config):

Does this help

--- drivers/scsi/aic7xxx/aic7xxx_linux.c~	Sat Aug 11 23:50:55 2001
+++ drivers/scsi/aic7xxx/aic7xxx_linux.c	Mon Aug 27 20:34:30 2001
@@ -788,10 +788,11 @@
 	 * address).  For this reason, we have to reset
 	 * our dma mask when doing allocations.
 	 */
+	if(ahc->dev_softc)
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,3)
-	pci_set_dma_mask(ahc->dev_softc, 0xFFFFFFFF);
+		pci_set_dma_mask(ahc->dev_softc, 0xFFFFFFFF);
 #else
-	ahc->dev_softc->dma_mask = 0xFFFFFFFF;
+		ahc->dev_softc->dma_mask = 0xFFFFFFFF;
 #endif
 	*vaddr = pci_alloc_consistent(ahc->dev_softc,
 				      dmat->maxsize, &map->bus_addr);
