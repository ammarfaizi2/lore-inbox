Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263920AbTKTXIU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 18:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263938AbTKTXIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 18:08:17 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:63187 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263909AbTKTXFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 18:05:45 -0500
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: akpm@osdl.org, B.Zolnierkiewicz@elka.pw.edu.pl
Date: Fri, 21 Nov 2003 10:05:35 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16317.18623.912339.111750@wombat.disy.cse.unsw.edu.au>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Can't disable IDE DMA on 2.6.0-test9 (patch)
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Folks,
   If you try to disable IDE DMA from Kconfig, you'll end up with an
undefined symbol, ide_hwif_setup_dma().

The attached rather ugly patch fixes the problem by defining a dummy
function.

===== setup-pci.c 1.19 vs edited =====
--- 1.19/drivers/ide/setup-pci.c	Sat Oct 18 01:22:22 2003
+++ edited/setup-pci.c	Wed Nov 19 13:52:25 2003
@@ -474,6 +474,11 @@
  *	state
  */
  
+#ifndef CONFIG_BLK_DEV_IDEDMA_PCI
+static void ide_hwif_setup_dma(struct pci_dev *dev, ide_pci_device_t *d, ide_hwif_t *hwif)
+{
+}
+#else
 static void ide_hwif_setup_dma(struct pci_dev *dev, ide_pci_device_t *d, ide_hwif_t *hwif)
 {
 	u16 pcicmd;
@@ -516,6 +521,7 @@
 		}
 	}
 }
+#endif /* CONFIG_BLK_DEV_IDEDMA_PCI*/
 
 /**
  *	ide_setup_pci_controller	-	set up IDE PCI

