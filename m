Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268695AbUIXLmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268695AbUIXLmt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 07:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268696AbUIXLmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 07:42:49 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:26556 "EHLO
	merkurneu.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id S268695AbUIXLmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 07:42:45 -0400
Date: Fri, 24 Sep 2004 21:42:06 +1000 (EST)
From: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
X-X-Sender: gc1007@fb07-calculator.math.uni-giessen.de
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: lost memory on a 4GB amd64
In-Reply-To: <200409241041.08975.andrew@walrond.org>
Message-Id: <Pine.LNX.4.58.0409242126450.16306@fb07-calculator.math.uni-giessen.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au>
 <Pine.LNX.4.58.0409241856120.16011@fb07-calculator.math.uni-giessen.de>
 <200409241127.38529.rjw@sisk.pl> <200409241041.08975.andrew@walrond.org>
Organization: University of Giessen * Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004, Andrew Walrond (AW) wrote:

AW> On Friday 24 Sep 2004 10:27, Rafael J. Wysocki wrote:
AW> >
AW> > > AW> cpu1's bank. How are yours arranged?
AW> > >
AW> > > my board has only four banks, each of them has a 1GB module sitting.
AW> > > (page 26 of ftp://ftp.tyan.com/manuals/m_s2875_102.pdf)
AW> >
AW> > Which is what makes the difference, I think.  IMO, the problem is that
AW> > _both_ CPUs use the same memory bank that is physically attached to only
AW> > one of them which leads to conflicts, apparently (the CPU with memory has
AW> > also PCI/AGP/whatever attached to it via HyperTransport so I can imagine
AW> > there may be issues with overlapping address spaces etc.).  I'd bet that
AW> > there's something wrong either with the BIOS or with the board design
AW> > itself and I don't think there's anything that the kernel can do about it
AW> > (usual disclaimer applies).
AW> >
AW> > Out of couriosity: have you tried to run the kernel with K8 NUMA enabled?
AW> >

yes.

AW> Actually, the block diagram on page 9 of the manual suggests that this is 
AW> _not_ a NUMA board, since all DIMMS are connected to cpu1. The block diagram 
AW> for my thunder k8w specifically shows DIMMS associated with individual 
AW> processors.
AW> 
AW> Which suggests that NUMA show be _disabled_ in the kernel config.

hmm. 

AW> Have you tried it with NUMA disabled? I think I remeber it being on in 
AW> the .config you sent me.

NUMA was enabled all the time (at least most of the time). I don't know if 
I ever ran it without NUMA. I'll certainly try that.

Unfortunately, I won't be able to do any reboots during the next one or 
two weeks since the machine has gone into stable operation tonight. (with 
some loss of memory for now)

if it is of some interest, that's what dmesg tells about NUMA:

     BIOS-provided physical RAM map:
      BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
      BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
      BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
      BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
      BIOS-e820: 00000000bfff0000 - 00000000bffff000 (ACPI data)
      BIOS-e820: 00000000bffff000 - 00000000c0000000 (ACPI NVS)
      BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
      BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
     Scanning NUMA topology in Northbridge 24
     Number of nodes 2 (10010)
     Node 0 MemBase 0000000000000000 Limit 000000013fffffff
     Skipping disabled node 1
     Using node hash shift of 24
     Bootmem setup node 0 0000000000000000-000000013fffffff
     No mptable found.
     On node 0 totalpages: 1310719
       DMA zone: 4096 pages, LIFO batch:1
       Normal zone: 1306623 pages, LIFO batch:16
       HighMem zone: 0 pages, LIFO batch:1

So actually it looks like the kernel well notices that only one processor
has access to the memory here.


        Sergei
-- 
--------------------------------------------------------------------  -?)
         eMail:       Sergei.Haller@math.uni-giessen.de               /\\
-------------------------------------------------------------------- _\_V
Be careful of reading health books, you might die of a misprint.
                -- Mark Twain
