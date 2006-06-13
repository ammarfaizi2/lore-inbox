Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWFMVt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWFMVt4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 17:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWFMVtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 17:49:55 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:40336 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932348AbWFMVty
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 17:49:54 -0400
Subject: Re: 2.6.16-rc6-mm2
From: Badari Pulavarty <pbadari@gmail.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Andrew Morton <akpm@osdl.org>, Steve Fox <drfickle@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <448EC74F.30104@ru.mvista.com>
References: <20060609214024.2f7dd72c.akpm@osdl.org>
	 <pan.2006.06.12.22.09.47.855327@us.ibm.com>
	 <20060613065443.7f302319.akpm@osdl.org>  <448EC74F.30104@ru.mvista.com>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 14:51:42 -0700
Message-Id: <1150235502.28414.52.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 18:10 +0400, Sergei Shtylyov wrote:
> Hello.
> 
> Andrew Morton wrote:
> > On Mon, 12 Jun 2006 17:09:52 -0500
> > Steve Fox <drfickle@us.ibm.com> wrote:
> 
> >>On Fri, 09 Jun 2006 21:40:24 -0700, Andrew Morton wrote:
> 
> >>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm2/
> 
> >>Boot fails on a ppc64 machine.
> >>
> >>[snip]
> >>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> >>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> >>AMD8111: IDE controller at PCI slot 0000:00:04.1
> >>AMD8111: chipset revision 3
> >>AMD8111: 0000:00:04.1 (rev 03) UDMA133 controller
> >>AMD8111: 100% native mode on irq 32
> >>    ide0: BM-DMA at 0x7c00-0x7c07<3>AMD8111: -- Error, unable to allocate DMA table.
> >>    ide1: BM-DMA at 0x7c08-0x7c0f<3>AMD8111: -- Error, unable to allocate DMA table.
> >>hda: TOSHIBA MK4019GAXB, ATA DISK drive

Okay. Here is the fix Anton did - which helped my machine.

http://patchwork.ozlabs.org/linuxppc/patch?id=5713

Thanks,
Badari

Index: build/arch/powerpc/kernel/iommu.c
===================================================================
--- build.orig/arch/powerpc/kernel/iommu.c	2006-06-10 19:49:51.000000000 +1000
+++ build/arch/powerpc/kernel/iommu.c	2006-06-10 19:52:12.000000000 +1000
@@ -561,7 +561,7 @@ void *iommu_alloc_coherent(struct iommu_
 		return NULL;
 
 	/* Alloc enough pages (and possibly more) */
-	page = alloc_pages_node(flag, order, node);
+	page = alloc_pages_node(node, flag, order);
 	if (!page)
 		return NULL;
 	ret = page_address(page);

