Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314080AbSEISad>; Thu, 9 May 2002 14:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314082AbSEISac>; Thu, 9 May 2002 14:30:32 -0400
Received: from air-2.osdl.org ([65.201.151.6]:13441 "EHLO segfault.osdl.org")
	by vger.kernel.org with ESMTP id <S314080AbSEISab>;
	Thu, 9 May 2002 14:30:31 -0400
Date: Thu, 9 May 2002 11:26:18 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>,
        James Bottomley <James.Bottomley@steeleye.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] PCI reorg fix
In-Reply-To: <Pine.LNX.4.44.0205091320260.11642-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.33.0205091121450.762-100000@segfault.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 9 May 2002, Kai Germaschewski wrote:

> On Thu, 9 May 2002, Patrick Mochel wrote:
> 
> > I would suggest something like:
> > 
> > void * 
> > dev_alloc_consistent(struct device * dev, size_t size, dma_addr_t * dma_handle);
> > 
> > and moving dma_mask to struct device. 
> > 
> > To handle differences in arch-specific implementations, we could have a 
> > callback that the generic code calls.
> > 
> > Implementing the generic code is ~5 minutes work. However, it will break 
> > everything. OTOH, it would be the best motivation for modernizing these 
> > drivers...
> 
> Certainly sounds reasonable. I'd guess it's trivial enough to provide
> wrappers for pci_alloc_consistent(), pci_set_dma_mask() etc., so I don't 
> see why everything would break?

Actually, the point _is_ to break everything. 

The fact that there are wrappers emulating old PCI behavior is the reason 
the SCSI drivers don't use the 2.4 interface. If we provide wrappers for 
alloc_consistent, they'll never change those, either. 

At some point, you have to bite the bullet and break the API. It'll be 
the only way to get drivers to convert. The statement was more of "When we 
do this, it'll be painful" rather than "If we do it..." :)

	-pat


