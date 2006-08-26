Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422930AbWHZADP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422930AbWHZADP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 20:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422948AbWHZADO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 20:03:14 -0400
Received: from mga05.intel.com ([192.55.52.89]:30870 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1422930AbWHZADJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 20:03:09 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,170,1154934000"; 
   d="scan'208"; a="121404833:sNHT27921425"
Message-Id: <20060826000302.833529000@linux.intel.com>
References: <20060826000227.818796000@linux.intel.com>
User-Agent: quilt/0.45-1
Date: Fri, 25 Aug 2006 17:02:29 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Kyle McMartin <kyle@parisc-linux.org>,
       Valerie Henson <val_henson@linux.intel.com>,
       Jeff Garzik <jeff@garzik.org>
Subject: [patch 02/10] [TULIP] Print physical address in tulip_init_one
Content-Disposition: inline; filename=tulip-print-physical-address-in-tulip_init_one
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grant Grundler <grundler@parisc-linux.org>

As the cookie returned by pci_iomap() is fairly useless...

[Compile warning on pci_resource_start() format fixed up by Valerie
Henson.]

Signed-off-by: Grant Grundler <grundler@parisc-linux.org>
Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>
Signed-off-by: Valerie Henson <val_henson@linux.intel.com>
Signed-off-by: Jeff Garzik <jeff@garzik.org>

---
 drivers/net/tulip/tulip_core.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

--- linux-2.6.18-rc4-mm1.orig/drivers/net/tulip/tulip_core.c
+++ linux-2.6.18-rc4-mm1/drivers/net/tulip/tulip_core.c
@@ -1656,8 +1656,14 @@ static int __devinit tulip_init_one (str
 	if (register_netdev(dev))
 		goto err_out_free_ring;
 
-	printk(KERN_INFO "%s: %s rev %d at %p,",
-	       dev->name, chip_name, chip_rev, ioaddr);
+	printk(KERN_INFO "%s: %s rev %d at "
+#ifdef CONFIG_TULIP_MMIO
+		"MMIO"
+#else
+		"Port"
+#endif
+		" %#llx,", dev->name, chip_name, chip_rev,
+		(unsigned long long) pci_resource_start(pdev, TULIP_BAR));
 	pci_set_drvdata(pdev, dev);
 
 	if (eeprom_missing)

--
