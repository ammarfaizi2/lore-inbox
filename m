Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbWHQRQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWHQRQI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 13:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030183AbWHQRQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 13:16:08 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:39510 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S1030182AbWHQRQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 13:16:07 -0400
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] PCI: i386 mmconfig: don't forget bus number when setting fallback_slots bits
Date: Thu, 17 Aug 2006 19:15:31 +0200
User-Agent: KMail/1.7.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-pci" <linux-pci@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608171915.31704.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-01.tornado.cablecom.ch-Metrics: smtp-04.tornado.cablecom.ch 1377;
	Body=4 Fuz1=4 Fuz2=4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: i386 mmconfig: don't forget bus number when setting fallback_slots bits

on i386 PCI mmconfig forgets the bus number when setting the fallback_slots
bits which means fallback to conf1 only works for bus 0.

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>

diff --git a/arch/i386/pci/mmconfig.c b/arch/i386/pci/mmconfig.c
index e545b09..972180f 100644
--- a/arch/i386/pci/mmconfig.c
+++ b/arch/i386/pci/mmconfig.c
@@ -178,7 +178,7 @@ static __init void unreachable_devices(v
 				pci_exp_set_dev_base(addr, k, PCI_DEVFN(i, 0));
 			if (addr == 0 ||
 			    readl((u32 __iomem *)mmcfg_virt_addr) != val1) {
-				set_bit(i, fallback_slots);
+				set_bit(i + 32*k, fallback_slots);
 				printk(KERN_NOTICE
 			"PCI: No mmconfig possible on %x:%x\n", k, i);
 			}
