Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314984AbSECXxY>; Fri, 3 May 2002 19:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315048AbSECXxX>; Fri, 3 May 2002 19:53:23 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:13298 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S314984AbSECXxW>;
	Fri, 3 May 2002 19:53:22 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15571.8922.257609.977745@napali.hpl.hp.com>
Date: Fri, 3 May 2002 16:52:58 -0700
To: Anton Blanchard <anton@samba.org>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
        Jesse Barnes <jbarnes@sgi.com>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
In-Reply-To: <20020502002010.GA14243@krispykreme>
X-Mailer: VM 7.03 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Looks like this buffer was laying dormant in my Emacs and never sent.
 Hence the delay... ;-) ]

>>>>> On Thu, 2 May 2002 10:20:11 +1000, Anton Blanchard <anton@samba.org> said:

  >> so ia64 is one of those archs with a ram layout with huge holes
  >> in the middle of the ram of the nodes? I'd be curious to know
  >> what's the hardware advantage of designing the ram layout in such
  >> a way, compared to all other numa archs that I deal with. Also if
  >> you know other archs with huge holes in the middle of the ram of
  >> the nodes I'd be curious to know about them too. thanks for the
  >> interesting info!

  >> From arch/ppc64/kernel/iSeries_setup.c:

  Anton>  * The iSeries may have very large memories ( > 128 GB ) and
  Anton> a partition * may get memory in "chunks" that may be anywhere
  Anton> in the 2**52 real * address space.  The chunks are 256K in
  Anton> size.

  Anton> Also check out CONFIG_MSCHUNKS code and see why I'd love to
  Anton> see a generic solution to this problem.

Me too.  HP's zx1 platform also has a rather giant hole above the 1GB
boundary.  I don't know the exact reasons for this hole, but it's
related to the fact that (many) PCI devices need <4GB memory.

The current solution for zx1 is to place the mem_map in virtual
memory.  This obviously increases TLB pressure when touching lots of
mem_map[] entries randomly, but I haven't really seen any benchmarks
so far (real or artificial) where this has a signifcant performance
effect.  The nice part of this approach is that it is a rather general
solution, provided the kernel's page-table mapped address space is
sufficiently big.

	--david
