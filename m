Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267270AbSK3QdE>; Sat, 30 Nov 2002 11:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267271AbSK3QdD>; Sat, 30 Nov 2002 11:33:03 -0500
Received: from louise.pinerecords.com ([212.71.160.16]:21514 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267270AbSK3QdD>; Sat, 30 Nov 2002 11:33:03 -0500
Date: Sat, 30 Nov 2002 17:40:22 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-ac1
Message-ID: <20021130164022.GH18259@louise.pinerecords.com>
References: <20021130114049.GA1735@steffen-moser.de> <200211301345.gAUDjJO16145@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211301345.gAUDjJO16145@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It reports "DMA disabled" messages on boot for all of my IDE drives:
> 
> Its a funny off the VIA driver - it turns DMA off noisily then turnd it
> back on quietly for the devices it decies can do DMA/UDMA

Hmmm, I can only find references to dma_off_quietly within the via driver.
Weird.

Also Alan, you've left your infamous 'x1' in drivers/ide.  :)

So would the following make things more explicit?

diff -urN linux-2.4.20-ac1/drivers/ide/ide-dma.c linux-2.4.20-ac1.x/drivers/ide/ide-dma.c
--- linux-2.4.20-ac1/drivers/ide/ide-dma.c	2002-11-30 17:37:32.000000000 +0100
+++ linux-2.4.20-ac1.x/drivers/ide/ide-dma.c	2002-11-30 17:34:22.000000000 +0100
@@ -627,6 +627,7 @@
 {
 	drive->using_dma = 1;
 	ide_toggle_bounce(drive, 1);
+	printk(KERN_INFO "%s: DMA enabled\n", drive->name);
 	return HWIF(drive)->ide_dma_host_on(drive);
 }

-- 
Tomas Szepe <szepe@pinerecords.com>
