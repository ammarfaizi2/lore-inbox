Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266031AbRF1RAo>; Thu, 28 Jun 2001 13:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266032AbRF1RAf>; Thu, 28 Jun 2001 13:00:35 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:63204 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266031AbRF1RA3>;
	Thu, 28 Jun 2001 13:00:29 -0400
Message-ID: <3B3B62D1.A11A4444@mandrakesoft.com>
Date: Thu, 28 Jun 2001 13:01:05 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Todd Inglett <tinglett@vnet.ibm.com>
Cc: "David S. Miller" <davem@redhat.com>,
        tgall%rchland.vnet@RCHGATE.RCHLAND.IBM.COM,
        linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes for PCI
In-Reply-To: <3B3A58FC.2728DAFF@vnet.ibm.com> <15162.33158.683289.641171@pizda.ninka.net> <3B3B5FCE.EF80E5E9@vnet.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Todd Inglett wrote:
> 
> "David S. Miller" wrote:
> >
> > Tom Gall writes:
> >  >   The first part changes number, primary, and secondary to unsigned ints from
> >  > chars. What we do is encode the PCI "domain" aka PCI Primary Host Bridge, aka
> >  > pci controller in with the bus number. In our case we do it like this:
> >  >
> >  > pci_controller=dev->bus->number>>8) &0xFF0000
> >  > bus_number= dev->bus->number&0x0000FF),
> >  >
> >  >   Is this reasonable for everyone?
> >
> > This is totally unreasonable.
> 
> Well, back in the "Going beyond 256 PCI buses" thread two weeks ago when
> you argued that Linux not supporting >256 busses was a fallacy...
> 
> "David S. Miller" wrote:
> > There are only two real issues:
> >
> > 1) Extending the type bus numbers use inside the kernel.
> >
> >    Basically how most multi-controller platforms work now
> >    is they allocate bus numbers in the 256 bus space as
> >    controllers are probed. If we change the internal type
> >    used by the kernel to "u32" or whatever, we expand that
> >   available space accordingly.
> >
> >   For the lazy, basically go into include/linux/pci.h
> >   and change the "unsigned char"s in struct pci_bus into
> >   some larger type. This is mindless work.

> Yes it is mindless work and is in that patch.  Should we attempt to go
> beyond 256 physical busses in 2.4?  Maybe not.  But it is a simple
> change and it does work and it works around the existing drivers which
> compare busid+devfn for uniqueness when they really should compare
> pci_dev pointers.  Should it be redone the correct way (domains) in
> 2.5?  Absolutely.

2.5 is right around the corner, and sysdata should handle PCI
domains/segments just fine in 2.4.

Why do we need to patch 2.4 at all right now?   Since 2.5 is close I
don't think it's a big deal saying "use 2.5+ for >256 physical buses"

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
