Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132133AbRCVSxH>; Thu, 22 Mar 2001 13:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132136AbRCVSw6>; Thu, 22 Mar 2001 13:52:58 -0500
Received: from hood.tvd.be ([195.162.196.21]:748 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S132133AbRCVSww>;
	Thu, 22 Mar 2001 13:52:52 -0500
Date: Thu, 22 Mar 2001 19:51:45 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Gérard Roudier <groudier@club-internet.fr>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: st corruption with 2.4.3-pre4
In-Reply-To: <Pine.LNX.4.10.10103202029370.1698-100000@linux.local>
Message-ID: <Pine.LNX.4.05.10103221947120.552-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2001, Gérard Roudier wrote:
> On Tue, 20 Mar 2001, Geert Uytterhoeven wrote:
> > On Tue, 20 Mar 2001, Geert Uytterhoeven wrote:
> > > On Mon, 19 Mar 2001, Jeff Garzik wrote:
> > I did some more tests:
> >   - The problem also occurs when tarring up files from a disk on the Sym53c875.
> >   - The corrupted data always occurs at offset 32*x (the `+1' above was caused
> >     by hexdump, starting counting at 1).
> >   - The 32 bytes of corrupted data at offset 32*x are always a copy of the data
> >     at offset 32*x-10240.
> >   - Since 10240 is the default blocksize of tar (bug in tar?), I made a tarball
> >     on disk instead of on tape, but no corruption.
> >   - 32 is the size of a cacheline on PPC. Is there a missing cacheflush
> >     somewhere in the Sym53c875 driver? But then it should happen on disk as
> >     well?
> 
> The only PCI transaction that requires the cache line size to be correctly
> configured is PCI WRITE and INVALIDATE. This transaction may be used by
> the 875 only for data read from a SCSI device and DMAed to memory.
> 
> Note that the controller may use optimized PCI transactions only if the 
> cache line size is configured in its PCI device configuration space.
> Otherwise only normal PCI memory read and PCI memory write transactions 
> will be used.
> 
> Could you check if the cache line size is configured for your 875?

It's set to 0 :-(

> Let me imagine it is so. Btw, I may be wasting my time if it is not ...
> Then the 875 may also use PCI read multiple transactions and/or PCI read
> line transactions when reading data from memory. If the corruption is due
> to the use of these transactions, the the PCI-HOST bridges may well be the
> culprit, in my opinion.
> 
> Anyway, since the sym53c8xx driver does not try to change the configured
> cache line size on PPC, I would suggest to try again the same tests with
> the cache line size set to zero for the 875. You may hack the driver code
> or the PPC pci code if needed, for example, for value zero to be written
> in the proper place in the PCI configuration space of the 875.

So this is not the case.

Any more clues? I want to try different tape drives as well, but so far the
first batch of old DDS drives I found at work seem to be no longer functional.
Let's fetch some other drives tomorrow :-)

BTW, I tried my good old 2.4.0-test1-ac10 kernel from June 2000, and it also
suffered from the same problem. Also note that I did read/write tests on the
tape drive when I just bought it and when I installed the Sym53c875 later, and
I never noticed the problem. So I'm still willing to believe it's a software
bug in recent(?) kernels...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

