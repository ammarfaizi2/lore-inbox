Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130064AbRBHRSI>; Thu, 8 Feb 2001 12:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129741AbRBHRR7>; Thu, 8 Feb 2001 12:17:59 -0500
Received: from cmr0.ash.ops.us.uu.net ([198.5.241.38]:55213 "EHLO
	cmr0.ash.ops.us.uu.net") by vger.kernel.org with ESMTP
	id <S130064AbRBHRRt>; Thu, 8 Feb 2001 12:17:49 -0500
Message-ID: <3A82D414.A6830B64@uu.net>
Date: Thu, 08 Feb 2001 12:15:00 -0500
From: Alex Deucher <adeucher@UU.NET>
Organization: UUNET
X-Mailer: Mozilla 4.74 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Hartmann <jhartmann@valinux.com>
CC: vandrove@vc.cvut.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.4.x, drm, g400 and pci_set_master
In-Reply-To: <3A82CBCE.6926AFAF@uu.net> <3A82D271.6010000@valinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wasn't talking about the drm driver I was talking about programming
the PCI controller directly using setpci 1.0.0 .... or some such
command, I can't remember off hand.  Which turns on busmastering if it
is off for a particular device.

Alex

Jeff Hartmann wrote:
> 
> Alex Deucher wrote:
> 
> > I'm not sure about the mga source, but you can enable busmaster manually
> > as root.  See the dri-devel list for more.  I can't remember the exact
> > message off hand.  THere was also some discussion of this last week I
> > think.
> >
> > Alex
> >
> >
> > ----------------------------
> >
> > Hi,
> >   friend of mine bought g400 on my recommendation, and unfortunately,
> > mga drm driver did not worked for me. I tracked it down to missing
> > pci_enable_device and pci_set_master in mga* driver. But even after
> > looking more than hour into that code I have no idea where I should
> > place this call, as it looks like that mga driver is completely
> > shielded from seeing pcidev structure :-(
> >   Does anybody know where I should place pci_enable_device and
> > pci_set_master into mga code? I worked around pci_enable_device by
> > using matroxfb, but pci_set_master is not invoked by matroxfb, and
> > adding this call into matroxfb just to get mga drm driver to work does
> > not look correctly to me - although it is what I had done just now.
> >                                     Thanks,
> >                                             Petr Vandrovec
> >                                             vandrove@vc.cvut.cz
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> >
> 
> The DRM drivers don't know about the pcidev structure at all.  All this
> is done in the XFree86 ddx driver.  You can probably add something like
> this to MGAPreInit (after pMga->PciTag is set, in my copy its
> mga_driver.c:1232 yours might be at a slightly different line number
> depending on the version your using):
> 
> {
>    CARD32 temp;
>    temp = pciReadLong(pMga->PciTag, PCI_CMD_STAT_REG);
>    pciWriteLong(pMga->PciTag, PCI_CMD_STAT_REG, temp |
> PCI_CMD_MASTER_ENABLE);
> }
> 
> -Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
