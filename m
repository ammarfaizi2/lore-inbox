Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269771AbUHZWns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269771AbUHZWns (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269774AbUHZWk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 18:40:58 -0400
Received: from virgo.xame.net ([213.183.15.50]:7049 "EHLO virgo.xame.net")
	by vger.kernel.org with ESMTP id S269769AbUHZWhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 18:37:19 -0400
Date: Fri, 27 Aug 2004 00:36:19 +0200
From: Folke Ashberg <folke@ashberg.de>
To: linux-kernel@vger.kernel.org
Subject: hpt366.c: wrong timings used since 2.6.8
Message-ID: <20040826223617.GA4557@ashberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

i have an HPT372A (rev 02) (PCI_DEVICE_ID_TTI_HPT372) and since 2.6.8
i've got an Ooooops.

I saw that hpt366.c got support for HPT372_N_ and its special timings, but
that timings have been used for my HPT372_A_ and caused the Oops.

I did the following and now it works:
-------------------------------------------
diff -pur linux-2.6.9rc1-orig/drivers/ide/pci/hpt366.c linux-2.6.9rc1/drivers/ide/pci/hpt366.c
--- linux-2.6.9rc1-orig/drivers/ide/pci/hpt366.c        2004-08-26 19:42:16.000000000 +0200
+++ linux-2.6.9rc1/drivers/ide/pci/hpt366.c     2004-08-26 23:22:56.000000000 +0200
@@ -881,7 +881,7 @@ static int __devinit init_hpt37x(struct
        /* interrupt force enable */
        pci_write_config_byte(dev, 0x5a, (reg5ah & ~0x10));

-       if(dmabase)
+       if(dev->device == PCI_DEVICE_ID_TTI_HPT372N && dmabase)
        {
                did = inb(dmabase + 0x22);
                rid = inb(dmabase + 0x28);
@@ -1132,7 +1132,7 @@ static void __devinit init_hwif_hpt366(i
        unsigned long dmabase           = hwif->dma_base;
        int is_372n = 0;

-       if(dmabase)
+       if(dev->device == PCI_DEVICE_ID_TTI_HPT372N && dmabase)
        {
                did = inb(dmabase + 0x22);
                rid = inb(dmabase + 0x28);
-------------------------------------------

Not to also check dev->device for the N-Version at that two places
(which are used also for other versions) seems to be wrong.


Kind Regards

Folke Ashberg

-- 
Folke Ashberg
folke@ashberg.de
www.ashberg.de
