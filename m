Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314075AbSEISP2>; Thu, 9 May 2002 14:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314077AbSEISP1>; Thu, 9 May 2002 14:15:27 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:6665 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S314075AbSEISP0>;
	Thu, 9 May 2002 14:15:26 -0400
Date: Thu, 9 May 2002 10:15:22 -0700
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        James Bottomley <James.Bottomley@steeleye.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI reorg fix
Message-ID: <20020509171522.GB17627@kroah.com>
In-Reply-To: <20020509165234.GA17627@kroah.com> <Pine.LNX.4.33.0205091058120.762-100000@segfault.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 11 Apr 2002 15:09:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2002 at 11:06:45AM -0700, Patrick Mochel wrote:
> 
> > As a side note, I don't think that any pci_* function should be able to
> > be called by non-pci drivers.  Is it worth spending the time now in 2.5
> > to make these two functions not rely on 'struct pci_dev' and fix up all
> > of the drivers and architectures and documentation to reflect this?
> > Possible names would be alloc_consistent() and free_consistent()?
> 
> I would suggest something like:
> 
> void * 
> dev_alloc_consistent(struct device * dev, size_t size, dma_addr_t * dma_handle);
> 
> and moving dma_mask to struct device. 

That seems reasonable.

> To handle differences in arch-specific implementations, we could have a 
> callback that the generic code calls.
> 
> Implementing the generic code is ~5 minutes work. However, it will break 
> everything. OTOH, it would be the best motivation for modernizing these 
> drivers...

Eeek, the scsi drivers?  They haven't even started moving to the > 2
years old pci interface yet!  :)

greg k-h
