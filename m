Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129942AbRBBQsO>; Fri, 2 Feb 2001 11:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129536AbRBBQsE>; Fri, 2 Feb 2001 11:48:04 -0500
Received: from [195.71.115.196] ([195.71.115.196]:42112 "HELO
	demdwug7.mediaways.net") by vger.kernel.org with SMTP
	id <S129896AbRBBQru>; Fri, 2 Feb 2001 11:47:50 -0500
Date: Fri, 2 Feb 2001 17:49:08 +0100 (CET)
From: Martin Diehl <mdiehlcs@compuserve.de>
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
cc: davej@suse.de, Linus Torvalds <torvalds@transmeta.com>, becker@scyld.com,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] minor ne2k-pci irq fix
In-Reply-To: <Pine.LNX.3.96.1010201090450.26802C-100000@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0102021746001.11308-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(apologies in case anybody should get this twice - was catched by the DUL
blocker again. Seems time to change my mail routing anyway...)

On Thu, 1 Feb 2001, Jeff Garzik wrote:

> > Probably I've missed this because the last time I hit such a thing was
> > when my ob800 bios mapped the cardbus memory BAR's into bogus legacy
> > 0xe0000 area. Hence there was good reason to read and correct this before
> > trying to enable the device.
> 
> This is a PCI fixup, the driver shouldn't have to worry about this..

Agreed. Point was when I discovered the broken BAR location the BIOS had
set, it was at late 2.4.0-test12. So I prefered a simple fix in the yenta
driver without touching other stuff like PCI, just in case Linus would
have liked it for 2.4.

> > BTW, will it ever happen the kernel starts remapping BAR's when enabling
> > devices?
> 
> huh?  The two steps do not occur simultaneously.  The enabling should
> occur first, at which point the BARs should be useable.  The remapping
> occurs after that.  If the BARs are not usable after remapping, that is
> a PCI quirk that needs to be added to the list [probably].

Sorry, wasn't clear enough. I've meant, the kernel (PCI stuff) changing
the BAR bus address in the config space when enabling the device (i.e.
the bus address value which is used for later mapping). Doing so would
make the pci_resource_start() value bogus (when obtained before enabling
the device) - even without accessing/ioremap() it.
My guess is this might happen, but I'm not sure when. Probably if our PCI
stuff assigned another BAR without inital bus address to overlap with
what the BIOS suggested for some initially disabled BAR. Or for real PCI
hotplugging in general.

Just to understand it's more than a cosmetical bug if a driver saves this
before the device is up...

Martin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
