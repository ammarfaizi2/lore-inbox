Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272026AbRHVPGr>; Wed, 22 Aug 2001 11:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272025AbRHVPGh>; Wed, 22 Aug 2001 11:06:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:17066 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272028AbRHVPGR>;
	Wed, 22 Aug 2001 11:06:17 -0400
Date: Wed, 22 Aug 2001 08:05:40 -0700 (PDT)
Message-Id: <20010822.080540.35030343.davem@redhat.com>
To: gibbs@scsiguy.com
Cc: axboe@suse.de, skraw@ithnet.com, phillips@bonn-fries.net,
        linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200108221324.f7MDOTY10490@aslan.scsiguy.com>
In-Reply-To: <20010822084649.F604@suse.de>
	<200108221324.f7MDOTY10490@aslan.scsiguy.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Justin T. Gibbs" <gibbs@scsiguy.com>
   Date: Wed, 22 Aug 2001 07:24:29 -0600
   
   Is this somehow different than how large DMA is done on the ia64
   port?  All I do is look at the size of dma_addr_t to decide whether
   to enable high address support in my driver.  If dma_addr_t's size
   changes, then 64bit addressing will work the same as on every other
   Linux port.

It is totally different.

The ia64 method, while it worked for ia64, could not work properly on
just about any other platform.  For example, it assumed that any
physical address could be represented by a kernel virtual address.
This is not true on 32-bit HIGHMEM systems.  It also assumed that
using SAC or DAC addressing was simply a matter of "does the device
support it", and the world is far from being that simple :-)

Please see the pci64 patches for details:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/PCI64/*.gz

There are Documentation/DMA-mapping.txt updates, where you can read
how to use the interfaces properly.  A handful of net and scsi drivers
were updated to use the new API, you have examples to work with as
well.

I note that the aic7xxx won't be usable for DAC cycles on many
platforms since not all 64-bits are significant :-(  SYM53C8XX
has a similar limitation.  Surprisingly, the network PCI cards
have been the absolute best about this, supporting the full 64-bits
of DAC address in all card instances I delved into.

Later,
David S. Miller
davem@redhat.com
