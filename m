Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317230AbSGCU1F>; Wed, 3 Jul 2002 16:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317232AbSGCU1E>; Wed, 3 Jul 2002 16:27:04 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:37356 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S317230AbSGCU1D>; Wed, 3 Jul 2002 16:27:03 -0400
Message-ID: <20020703202929.27339.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "John Shriver" <jshriver@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Thu, 04 Jul 2002 00:29:29 +0400
Subject: 2.4.19-rc1 still has one issue with Intel D845GBV motherboard
X-Originating-Ip: 65.209.66.235
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the patches necessary to get the IDE controller in the ICH4 (82801DB) on the Intel D845GBV motherboard are already in 2.4.19-rc1.  (These are the issues in the mail thread  "Anthony Spinillo" <tspinillo@linuxmail.org> started on June 1, 2002.)

However, the patch to pci-pc.c that JeffN sent him is still needed, as the BIOS on the board (both patches P02 and P04) doesn't allocate any I/O space for the first four BAR's in the IDE device.

So this is confirmation that such a patch is needed, and that JeffN's patch works.  I suspect it's generic to all Intel BIOSes that are setting up the ICH4.

I've attached a fresh version of the patch based on the 2.4.19-rc1 baseline.

--- linux/arch/i386/kernel/pci-pc.c.orig	2002-07-03 15:48:46.000000000 -0400
+++ linux/arch/i386/kernel/pci-pc.c	2002-07-03 15:50:19.000000000 -0400
@@ -1250,6 +1250,7 @@
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454GX,	pci_fixup_i450gx },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_UMC,	PCI_DEVICE_ID_UMC_UM8886BF,	pci_fixup_umc_ide },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5513,		pci_fixup_ide_trash },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_11,	pci_fixup_ide_trash },
 	{ PCI_FIXUP_HEADER,	PCI_ANY_ID,		PCI_ANY_ID,			pci_fixup_ide_bases },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		pci_fixup_latency },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5598,		pci_fixup_latency },

-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
