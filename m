Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267229AbTAOTbx>; Wed, 15 Jan 2003 14:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267236AbTAOTbx>; Wed, 15 Jan 2003 14:31:53 -0500
Received: from are.twiddle.net ([64.81.246.98]:42889 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S267229AbTAOTbt>;
	Wed, 15 Jan 2003 14:31:49 -0500
Date: Wed, 15 Jan 2003 11:40:43 -0800
From: Richard Henderson <rth@twiddle.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK] alpha update
Message-ID: <20030115114043.A11360@twiddle.net>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from

	bk://are.twiddle.net/axp-2.5


r~



 arch/alpha/Kconfig                |    9 +
 arch/alpha/Makefile               |    4 
 arch/alpha/boot/Makefile          |    7 +
 arch/alpha/kernel/alpha_ksyms.c   |   13 ++
 arch/alpha/kernel/core_wildfire.c |   27 +++++
 arch/alpha/kernel/osf_sys.c       |    9 -
 arch/alpha/kernel/pci_impl.h      |    4 
 arch/alpha/kernel/pci_iommu.c     |   38 +++++++
 arch/alpha/kernel/proto.h         |    4 
 arch/alpha/kernel/setup.c         |   18 +++
 arch/alpha/kernel/smp.c           |  113 +++++++++++------------
 arch/alpha/kernel/sys_wildfire.c  |    5 +
 arch/alpha/lib/callback_srm.S     |    2 
 arch/alpha/mm/numa.c              |  101 ++++++---------------
 arch/alpha/vmlinux.lds.S          |  181 ++++++++++++++++++--------------------
 include/asm-alpha/console.h       |    5 +
 include/asm-alpha/hardirq.h       |    8 +
 include/asm-alpha/ide.h           |    2 
 include/asm-alpha/io.h            |   34 +++++--
 include/asm-alpha/machvec.h       |    6 +
 include/asm-alpha/mmzone.h        |  137 ++++++++++++++++------------
 include/asm-alpha/numnodes.h      |    8 -
 include/asm-alpha/pgalloc.h       |    3 
 include/asm-alpha/pgtable.h       |   32 ------
 include/asm-alpha/smp.h           |   15 ++-
 include/asm-alpha/system.h        |    2 
 include/asm-alpha/topology.h      |   47 ++++++++-
 27 files changed, 482 insertions, 352 deletions

through these ChangeSets:

<ink@jurassic.park.msu.ru> (03/01/15 1.935)
   [PATCH] alpha kernel start address
   From Jeff.Wiedemeier@hp.com:
   
   Bump non-legacy start addr to 16mb to accomodate new larger
   SRM console footprint.

<ink@jurassic.park.msu.ru> (03/01/15 1.934)
   [PATCH] alpha smp fixes
   From Jeff.Wiedemeier@hp.com:
   
   Misc alpha smp updates for 2.5 tree.

<ink@jurassic.park.msu.ru> (03/01/15 1.933)
   [PATCH] alpha numa update
   From Jeff.Wiedemeier@hp.com:
   
   numa mm update including moving alpha numa support into 
   machine vector so a generic numa kernel can be used.

<ink@jurassic.park.msu.ru> (03/01/15 1.932)
   [PATCH] alpha numa iommu
   From Jeff.Wiedemeier@hp.com:
   
   On NUMA alpha systems, attempt to allocate scatter-gather
   tables local to IO processor.  If that doesn't work, then
   allocate anywhere in the system.

<ink@jurassic.park.msu.ru> (03/01/15 1.931)
   [PATCH] alpha mem_size_limit
   From Jeff.Wiedemeier@hp.com:
   
   This adds the 32GB limit to setup.c.  (It actually hits the first
   2 nodes on Marvel, but that's ok, where we really run into a big
   problem is if we go past 4, then we hit a much larger hole.)

<ink@jurassic.park.msu.ru> (03/01/15 1.930)
   [PATCH] alpha ide hwifs
   From Jeff.Wiedemeier@hp.com:
   
   Make the max IDE HWIFS configurable on alpha (default to
   previous hardwired value of 4).

<ink@jurassic.park.msu.ru> (03/01/15 1.929)
   [PATCH] alpha console callbacks
   From Jeff.Wiedemeier@hp.com:
   
   Add open_console / close_console callback definitions.

<rth@are.twiddle.net> (03/01/15 1.928)
   [ALPHA] Expose shifts in virt_to_phys to the compiler.

<ink@jurassic.park.msu.ru> (03/01/15 1.927)
   [PATCH] alpha ev6/ev7 virt_to_phys
   From Jeff.Wiedemeier@hp.com:
   
   Adjust virt_to_phys / phys_to_virt functions to follow
   EV6/7 PA sign extension to properly convert between 43-bit
   superpage I/O addresses and physical addresses.
   This change is backwards compatible with all previous Alphas
   as they implemented fewer than 41 bits of physical address.

<ink@jurassic.park.msu.ru> (03/01/15 1.926)
   [PATCH] alpha osf_shmat lock
   From Jeff.Wiedemeier@hp.com:
   
   Remove redundant lock in osf_shmat (sys_shmat locks already);
   redundant lock has been seen to cause livelock in some workloads.

<ink@jurassic.park.msu.ru> (03/01/15 1.925)
   [PATCH] alpha kernel layout
   From Jeff.Wiedemeier@hp.com:
   
   Adjust kernel layout format to match other architectures and
   prevent reording of the first entry in a section with the
   section start label.

<ink@jurassic.park.msu.ru> (03/01/15 1.924)
   [PATCH] alpha HARDIRQ_BITS
   From Jeff.Wiedemeier@hp.com:
   
   Adjust Alpha HARDIRQ_BITS check to make sure there is enough
   room for each IPL, not each interrupt (Marvel can have
   too many unique device interrupts for that, and it really
   only needs to cover potential nesting of interrupts, which covering
   the IPLs does)

<ink@jurassic.park.msu.ru> (03/01/15 1.923)
   [PATCH] alpha ipi timeout
   From Jeff.Wiedemeier@hp.com:
   
   Two stage timeout in alpha call_function_on_cpu. If the
   primary timeout expires with no response, log a message and
   start secondary timeout. If reponse is received log how
   far into secondary timeout. If no response is received,
   crash.

<ink@jurassic.park.msu.ru> (03/01/15 1.922)
   [PATCH] alpha bootp target
   From Jeff.Wiedemeier@hp.com:
   
   Fix alpha Makefiles for bootpfile target.

<ink@jurassic.park.msu.ru> (03/01/15 1.921)
   [PATCH] alpha ksyms
   From Jeff.Wiedemeier@hp.com:
   
   Export proper functions when debugging is enabled.

