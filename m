Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265444AbRF0XeK>; Wed, 27 Jun 2001 19:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265445AbRF0XeA>; Wed, 27 Jun 2001 19:34:00 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:715 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S265444AbRF0Xdq>;
	Wed, 27 Jun 2001 19:33:46 -0400
Message-ID: <3B3A6D80.E82A2BA6@mandrakesoft.com>
Date: Wed, 27 Jun 2001 19:34:24 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tom_gall@vnet.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes for PCI
In-Reply-To: <3B3A58FC.2728DAFF@vnet.ibm.com> <3B3A5B00.9FF387C9@mandrakesoft.com> <3B3A64CD.28B72A2A@vnet.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Gall wrote:
> Well you have device drivers like the symbios scsi driver for instance that
> tries to determine if it's seen a card before. It does this by looking at the
> bus,dev etc numbers...  It's quite reasonable for two different scsi cards to be
> on the same bus number, same dev number etc yet they are in different PCI
> domains.
> 
> Is this a device driver bug or feature?

I hesitate to call it a device driver bug, because that was likely the
best decision Gerard could make at the time.

However, I think the driver (only going by your description) would be
more correct to use a pointer to struct pci_dev.  We have a token in the
kernel that is guaranteed 100% unique to any given PCI device:  the
pointer to its struct pci_dev.


> > Changing the meaning of dev->bus->number globally seems pointless.  If
> > you are going to do that, just do it the right way and introduce another
> > struct member, pci_domain or somesuch.
> 
> Right, one could do that and then all the large machine architectures would have
> their own implementation for the same problem. That's not necessarily a bad
> thing, but some commonality I think would be a good thing.

Sorry, not pci_domain, just system bus number, for any bus, like we
talked about in the previous discussion.

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
