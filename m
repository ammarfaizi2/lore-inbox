Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132593AbRAaU5d>; Wed, 31 Jan 2001 15:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132770AbRAaU5X>; Wed, 31 Jan 2001 15:57:23 -0500
Received: from front6.grolier.fr ([194.158.96.56]:40955 "EHLO
	front6.grolier.fr") by vger.kernel.org with ESMTP
	id <S132593AbRAaU5M> convert rfc822-to-8bit; Wed, 31 Jan 2001 15:57:12 -0500
Date: Wed, 31 Jan 2001 20:56:09 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] make sym53c8xx.c and ncr53c8xx.c call pci_enable_device
In-Reply-To: <E14O2SF-0002tb-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10101312032590.2134-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 31 Jan 2001, Alan Cox wrote:

> > If the pci_enable_device() thing is to be added to the drivers, it must
> > preferently be placed after the checking against RAID attachement.
> 
> You cant check the signature until the device has been enabled. Maybe you
> could poke the LSI guys and find out how windows PnP stuff handles this.

Personnaly I donnot need to know how windows handle this in order to
figure out how it should be properly handled.

In theory, the signature should be checked prior to any change in the
device configuration space. But since PCI BIOS assigning of resource
windows is complete mess-up, the O/S has to probe BAR sizes. The probing
of BAR sizes does not seem to harm. This done, given that it is possible
then to first check the signature and to leave quiet the device if it is
owned by RAID, there is no valuable reason to still tamper the device for
nothing if it is not to be attached.

> I think the proposed change is ok because if the board is enabled then the 
> enabling code won't touch it.

Can you swear that the code will never change ?

Anyway, the current code at least enables response to IO and to MEM based
on existing BARs. This probably does not harm but this should be done on
behalf of the software driver and based on actually _used_ resources. On
the other hand, the complex enabling of IRQ is really something we want to
avoid in situation where it is not actually useful.

End of story, since moving pci_enable_device() in its preferred place as I
suggested is an obvious minute change.

  Gérard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
