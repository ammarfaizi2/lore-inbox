Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269822AbRHIOrf>; Thu, 9 Aug 2001 10:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269825AbRHIOrZ>; Thu, 9 Aug 2001 10:47:25 -0400
Received: from willow.commerce.uk.net ([213.219.35.202]:25118 "EHLO
	willow.commerce.uk.net") by vger.kernel.org with ESMTP
	id <S269822AbRHIOrQ>; Thu, 9 Aug 2001 10:47:16 -0400
Date: Thu, 9 Aug 2001 15:45:22 +0100 (BST)
From: Corin Hartland-Swann <cdhs@commerce.uk.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jason Collins <jcollins@valinux.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Memory Problems - CTCS/memtst
In-Reply-To: <E15SJqa-0000lu-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0108091529070.18150-100000@willow.commerce.uk.net>
Organization: Commerce Internet Ltd
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan/Jason,

To recap...

On Thu, 2 Aug 2001, I wrote:
> > I have been trying to identify the cause of a number of problems we've
> > been having with a server.
> > 
> > The server consists of two Pentium III 1000/133's on a Tyan Tiger LE
> > motherboard, 4 x 1024MB PC133 ECC DIMMs and two UDMA disk drives. It is
> > running kernel 2.4.7 (unpatched, but with tailored config). To rule out
> > problems related to the large amount of memory, I temporarily removed all
> > but one of the DIMMs, leaving it with 1024MB.
> > 
> > I've been getting the usual signs of memory errors:
> > 
> >   segmentation faults
> >   "unable to handle kernel NULL pointer dereference at virtual address"
> >   kernel compilations failing
> >   random panics

On Thu, 2 Aug 2001, Jason Collins wrote:
> One way to tell whether or not your memory is the problem is by examining your
> files/coredumps for corruption.  If entire page-sized chunks have been
> substituted with chunks from other files, pages in RAM, etc, you're likely
> dealing with a kernel MM bug rather than memory corruption.  (I suppose an MMU
> bug is possible too.. sigh...)  A few bits swapped here and there points to
> hardware/faulty memory.  That's one reason why my memory checker displays that
> nice context information, so those sorts of determinations can be made.

I came up with a new way to get the problems to show up - I used the
prandom package in CTCS (generates large amounts of pseudorandom data) to
create a 2048MB file. I then used cp to copy it repeatedly to a different
disk, and then used md5sum to compare the files. Any files that differed,
I used a perl program to compare 4K blocks and indicate the number of
differing bits for each differing block.

The result was that there were differing groups of blocks in the files,
but these were always multiples of 4K blocks. This means that the problem
is not related to memory errors, but more likely to the IDE driver or
(less likely) memory management.

On Thu, 2 Aug 2001, Alan Cox wrote:
> > The BIOS has an ECC logging feature, and if I understand it correctly,
> > then there /cannot/ have been any main memory errors or they would have
> > shown up in the logs. At least not any single or double-bit errors (ECC
> > corrects single-bit and detects double-bit, doesn't it?)
> 
> ALmost certainly it should have been logged. That indicates you may have
> problems elsewhere (pci bus, drivers, motherboard, processors...) or you
> might even be triggering a kernel bug.
> 
> Try a  2.2.19 kernel just out of curiousity

The 2.2.19 kernel works without a problem. After trying a large number of
different kernels, 2.4.7-ac9 also works. I believe that this is because of
the new serverworks driver (as opposed to osb4).

So, I'm fairly convinced that the osb4 driver causes data corruption - has
anyone else experienced this?

What is the status of the new serverworks driver in 2.4.7-ac9 - is it due
to go into the main kernel soon?

Thanks,

Corin

/------------------------+-------------------------------------\
| Corin Hartland-Swann   |    Tel: +44 (0) 20 7491 2000        |
| Commerce Internet Ltd  |    Fax: +44 (0) 20 7491 2010        |
| 22 Cavendish Buildings | Mobile: +44 (0) 79 5854 0027        | 
| Gilbert Street         |                                     |
| Mayfair                |    Web: http://www.commerce.uk.net/ |
| London W1K 5HJ         | E-Mail: cdhs@commerce.uk.net        |
\------------------------+-------------------------------------/

