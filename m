Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130478AbRBAPGz>; Thu, 1 Feb 2001 10:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130527AbRBAPGq>; Thu, 1 Feb 2001 10:06:46 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:57910 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S130478AbRBAPGj>; Thu, 1 Feb 2001 10:06:39 -0500
Date: Thu, 1 Feb 2001 09:06:23 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Martin Diehl <mdiehlcs@compuserve.de>
cc: davej@suse.de, Linus Torvalds <torvalds@transmeta.com>, becker@scyld.com,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] minor ne2k-pci irq fix
In-Reply-To: <Pine.LNX.4.21.0102010039290.2065-100000@notebook.diehl.home>
Message-ID: <Pine.LNX.3.96.1010201090450.26802C-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001, Martin Diehl wrote:
> On Wed, 31 Jan 2001 davej@suse.de wrote:
> > I think it would be better to move the pci_enable_device(pdev);
> > above all this, as we should enable the device before reading the
> > pdev->resource[] too iirc.

Agreed.


> Probably I've missed this because the last time I hit such a thing was
> when my ob800 bios mapped the cardbus memory BAR's into bogus legacy
> 0xe0000 area. Hence there was good reason to read and correct this before
> trying to enable the device.

This is a PCI fixup, the driver shouldn't have to worry about this..


> BTW, will it ever happen the kernel starts remapping BAR's when enabling
> devices?

huh?  The two steps do not occur simultaneously.  The enabling should
occur first, at which point the BARs should be useable.  The remapping
occurs after that.  If the BARs are not usable after remapping, that is
a PCI quirk that needs to be added to the list [probably].

	Jeff



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
