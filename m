Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272179AbRHWBtl>; Wed, 22 Aug 2001 21:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272181AbRHWBtb>; Wed, 22 Aug 2001 21:49:31 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:7 "EHLO aslan.scsiguy.com")
	by vger.kernel.org with ESMTP id <S272179AbRHWBtS>;
	Wed, 22 Aug 2001 21:49:18 -0400
Message-Id: <200108230149.f7N1nKY22862@aslan.scsiguy.com>
To: "David S. Miller" <davem@redhat.com>
cc: groudier@free.fr, axboe@suse.de, skraw@ithnet.com, phillips@bonn-fries.net,
        linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch 
In-Reply-To: Your message of "Wed, 22 Aug 2001 18:39:12 PDT."
             <20010822.183912.61335222.davem@redhat.com> 
Date: Wed, 22 Aug 2001 19:49:20 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   From: "Justin T. Gibbs" <gibbs@scsiguy.com>
>   Date: Wed, 22 Aug 2001 19:32:46 -0600
>
>   Perhaps its different for SBUS, but its not different for ISA
>   or EISA.
>
>Right, you pass in a NULL pci_dev pointer.  What is the
>problem with that?

I don't have the same lattitude to express dma characteristics of
broken, non-PCI devices.  For instance, I can't set the "dma mask"
for a VLB card (say some early BusLogic 445) that had some DMA bugs.
I have to treat it like an ISA card even if it may have problems
with DMAs below the typical ISA dma limit.

>   Do you believe that it is architecturally correct to have a single
>   api or multiple apis?
>
>I think just plain different entry points are the way to do things,
>because function pointers and/or extra conditional execution rots when
>it's really not needed.

That needent be the case.  If I can use a single API to define the
DMA characteristics of my device, and the system knows where it
is in the bus hierarchy (and all the warts of the bridges along
the way, etc.), the magic to do the mapping can be hidden from me
and I don't need to have multiple APIs or code paths.  I just pass
a "dma descriptor" that has the necessary info for that type of
dma operation on that platform, and the system does the rest.  This
even allows a device to allocate multiple descriptors to handle its
different operations (bulk data is 64bit capable, transaction descriptors
need to be handled with 24bit addresses, etc.).

>   The "pci" api already allows you to express this.
>
>There will be a "struct device" in 2.5.x and lots of unification.

That's good to know.

--
Justin
