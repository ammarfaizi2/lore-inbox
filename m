Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUBJXWL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 18:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbUBJXWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 18:22:11 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:18314 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262050AbUBJXWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 18:22:06 -0500
Date: Tue, 10 Feb 2004 18:05:04 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Greg KH <greg@kroah.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, kkeil@suse.de,
       isdn4linux@listserv.isdn4linux.de, kai.germaschewski@gmx.de,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
Message-ID: <20040210180504.GF3158@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, Greg KH <greg@kroah.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, kkeil@suse.de,
	isdn4linux@listserv.isdn4linux.de, kai.germaschewski@gmx.de,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <10763689362321@kroah.com> <Pine.GSO.4.58.0402101702420.2261@waterleaf.sonytel.be> <20040210164612.GB27221@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210164612.GB27221@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 08:46:12AM -0800, Greg KH wrote:
> On Tue, Feb 10, 2004 at 05:03:17PM +0100, Geert Uytterhoeven wrote:
> > On Mon, 9 Feb 2004, Greg KH wrote:
> > > ChangeSet 1.1500.11.2, 2004/01/30 16:34:48-08:00, ambx1@neo.rr.com
> > >
> > > [PATCH] PCI: Remove uneeded resource structures from pci_dev
> > >
> > > The following patch remove irq_resource and dma_resource from pci_dev.  It
> > > appears that the serial pci driver depends on irq_resource, however, it may be
> > > broken portions of an old quirk.  I attempted to maintain the existing behavior
> > > while removing irq_resource.  I changed FL_IRQRESOURCE to FL_NOIRQ.  Russell,
> > > could you provide any comments?  irq_resource and dma_resource are most likely
> > > remnants from when pci_dev was shared with pnp.
> >
> > FYI, at least one ISDN driver seems to need it as well:
> >
> > | drivers/isdn/hardware/avm/b1isa.c: In function `b1isa_init':
> > | drivers/isdn/hardware/avm/b1isa.c:183: structure has no member named `irq_resource'
>
> Ick, I don't really think we want users trying to override the irq
> number of their pci cards...

Yeah, I have plans for a struct isa_dev in 2.7.  It seems we currently
have a few cases of drivers sharing pci_dev.

>
> Here's the patch that fixes this, and one other isdn driver up.  ISDN
> people, feel free to add this to your huge patch :)
>
> thanks,
>
> greg k-h
>


It occured to me that we also have the following related code in pci.h:

--- a/include/linux/pci.h       2004-01-09 06:59:33.000000000 +0000
+++ b/include/linux/pci.h       2004-02-10 17:51:08.000000000 +0000
@@ -362,8 +362,6 @@
 #define PCI_DMA_NONE           3

 #define DEVICE_COUNT_COMPATIBLE        4
-#define DEVICE_COUNT_IRQ       2
-#define DEVICE_COUNT_DMA       2
 #define DEVICE_COUNT_RESOURCE  12

 /*

Perhaps this should be removed as well?

A quick compile and cscope didn't reveal any dependencies but it's
difficult to be positive.

Thanks,
Adam
