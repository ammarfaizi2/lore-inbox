Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbWGKPTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWGKPTg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 11:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWGKPTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 11:19:36 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17939 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751004AbWGKPTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 11:19:34 -0400
Date: Tue, 11 Jul 2006 17:19:33 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: akpm@osdl.org, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/ide/: cleanups
Message-ID: <20060711151933.GT13938@stusta.de>
References: <20060711141637.GS13938@stusta.de> <44B3B7E8.3080800@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B3B7E8.3080800@ru.mvista.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 06:38:32PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> Adrian Bunk wrote:
> 
> >This patch contains the following clenups:
> >- setup-pci.c: #if 0 the unused ide_pci_unregister_driver()
> >- ide.c: remove the unused EXPORT_SYMBOL(ide_register_hw)
> 
>    It's used by arm/bast-ide.c (CONFIG_NLK_DEV_IDE_BAST is defined as 
> tristate).

Sorry, my fault.

I did grep and check the options, but it seems I missed this one.

Updated patch below.

> I don't understand what's the point insisting on its removal 
> since any SOC modular driver in the future may need it...

There are two points:
- re-adding is trivial if it's ever needed, but until then it only
  bloats the kernel
- drivers/ide/ are the legacy IDE drivers that will be superseded
  by libata

>...
> WBR, Sergei

cu
Adrian


<--  snip  -->


This patch contains the following clenups:
- setup-pci.c: #if 0 the unused ide_pci_unregister_driver()
- ide-dma.c: remove the unused EXPORT_SYMBOL_GPL(ide_in_drive_list)

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/ide/ide-dma.c   |    2 --
 drivers/ide/setup-pci.c |    4 +++-
 include/linux/ide.h     |    1 -
 3 files changed, 3 insertions(+), 4 deletions(-)

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
--- linux-2.6.17-rc1-mm2-full/drivers/ide/setup-pci.c.old	2006-04-10 22:46:46.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/ide/setup-pci.c	2006-04-10 22:47:03.000000000 +0200
@@ -807,7 +807,8 @@
  *	Unregister a currently installed IDE driver. Returns are the same
  *	as for pci_unregister_driver
  */
- 
+
+#if 0
 void ide_pci_unregister_driver(struct pci_driver *driver)
 {
 	if(!pre_init)
@@ -817,6 +818,7 @@
 }
 
 EXPORT_SYMBOL_GPL(ide_pci_unregister_driver);
+#endif  /*  0  */
 
 /**
  *	ide_scan_pcidev		-	find an IDE driver for a device



