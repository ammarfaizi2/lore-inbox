Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129360AbRBHSQ3>; Thu, 8 Feb 2001 13:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130064AbRBHSQJ>; Thu, 8 Feb 2001 13:16:09 -0500
Received: from cmr0.ash.ops.us.uu.net ([198.5.241.38]:52167 "EHLO
	cmr0.ash.ops.us.uu.net") by vger.kernel.org with ESMTP
	id <S129129AbRBHSPu>; Thu, 8 Feb 2001 13:15:50 -0500
Message-ID: <3A82E1FB.75361E04@uu.net>
Date: Thu, 08 Feb 2001 13:14:19 -0500
From: Alex Deucher <adeucher@UU.NET>
Organization: UUNET
X-Mailer: Mozilla 4.74 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Hartmann <jhartmann@valinux.com>
CC: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.x, drm, g400 and pci_set_master
In-Reply-To: <14E9CDBC07F1@vcnet.vc.cvut.cz> <3A82DB9B.3050008@valinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jeff Hartmann wrote:
> 
> Petr Vandrovec wrote:
> 
> > On  8 Feb 01 at 12:15, Alex Deucher wrote:
> >
> >> I wasn't talking about the drm driver I was talking about programming
> >> the PCI controller directly using setpci 1.0.0 .... or some such
> >> command, I can't remember off hand.  Which turns on busmastering if it
> >> is off for a particular device.
> >
> >
> > OK.
> >
> >> Jeff Hartmann wrote:
> >>
> >>> The DRM drivers don't know about the pcidev structure at all.  All this
> >>> is done in the XFree86 ddx driver.  You can probably add something like
> >>> this to MGAPreInit (after pMga->PciTag is set, in my copy its
> >>> mga_driver.c:1232 yours might be at a slightly different line number
> >>> depending on the version your using):
> >>>
> >>> {
> >>>    CARD32 temp;
> >>>    temp = pciReadLong(pMga->PciTag, PCI_CMD_STAT_REG);
> >>>    pciWriteLong(pMga->PciTag, PCI_CMD_STAT_REG, temp |
> >>> PCI_CMD_MASTER_ENABLE);
> >>> }
> >>
> >
> > Jeff, do you say that drm code does not use dynamic DMA mapping, which is
> > specified as only busmastering interface for kernels 2.4.x, at all? Now
> > I understand what had one friend in the mind when he laughed when I said
> > that it must be easy to get it to work on Alpha...
> >                             Thanks anyway for all suggestions,
> >                                         Petr Vandrovec
> >                                         vandrove@vc.cvut.cz
> >
> >
> It does not use dynamic DMA mapping, because it doesn't do PCI DMA at
> all.  It uses AGP DMA.  Actually, it shouldn't be too hard to get it to
> work on the Alpha (just a few 32/64 bit issues probably.)  Someone just
> needs to get agpgart working on the Alpha, thats the big step.
> 
> -Jeff


That shouldn't be too hard since many (all?) AGP alpha boards (UP1000's
anyway) are based on the AMD 751 Northbridge? And there is already
support for that in the kernel for x86. 

Alex
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
