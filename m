Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314069AbSEISKW>; Thu, 9 May 2002 14:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314072AbSEISKW>; Thu, 9 May 2002 14:10:22 -0400
Received: from air-2.osdl.org ([65.201.151.6]:6017 "EHLO segfault.osdl.org")
	by vger.kernel.org with ESMTP id <S314069AbSEISKV>;
	Thu, 9 May 2002 14:10:21 -0400
Date: Thu, 9 May 2002 11:06:45 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        James Bottomley <James.Bottomley@steeleye.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] PCI reorg fix
In-Reply-To: <20020509165234.GA17627@kroah.com>
Message-ID: <Pine.LNX.4.33.0205091058120.762-100000@segfault.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> As a side note, I don't think that any pci_* function should be able to
> be called by non-pci drivers.  Is it worth spending the time now in 2.5
> to make these two functions not rely on 'struct pci_dev' and fix up all
> of the drivers and architectures and documentation to reflect this?
> Possible names would be alloc_consistent() and free_consistent()?

I would suggest something like:

void * 
dev_alloc_consistent(struct device * dev, size_t size, dma_addr_t * dma_handle);

and moving dma_mask to struct device. 

To handle differences in arch-specific implementations, we could have a 
callback that the generic code calls.

Implementing the generic code is ~5 minutes work. However, it will break 
everything. OTOH, it would be the best motivation for modernizing these 
drivers...

	-pat

