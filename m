Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315665AbSEIJo0>; Thu, 9 May 2002 05:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315666AbSEIJoZ>; Thu, 9 May 2002 05:44:25 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:14344 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315665AbSEIJoZ>;
	Thu, 9 May 2002 05:44:25 -0400
Date: Thu, 9 May 2002 01:44:24 -0700
From: Greg KH <greg@kroah.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Problems with 2.5.14 PCI reorg and non-PCI architectures
Message-ID: <20020509084424.GC15460@kroah.com>
In-Reply-To: <200205082311.g48NBAh01729@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 11 Apr 2002 07:03:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2002 at 07:11:10PM -0400, James Bottomley wrote:
> Hi All,
> 
> You've moved arch/i386/kernel/pci-dma.c under your pci subdirectory.  This 
> means that it is now compiled in only when CONFIG_PCI is defined whereas 
> previously it was always compiled.
> 
> This file contains all of the DMA memory manipulation functions (like 
> pci_alloc_consistent et al.) which you need for device driver memory mapping 
> even in a non PCI bus machine.

arch/i386/pci/dma.c now only contains pci_alloc_consistent() and
pci_free_consistent().  What kind of configuration are you using that
works without CONFIG_PCI and yet calls those functions?  Is it a ISA_PNP
type configuration?  Do you have a .config that this fails on?

> I think the solution is to move it back up to the i386/kernel level and make 
> it always compiled in (perhaps keeping the name as dma.c, though).

I'd be glad to move it back, but I'd like to understand who is using
those functions outside of the pci and isa_pnp drivers.

thanks,

greg k-h
