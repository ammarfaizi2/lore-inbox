Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263432AbTKCWDl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 17:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263454AbTKCWDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 17:03:41 -0500
Received: from gn78-101.ma.emulex.com ([138.239.78.101]:33739 "EHLO
	wintermute.ma.emulex.com") by vger.kernel.org with ESMTP
	id S263432AbTKCWDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 17:03:38 -0500
Date: Mon, 3 Nov 2003 17:03:35 -0500
From: Jamie Wellnitz <Jamie.Wellnitz@emulex.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jes Sorensen <jes@wildopensource.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: virt_to_page/pci_map_page vs. pci_map_single
Message-ID: <20031103220335.GH18060@ma.emulex.com>
References: <1067885332.2076.13.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067885332.2076.13.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 03, 2003 at 12:48:42PM -0600, James Bottomley wrote:
> 
> 
>     Jamie> The Document/DMA-mapping.txt in 2.6.0-test9 says "To map a
>     Jamie> single region, you do:" and then shows pci_map_single.  Is
>     Jamie> DMA-mapping.txt in need of patching?
>     
>     Sounds like it needs an update.
>     
> Erm, I don't think so.  pci_map_single() covers a different use case
> from pci_map_page().
> 
> The thing pci_map_single() can do that pci_map_page() can't is cope with
> contiguous regions greater than PAGE_SIZE in length (which you get
> either from kmalloc() or __get_free_pages()).  This feature is used in
> the SCSI layer for instance.

Does "pci_map_page(virt_to_page(addr))" handle contiguous regions of
multiple pages?  It seems like the i386 implementation will (assuming
we're dealing with kmalloc'd memory).  Although the semantics of
map_single seem better to me than map_page, if I'm mapping a single
"region" of multiple pages.

> 
> There has been talk of deprecating dma_map_single() in favour of
> dma_map_sg() (i.e. make all transfers use scatter/gather and eliminate
> dma_map_single() in favour of a single sg entry table) but nothing has
> been done about it (at least as far as I know).
> 
> James

Thanks,
Jamie Wellnitz
