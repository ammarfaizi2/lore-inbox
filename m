Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269238AbRH3BSz>; Wed, 29 Aug 2001 21:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271135AbRH3BSq>; Wed, 29 Aug 2001 21:18:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:35978 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269238AbRH3BSg>;
	Wed, 29 Aug 2001 21:18:36 -0400
Date: Wed, 29 Aug 2001 18:18:52 -0700 (PDT)
Message-Id: <20010829.181852.98555095.davem@redhat.com>
To: linux-kernel@vger.kernel.org
CC: axboe@suse.de, rth@redhat.com, davidm@hpl.hp.com
Subject: [UPDATE] 2.4.10-pre2 PCI64, API changes README
From: "David S. Miller" <davem@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, new patch up on kernel.org against 2.4.10-pre2:

ftp.kernel.org:/pub/linux/kernel/davem/PCI64/pci64-2.4.10p2-1.patch.gz

The major change in this release is that the API has been redone.
After considering feedback on this list, and in particular feedback
from David Mosberger in private emails, I redid things to match the
simplifications suggested without losing sight of the goals I had.

Basically, what has changed is that nothing changes :-)  There are no
longer pci64_foo() interfaces, a normal drivers use dma_addr_t and
pci_foo() for 32-bit and 64-bit drivers.

If you have a "weird device" which requires a large DMA address space,
the solution is provided in a set of pci_dac_*() interfaces.  These
are like "virt_to_bus()" for PCI DAC but with cache coherency,
HIGHMEM, and other portability issues kept in mind.

I could just regurgitate the DMA-mapping.txt changes, but I think it's
better for folks to just go look at what is written there.

Also, I integrated the Alpha bits from Richard.  He wrote his stuff
against the old API, so I had to whack it into the new stuff.  So if
there are any build problems or bugs, they are mine and mine alone.

If you look at the driver changes now, they are more about
initialization changes and using dma_addr_t more consistently.
But that's about it.

Jens should be making a nobounce patch relative to this some time
soon.

Enjoy, and please send feedback and success/failure reports.  Thanks.

Later,
David S. Miller
davem@redhat.com

