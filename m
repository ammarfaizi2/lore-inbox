Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWIHSUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWIHSUp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 14:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWIHSUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 14:20:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:64339 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1751135AbWIHSUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 14:20:33 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,134,1157353200"; 
   d="scan'208"; a="123415629:sNHT17629577"
Message-Id: <20060908182023.330738000@linux.intel.com>
References: <20060908181533.771856000@linux.intel.com>
User-Agent: quilt/0.45-1
Date: Fri, 08 Sep 2006 11:15:37 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Kyle McMartin <kyle@parisc-linux.org>,
       Valerie Henson <val_henson@linux.intel.com>,
       Jeff Garzik <jeff@garzik.org>
Subject: [patch 04/10] [TULIP] Flush MMIO writes in reset sequence
Content-Disposition: inline; filename=tulip-flush-mmio-writes-in-reset-sequence
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grant Grundler <grundler@parisc-linux.org>

The obvious safe registers to read is one from PCI config space.

Signed-off-by: Grant Grundler <grundler@parisc-linux.org>
Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>
Signed-off-by: Valerie Henson <val_henson@linux.intel.com>
Signed-off-by: Jeff Garzik <jeff@garzik.org>

---
 drivers/net/tulip/tulip_core.c |    2 ++
 1 files changed, 2 insertions(+)

--- linux-2.6.18-rc4-mm1.orig/drivers/net/tulip/tulip_core.c
+++ linux-2.6.18-rc4-mm1/drivers/net/tulip/tulip_core.c
@@ -295,12 +295,14 @@ static void tulip_up(struct net_device *
 
 	/* Reset the chip, holding bit 0 set at least 50 PCI cycles. */
 	iowrite32(0x00000001, ioaddr + CSR0);
+	pci_read_config_dword(tp->pdev, PCI_COMMAND, &i);  /* flush write */
 	udelay(100);
 
 	/* Deassert reset.
 	   Wait the specified 50 PCI cycles after a reset by initializing
 	   Tx and Rx queues and the address filter list. */
 	iowrite32(tp->csr0, ioaddr + CSR0);
+	pci_read_config_dword(tp->pdev, PCI_COMMAND, &i);  /* flush write */
 	udelay(100);
 
 	if (tulip_debug > 1)

--
