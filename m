Return-Path: <linux-kernel-owner+w=401wt.eu-S932153AbWLNJW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWLNJW3 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 04:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWLNJW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 04:22:29 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:15823 "EHLO
	mtagate3.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932153AbWLNJW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 04:22:28 -0500
Date: Thu, 14 Dec 2006 11:22:08 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Karsten Weiss <K.Weiss@science-computing.de>
Cc: Chris Wedgwood <cw@f00f.org>,
       Christoph Anton Mitterer <calestyo@scientia.net>,
       linux-kernel@vger.kernel.org, Erik Andersen <andersen@codepoet.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory hole mapping related bug?!
Message-ID: <20061214092208.GB6674@rhun.haifa.ibm.com>
References: <Pine.LNX.4.64.0612021202000.2981@addx.localnet> <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de> <458051FD.1060900@scientia.net> <20061213195345.GA16112@tuatara.stupidest.org> <Pine.LNX.4.61.0612132100060.6688@palpatine.science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0612132100060.6688@palpatine.science-computing.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 09:34:16PM +0100, Karsten Weiss wrote:

> FWIW: As far as I understand the linux kernel code (I am no kernel 
> developer so please correct me if I am wrong) the PCI dma mapping code is 
> abstracted by struct dma_mapping_ops. I.e. there are currently four 
> possible implementations for x86_64 (see
> linux-2.6/arch/x86_64/kernel/)
> 
> 1. pci-nommu.c : no IOMMU at all (e.g. because you have < 4 GB memory)
>    Kernel boot message: "PCI-DMA: Disabling IOMMU."
> 
> 2. pci-gart.c : (AMD) Hardware-IOMMU.
>    Kernel boot message: "PCI-DMA: using GART IOMMU" (this message
>    first appeared in 2.6.16)
> 
> 3. pci-swiotlb.c : Software-IOMMU (used e.g. if there is no hw iommu)
>    Kernel boot message: "PCI-DMA: Using software bounce buffering 
>    for IO (SWIOTLB)"

Used if there's no HW IOMMU *and* it's needed (because you have >4GB
memory) or you told the kernel to use it (iommu=soft).

> 4. pci-calgary.c : Calgary HW-IOMMU from IBM; used in pSeries servers. 
>    This HW-IOMMU supports dma address mapping with memory proctection,
>    etc.
>    Kernel boot message: "PCI-DMA: Using Calgary IOMMU" (since
>    2.6.18!)

Calgary is found in pSeries servers, but also in high-end xSeries
(Intel based) servers. It would be a little awkward if pSeries servers
(which are based on PowerPC processors) used code under arch/x86-64
:-)

> BTW: It would be really great if this area of the kernel would get some 
> more and better documentation. The information at 
> linux-2.6/Documentation/x86_64/boot_options.txt is very terse. I had to 
> read the code to get a *rough* idea what all the "iommu=" options 
> actually do and how they interact.

Patches happily accepted :-)

Cheers,
Muli
