Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263759AbTFXRxR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 13:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264178AbTFXRxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 13:53:16 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:52433 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263786AbTFXRxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 13:53:08 -0400
Date: Tue, 24 Jun 2003 20:07:10 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Gerard Roudier <groudier@free.fr>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 2.5.73: integer constants in sym53c8xx_2/sym_glue.c too big for int
Message-ID: <20030624180710.GY3710@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below postfixes a constant in sym53c8xx_2/sym_glue.c with ULL,
on 32 bit archs this constant is too big for an int.

The other problem is the PciDmaMask #if SYM_CONF_DMA_ADDRESSING_MODE == 1:
Are the _ten_ "f"'s intended (making the constant bigger than the size 
of an int on 32 bit archs)?

cu
Adrian

--- linux-2.5.73-not-full/drivers/scsi/sym53c8xx_2/sym_glue.c.old	2003-06-24 19:53:04.000000000 +0200
+++ linux-2.5.73-not-full/drivers/scsi/sym53c8xx_2/sym_glue.c	2003-06-24 19:56:01.000000000 +0200
@@ -1863,7 +1863,7 @@
 #if   SYM_CONF_DMA_ADDRESSING_MODE == 1
 #define	PciDmaMask	0xffffffffff
 #elif SYM_CONF_DMA_ADDRESSING_MODE == 2
-#define	PciDmaMask	0xffffffffffffffff
+#define	PciDmaMask	0xffffffffffffffffULL
 #endif
 	if (np->features & FE_DAC) {
 		if (!pci_set_dma_mask(np->s.device, PciDmaMask)) {
