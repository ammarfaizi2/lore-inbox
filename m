Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSEINAf>; Thu, 9 May 2002 09:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310206AbSEINAe>; Thu, 9 May 2002 09:00:34 -0400
Received: from host194.steeleye.com ([216.33.1.194]:17936 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S310190AbSEINAd>; Thu, 9 May 2002 09:00:33 -0400
Message-Id: <200205091300.g49D0TY01841@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Greg KH <greg@kroah.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>, mochel@osdl.org,
        linux-kernel@vger.kernel.org
Subject: Re: Problems with 2.5.14 PCI reorg and non-PCI architectures 
In-Reply-To: Message from Greg KH <greg@kroah.com> 
   of "Thu, 09 May 2002 01:44:24 PDT." <20020509084424.GC15460@kroah.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 May 2002 09:00:28 -0400
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

greg@kroah.com said:
> arch/i386/pci/dma.c now only contains pci_alloc_consistent() and
> pci_free_consistent().  What kind of configuration are you using that
> works without CONFIG_PCI and yet calls those functions?  Is it a
> ISA_PNP type configuration?  Do you have a .config that this fails on?

The problem is that this is not necessarily PCI related on other platforms.

My cross platform SCSI driver, 53c700.c, uses pci_alloc_consistent because it 
has to work on parisc archs as well (which do have consistent memory even 
though a few of them don't have PCI busses).  It was failing a test compile.  
I can manipulate the #ifdefs so that it doesn't use the consistent allocation 
functions on x86, but I think, in principle, cross platform drivers should be 
able to use these functions.

> I'd be glad to move it back, but I'd like to understand who is using
> those functions outside of the pci and isa_pnp drivers. 

Yes, please.  If you look at a lot of the non-x86 arch drivers, some of them 
also use pci_alloc_consistent.  I think the only other x86 example I can come 
up with is aic7xxx_old which also supports the 7770 chip which is used for 
SCSI in the intel xpress motherboard (pure EISA).

James


