Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbRBBRGG>; Fri, 2 Feb 2001 12:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129189AbRBBRF4>; Fri, 2 Feb 2001 12:05:56 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:17264 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129136AbRBBRFs>; Fri, 2 Feb 2001 12:05:48 -0500
Date: Fri, 2 Feb 2001 11:05:39 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Martin Diehl <mdiehlcs@compuserve.de>
cc: davej@suse.de, Linus Torvalds <torvalds@transmeta.com>, becker@scyld.com,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] minor ne2k-pci irq fix
In-Reply-To: <Pine.LNX.4.21.0102021746001.11308-100000@notebook.diehl.home>
Message-ID: <Pine.LNX.3.96.1010202110303.4820A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2001, Martin Diehl wrote:
> Sorry, wasn't clear enough. I've meant, the kernel (PCI stuff) changing
> the BAR bus address in the config space when enabling the device (i.e.
> the bus address value which is used for later mapping). Doing so would
> make the pci_resource_start() value bogus (when obtained before enabling
> the device) - even without accessing/ioremap() it.

The pci_resource_start() value is only bogus if the driver is changing
the BAR value -- which it should never do.  Enabling the device could
indeed change the BAR address... that's why pci_enable_device must
ALWAYS be called before reading pci_dev->irq and pci_resource_start()
values.

	Jeff



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
