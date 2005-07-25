Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVGYU2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVGYU2G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 16:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVGYU2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 16:28:06 -0400
Received: from [194.90.237.34] ([194.90.237.34]:12375 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261502AbVGYU1J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 16:27:09 -0400
Date: Tue, 26 Jul 2005 01:32:00 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, mj@ucw.cz
Cc: openib-general@openib.org
Subject: [PATCH] arch/xx/pci: remap_pfn_range -> io_remap_pfn_range
Message-ID: <20050725223200.GA1545@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg, Martin, does the following make sense?
If it does, should other architectures be updated as well?

---

Convert i386/pci to use io_remap_pfn_range instead of remap_pfn_range.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

Index: linux-2.6.12.2/arch/i386/pci/i386.c
===================================================================
--- linux-2.6.12.2.orig/arch/i386/pci/i386.c
+++ linux-2.6.12.2/arch/i386/pci/i386.c
@@ -295,9 +295,9 @@ int pci_mmap_page_range(struct pci_dev *
 	/* Write-combine setting is ignored, it is changed via the mtrr
 	 * interfaces on this platform.
 	 */
-	if (remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
-			     vma->vm_end - vma->vm_start,
-			     vma->vm_page_prot))
+	if (io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+			       vma->vm_end - vma->vm_start,
+			       vma->vm_page_prot))
 		return -EAGAIN;
 
 	return 0;


-- 
MST
