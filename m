Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSHBReP>; Fri, 2 Aug 2002 13:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSHBReP>; Fri, 2 Aug 2002 13:34:15 -0400
Received: from mail.esstech.com ([64.152.86.3]:9108 "HELO [64.152.86.3]")
	by vger.kernel.org with SMTP id <S313571AbSHBReN>;
	Fri, 2 Aug 2002 13:34:13 -0400
Subject: ide prd table size
From: Gerald Champagne <gerald.champagne@esstech.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 02 Aug 2002 12:30:46 -0500
Message-Id: <1028309451.29024.659.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a question about the calculation of the PRD_ENTRIES constant used
in the ide code  The documentation for the size of PRD_ENTRIES says
this:
-----------------------------
/*
Our Physical Region Descriptor (PRD) table should be large enough to
handle the biggest I/O request we are likely to see.  Since requests can
have no more than 256 sectors, and since the typical blocksize is two or
more sectors, we could get by with a limit of 128 entries here for the
usual worst case.  Most requests seem to include some contiguous blocks,
further reducing the number of table entries required.

As it turns out though, we must allocate a full 4KB page for this, so
the two PRD tables (ide0 & ide1) will each get half of that, allowing
each to have about 256 entries (8 bytes each) from this.
*/
#define PRD_BYTES	8
#define PRD_ENTRIES	(PAGE_SIZE / (2 * PRD_BYTES))
-----------------------------


This looks a little outdated, but I'm interested in the second
paragraph.  I don't see where multiple interfaces are sharing the same
page.  The documentation here and for pci_alloc_consistent says that
blocks are allocated in full pages.  This implies that the unused
portion is wasted.

So...

- Is the code wasting half of the page, and should PRD_ENTRIES be
redefined to be larger?

- Am I misunderstanding the documentation, and is the other half of the
page used somewhere else?

- Am I misunderstanding the code, and do multiple interfaces share the
page?

- Should this be modified to use the pci_pool interface as defined in
DMA-mapping.txt?

Thanks!

Gerald





