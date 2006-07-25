Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWGYCf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWGYCf5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 22:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWGYCf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 22:35:57 -0400
Received: from cantor2.suse.de ([195.135.220.15]:24238 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932413AbWGYCf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 22:35:56 -0400
From: Andi Kleen <ak@suse.de>
To: Anthony DeRobertis <asd@suespammers.org>
Subject: Re: skge error; hangs w/ hardware memory hole
Date: Tue, 25 Jul 2006 04:35:05 +0200
User-Agent: KMail/1.9.3
Cc: Stephen Hemminger <shemminger@osdl.org>, Martin Michlmayr <tbm@cyrius.com>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       kevin@sysexperts.com
References: <20060703205238.GA10851@deprecation.cyrius.com> <121226.1152672894714.SLOX.WebMail.wwwrun@imap-dhs.suse.de> <44C317FF.8030705@suespammers.org>
In-Reply-To: <44C317FF.8030705@suespammers.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607250435.05557.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 July 2006 08:32, Anthony DeRobertis wrote:
> Andreas Kleen wrote:
> 
> > 
> > You need to use iommu=soft swiotlb=force
> > 
> > The standard IOMMU is also broken on VIA, but forced swiotlb should
> > work.
> 
> Didn't work :-(

swiotlb=force is unfortunately broken right now. 

But which this patch it should work. Does it?

-Andi

Test patch only: disable DMA over 4GB

Index: linux-2.6.17-work/arch/x86_64/kernel/pci-dma.c
===================================================================
--- linux-2.6.17-work.orig/arch/x86_64/kernel/pci-dma.c
+++ linux-2.6.17-work/arch/x86_64/kernel/pci-dma.c
@@ -202,7 +202,7 @@ int dma_set_mask(struct device *dev, u64
 {
 	if (!dev->dma_mask || !dma_supported(dev, mask))
 		return -EIO;
-	*dev->dma_mask = mask;
+	*dev->dma_mask = mask & 0xffffffff;
 	return 0;
 }
 EXPORT_SYMBOL(dma_set_mask);

