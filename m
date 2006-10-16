Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWJPPXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWJPPXQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWJPPXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:23:16 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34435 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932146AbWJPPXP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:23:15 -0400
Subject: [PATCH] arm: switch to new pci_get_bus_and_slot API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 16:49:50 +0100
Message-Id: <1161013790.24237.97.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc1-mm1/arch/arm/mach-ixp2000/ixdp2400.c linux-2.6.19-rc1-mm1/arch/arm/mach-ixp2000/ixdp2400.c
--- linux.vanilla-2.6.19-rc1-mm1/arch/arm/mach-ixp2000/ixdp2400.c	2006-10-13 15:06:14.000000000 +0100
+++ linux-2.6.19-rc1-mm1/arch/arm/mach-ixp2000/ixdp2400.c	2006-10-13 17:14:23.000000000 +0100
@@ -133,11 +133,13 @@
 	struct pci_dev *dev;
 
 	if (ixdp2x00_master_npu()) {
-		dev = pci_find_slot(1, IXDP2400_SLAVE_ENET_DEVFN);
+		dev = pci_get_bus_and_slot(1, IXDP2400_SLAVE_ENET_DEVFN);
 		pci_remove_bus_device(dev);
+		pci_dev_put(dev)
 	} else {
-		dev = pci_find_slot(1, IXDP2400_MASTER_ENET_DEVFN);
+		dev = pci_get_bus_and_slot(1, IXDP2400_MASTER_ENET_DEVFN);
 		pci_remove_bus_device(dev);
+		pci_dev_put(dev)
 
 		ixdp2x00_slave_pci_postinit();
 	}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc1-mm1/arch/arm/mach-ixp2000/ixdp2800.c linux-2.6.19-rc1-mm1/arch/arm/mach-ixp2000/ixdp2800.c
--- linux.vanilla-2.6.19-rc1-mm1/arch/arm/mach-ixp2000/ixdp2800.c	2006-10-13 15:06:14.000000000 +0100
+++ linux-2.6.19-rc1-mm1/arch/arm/mach-ixp2000/ixdp2800.c	2006-10-13 17:14:23.000000000 +0100
@@ -261,14 +261,16 @@
 
 		pci_common_init(&ixdp2800_pci);
 		if (ixdp2x00_master_npu()) {
-			dev = pci_find_slot(1, IXDP2800_SLAVE_ENET_DEVFN);
+			dev = pci_get_bus_and_slot(1, IXDP2800_SLAVE_ENET_DEVFN);
 			pci_remove_bus_device(dev);
+			pci_dev_put(dev);
 
 			ixdp2800_master_enable_slave();
 			ixdp2800_master_wait_for_slave_bus_scan();
 		} else {
-			dev = pci_find_slot(1, IXDP2800_MASTER_ENET_DEVFN);
+			dev = pci_get_bus_and_slot(1, IXDP2800_MASTER_ENET_DEVFN);
 			pci_remove_bus_device(dev);
+			pci_dev_put(dev);
 		}
 	}
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc1-mm1/arch/arm/mach-ixp2000/ixdp2x00.c linux-2.6.19-rc1-mm1/arch/arm/mach-ixp2000/ixdp2x00.c
--- linux.vanilla-2.6.19-rc1-mm1/arch/arm/mach-ixp2000/ixdp2x00.c	2006-10-13 15:10:06.000000000 +0100
+++ linux-2.6.19-rc1-mm1/arch/arm/mach-ixp2000/ixdp2x00.c	2006-10-13 17:14:23.000000000 +0100
@@ -241,11 +241,14 @@
 	/*
 	 * Remove PMC device is there is one
 	 */
-	if((dev = pci_find_slot(1, IXDP2X00_PMC_DEVFN)))
+	if((dev = pci_get_bus_and_slot(1, IXDP2X00_PMC_DEVFN))) {
 		pci_remove_bus_device(dev);
+		pci_dev_put(dev);
+	}
 
-	dev = pci_find_slot(0, IXDP2X00_21555_DEVFN);
+	dev = pci_get_bus_and_slot(0, IXDP2X00_21555_DEVFN);
 	pci_remove_bus_device(dev);
+	pci_dev_put(dev);
 }
 
 /**************************************************************************

