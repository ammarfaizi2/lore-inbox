Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbREUJaa>; Mon, 21 May 2001 05:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262419AbREUJaU>; Mon, 21 May 2001 05:30:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19072 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262418AbREUJaN>;
	Mon, 21 May 2001 05:30:13 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15112.57377.723591.710628@pizda.ninka.net>
Date: Mon, 21 May 2001 02:30:09 -0700 (PDT)
To: Andi Kleen <ak@suse.de>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <20010521112357.A1718@gruyere.muc.suse.de>
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
	<20010521112357.A1718@gruyere.muc.suse.de>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen writes:
 > On the topic of to the PCI DMA code: one thing I'm missing
 > are pci_map_single()/pci_map_sg() that take struct page * instead of
 > of direct pointers. Currently I don't see how you would implement IO-MMU IO
 > on a 32bit box with more than 4GB of memory, because the address won't
 > fit into the pointer.

How does the buffer get there in the first place? :-)

Yes, the zerocopy stuff is capable of doing this.  But the block
I/O layer is not, neither is any other subsystem to my knowledge.

Certainly, when this changes, we can make the interfaces adapt to
this.

Because of this, for example, the sbus IOMMU stuff on sparc32 still
uses HIGHMEM exactly because of this pointer limitation.  In fact,
any machine using >4GB of memory currently cannot be supported without
highmem enabled, which is going to enable bounce buffering in the block
I/O layer, etc.

Later,
David S. Miller
davem@redhat.com
