Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265385AbSKFAOa>; Tue, 5 Nov 2002 19:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265400AbSKFAO3>; Tue, 5 Nov 2002 19:14:29 -0500
Received: from web13806.mail.yahoo.com ([216.136.175.16]:8841 "HELO
	web13806.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S265385AbSKFAOT>; Tue, 5 Nov 2002 19:14:19 -0500
Message-ID: <20021106002053.7411.qmail@web13806.mail.yahoo.com>
Date: Tue, 5 Nov 2002 16:20:53 -0800 (PST)
From: Padraig O Mathuna <padraigo@yahoo.com>
Subject: MIPS32 VM/ioremap question mapping 32 bit virtual address to 36 bit physical
To: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I'm still having issues trying to get the AU1000's 32
bit MIPS to access 36 bit physical address space. 
After reading the code and docs, I wrote a simple
clone for ioremap, ioremap_ext, which remap the usage
of _PAGE_R4KBUG (which I don't see to be present in
the AU1000 core) to indicate a mapping of 32bit VA
0xXXXX_XXXX to the 36bit phy addr 0xD_XXXX_XXXX.  I
then edited the update_mmu_cache routine in mips32.c
to look for this indicator and alter the mmu load to
load a PTE value or'ed with 0xD00000000 as opposed to
the straight 32 bit address into the TLB.  I then
wrote a test program to call the new ioremap and map
and area of memory into the extended 36 bit range and
then access it.  This seems like it would work except
I never see the update_mmu_cache being called for a
PTE with the _PAGE_R4KBUG indicator set. What am I
missing here in regards to the operation of VM,
ioremap or update_mmu_cache?   
thanks,
Padraig

> I'm developing some drivers for the AU1000 under
> Mountain Vista's 2.4.17 sherman release. The AU1000
is
> a MIPS based SOC with a 36 bit internal address bus
> and a 32 bit MIPS cpu. According to the
documentation
> the MIPS' TLB is able to map 32 bit virtual
addresses
> to 36 bit physical addresses, however I cannot
figure
> out how to get Linux to set this up. I've looked at
> ioremap which only takes unsigned long (32bits) as
an
> argument to assign a virtual address. Is there
> another way?

 You should probably look at how CONFIG_HIGHMEM and
CONFIG_64BIT_PHYS_ADDR
support is implemented and add an option like
CONFIG_36BIT_PHYS_ADDR (or
just use CONFIG_HIGHMEM for that) plus a few necessary
bits to the mm code
so that ioremap() can make use of the additional bits.
It doesn't seem
too difficult to develop, but you may want to work on
a current snapshot
from the CVS.




__________________________________________________
Do you Yahoo!?
HotJobs - Search new jobs daily now
http://hotjobs.yahoo.com/
