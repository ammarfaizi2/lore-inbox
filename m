Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTFJSsF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTFJSn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:43:58 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:54946 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264026AbTFJSh2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:28 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1055270967899@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709671915@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:27 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1345, 2003/06/09 15:52:51-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/net/wan/lmc/lmc_main.c


 drivers/net/wan/lmc/lmc_main.c |    8 --------
 drivers/net/wan/lmc/lmc_ver.h  |    2 --
 2 files changed, 10 deletions(-)


diff -Nru a/drivers/net/wan/lmc/lmc_main.c b/drivers/net/wan/lmc/lmc_main.c
--- a/drivers/net/wan/lmc/lmc_main.c	Tue Jun 10 11:20:20 2003
+++ b/drivers/net/wan/lmc/lmc_main.c	Tue Jun 10 11:20:20 2003
@@ -1034,14 +1034,6 @@
     u8 intcf = 0;
     struct pci_dev *pdev = NULL;
 
-    /* The card is only available on PCI, so if we don't have a
-     * PCI bus, we are in trouble.
-     */
-
-    if (!pci_present()) {
-/*        printk ("%s: We really want a pci bios!\n", dev->name);*/
-        return -1;
-    }
     /* Loop basically until we don't find anymore. */
     while ((pdev = pci_find_class (PCI_CLASS_NETWORK_ETHERNET << 8, pdev))) {
 	if (pci_enable_device(pdev))
diff -Nru a/drivers/net/wan/lmc/lmc_ver.h b/drivers/net/wan/lmc/lmc_ver.h
--- a/drivers/net/wan/lmc/lmc_ver.h	Tue Jun 10 11:20:20 2003
+++ b/drivers/net/wan/lmc/lmc_ver.h	Tue Jun 10 11:20:20 2003
@@ -69,12 +69,10 @@
 #if LINUX_VERSION_CODE < 0x20155 /* basically 2.2 plus */
 
 #define LMC_DEV_KFREE_SKB(skb) dev_kfree_skb((skb), FREE_WRITE)
-#define LMC_PCI_PRESENT() pcibios_present()
 
 #else /* Mostly 2.0 kernels */
 
 #define LMC_DEV_KFREE_SKB(skb) dev_kfree_skb(skb)
-#define LMC_PCI_PRESENT() pci_present()
 
 #endif
 

