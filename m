Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWBFVtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWBFVtv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 16:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWBFVtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 16:49:50 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:29602
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932190AbWBFVtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 16:49:50 -0500
Date: Mon, 06 Feb 2006 13:49:39 -0800 (PST)
Message-Id: <20060206.134939.130100576.davem@davemloft.net>
To: ak@suse.de
Cc: hugh@veritas.com, brking@us.ibm.com, James.Bottomley@steeleye.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] ipr: don't doublefree pages from scatterlist
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200602062211.29993.ak@suse.de>
References: <43E7613B.5060706@us.ibm.com>
	<Pine.LNX.4.61.0602061621450.3560@goblin.wat.veritas.com>
	<200602062211.29993.ak@suse.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>
Date: Mon, 6 Feb 2006 22:11:29 +0100

> Don't touch the non DMA members in the sg list in dma_map_sg in the IOMMU
> 
> Some drivers (in particular ipr) ran into problems because they
> reused the sg lists after passing them to pci_map_sg(). The merging
> procedure in the K8 GART IOMMU corrupted the state. This patch
> changes it to only touch the dma* entries during merging,
> but not the other fields.  Approach suggested by Dave Miller.
> 
> I did some basic tests with CONFIG_IOMMU_DEBUG (LTP, large dd) 
> and without and it hold up, but needs more testing.
> 
> Signed-off-by: Andi Kleen <ak@suse.de>

Thanks for doing this work Andi.
