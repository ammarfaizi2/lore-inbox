Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264380AbRF1VAU>; Thu, 28 Jun 2001 17:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264371AbRF1VAK>; Thu, 28 Jun 2001 17:00:10 -0400
Received: from front6m.grolier.fr ([195.36.216.56]:21201 "EHLO
	front6m.grolier.fr") by vger.kernel.org with ESMTP
	id <S264323AbRF1U75> convert rfc822-to-8bit; Thu, 28 Jun 2001 16:59:57 -0400
Date: Thu, 28 Jun 2001 22:57:50 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
X-X-Sender: <groudier@>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: <tom_gall@vnet.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Changes for PCI
In-Reply-To: <3B3A6D80.E82A2BA6@mandrakesoft.com>
Message-ID: <20010628223210.Q1578-100000@>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Jun 2001, Jeff Garzik wrote:

> Tom Gall wrote:
> > Well you have device drivers like the symbios scsi driver for instance that
> > tries to determine if it's seen a card before. It does this by looking at the
> > bus,dev etc numbers...  It's quite reasonable for two different scsi cards to be
> > on the same bus number, same dev number etc yet they are in different PCI
> > domains.
> >
> > Is this a device driver bug or feature?
>
> I hesitate to call it a device driver bug, because that was likely the
> best decision Gerard could make at the time.
>
> However, I think the driver (only going by your description) would be
> more correct to use a pointer to struct pci_dev.  We have a token in the
> kernel that is guaranteed 100% unique to any given PCI device:  the
> pointer to its struct pci_dev.

The driver checks against PCI bus+dev+func in 2 situations:

1) To apply the boot order that user can set up in the controller NVRAMs.
2) To detect buggy double reporting of the same device by the kernel PCI
   code (this made lot of troubles at some time).

The great bug is to invent useless abstractions that don't match reality.
Such brain masturbation leads to confusion (hence subtle bugs)  and
useless software bloatage (thus _real_ resource wastage).

If we want to handle _real_ PCI bus domains, we just have to add a domain
number to identify a _real_ PCI device. Anything that wants to hide such
reality in some opaque data looks like brain masturbation to me.

  Gérard.

