Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVGZEwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVGZEwv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 00:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVGZEwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 00:52:51 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:26248 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S261644AbVGZEwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 00:52:50 -0400
Date: Mon, 25 Jul 2005 23:52:43 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: PCI: fix up errors after dma bursting patch and CONFIG_PCI=n -- bug?
Message-ID: <Pine.LNX.4.61.0507252350390.7078@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

In the patch from:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0506.3/0985.html

Is the the following line suppose inside the if CONFIG_PCI=n

  #define pci_dma_burst_advice(pdev, strat, strategy_parameter) do { } while (0)

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
diff --git a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -971,6 +971,8 @@ static inline int pci_enable_wake(struct
 
 #define	isa_bridge	((struct pci_dev *)NULL)
 
+#define pci_dma_burst_advice(pdev, strat, strategy_parameter) do { } while (0)
+
 #else
 
 /*
@@ -985,9 +987,6 @@ static inline int pci_proc_domain(struct
 	return 0;
 }
 #endif
-
-#define pci_dma_burst_advice(pdev, strat, strategy_parameter) do { } while (0)
-
 #endif /* !CONFIG_PCI */
 
 /* these helpers provide future and backwards compatibility

