Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbVGaKgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVGaKgN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 06:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbVGaKgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 06:36:12 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:19840 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261638AbVGaKgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 06:36:11 -0400
Message-ID: <42ECA997.8020908@colorfullife.com>
Date: Sun, 31 Jul 2005 12:36:07 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: default values for pci dma_mask and coherent_dma_mask
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 From Documentation/DMA-mapping.txt:

> pci_alloc_consistent() by default will return 32-bit DMA addresses.
> PCI-X specification requires PCI-X devices to support 64-bit
> addressing (DAC) for all transactions. And at least one platform (SGI
> SN2) requires 64-bit consistent allocations to operate correctly when
> the IO bus is in PCI-X mode. Therefore, like with pci_set_dma_mask(),
> it's good practice to call pci_set_consistent_dma_mask() to set the
> appropriate mask even if your device only supports 32-bit DMA
> (default) and especially if it's a PCI-X device.

What does "good practice" mean? Is the default 32-bit on all archs or not?
Recent nForce nics support 32-bit for the (coherent) ring buffer and 
40-bit for the rx/tx data buffers. I intend to add these lines to the 
driver:

+    if (pci_set_dma_mask(pci_dev, 0x0000007fffffffffULL)) {
+         printk(KERN_INFO "forcedeth: 64-bit DMA failed, using 32-bit 
addressing for device %s.\n",
+                            pci_name(pci_dev));
+   }

Is this sufficient, or is it mandatory to add 
pci_set_dma_mask(,DMA_32BIT_MASK) and pci_set_consistent_dma_mask (with 
error handling - IMHO 10 useless lines).

--
    Manfred

