Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbWJRVPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbWJRVPP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 17:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030284AbWJRVPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 17:15:15 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:2275 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1030283AbWJRVPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 17:15:12 -0400
Date: Wed, 18 Oct 2006 23:15:09 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Sebastian Biallas <sb@biallas.net>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: PCI-DMA: Disabling IOMMU
Message-ID: <20061018211509.GB4582@rhun.haifa.ibm.com>
References: <45364248.2020901@biallas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45364248.2020901@biallas.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 05:03:36PM +0200, Sebastian Biallas wrote:

> Should I worry about this IOMMU-disabling? All other Linux/IOMMU stuff I
> found had AGP or BIOS messages nearby, but I only get this single
> "PCI-DMA: Disabling IOMMU" line, without any hint.

No, it's fine. Just a badly worded information message. Andi, how
about something like this?

Print a less alarming information message when we don't use GART

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>

diff -r 3f7bc84201e7 arch/x86_64/kernel/pci-gart.c
--- a/arch/x86_64/kernel/pci-gart.c	Wed Oct 18 09:14:19 2006 +0200
+++ b/arch/x86_64/kernel/pci-gart.c	Wed Oct 18 23:13:05 2006 +0200
@@ -601,7 +601,7 @@ void __init gart_iommu_init(void)
 	    (!force_iommu && end_pfn <= MAX_DMA32_PFN) ||
 	    !iommu_aperture ||
 	    (no_agp && init_k8_gatt(&info) < 0)) {
-		printk(KERN_INFO "PCI-DMA: Disabling IOMMU.\n");
+		printk(KERN_INFO "PCI-DMA: Not using GART IOMMU.\n");
 		if (end_pfn > MAX_DMA32_PFN) {
 			printk(KERN_ERR "WARNING more than 4GB of memory "
 					"but IOMMU not available.\n"
