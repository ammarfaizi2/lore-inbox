Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265440AbRF0W6W>; Wed, 27 Jun 2001 18:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265441AbRF0W6M>; Wed, 27 Jun 2001 18:58:12 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:33702 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265440AbRF0W5x>; Wed, 27 Jun 2001 18:57:53 -0400
Message-ID: <3B3A64CD.28B72A2A@vnet.ibm.com>
Date: Wed, 27 Jun 2001 22:57:17 +0000
From: Tom Gall <tom_gall@vnet.ibm.com>
Reply-To: tom_gall@vnet.ibm.com
Organization: IBM
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes for PCI
In-Reply-To: <3B3A58FC.2728DAFF@vnet.ibm.com> <3B3A5B00.9FF387C9@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Tom Gall wrote:
> >   The first part changes number, primary, and secondary to unsigned ints from
> > chars. What we do is encode the PCI "domain" aka PCI Primary Host Bridge, aka
> > pci controller in with the bus number. In our case we do it like this:
> >
> > pci_controller=dev->bus->number>>8) &0xFF0000
> > bus_number= dev->bus->number&0x0000FF),
> >
> >   Is this reasonable for everyone?
> 
> Why not use sysdata like the other arches?

Hi Jeff,

Well you have device drivers like the symbios scsi driver for instance that
tries to determine if it's seen a card before. It does this by looking at the
bus,dev etc numbers...  It's quite reasonable for two different scsi cards to be
on the same bus number, same dev number etc yet they are in different PCI
domains.

Is this a device driver bug or feature?

> Changing the meaning of dev->bus->number globally seems pointless.  If
> you are going to do that, just do it the right way and introduce another
> struct member, pci_domain or somesuch.

Right, one could do that and then all the large machine architectures would have
their own implementation for the same problem. That's not necessarily a bad
thing, but some commonality I think would be a good thing.
 
>         Jeff

Regards,

Tom

-- 
Tom Gall - PPC64 Maintainer      "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://www.ibm.com/linux/ltc/projects/ppc
