Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272125AbRHVVKm>; Wed, 22 Aug 2001 17:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272119AbRHVVKc>; Wed, 22 Aug 2001 17:10:32 -0400
Received: from postfix2-2.free.fr ([213.228.0.140]:12040 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S272128AbRHVVKQ> convert rfc822-to-8bit; Wed, 22 Aug 2001 17:10:16 -0400
Date: Wed, 22 Aug 2001 23:07:47 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: "David S. Miller" <davem@redhat.com>
Cc: <gibbs@scsiguy.com>, <axboe@suse.de>, <skraw@ithnet.com>,
        <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>
Subject: Re: With Daniel Phillips Patch 
In-Reply-To: <20010822.114620.77339267.davem@redhat.com>
Message-ID: <20010822223658.X932-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Aug 2001, David S. Miller wrote:

>    From: "Justin T. Gibbs" <gibbs@scsiguy.com>
>    Date: Wed, 22 Aug 2001 12:32:17 -0600
>
>    I would like the change much better if the size of dma_addr_t
>    simply changed to be 64bits wide if high mem support is enabled
>    in your kernel config.
>
> Drivers for SAC only PCI devices shall not be bloated by 64-bit type,
> not in any case whatsoever.
>
>    Sure, you need the other API changes to more finely set dma characteristics,
>    but having two APIs just complicates life for the device driver.
>
> Either your device is 64-bit capable or not, what is so complicated?
> Each driver I converted was like 15 minutes or work, at best!
>
>    From the device driver's point of view, this wasn't the case.
>    The driver asks to have the data mapped into an address that
>    its dma engine can understand and the system is supposed to do that
>    mapping.
>
> What is the virtual address of physical address 0x100000000
> on a 32-bit cpu system if the page is not currently kmap()'d?
>
> Answer: it doesn't exist.

I seem to understand that Justin's is referring to the DMA related API of
BSD O/Ses that, I believe, originates from NetBSD. Just, the Linux
approach seems to make the hypothesis that 32 bits addressing will still
have a long life. Note that my guess is also that most low end servers and
personnal computers may well still use less than 4 GB and so 32 bit
addressable for a long time. This let me prefer the Linux differentiation,
at the moment, given that O/S vendors provides binaries and donnot
encourage users to recompile the kernel and modules. We probably donnot
want more than 99% of real machines to waste uselessly with 64 bit
quantities just for some source program aesthetic considerations.

And I seem to understand that David's preferred SUN hardware only allows
streaming when using SAC with IOMMU.:-)

And using DAC is 1 PCI cycle lost per transaction and if we are
picky on performances ...

> The only portable way is to use pages.  That is what Jens's and
> my work aims to do.  The ia64 API is nonportable and works only
> on 64-bit systems.
>
>    >It also assumed that using SAC or DAC addressing was simply a matter of
>    >"does the device support it", and the world is far from being that simple :-)
>
>    Can you enumerate the devices that actually issue a DAC when loaded with
>    a 64bit address with 0's in the most significant 32bits?
>
> Sym53c8xx does this.  You have to configure it to do SAC or DAC
> for data, descriptors use SAC always.

Note that the manual says that the device will not use DAC if higher 32
bits are zero. Nor I remember of any errata about the device behaving
this way. But, as sym53c8xx device actually trying to do 64 bit PCI
addressing should have been pretty rare for now, not all errata on this
point should have been discovered (just trying to guess ...).

[...]

Later,
  Gérard.

