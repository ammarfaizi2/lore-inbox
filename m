Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269778AbRHMD3e>; Sun, 12 Aug 2001 23:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269781AbRHMD3Z>; Sun, 12 Aug 2001 23:29:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24966 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269778AbRHMD3P>;
	Sun, 12 Aug 2001 23:29:15 -0400
Date: Sun, 12 Aug 2001 20:29:18 -0700 (PDT)
Message-Id: <20010812.202918.48532196.davem@redhat.com>
To: torvalds@transmeta.com
Cc: andrea@suse.de, eyal@eyal.emu.id.au, linux-kernel@vger.kernel.org
Subject: Re: 2.4.8aa1
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0108121003520.15697-100000@penguin.transmeta.com>
In-Reply-To: <20010812190202.H737@athlon.random>
	<Pine.LNX.4.33.0108121003520.15697-100000@penguin.transmeta.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Sun, 12 Aug 2001 10:21:58 -0700 (PDT)
   
   On Sun, 12 Aug 2001, Andrea Arcangeli wrote:
   > So I believe a kind of page_to_bus64 should be implemented, and it should
   > possibly return dma64_addr_t typedeffed as 'unsigned long long'.
   
   Fair enough, that sounds like a good idea too.
   
I agree with the dma64_addr_t type, but I don't know if I agree
with the logistics of how drivers go about doing things and what
the interfaces are that an architecture implements.

First, maybe I'm confused about intent.  Are we trying to just hack
together something quick for 2.4.x that allows PCI drivers on highmem
machines to get at the complete low 4GB of physical memory, even the
highmem parts?

If this is the case, then I have no strong opinions about what you do
because I know I will be able to retrofit my ports into whatever
interfaces you come up with for that (f.e. the pci_kmap()/pci_kunmap()
stuff).

But if this is more far reaching, ie. a 64-bit addressing API for
drivers, my thinking is that this is a larger problem to solve.

For example, if you're talking seriously about sending page/off/len
triplets to the drivers (which is what we want in the end), then with
that I can whip together something really nice and portable in about
a weekend of thinking and hacking.

The only reason I haven't done this work yet is strictly because the
drivers aren't getting pages yet (well, the zerocopy aware networking
drivers are).  It was my understanding that this is the bit that Jens
Axboe and Andrea are working on.

Later,
David S. Miller
davem@redhat.com

