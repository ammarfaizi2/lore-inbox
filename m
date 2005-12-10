Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161016AbVLJSKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161016AbVLJSKU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 13:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161017AbVLJSKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 13:10:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:30662 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161016AbVLJSKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 13:10:18 -0500
Subject: Re: Please help with kernel BUG at include/linux/gfp.h:80 with
	ndiswrapper on x86_64
From: Arjan van de Ven <arjan@infradead.org>
To: Orion Poplawski <orion@cora.nwra.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <dncs1c$8e5$1@sea.gmane.org>
References: <dncs1c$8e5$1@sea.gmane.org>
Content-Type: text/plain
Date: Sat, 10 Dec 2005 19:10:10 +0100
Message-Id: <1134238210.2828.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 14:13 -0700, Orion Poplawski wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> With kernel 2.6.15-rc5, gfp_zone has the following BUG_ON:
> 
> static inline int gfp_zone(gfp_t gfp)
> {
>         int zone = GFP_ZONEMASK & (__force int) gfp;
>         BUG_ON(zone >= GFP_ZONETYPES);
>         return zone;
> }
> 
> This is being tripped by ndiswrapper on x86_64 when it calls:
> 
> dma_alloc_coherent(&pci_dev->dev,size,dma_handle, \
>                            GFP_KERNEL | __GFP_REPEAT | GFP_DMA)


I don't think GFP_DMA is a valid option for dma_alloc_coherent at all;
GFP_DMA was for isa card allocations, for PCI stuff you need to set the
proper masks instead, and GFP_DMA is obsolete and wrong for PCI.
(except for potentially deep arch code that knows what it's doing).


