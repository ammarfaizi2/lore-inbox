Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262421AbREUJnd>; Mon, 21 May 2001 05:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262422AbREUJnX>; Mon, 21 May 2001 05:43:23 -0400
Received: from ns.suse.de ([213.95.15.193]:60169 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S262421AbREUJnI>;
	Mon, 21 May 2001 05:43:08 -0400
Date: Mon, 21 May 2001 11:42:16 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Andrea Arcangeli <andrea@suse.de>,
        Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010521114216.A1968@gruyere.muc.suse.de>
In-Reply-To: <20010520154958.E18119@athlon.random> <3B07CF20.2ABB5468@uow.edu.au> <20010520163323.G18119@athlon.random> <15112.26868.5999.368209@pizda.ninka.net> <20010521034726.G30738@athlon.random> <15112.48708.639090.348990@pizda.ninka.net> <20010521105944.H30738@athlon.random> <15112.55709.565823.676709@pizda.ninka.net> <20010521112357.A1718@gruyere.muc.suse.de> <15112.57377.723591.710628@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15112.57377.723591.710628@pizda.ninka.net>; from davem@redhat.com on Mon, May 21, 2001 at 02:30:09AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 02:30:09AM -0700, David S. Miller wrote:
> 
> Andi Kleen writes:
>  > On the topic of to the PCI DMA code: one thing I'm missing
>  > are pci_map_single()/pci_map_sg() that take struct page * instead of
>  > of direct pointers. Currently I don't see how you would implement IO-MMU IO
>  > on a 32bit box with more than 4GB of memory, because the address won't
>  > fit into the pointer.
> 
> How does the buffer get there in the first place? :-)

I guess you know ;)

e.g. via page table tricks from user space, like the PAE mode on IA32
or via kmap.

> Certainly, when this changes, we can make the interfaces adapt to
> this.

I am just curious why you didn't consider that case when designing the
interfaces. Was that a deliberate decision or just an oversight?
[I guess the first, but why?]

> 
> Because of this, for example, the sbus IOMMU stuff on sparc32 still
> uses HIGHMEM exactly because of this pointer limitation.  In fact,
> any machine using >4GB of memory currently cannot be supported without
> highmem enabled, which is going to enable bounce buffering in the block
> I/O layer, etc.

That's currently the case, but at least on IA32 the block layer must be
fixed soon because it's a serious performance problem in some cases
(and fixing it is not very hard). Now that will probably first use DAC
and not a IO-MMU, and thus not use the pci mapping API, but I would not be 
surprised if people came up with IO-MMU schemes for it too.
[actually most IA32 boxes already have one in form of the AGP GART, it's just
not commonly used for serious things yet]

-Andi
