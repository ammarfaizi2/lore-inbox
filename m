Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271826AbRHVTlg>; Wed, 22 Aug 2001 15:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271944AbRHVTl0>; Wed, 22 Aug 2001 15:41:26 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:20229 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S271826AbRHVTlM>; Wed, 22 Aug 2001 15:41:12 -0400
Message-Id: <200108221941.f7MJfGY14365@aslan.scsiguy.com>
To: "David S. Miller" <davem@redhat.com>
cc: axboe@suse.de, skraw@ithnet.com, phillips@bonn-fries.net,
        linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch 
In-Reply-To: Your message of "Wed, 22 Aug 2001 11:46:20 PDT."
             <20010822.114620.77339267.davem@redhat.com> 
Date: Wed, 22 Aug 2001 13:41:16 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   From: "Justin T. Gibbs" <gibbs@scsiguy.com>
>   Date: Wed, 22 Aug 2001 12:32:17 -0600
>
>   I would like the change much better if the size of dma_addr_t
>   simply changed to be 64bits wide if high mem support is enabled
>   in your kernel config.
>
>Drivers for SAC only PCI devices shall not be bloated by 64-bit type,
>not in any case whatsoever.

Where's the bloat?  The driver's S/G list is in the driver's native format.
Are saying that there will be two different mapping implementation back
ends with the 32bit one possibly saving space by using 32bit only address
in whatever storage is required to record the mapping?  Since you have to
use an API call to fetch these values on a per-element basis, the 32bit back
end need only promote its 32bit values to 64bit values upon return.  On most
architectures I've seen, a load of a 32bit value from a 64bit value is still
just a 32bit move, so the fact that the returned value is a 64bit quantity
makes no difference code wise inside the driver.

>   Sure, you need the other API changes to more finely set dma characteristics
>,
>   but having two APIs just complicates life for the device driver.
>
>Either your device is 64-bit capable or not, what is so complicated?

The complication arrises when there is a performance impact associated
with 64bit support.  You may want to completely compile out 64bit support.
If I can use the exact same API if the user decides to configure my
device to not enable large address support, then my complaint is only
that it seems supurfluous to have two different APIs and types.

>   From the device driver's point of view, this wasn't the case.
>   The driver asks to have the data mapped into an address that
>   its dma engine can understand and the system is supposed to do that
>   mapping.
>
>What is the virtual address of physical address 0x100000000
>on a 32-bit cpu system if the page is not currently kmap()'d?

Why does the driver care?  The driver asked to have some virtual address
mapped into a bus address.  Are you saying the system can't understand
figure out what physical page this is and from that the necessary
IOMMU magic to make it visible to the device?

>The only portable way is to use pages.  That is what Jens's and
>my work aims to do.  The ia64 API is nonportable and works only
>on 64-bit systems.

This doesn't follow from your explanation.  Sure, you need to use
pages, but the basic information provided to the mapping calls allows
you to figure out the pages and that basic information is the same in
the new API.

It seems to me that you are complaining that the "backend" implementation
for IA64 sucked.  Okay.  Fine.  But the drivers were never exposed to
that suckage.

--
Justin
