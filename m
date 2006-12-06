Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760591AbWLFNNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760591AbWLFNNY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 08:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760593AbWLFNNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 08:13:23 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:45153 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760588AbWLFNNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 08:13:22 -0500
Message-ID: <4576C092.5030202@jp.fujitsu.com>
Date: Wed, 06 Dec 2006 22:07:30 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>, tom.l.nguyen@intel.com
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [BUG][PATCH] pcieport-driver: remove invalid warning message
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got the following warning messages on some PCI Express ports.

    pcie_portdrv_probe->Dev[1263:10cf] has invalid IRQ. Check vendor BIOS

I think this message is improper because those PCI Express ports don't
use an interrupt pin. This message should not be displayed for devices
which don't use an interrupt pin.

Thanks,
Kenji Kaneshige


The following warning message should not be displayed for devices
which don't use an interrupt pin.

    pcie_portdrv_probe->Dev[XXXX:XXXX] has invalid IRQ. Check vendor BIOS

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/pci/pcie/portdrv_pci.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.19/drivers/pci/pcie/portdrv_pci.c
===================================================================
--- linux-2.6.19.orig/drivers/pci/pcie/portdrv_pci.c	2006-12-06 21:31:32.000000000 +0900
+++ linux-2.6.19/drivers/pci/pcie/portdrv_pci.c	2006-12-06 21:31:38.000000000 +0900
@@ -90,7 +90,7 @@
 		return -ENODEV;
 	
 	pci_set_master(dev);
-        if (!dev->irq) {
+        if (!dev->irq && dev->pin) {
 		printk(KERN_WARNING 
 		"%s->Dev[%04x:%04x] has invalid IRQ. Check vendor BIOS\n", 
 		__FUNCTION__, dev->device, dev->vendor);


