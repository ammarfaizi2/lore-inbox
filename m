Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265500AbRF1D11>; Wed, 27 Jun 2001 23:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265501AbRF1D1Q>; Wed, 27 Jun 2001 23:27:16 -0400
Received: from [32.97.182.101] ([32.97.182.101]:29862 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265500AbRF1D1M>;
	Wed, 27 Jun 2001 23:27:12 -0400
Message-ID: <3B3A2EF9.4A44264F@vnet.ibm.com>
Date: Wed, 27 Jun 2001 14:07:37 -0500
From: Tom Gall <tom_gall@vnet.ibm.com>
X-Mailer: Mozilla 4.7 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes for PCI
In-Reply-To: <3B3A58FC.2728DAFF@vnet.ibm.com>
		<3B3A5B00.9FF387C9@mandrakesoft.com>
		<3B3A64CD.28B72A2A@vnet.ibm.com> <15162.33332.781686.45753@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"David S. Miller" wrote:

> Tom Gall writes:
>  > Right, one could do that and then all the large machine architectures would have
>  > their own implementation for the same problem. That's not necessarily a bad
>  > thing, but some commonality I think would be a good thing.
>
> Well, if the claim is that your suggested changes provide this
> "commonality", I totally disagree.

Well let me be more clear and I should have been earlier. I think encoding the system
domain into the bus value is a good approach IF and ONLY IF we're trying to avoid the
addition of a new value to pci_dev. Alternatively a new value for pci_dev is to me the
better approach.

Consider also in drivers/pci/pci.c:

The function pci_bus_exists checks based on bus numbers. This function is of course
used by pci_alloc_primary_bus, which is in turn used by pci_scan_bus. As is today, this
code can break me the second I'm onto my second PCI system domain.

Additionally there is pci_find_slot which is done by bus number and devfn number. If I
don't take into account the PCI system domain I've got problems.

To get past that either things need to be expanded out to ints from chars or a new
value for PCI system domain needs to be added. I'm happy with either, and personally I
like the later better, but the former seems more compatible.

Sure one could do some fancy bus mapping and encoding, but then I'm going to be limited
to some number of PCI system domains + buses <= 256. Not fun.

> Your changes do no more than
> provide hooks where no hooks are needed.  The hooks are there,
> and are why we have "sysdata" and all the drivers/pci/setup-*.c
> buisness.  If ppc64 cannot fit itself into the drivers/pci/setup-*.c
> infrastructure, either fix the infrastructure or concede that "our
> stuff is too weird to solve with generic code" and do what sparc64
> does with driving it's own PCI probing layer.

I need to look at this some more, perferably under the influence of more sugar and
caffeine. Fitting in is one of my primary goals. I sure as heck do NOT want to do any
changes to any directory outside of arch/ppc64 or include/asm-ppc64 than what is
absolutely needed and for good technical reason.

Regards,

Tom

--
Tom Gall - PPC64 Maintainer      "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://www.ibm.com/linux/ltc/projects/ppc


