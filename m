Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945950AbWGOAh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945950AbWGOAh4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 20:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945951AbWGOAhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 20:37:54 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38921 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1945950AbWGOAhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 20:37:38 -0400
Date: Sat, 15 Jul 2006 02:37:36 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Andrew Morton <akpm@osdl.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [2.6 patch] drivers/ide/: cleanups
Message-ID: <20060715003736.GP3633@stusta.de>
References: <20060711141637.GS13938@stusta.de> <44B3B61B.4010206@tls.msk.ru> <1152634804.18028.27.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152634804.18028.27.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 05:20:04PM +0100, Alan Cox wrote:
> Ar Maw, 2006-07-11 am 18:30 +0400, ysgrifennodd Michael Tokarev:
> > Adrian Bunk wrote:
> > > This patch contains the following clenups:
> > > - setup-pci.c: #if 0 the unused ide_pci_unregister_driver()
> > 
> > Hmm.  So, ide drivers will be unloadable forever, without
> > a chance to fix it someday? ;)
> 
> If you want removable IDE drivers use 2.4-ac or follow the libata work.
> drivers/ide is on its way out. In fact Adrian, just deleting that
> function would be a better patch.

OK, below is a version doing this.

> Alan

cu
Adrian


<--  snip  -->



This patch contains the following clenups:
- setup-pci.c: remove the unused ide_pci_unregister_driver()
- ide-dma.c: remove the unused EXPORT_SYMBOL_GPL(ide_in_drive_list)

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/ide/ide-dma.c   |    2 --
 drivers/ide/setup-pci.c |   18 ------------------
 include/linux/ide.h     |    1 -
 3 files changed, 21 deletions(-)

--- linux-2.6.17-rc1-mm2-full/include/linux/ide.h.old	2006-04-10 22:46:27.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/include/linux/ide.h	2006-04-10 22:46:36.000000000 +0200
@@ -1188,7 +1188,6 @@
 extern void ide_scan_pcibus(int scan_direction) __init;
 extern int __ide_pci_register_driver(struct pci_driver *driver, struct module *owner);
 #define ide_pci_register_driver(d) __ide_pci_register_driver(d, THIS_MODULE)
-extern void ide_pci_unregister_driver(struct pci_driver *driver);
 void ide_pci_setup_ports(struct pci_dev *, struct ide_pci_device_s *, int, ata_index_t *);
 extern void ide_setup_pci_noise (struct pci_dev *dev, struct ide_pci_device_s *d);
 
--- linux-2.6.17-rc1-mm2-full/drivers/ide/ide-dma.c.old	2006-04-10 22:44:21.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/ide/ide-dma.c	2006-04-10 22:44:28.000000000 +0200
@@ -152,8 +152,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL_GPL(ide_in_drive_list);
-
 /**
  *	ide_dma_intr	-	IDE DMA interrupt handler
  *	@drive: the drive the interrupt is for
--- linux-2.6.18-rc1-mm2-full/drivers/ide/setup-pci.c.old	2006-07-15 01:11:47.000000000 +0200
+++ linux-2.6.18-rc1-mm2-full/drivers/ide/setup-pci.c	2006-07-15 01:12:02.000000000 +0200
@@ -795,24 +795,6 @@
 EXPORT_SYMBOL_GPL(__ide_pci_register_driver);
 
 /**
- *	ide_unregister_pci_driver	-	unregister an IDE driver
- *	@driver: driver to remove
- *
- *	Unregister a currently installed IDE driver. Returns are the same
- *	as for pci_unregister_driver
- */
- 
-void ide_pci_unregister_driver(struct pci_driver *driver)
-{
-	if(!pre_init)
-		pci_unregister_driver(driver);
-	else
-		list_del(&driver->node);
-}
-
-EXPORT_SYMBOL_GPL(ide_pci_unregister_driver);
-
-/**
  *	ide_scan_pcidev		-	find an IDE driver for a device
  *	@dev: PCI device to check
  *

