Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133113AbRDRRVF>; Wed, 18 Apr 2001 13:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135222AbRDRRUz>; Wed, 18 Apr 2001 13:20:55 -0400
Received: from ns.caldera.de ([212.34.180.1]:62217 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S133113AbRDRRUp>;
	Wed, 18 Apr 2001 13:20:45 -0400
Date: Wed, 18 Apr 2001 19:20:36 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Marcus Meissner <Marcus.Meissner@caldera.de>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] misplaced pci_enable_device()s in drivers/sound/
Message-ID: <20010418192036.A30279@caldera.de>
In-Reply-To: <20010418182944.A25024@caldera.de> <3ADDC716.7F5B43C8@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <3ADDC716.7F5B43C8@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Apr 18, 2001 at 12:55:50PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2001 at 12:55:50PM -0400, Jeff Garzik wrote:
> Marcus Meissner wrote:
> > Several pci_enable_device()s in drivers/sound happen _after_ accessing
> > PCI resources. I have moved them before the relevant first accesses.
> 
> cool
> 
> >         if (!RSRCISIOREGION(pcidev, 0))
> >                 return -1;
> 
> can you replace this mess while you are cleaning stuff up.  this, for
> example, should be
> 	if (!(pci_resource_flags(pcidev,) & IORESOURCE_IO))
> 
> There is also pci_resource_start and pci_resource_len.
> 
> >         iobase = SILLY_PCI_BASE_ADDRESS(pcidev);
> 
> pci_resource_start

THere is also some pci dma stuff which probably got changed.

> patch looks ok to me, but those would be nice additions...

I am a bit afraid to break stuff doing this without testing, but I will
do it for the cards I have access to.

Is there a 'HOW TO DO IT' PCI driver?

drivers/net/pci-skeleton.c looks up to date, is it?

Ciao, Marcus
