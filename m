Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266540AbSKLMd2>; Tue, 12 Nov 2002 07:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266552AbSKLMd2>; Tue, 12 Nov 2002 07:33:28 -0500
Received: from holomorphy.com ([66.224.33.161]:48058 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266540AbSKLMd0>;
	Tue, 12 Nov 2002 07:33:26 -0500
To: linux-kernel@vger.kernel.org
Subject: [1/4] NUMA-Q: use sysdata as quad numbers in pci_scan_bus()
Message-Id: <E18BaIc-0006Zu-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 12 Nov 2002 04:37:46 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This passes (void *)quad as the sysdata parameter to pci_scan_bus() in all
calls within arch/i386/pci/numa.c

 numa.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -urpN pci-2.5.47-0/arch/i386/pci/numa.c pci-2.5.47-1/arch/i386/pci/numa.c
--- pci-2.5.47-0/arch/i386/pci/numa.c	2002-11-10 19:28:06.000000000 -0800
+++ pci-2.5.47-1/arch/i386/pci/numa.c	2002-11-12 03:12:01.000000000 -0800
@@ -106,9 +106,9 @@ static void __devinit pci_fixup_i450nx(s
 		pci_read_config_byte(d, reg++, &subb);
 		DBG("i450NX PXB %d: %02x/%02x/%02x\n", pxb, busno, suba, subb);
 		if (busno)
-			pci_scan_bus(QUADLOCAL2BUS(quad,busno), pci_root_ops, NULL);	/* Bus A */
+			pci_scan_bus(QUADLOCAL2BUS(quad,busno), pci_root_ops, (void *)quad);	/* Bus A */
 		if (suba < subb)
-			pci_scan_bus(QUADLOCAL2BUS(quad,suba+1), pci_root_ops, NULL);	/* Bus B */
+			pci_scan_bus(QUADLOCAL2BUS(quad,suba+1), pci_root_ops, (void *)quad);	/* Bus B */
 	}
 	pcibios_last_bus = -1;
 }
@@ -132,7 +132,7 @@ static int __init pci_numa_init(void)
 			printk("Scanning PCI bus %d for quad %d\n", 
 				QUADLOCAL2BUS(quad,0), quad);
 			pci_scan_bus(QUADLOCAL2BUS(quad,0), 
-				pci_root_ops, NULL);
+				pci_root_ops, (void *)quad);
 		}
 	}
 	return 0;
