Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265870AbRF2Lr6>; Fri, 29 Jun 2001 07:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265866AbRF2Lrt>; Fri, 29 Jun 2001 07:47:49 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:5769 "EHLO
	e32.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265868AbRF2Lrm>; Fri, 29 Jun 2001 07:47:42 -0400
Message-ID: <3B3BF2AB.D95DCEC3@vnet.ibm.com>
Date: Thu, 28 Jun 2001 22:14:51 -0500
From: Tom Gall <tom_gall@vnet.ibm.com>
X-Mailer: Mozilla 4.7 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes for PCI
In-Reply-To: <3B3A58FC.2728DAFF@vnet.ibm.com> <3B3A5B00.9FF387C9@mandrakesoft.com> <3B3A64CD.28B72A2A@vnet.ibm.com> <15162.33332.781686.45753@pizda.ninka.net> <3B3A2EF9.4A44264F@vnet.ibm.com> <20010628222201.A2521@twiddle.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Richard Henderson wrote:

> On Wed, Jun 27, 2001 at 02:07:37PM -0500, Tom Gall wrote:
> > Consider also in drivers/pci/pci.c:
> >
> > The function pci_bus_exists checks based on bus numbers. This function is
> > of course used by pci_alloc_primary_bus, which is in turn used by
> > pci_scan_bus. As is today, this code can break me the second I'm
> > onto my second PCI system domain.
>
> You'll find that the existing ports that support multiple pci
> domains do not number the busses on the secondary domains from
> zero.  If domain 0 has 3 busses, then domain 1's root bus will
> be bus number 3, and so on.

Yes I've looked at this in depth, and it does work well to compact things down
and conserve on the precious and limited bus numbers.

> This approach works quite well in practice, even on machines
> with large numbers of pci domains, since there tends to be no
> pci-pci busses on domains other than the one containing legacy
> i/o widgetry.

We have pci-pci bridges in every PCI system domain. Additionally we have cards
that have pci-pci bridges on them and certainly they can be plugged in anywhere
on the system.

Unfortunately the majority of our problem is centered on the fact that in the
end we have more than 256 buses. I look forward to this limit disappearing in
2.5.

Regards,

Tom

--
Tom Gall - PPC64 Maintainer      "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://www.ibm.com/linux/ltc/projects/ppc


