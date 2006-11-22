Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753924AbWKVMJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924AbWKVMJo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 07:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753932AbWKVMJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 07:09:44 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:46299 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1753924AbWKVMJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 07:09:43 -0500
Date: Wed, 22 Nov 2006 14:09:27 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: d binderman <dcb314@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH x86-64] Calgary: remove unused vars
Message-ID: <20061122120927.GI4118@rhun.haifa.ibm.com>
References: <BAY107-F16375715795A91CEA1E2D99CE30@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY107-F16375715795A91CEA1E2D99CE30@phx.gbl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 11:45:24AM +0000, d binderman wrote:
> 
> Hello there,
> 
> I just tried to compile Linux kernel 2.6.18.3 with the Intel C
> C compiler.
> 
> The compiler said
> 
> arch/x86_64/kernel/pci-calgary.c(600): remark #593: variable "bbar" was set 
> but never used
> arch/x86_64/kernel/pci-calgary.c(601): remark #593: variable "busnum" was 
> set but never used
> 
> The source code is
> 
>    void __iomem *bbar;
>    unsigned char busnum;
> 
> I have checked the source code and I agree with the compiler.
> Suggest delete local variables.

Thanks, I agree. Andi, please apply.

[PATCH x86-64] Calgary: remove unused vars

Spotted by d binderman <dcb314@hotmail.com>.

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>

diff -r aed4939c234b -r acb0eb3ee9c3 arch/x86_64/kernel/pci-calgary.c
--- a/arch/x86_64/kernel/pci-calgary.c	Mon Nov 20 22:44:19 2006 +0200
+++ b/arch/x86_64/kernel/pci-calgary.c	Wed Nov 22 14:08:19 2006 +0200
@@ -653,13 +653,8 @@ static void __init calgary_reserve_regio
 static void __init calgary_reserve_regions(struct pci_dev *dev)
 {
 	unsigned int npages;
-	void __iomem *bbar;
-	unsigned char busnum;
 	u64 start;
 	struct iommu_table *tbl = dev->sysdata;
-
-	bbar = tbl->bbar;
-	busnum = dev->bus->number;
 
 	/* reserve bad_dma_address in case it's a legal address */
 	iommu_range_reserve(tbl, bad_dma_address, 1);
