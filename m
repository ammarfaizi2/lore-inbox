Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317948AbSGWEdw>; Tue, 23 Jul 2002 00:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317949AbSGWEdw>; Tue, 23 Jul 2002 00:33:52 -0400
Received: from holomorphy.com ([66.224.33.161]:23176 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317948AbSGWEdu>;
	Tue, 23 Jul 2002 00:33:50 -0400
Date: Mon, 22 Jul 2002 21:36:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Craig Kulesa <ckulesa@as.arizona.edu>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Steven Cole <scole@lanl.gov>,
       Ed Tomlinson <tomlins@cam.org>
Subject: Re: [PATCH 2/2] move slab pages to the lru, for 2.5.27
Message-ID: <20020723043653.GF13589@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Craig Kulesa <ckulesa@as.arizona.edu>,
	Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Steven Cole <scole@lanl.gov>,
	Ed Tomlinson <tomlins@cam.org>
References: <20020722222150.GF919@holomorphy.com> <Pine.LNX.4.44.0207221520301.14311-100000@loke.as.arizona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207221520301.14311-100000@loke.as.arizona.edu>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2002, William Lee Irwin III wrote:
>> The pte_chain mempool was ridiculously huge and the use of mempool for
>> this at all was in error.

On Mon, Jul 22, 2002 at 03:36:33PM -0700, Craig Kulesa wrote:
> That's what I thoguht too -- but Steven tried making the pool 1/4th the
> size and it still failed.  OTOH, he tried 2.5.27-rmap, which uses the
> *same mempool patch* and he had no problem with the monster 128KB 
> allocation.  Maybe it was all luck. :)  I can't yet see anything in the 
> slablru patch that has anything to do with it...

While waiting for the other machine to boot I tried these out. There
appear to be bootstrap ordering problems either introduced by or
exposed by this patch:

Cheers,
Bill


[log buffer too small to capture the whole thing]

CPU0<T0:99984,T1:96944,D:10,S:3030,C:99992>
cpu: 1, clocks: 99992, slice: 3030
cpu: 2, clocks: 99992, slice: 3030
cpu: 3, clocks: 99992, slice: 3030
cpu: 4, clocks: 99992, slice: 3030
cpu: 5, clocks: 99992, slice: 3030
cpu: 7, clocks: 99992, slice: 3030
cpu: 6, clocks: 99992, slice: 3030
cpu: 9, clocks: 99992, slice: 3030
cpu: 10, clocks: 99992, slice: 3030
cpu: 11, clocks: 99992, slice: 3030
cpu: 8, clocks: 99992, slice: 3030
cpu: 14, clocks: 99992, slice: 3030
cpu: 15, clocks: 99992, slice: 3030
cpu: 12, clocks: 99992, slice: 3030
cpu: 13, clocks: 99992, slice: 3030
CPU2<T0:99984,T1:90880,D:14,S:3030,C:99992>
CPU3<T0:99984,T1:87856,D:8,S:3030,C:99992>
CPU5<T0:99984,T1:81792,D:12,S:3030,C:99992>
CPU7<T0:99984,T1:75744,D:0,S:3030,C:99992>
CPU4<T0:99984,T1:84832,D:2,S:3030,C:99992>
CPU6<T0:99984,T1:78768,D:6,S:3030,C:99992>
CPU12<T0:99984,T1:60592,D:2,S:3030,C:99992>
CPU10<T0:99984,T1:66640,D:14,S:3030,C:99992>
CPU11<T0:99984,T1:63616,D:8,S:3030,C:99992>
CPU8<T0:99984,T1:72704,D:10,S:3030,C:99992>
CPU9<T0:99984,T1:69680,D:4,S:3030,C:99992>
CPU15<T0:99984,T1:51504,D:0,S:3030,C:99992>
CPU13<T0:99984,T1:57552,D:12,S:3030,C:99992>
CPU14<T0:99984,T1:54528,D:6,S:3030,C:99992>
CPU1<T0:99984,T1:93920,D:4,S:3030,C:99992>
checking TSC synchronization across CPUs:
BIOS BUG: CPU#0 improperly initialized, has 7692500 usecs TSC skew! FIXED.
BIOS BUG: CPU#1 improperly initialized, has 7692500 usecs TSC skew! FIXED.
BIOS BUG: CPU#2 improperly initialized, has 7692500 usecs TSC skew! FIXED.
BIOS BUG: CPU#3 improperly initialized, has 7692500 usecs TSC skew! FIXED.
BIOS BUG: CPU#4 improperly initialized, has 7750408 usecs TSC skew! FIXED.
BIOS BUG: CPU#5 improperly initialized, has 7750408 usecs TSC skew! FIXED.
BIOS BUG: CPU#6 improperly initialized, has 7750408 usecs TSC skew! FIXED.
BIOS BUG: CPU#7 improperly initialized, has 7750408 usecs TSC skew! FIXED.
BIOS BUG: CPU#8 improperly initialized, has 7773209 usecs TSC skew! FIXED.
BIOS BUG: CPU#9 improperly initialized, has 7773162 usecs TSC skew! FIXED.
BIOS BUG: CPU#10 improperly initialized, has 7773162 usecs TSC skew! FIXED.
BIOS BUG: CPU#11 improperly initialized, has 7773161 usecs TSC skew! FIXED.
BIOS BUG: CPU#12 improperly initialized, has -23216067 usecs TSC skew! FIXED.
BIOS BUG: CPU#13 improperly initialized, has -23216089 usecs TSC skew! FIXED.
BIOS BUG: CPU#14 improperly initialized, has -23216089 usecs TSC skew! FIXED.
BIOS BUG: CPU#15 improperly initialized, has -23216089 usecs TSC skew! FIXED.
migration_task 0 on cpu=0
migration_task 1 on cpu=1
migration_task 2 on cpu=2
migration_task 3 on cpu=3
migration_task 4 on cpu=4
migration_task 5 on cpu=5
migration_task 6 on cpu=6
migration_task 7 on cpu=7
migration_task 8 on cpu=8
migration_task 9 on cpu=9
migration_task 10 on cpu=10
migration_task 11 on cpu=11
migration_task 12 on cpu=12
migration_task 13 on cpu=13
migration_task 14 on cpu=14
migration_task 15 on cpu=15
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd231, last bus=2
PCI: Using configuration type 1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PCI: Probing PCI hardware (bus 00)
PCI: Searching for i450NX host bridges on 00:10.0
Unknown bridge resource 2: assuming transparent
Scanning PCI bus 3 for quad 1
Scanning PCI bus 6 for quad 2
Scanning PCI bus 9 for quad 3
PCI->APIC IRQ transform: (B0,I10,P0) -> 23
PCI->APIC IRQ transform: (B0,I11,P0) -> 19
PCI->APIC IRQ transform: (B2,I15,P0) -> 28
PCI: using PPB(B0,I12,P0) to get irq 15
PCI->APIC IRQ transform: (B1,I4,P0) -> 15
PCI: using PPB(B0,I12,P1) to get irq 13
PCI->APIC IRQ transform: (B1,I5,P1) -> 13
PCI: using PPB(B0,I12,P2) to get irq 11
PCI->APIC IRQ transform: (B1,I6,P2) -> 11
PCI: using PPB(B0,I12,P3) to get irq 7
PCI->APIC IRQ transform: (B1,I7,P3) -> 7
enable_cpucache failed for dentry_cache, error 12.
enable_cpucache failed for filp, error 12.
enable_cpucache failed for names_cache, error 12.
enable_cpucache failed for buffer_head, error 12.
enable_cpucache failed for mm_struct, error 12.
enable_cpucache failed for vm_area_struct, error 12.
enable_cpucache failed for fs_cache, error 12.
enable_cpucache failed for files_cache, error 12.
enable_cpucache failed for signal_act, error 12.
enable_cpucache failed for task_struct, error 12.
enable_cpucache failed for pte_chain, error 12.
enable_cpucache failed for pae_pgd, error 12.
enable_cpucache failed for size-4096 (DMA), error 12.
enable_cpucache failed for size-4096, error 12.
enable_cpucache failed for size-2048 (DMA), error 12.
enable_cpucache failed for size-2048, error 12.
enable_cpucache failed for size-1024 (DMA), error 12.
enable_cpucache failed for size-1024, error 12.
enable_cpucache failed for size-512 (DMA), error 12.
enable_cpucache failed for size-512, error 12.
enable_cpucache failed for size-256 (DMA), error 12.
enable_cpucache failed for size-256, error 12.
enable_cpucache failed for size-192 (DMA), error 12.
enable_cpucache failed for size-192, error 12.
enable_cpucache failed for size-128 (DMA), error 12.
enable_cpucache failed for size-128, error 12.
enable_cpucache failed for size-96 (DMA), error 12.
enable_cpucache failed for size-96, error 12.
enable_cpucache failed for size-64 (DMA), error 12.
enable_cpucache failed for size-64, error 12.
enable_cpucache failed for size-32 (DMA), error 12.
enable_cpucache failed for size-32, error 12.
Starting kswapd
enable_cpucache failed for shmem_inode_cache, error 12.
could not kern_mount tmpfs

