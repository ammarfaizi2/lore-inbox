Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261701AbREUHF7>; Mon, 21 May 2001 03:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261705AbREUHFs>; Mon, 21 May 2001 03:05:48 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28832 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261701AbREUHFn>;
	Mon, 21 May 2001 03:05:43 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15112.48708.639090.348990@pizda.ninka.net>
Date: Mon, 21 May 2001 00:05:40 -0700 (PDT)
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <20010521034726.G30738@athlon.random>
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru>
	<20010519155502.A16482@athlon.random>
	<20010519231131.A2840@jurassic.park.msu.ru>
	<20010520044013.A18119@athlon.random>
	<3B07AF49.5A85205F@uow.edu.au>
	<20010520154958.E18119@athlon.random>
	<3B07CF20.2ABB5468@uow.edu.au>
	<20010520163323.G18119@athlon.random>
	<15112.26868.5999.368209@pizda.ninka.net>
	<20010521034726.G30738@athlon.random>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli writes:
 > On Sun, May 20, 2001 at 06:01:40PM -0700, David S. Miller wrote:
 > > No, the interface says that the DMA routines may not return failure.
 > 
 > The alpha returns a faliure since day zero of iommu support, the sparc64
 > has too otherwise it's even more buggy than alpha when the machine runs
 > out of pci virtual address space.

So what?  I frankly don't care what alpha or any platform happens to
do.  The Documentation/DMA-mapping.txt document says absolutely
nothing about these routines ever failing nor what a failure value
would be.  If you ask David Mosberger and the ia64 people, the PPC
folks, or even HPPA port team, they will all show no surprise when
told that these routines may not fail.  I talked to them, along with
Richard, about this issue at length when the DMA stuff was put
together.  And it was agreed upon that the routines will not allow
failure in 2.4.x and we would work on resolving this in 2.5.x and no
sooner.

THIS DMA-mapping.txt document is the specification of the behavior of
these DMA interfaces, and the driver author may only assume the
behavior described in that document.

If Alpha does something different, that's a feature.

 > About the pci_map_single API I'd like if bus address 0 would not be the
 > indication of faluire, mainly on platforms without an iommu that's not
 > nice, x86 happens to get it right only because the physical page zero is
 > reserved for completly other reasons. so we either add a err parameter
 > to the pci_map_single, or we define a per-arch bus address to indicate
 > an error, either ways are ok from my part.

I'm more than happy to add the per-arch define (which would be zero
on all platforms right now, so this exercise is %100 academic :-)))))

But I will NOT add the change that the pci_map_*() interfaces may
fail in 2.4.x, this is an unacceptable API change.  Reasons are
starting with the scsi layer issues Gerard mentioned, and I knew
about this kind of crap when I designed the API.  We can work on a
failure mode for this stuff, but it is 2.5.x material, no sooner.

Later,
David S. Miller
davem@redhat.com
