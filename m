Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbTKCMxh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 07:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbTKCMxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 07:53:37 -0500
Received: from gn78-101.ma.emulex.com ([138.239.78.101]:45768 "EHLO
	wintermute.ma.emulex.com") by vger.kernel.org with ESMTP
	id S262048AbTKCMxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 07:53:35 -0500
Date: Mon, 3 Nov 2003 07:52:59 -0500
From: Jamie Wellnitz <Jamie.Wellnitz@emulex.com>
To: Jes Sorensen <jes@trained-monkey.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: virt_to_page/pci_map_page vs. pci_map_single
Message-ID: <20031103125259.GC16690@ma.emulex.com>
References: <20031102181224.GD2149@ma.emulex.com> <yq0wuahan3t.fsf@trained-monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0wuahan3t.fsf@trained-monkey.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 03, 2003 at 03:10:46AM -0500, Jes Sorensen wrote:
> >>>>> "Jamie" == Jamie Wellnitz <Jamie.Wellnitz@emulex.com> writes:
> 
> Jamie> page = virt_to_page(buffer); offset = ((unsigned long)buffer &
> Jamie> ~PAGE_MASK); busaddr = pci_map_page(pci_dev, page, offset, len,
> Jamie> direction);
> 
> Jamie> How is this preferable to:
> 
> Jamie> pci_map_single( pci_dev, buffer, len, direction);
> 
> Jamie> pci_map_single can't handle highmem pages (because they don't
> Jamie> have a kernel virtual address) but doesn't virt_to_page suffer
> Jamie> from the same limitation?  Is there some benefit on
> Jamie> architectures that don't have highmem?
> 
> virt_to_page() can handle any page in the standard kernel region

What is the "standard kernel region"?  ZONE_NORMAL?

> including pages that are physically in 64-bit space if the
> architecture requires it. It doesn't handle vmalloc pages etc. but
> one shouldn't try and dynamically map vmalloc pages at
> random. pci_map_page() can handle all memory in the system though as
> every page that can be mapped has a struct page * entry.
> 
> pci_map_page() is the correct API to use, pci_map_single() is
> deprecated.

Are you talking about 2.4 or 2.6 or both?

The Document/DMA-mapping.txt in 2.6.0-test9 says "To map a single
region, you do:" and then shows pci_map_single.  Is DMA-mapping.txt in
need of patching?

> 
> Cheers,
> Jes

Thanks,
Jamie
Jamie.Wellnitz@emulex.com
