Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUC0AGo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 19:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbUC0AGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 19:06:44 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:26008 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S261497AbUC0AGm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 19:06:42 -0500
Date: Fri, 26 Mar 2004 17:06:39 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6-BK] Allow arch-specific pci_dma_set_mask
Message-ID: <20040327000639.GA29290@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Plexity Networks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff, 

Following is a patch that allows for architectures to override 
pci_set_dma_mask and friends for systems that need to do so such
as the ARM IXP425. Instead of having invidual HAVE_ARCH_FOO
for each of the three mask functions, I think it just makes more
sense to have one for overrdding all three since chances are
if you need to override one, you need to do so for all of them.

Tnx,
~Deepak

===== drivers/pci/pci.c 1.63 vs edited =====
--- 1.63/drivers/pci/pci.c	Sun Mar 14 12:17:06 2004
+++ edited/drivers/pci/pci.c	Fri Mar 26 16:58:01 2004
@@ -658,6 +658,10 @@
 	}
 }
 
+#ifndef HAVE_ARCH_PCI_SET_DMA_MASK
+/*
+ * These can be overridden by arch-specific implementations
+ */
 int
 pci_set_dma_mask(struct pci_dev *dev, u64 mask)
 {
@@ -690,6 +694,7 @@
 
 	return 0;
 }
+#endif
      
 static int __devinit pci_init(void)
 {

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and   
 will die here like rotten cabbages." - Number 6
