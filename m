Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262448AbREUKMX>; Mon, 21 May 2001 06:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262447AbREUKMN>; Mon, 21 May 2001 06:12:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43648 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262448AbREUKLz>;
	Mon, 21 May 2001 06:11:55 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15112.59880.127047.315855@pizda.ninka.net>
Date: Mon, 21 May 2001 03:11:52 -0700 (PDT)
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <20010521115631.I30738@athlon.random>
In-Reply-To: <20010520044013.A18119@athlon.random>
	<3B07AF49.5A85205F@uow.edu.au>
	<20010520154958.E18119@athlon.random>
	<3B07CF20.2ABB5468@uow.edu.au>
	<20010520163323.G18119@athlon.random>
	<15112.26868.5999.368209@pizda.ninka.net>
	<20010521034726.G30738@athlon.random>
	<15112.48708.639090.348990@pizda.ninka.net>
	<20010521105944.H30738@athlon.random>
	<15112.55709.565823.676709@pizda.ninka.net>
	<20010521115631.I30738@athlon.random>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli writes:
 > I just given you a test case that triggers on sparc64 in earlier email.

If you are talking about the bttv card:

1) I showed you in a private email that I calculated the
   maximum possible IOMMU space that one could allocate
   to bttv cards in a fully loaded Sunfire sparc64 system
   to be between 300MB and 400MB.  This is assuming that
   every PCI slot contained a bttv card, and it still
   used only ~%35 of the available IOMMU resources.

2) It currently doesn't even use the portable APIs yet anyways,
   so effectively it is not supported on sparc64.

The only other examples you showed were theoretical, for cards and
configurations that simply are not supported or cannot happen
on sparc64 with current kernels.

 > Chris just given a real world example of applications where that kind of
 > design is useful and there are certainly other kind of apps where that
 > kind of hardware design can be useful too.
 > 
 > A name of an high end pci32 card that AFIK can trigger those bugs is the
 > Quadrics which is a very nice piece of hardware btw.

I think such designs which gobble up a gig or so of DMA mappings on
pci32 are not useful in the slightest.  These cards really ought
to be using dual address cycles, ie. 64-bit PCI addressing.  It is
the same response you would give to someone trying to obtain 3 or more
gigabytes of user address space in a process on x86, right?  You might
respond to that person "What you really need is x86-64." for example
:-)

To me, from this perspective, the Quadrics sounds instead like a very
broken piece of hardware.  And in any event, is there even a Quadrics
driver for sparc64? :-)  (I'm a free software old-fart, so please
excuse my immediate association between "high end" and "proprietary"
:-)

Finally Andrea, have you even begun to consider the possible
starvation cases once we make this a resource allocation which can
fail under "normal" conditions.  Maybe the device eatins all the IOMMU
entries, immediately obtains a new mapping when he frees any mapping,
effectively keeping out all other devices.

This may be easily solved, I don't know.

But this along with the potential scsi layer issues, are basically the
reasons I'm trying hard to keep the API as it is right now for 2.4.x
Changing this in 2.4.x is going to open up Pandora's Box, really.

Later,
David S. Miller
davem@redhat.com


