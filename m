Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266785AbTGKVCM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 17:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266798AbTGKVCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 17:02:11 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:53994 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP id S266785AbTGKVBb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 17:01:31 -0400
Subject: [PATCH] 2.5.75-bk update help texts for PDC202 (was [PATCH] Update
	COnfigure.help for PDC202 options)
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
       Andrew Morton <akpm@osdl.org>, Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <Pine.LNX.4.44.0307112038070.18477-200000@sharra.ivimey.org>
References: <Pine.LNX.4.44.0307112038070.18477-200000@sharra.ivimey.org>
Content-Type: text/plain
Organization: 
Message-Id: <1057956592.1728.11.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 11 Jul 2003 14:49:53 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-11 at 13:39, Ruth Ivimey-Cook wrote:
> Folks,
> 
> I have updated the help for the Promise controller cards to match the code 
> and provide a bit more information.
> 
> Enjoy.
> 
> Ruth

Thanks Ruth.

I've taken your work and formatted it for the drivers/ide/Kconfig file
in 2.5. Here's the patch.

This was made against the current 2.5 tree.

Steven

--- 2.5-linux/drivers/ide/Kconfig.orig	Fri Jul 11 13:44:02 2003
+++ 2.5-linux/drivers/ide/Kconfig	Fri Jul 11 14:07:34 2003
@@ -682,9 +682,33 @@
 config BLK_DEV_PDC202XX_OLD
 	tristate "PROMISE PDC202{46|62|65|67} support"
 	depends on BLK_DEV_IDEDMA_PCI
+	help
+	  Promise Ultra 33 [PDC20246]
+	  Promise Ultra 66 [PDC20262]
+	  Promise FastTrak 66 [PDC20263]
+	  Promise MB Ultra 100 [PDC20265]
+	  Promise Ultra 100 [PDC20267]
+	
+	  This driver adds up to 4 more EIDE devices sharing a single
+	  interrupt. This device is a bootable PCI UDMA controller. Since
+	  multiple cards can be installed and there are BIOS ROM problems that
+	  happen if the BIOS revisions of all installed cards (max of three) do
+	  not match, the driver attempts to do dynamic tuning of the chipset
+	  at boot-time for max speed.  Ultra33 BIOS 1.25 or newer is required
+	  for more than one card. This card may require that you say Y to
+	  "Special UDMA Feature" to force UDMA mode for connected UDMA capable
+	  disk drives.
+	
+	  If you say Y here, you need to say Y to "Use DMA by default when
+	  available" as well.
+	
+	  Please read the comments at the top of
+	  <file:drivers/ide/pci/pdc202xx_old.c>.
+	
+	  If unsure, say N.
 
 config PDC202XX_BURST
-	bool "Special UDMA Feature"
+	bool "Override-Enable UDMA for Promise Controllers"
 	depends on BLK_DEV_PDC202XX_OLD=y && CONFI_BLK_DEV_IDEDMA_PCI
 	---help---
 	  This option causes the pdc202xx driver to enable UDMA modes on the
@@ -703,13 +727,47 @@
 config BLK_DEV_PDC202XX_NEW
 	tristate "PROMISE PDC202{68|69|70|71|75|76|77} support"
 	depends on BLK_DEV_IDEDMA_PCI
+	help
+	  Promise Ultra 100 TX2 [PDC20268]
+	  Promise Ultra 133 PTX2 [PDC20269]
+	  Promise FastTrak LP/TX2/TX4 [PDC20270]
+	  Promise FastTrak TX2000 [PDC20271]
+	  Promise MB Ultra 133 [PDC20275]
+	  Promise MB FastTrak 133 [PDC20276]
+	  Promise FastTrak 133 [PDC20277]
+	
+	  This driver adds up to 4 more EIDE devices sharing a single
+	  interrupt. This device is a bootable PCI UDMA controller. Since
+	  multiple cards can be installed and there are BIOS ROM problems that
+	  happen if the BIOS revisions of all installed cards (max of five) do
+	  not match, the driver attempts to do dynamic tuning of the chipset
+	  at boot-time for max speed.  Ultra33 BIOS 1.25 or newer is required
+	  for more than one card.
+	
+	  If you say Y here, you need to say Y to "Use DMA by default when
+	  available" as well.
+	
+	  If unsure, say N.
 
 # FIXME - probably wants to be one for old and for new
 config PDC202XX_FORCE
-	bool "Special FastTrak Feature"
+	bool "Use FastTrak RAID capable device as plain IDE controller"
 	depends on BLK_DEV_PDC202XX_NEW=y
 	help
-	  For FastTrak enable overriding BIOS.
+	  Setting this option causes the kernel to use your Promise IDE disk
+	  controller as an ordinary IDE controller, rather than as a FastTrak
+	  RAID controller. RAID is a system for using multiple physical disks
+	  as one virtual disk.
+	
+	  You need to say Y here if you have a PDC20276 IDE interface but either
+	  you do not have a RAID disk array, or you wish to use the Linux
+	  internal RAID software (/dev/mdX).
+	
+	  You need to say N here if you wish to use your Promise controller to
+	  control a FastTrak RAID disk array, and you you must also say Y to
+	  CONFIG_BLK_DEV_ATARAID_PDC.
+	
+	  If unsure, say Y.
 
 config BLK_DEV_RZ1000
 	tristate "RZ1000 chipset bugfix/support"





