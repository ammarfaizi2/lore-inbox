Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315577AbSECG61>; Fri, 3 May 2002 02:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315579AbSECG60>; Fri, 3 May 2002 02:58:26 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:53428 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S315577AbSECG6Y>; Fri, 3 May 2002 02:58:24 -0400
Date: Thu, 02 May 2002 23:58:01 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: William Lee Irwin III <wli@holomorphy.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <4025316919.1020383879@[10.10.2.3]>
In-Reply-To: <20020503083849.Y11414@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> IIRC, there are some funny games you can play with 32bit PCI DMA.
>> You're not necessarily restricted to the bottom 4Gb of phys addr space, 
>> you're restricted to a 4Gb window, which you can shift by programming 
>> a register on the card. Fixing that register to point to a window for the 
>> node in question allows you to allocate from a node's pg_data_t and 
>> assure DMAable RAM is returned.
> 
> if you've as many windows as the number of nodes than you're just fine
> in all cases.  you only need to teach pci_map_single and friends to
> return the right bus address that won't be an identity anymore with the
> phys addr, then you can forget the >4G phys constraint on the pages
> returned by zone_normal :).

I only have third hand information, rather than real experience in
this particular area, but I believe the general idea was to map
the window for any given card onto it's own node's physaddr space.

For a general dirty kludge, we could allocated DMAable memory by
simply doing an alloc_pages_node from node 0 (assuming a max of
4Gb in the first node ... if we really want a bounce buffer *and*
we have more than 4Gb in the first node *and* we have a 32 bit
DMA card, we can always alloc from ZONE_NORMAL on node 0 ... yes,
that's pretty disgusting ... but 99% of things will have 64 bit
DMA).

M.

