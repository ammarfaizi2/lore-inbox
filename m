Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBHRie>; Thu, 8 Feb 2001 12:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129026AbRBHRiN>; Thu, 8 Feb 2001 12:38:13 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:48911 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129031AbRBHRiB>;
	Thu, 8 Feb 2001 12:38:01 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Alex Deucher <adeucher@UU.NET>
Date: Thu, 8 Feb 2001 18:36:30 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.4.x, drm, g400 and pci_set_master
CC: linux-kernel@vger.kernel.org, jhartmann@valinux.com
X-mailer: Pegasus Mail v3.40
Message-ID: <14E9CDBC07F1@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Feb 01 at 12:15, Alex Deucher wrote:

> I wasn't talking about the drm driver I was talking about programming
> the PCI controller directly using setpci 1.0.0 .... or some such
> command, I can't remember off hand.  Which turns on busmastering if it
> is off for a particular device.

OK. 

> Jeff Hartmann wrote:
> > 
> > The DRM drivers don't know about the pcidev structure at all.  All this
> > is done in the XFree86 ddx driver.  You can probably add something like
> > this to MGAPreInit (after pMga->PciTag is set, in my copy its
> > mga_driver.c:1232 yours might be at a slightly different line number
> > depending on the version your using):
> > 
> > {
> >    CARD32 temp;
> >    temp = pciReadLong(pMga->PciTag, PCI_CMD_STAT_REG);
> >    pciWriteLong(pMga->PciTag, PCI_CMD_STAT_REG, temp |
> > PCI_CMD_MASTER_ENABLE);
> > }

Jeff, do you say that drm code does not use dynamic DMA mapping, which is
specified as only busmastering interface for kernels 2.4.x, at all? Now 
I understand what had one friend in the mind when he laughed when I said 
that it must be easy to get it to work on Alpha...
                            Thanks anyway for all suggestions,
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz
                                        
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
