Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWABTBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWABTBL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 14:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWABTBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 14:01:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:51949 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750961AbWABTBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 14:01:10 -0500
To: c-otto@gmx.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: X86_64 + VIA + 4g problems
References: <43B90A04.2090403@conterra.de> <p73k6difvm3.fsf@verdi.suse.de>
	<20060102165231.GA23834@carsten-otto.halifax.rwth-aachen.de>
From: Andi Kleen <ak@suse.de>
Date: 02 Jan 2006 20:01:08 +0100
In-Reply-To: <20060102165231.GA23834@carsten-otto.halifax.rwth-aachen.de>
Message-ID: <p73bqyufo97.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carsten Otto <c-otto@gmx.de> writes:

[please don't strip cc lists like this - your email got nearly lost]

> On Mon, Jan 02, 2006 at 05:22:12PM +0100, Andi Kleen wrote:
> > When you not compile in the SKGE network driver does everything else work?
> > skge supports 64bit DMA, so it shouldn't use any IOMMU.  But I'm somewhat
> > suspicious of the >4GB support in the VIA chipset. We had problems with
> > that before. It's possible that it's just not supported in the hardware
> > or that the BIOS sets up the MTRRs wrong.
> 
> How can I find that out? Can I provide any useful material? VIA KT800Pro
> and 4GB RAM here..

What was unclear with my first question? Can you try that?
To repeat it again:

%% When you not compile in the SKGE network driver does everything else work?
%% skge supports 64bit DMA, so it shouldn't use any IOMMU. 

Alternatively you can try with the appended patch. If that helps
then the chipset or the BIOS likely has some fundamental issue with >4GB.

-Andi

Index: linux-2.6.15rc7-work/arch/x86_64/kernel/pci-gart.c
===================================================================
--- linux-2.6.15rc7-work.orig/arch/x86_64/kernel/pci-gart.c
+++ linux-2.6.15rc7-work/arch/x86_64/kernel/pci-gart.c
@@ -630,6 +630,13 @@ void dma_unmap_sg(struct device *dev, st
 
 int dma_supported(struct device *dev, u64 mask)
 {
+#if 1
+	/* test patch for VIA quirk */	
+	if (mask > 0xffffffff)
+		return 0;
+#endif
+
+
 	/* Copied from i386. Doesn't make much sense, because it will 
 	   only work for pci_alloc_coherent.
 	   The caller just has to use GFP_DMA in this case. */




