Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292533AbSB0O7F>; Wed, 27 Feb 2002 09:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292542AbSB0O6y>; Wed, 27 Feb 2002 09:58:54 -0500
Received: from cnxt10002.conexant.com ([198.62.10.2]:22846 "EHLO
	sophia-sousar2.nice.mindspeed.com") by vger.kernel.org with ESMTP
	id <S292533AbSB0O6o>; Wed, 27 Feb 2002 09:58:44 -0500
Date: Wed, 27 Feb 2002 15:58:27 +0100 (CET)
From: Rui Sousa <rui.p.m.sousa@clix.pt>
X-X-Sender: rsousa@sophia-sousar2.nice.mindspeed.com
To: German Gomez Garcia <german@piraos.com>
cc: =?ISO-8859-1?Q?Jos=E9?= Carlos Monteiro <jcm@netcabo.pt>,
        <linux-kernel@vger.kernel.org>, <emu10k1-devel@lists.sourceforge.net>,
        Steve Stavropoulos <steve@math.upatras.gr>,
        Daniel Bertrand <d.bertrand@ieee.org>, <dledford@redhat.com>
Subject: Re: [Emu10k1-devel] Re: Emu10k1 SPDIF passthru doesn't work if
 CONFIG_NOHIGHMEM is not enabled
In-Reply-To: <Pine.LNX.4.44.0202261626420.3953-100000@hal9000.piraos.com>
Message-ID: <Pine.LNX.4.44.0202271551370.1215-100000@sophia-sousar2.nice.mindspeed.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, German Gomez Garcia wrote:

> On 24 Feb 2002, José Carlos Monteiro wrote:
> 
> > Hi!
> > After some more careful testing, I was able to identify the exact moment
> > when the changes in the Linux kernel broke SPDIF passthru of Emu10k1
> > cards. I tested all the pre-patches between kernels 2.4.12 and 2.4.13
> > and I found that kernel 2.4.13-pre2 was the one that broke it. Up until
> > 2.4.13-pre1, everything works fine. From 2.4.13-pre2 on, passthru sound
> > is broken (if kernel option CONFIG_HIGHMEM4G or CONFIG_HIGHMEM64G is
> > used).
> >
> > According to the kernel Changelog, it appears that one of these changes
> > was the responsible for it:
> >
> > 2.4.13-pre2:
> > - Alan Cox: more merging
> > - Ben Fennema: UDF module license
> > - Jeff Mahoney: reiserfs endian safeness
> > - Chris Mason: reiserfs O_SYNC/fsync performance improvements
> > - Jean Tourrilhes: wireless extension update
> > - Joerg Reuter: AX.25 updates
> > - David Miller: 64-bit DMA interfaces
> 
> 	Does the emu10k1 driver support the new DMA interface? I've
> downloaded the patch-2.4.13-pre1-pre2.bz2 from

We allocate memory with pci_alloc_consistent() which according to
DMA-mapping.txt assures 32-bits PCI addresses. On top of that
we set a dma_mask (with pci_set_dma_mask) of 29 bits (512Mib).

> ftp://ftp.kernel.org/pub/linux/kernel/v2.4/testing/incr/
> 
> and checking it, it seems that the BIG change was the inclussion of
> David Miller 64-bit DMA. Does emu10k1 use DMA for SPDIF output?

It uses DMA for all sound input/output.

> the
> main change affecting dma when HIGHMEM is enabled is in types.h, that
> define dma_addr_t as a u64 instead of u32, so does the hardware in the
> live or the driver (or whatever :-) support that?
> 
> 	Best regards,
> 
> 	- german

The most bizzare is that in a machine with 192Mib of memory but with a 
kernel compiled with HIGHMEM support I see the same type of problems.


Rui Sousa

