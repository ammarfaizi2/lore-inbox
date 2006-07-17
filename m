Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWGQX7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWGQX7B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 19:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWGQX7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 19:59:01 -0400
Received: from aun.it.uu.se ([130.238.12.36]:12932 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751240AbWGQX7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 19:59:00 -0400
Date: Tue, 18 Jul 2006 01:58:34 +0200 (MEST)
Message-Id: <200607172358.k6HNwYhF002052@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: alan@redhat.com
Subject: libata pata_pdc2027x success on sparc64
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan & Albert,

I just tried the patch-2.6.17-ide1.gz libata PATA patch
on a sparc64 box in which I had put an Ultra133TX2 PCI
card (pdc20269) and an old 80GB IBM Deskstar disk. The
results were excellent: did lots of I/O with no kernel
errors, and I got about 45MB/s read speed at udma5.

(A minor nit: the patch kit doesn't have a config option
for pata_pdc2027x, so I had to hack one in. See below.)

In contrast, the old IDE pdc202xx_new driver had lots
of problems with CRC errors causing it to disable DMA.
I wasn't able to manually tune it above udma3 without
getting more errors. This isn't sparc64-specific: I've
had similar negative experience with the old IDE Promise
drivers in a PowerMac.

/Mikael

--- linux-2.6.17/drivers/scsi/Kconfig.~1~	2006-07-17 23:30:25.000000000 +0200
+++ linux-2.6.17/drivers/scsi/Kconfig	2006-07-17 23:39:25.000000000 +0200
@@ -843,6 +843,10 @@ config SCSI_PATA_PDC_OLD
 
 	  If unsure, say N.
 
+config SCSI_PATA_PDC_NEW
+	tristate "Newer Promise PATA controller support (Raving Lunatic)"
+	depends on SCSI_SATA && PCI && EXPERIMENTAL
+
 config SCSI_PATA_QDI
 	tristate "QDI VLB PATA support"
 	depends on SCSI_SATA
--- linux-2.6.17/drivers/scsi/Makefile.~1~	2006-07-17 23:30:25.000000000 +0200
+++ linux-2.6.17/drivers/scsi/Makefile	2006-07-17 23:40:06.000000000 +0200
@@ -161,6 +161,7 @@ obj-$(CONFIG_SCSI_PATA_OPTI)	+= libata.o
 obj-$(CONFIG_SCSI_PATA_OPTIDMA)	+= libata.o pata_optidma.o
 obj-$(CONFIG_SCSI_PATA_PCMCIA)	+= libata.o pata_pcmcia.o
 obj-$(CONFIG_SCSI_PATA_PDC_OLD)	+= libata.o pata_pdc202xx_old.o
+obj-$(CONFIG_SCSI_PATA_PDC_NEW)	+= libata.o pata_pdc2027x.o
 obj-$(CONFIG_SCSI_PATA_QDI)	+= libata.o pata_qdi.o
 obj-$(CONFIG_SCSI_PATA_RADISYS)	+= libata.o pata_radisys.o
 obj-$(CONFIG_SCSI_PATA_RZ1000)	+= libata.o pata_rz1000.o
