Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271931AbRHVSYr>; Wed, 22 Aug 2001 14:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272073AbRHVSY1>; Wed, 22 Aug 2001 14:24:27 -0400
Received: from postfix2-1.free.fr ([213.228.0.9]:41732 "HELO
	postfix2-1.free.fr") by vger.kernel.org with SMTP
	id <S271931AbRHVSYU> convert rfc822-to-8bit; Wed, 22 Aug 2001 14:24:20 -0400
Date: Wed, 22 Aug 2001 20:21:50 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: "David S. Miller" <davem@redhat.com>
Cc: <gibbs@scsiguy.com>, <axboe@suse.de>, <skraw@ithnet.com>,
        <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>
Subject: Re: With Daniel Phillips Patch
In-Reply-To: <20010822.080540.35030343.davem@redhat.com>
Message-ID: <20010822195804.R610-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Aug 2001, David S. Miller wrote:

>    From: "Justin T. Gibbs" <gibbs@scsiguy.com>
>    Date: Wed, 22 Aug 2001 07:24:29 -0600
>
>    Is this somehow different than how large DMA is done on the ia64
>    port?  All I do is look at the size of dma_addr_t to decide whether
>    to enable high address support in my driver.  If dma_addr_t's size
>    changes, then 64bit addressing will work the same as on every other
>    Linux port.
>
> It is totally different.
>
> The ia64 method, while it worked for ia64, could not work properly on
> just about any other platform.  For example, it assumed that any
> physical address could be represented by a kernel virtual address.
> This is not true on 32-bit HIGHMEM systems.  It also assumed that
> using SAC or DAC addressing was simply a matter of "does the device
> support it", and the world is far from being that simple :-)
>
> Please see the pci64 patches for details:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/davem/PCI64/*.gz
>
> There are Documentation/DMA-mapping.txt updates, where you can read
> how to use the interfaces properly.  A handful of net and scsi drivers
> were updated to use the new API, you have examples to work with as
> well.
>
> I note that the aic7xxx won't be usable for DAC cycles on many
> platforms since not all 64-bits are significant :-(  SYM53C8XX
> has a similar limitation.  Surprisingly, the network PCI cards
> have been the absolute best about this, supporting the full 64-bits
> of DAC address in all card instances I delved into.

First, let me thank you a LLLOOOOOOTTTTT, David, for you PCI 64 bit
addressing DMA-mapping. I didn't have looked yet into your patch and
documentation update, but I will do so ASAP.

OTOH, it is a great pleasure for me to hear that you didn't forget what I
told you about the current limitation of the SYM53C8XX driver. For now,
the driver would be only able to use 40 bit addresses with all upper bits
set to zero. This doesn't fit PCI 64 bit implementation of the Alpha
Monster window for example, and probably doesn't fit most other non-Intel
PCI 64 bit implementations.

But there is an alternate solution for the SYM53C8XX driver by using up to
16 x 32 bit segment registers. This would (will) allow to address for DMA
16 x 4GB segments with all upper bits being settable for each 4GB segment.
I have this in my todo-list since months, but haven't had strong reasons
for implementing it. The strongest reasons would be that I had access to
64 bit machines with 64 bit PCI, but this isn't possible. My machine uses
a Supermicro 370 DLE Mobo that offers PCI 64 bit path, but I only have 256
MB of memory. :-(, and anyway, the thing looks like a 15 years old 32 bit
Intel-arch :-(, that doesn't support 64 bit PCI addressing. :-(

  Gérard.

