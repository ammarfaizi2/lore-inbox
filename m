Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130954AbRBJJuc>; Sat, 10 Feb 2001 04:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131326AbRBJJuW>; Sat, 10 Feb 2001 04:50:22 -0500
Received: from front7.grolier.fr ([194.158.96.57]:44712 "EHLO
	front7.grolier.fr") by vger.kernel.org with ESMTP
	id <S130954AbRBJJuJ> convert rfc822-to-8bit; Sat, 10 Feb 2001 04:50:09 -0500
Date: Sat, 10 Feb 2001 09:48:41 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ion Badulescu <ionut@cs.columbia.edu>, Alan Cox <alan@redhat.com>,
        Donald Becker <becker@scyld.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        jes@linuxcare.com
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <E14RN4r-0008IY-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10102100932360.1117-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Feb 2001, Alan Cox wrote:

> > > For non routing paths its virtually free because the DMA forced the lines
> > > from cache anyway. 
> > 
> > Are you actually sure about this? I thought DMA from PCI devices reached 
> > the main memory without polluting the L2 cache. Otherwise any large DMA 
> > transfer would kill the cache (think frame grabbers...)
> 
> DMA to main memory normally invalidates those lines in the CPU cache rather
> than the cache snooping and updating its view of them.

In PCI, it is the Memory Write and Invalidate PCI transaction that is
intended to allow core-logics to optimize DMA this way. For normal Memory
Write PCI transactions or when the core-logic is aliasing MWI to MW, the
snooping may well happen. All that stuff, very probably, varies a lot
depending on the core-logic.

As we know, in normal PCI, the target is not told about the transaction
length prior to the bursting of the data. This makes difficult for a core
logic to use cache invalidation rather than dma snooping when a normal MW
is used, thus the invention of MWI.

  Gérard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
