Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbVANVDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbVANVDT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 16:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVANVCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 16:02:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:61079 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262132AbVANU7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 15:59:14 -0500
Message-ID: <41E82DF0.5020600@osdl.org>
Date: Fri, 14 Jan 2005 12:39:12 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>, ak@suse.de,
       tony.luck@intel.com
Subject: [PATCH] swiotlb: fix gcc printk warning
Content-Type: multipart/mixed;
 boundary="------------010404080503030104070907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010404080503030104070907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


swiotlb: Fix gcc printk format warning on x86_64, OK for ia64:
arch/ia64/lib/swiotlb.c:351: warning: long unsigned int format, long 
long unsigned int arg (arg 2)

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
  arch/ia64/lib/swiotlb.c |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)

---

--------------010404080503030104070907
Content-Type: text/x-patch;
 name="swiotlb_printk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="swiotlb_printk.patch"


diff -Naurp ./arch/ia64/lib/swiotlb.c~swiotlb_types ./arch/ia64/lib/swiotlb.c
--- ./arch/ia64/lib/swiotlb.c~swiotlb_types	2005-01-10 10:38:39.310529184 -0800
+++ ./arch/ia64/lib/swiotlb.c	2005-01-14 11:53:17.991480232 -0800
@@ -347,8 +347,8 @@ swiotlb_alloc_coherent(struct device *hw
 
 	/* Confirm address can be DMA'd by device */
 	if (address_needs_mapping(hwdev, dev_addr)) {
-		printk("hwdev DMA mask = 0x%016lx, dev_addr = 0x%016lx\n",
-		       *hwdev->dma_mask, dev_addr);
+		printk("hwdev DMA mask = 0x%016Lx, dev_addr = 0x%016lx\n",
+		       (unsigned long long)*hwdev->dma_mask, dev_addr);
 		panic("swiotlb_alloc_coherent: allocated memory is out of "
 		      "range for device");
 	}

--------------010404080503030104070907--
