Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281963AbRKUUGE>; Wed, 21 Nov 2001 15:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281965AbRKUUFx>; Wed, 21 Nov 2001 15:05:53 -0500
Received: from postfix2-2.free.fr ([213.228.0.140]:11730 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S281963AbRKUUFp> convert rfc822-to-8bit; Wed, 21 Nov 2001 15:05:45 -0500
Date: Wed, 21 Nov 2001 18:19:27 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Anton Blanchard <anton@samba.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] small sym-2 fix
In-Reply-To: <20011121131900.B13279@krispykreme>
Message-ID: <20011121175658.I1828-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Nov 2001, Anton Blanchard wrote:

> Hi,
>
> > Linux/ppc64 looks strange invention to me. As you know IO base addresses
> > are limited to 32 bit in PCI. And, btw, 32 bits seems to work just fine
> > here as PPC is defined from the driver as using normal IO. But, IIRC, the
> > strange Linux/PPC invention only supports MMIO. :-)
>
> Since all PCI IO is memory mapped on ppc64, IO addresses end up > 32 bits.
> Until recently we used to have an IO offset that we added to all accesses
> which kept the driver visible IO addresses < 32 bits. (This is still the
> case with ppc32)
>
> The change was made to support error handling, the 64 bit token has the
> pci bus,dev,fn embedded in it so that the low level IO routines can do
> error recovery if in{b,w,l} fails.

When it happens to implement a driver that involves both C code and some
firmware that works on the PCI-chip, using opaque handles as for C is not
enough. If you think your driver only with those abstractions, you will
get a bag of bits that does not work.

In such situations C abstractions are just dreams of some ideal world that
does not exists and that will never do. Having in mind and in some places
of the code the _reality_ is required if you want your stuff to have
chance to work.

> I didnt make these changes and it would seem we can link IO address <->
> pci bus,dev,fn in other ways, if it turns out many drivers cannot use u64
> for IO ports then we will have to investigate them.

The sym driver can do all what I wrote about regarding DMA addressing,
given expected kernel interfaces and appropriate hardware.

> > If you want to play with _explicit_ MMIO, you just have to remove a couple
> > of line from sym53c8xx.h. Here they are:
>
> Yes MMIO works fine. Is there a reason we force PCI IO on __powerpc__?

My opinion, may-be just 0.02 euros:

At the time of early PPC port, only a few courageous PCI device drivers
wanted to default to PCI-recommended MMIO. There were a least 1 driver
that wanted so, but not may more :). At this early time, the MMIO kernel
interface in ppc port was not behaving as expected and MMIO wasn't usable.
This lasted years. I would be very glad if MMIO related kernel interface
is now fine, but allow me to still doubt a bit about.

If Linux/ppc team can ensure that Linux/ppc is now ok for MMIO, then you
can send the corresponding patch, that default PPC to MMIO as seen by the
driver, to kernel maintainer(s) with my _full_ approbation.

Regards,
  Gérard.

