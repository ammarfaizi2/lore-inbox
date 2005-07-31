Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVGaIvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVGaIvf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 04:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVGaIvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 04:51:35 -0400
Received: from [194.90.237.34] ([194.90.237.34]:57804 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261854AbVGaIve
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 04:51:34 -0400
Date: Sun, 31 Jul 2005 11:51:45 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Greg KH <gregkh@suse.de>
Cc: Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>, Roland Dreier <rolandd@cisco.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, openib-general@openib.org,
       linux-kernel@vger.kernel.org, mj@ucw.cz, ian.pratt@cl.cam.ac.uk
Subject: Re: [PATCH] arch/xx/pci: remap_pfn_range -> io_remap_pfn_range
Message-ID: <20050731085145.GE14384@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <A95E2296287EAD4EB592B5DEEFCE0E9D282808@liverpoolst.ad.cl.cam.ac.uk> <20050728161720.GA23507@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050728161720.GA23507@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Greg KH <gregkh@suse.de>:
> Subject: Re: [openib-general] Re: [PATCH] arch/xx/pci: remap_pfn_range -> io_remap_pfn_range
> If this is a fix for xen, fine, then say so in the changelog information
> for the patch, as it is, no such information was given.
> 
> thanks,
> 
> greg k-h
> 

Like this?

---

Convert i386/pci to use io_remap_pfn_range instead of remap_pfn_range.
This is good for Xen which reuses i386/pci/i386.c for domain 0 code.

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
