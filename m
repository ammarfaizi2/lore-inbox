Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262440AbREUKAn>; Mon, 21 May 2001 06:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262439AbREUKAf>; Mon, 21 May 2001 06:00:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:35968 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262438AbREUKA2>;
	Mon, 21 May 2001 06:00:28 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15112.59192.613218.796909@pizda.ninka.net>
Date: Mon, 21 May 2001 03:00:24 -0700 (PDT)
To: Andi Kleen <ak@suse.de>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <20010521114216.A1968@gruyere.muc.suse.de>
In-Reply-To: <20010520154958.E18119@athlon.random>
	<3B07CF20.2ABB5468@uow.edu.au>
	<20010520163323.G18119@athlon.random>
	<15112.26868.5999.368209@pizda.ninka.net>
	<20010521034726.G30738@athlon.random>
	<15112.48708.639090.348990@pizda.ninka.net>
	<20010521105944.H30738@athlon.random>
	<15112.55709.565823.676709@pizda.ninka.net>
	<20010521112357.A1718@gruyere.muc.suse.de>
	<15112.57377.723591.710628@pizda.ninka.net>
	<20010521114216.A1968@gruyere.muc.suse.de>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen writes:
 > > Certainly, when this changes, we can make the interfaces adapt to
 > > this.
 > 
 > I am just curious why you didn't consider that case when designing the
 > interfaces. Was that a deliberate decision or just an oversight?
 > [I guess the first, but why?]

I didn't want the API to do exactly what we needed it to do
but not one bit more.  I tried very hard to keep it as minimal
as possible, and I even fought many additions to the API (a few
of which turned out to be reasonable, see pci_pool threads).

To this end, since HIGHMEM is needed anyways on such machines
(ie. the "sizeof(void *)" issue), I decided to not consider that
case.

Working on pages is useful even _ignoring_ the specific issues we are
talking about.  It really is the one generic way to represent all
pieces of memory inside the kernel (regardless of HIGHMEM and similar
issues).

But I simply did not see anyone who would really make use of it in
the 2.4.x timeframe.  (and I made this estimate in the middle of
2.3.x, so I didn't even see zerocopy coming along so clearly, shrug)

 > That's currently the case, but at least on IA32 the block layer
 > must be fixed soon because it's a serious performance problem in
 > some cases (and fixing it is not very hard).

If such a far reaching change goes into 2.4.x, I would probably
begin looking at enhancing the PCI dma interfaces as needed ;-)

 > Now that will probably first use DAC
 > and not a IO-MMU, and thus not use the pci mapping API, but I would not be 
 > surprised if people came up with IO-MMU schemes for it too.
 > [actually most IA32 boxes already have one in form of the AGP GART, it's just
 > not commonly used for serious things yet]

DAC usage should go through a portable PCI dma API as well,
for the reasons you mention as well as others.  If we do this
from the beginning, there will be no chance for things like
virt_to_bus64() et al. to start sneaking into the PCI drivers :-)

Later,
David S. Miller
davem@redhat.com
