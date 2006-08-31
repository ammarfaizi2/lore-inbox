Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWHaFtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWHaFtL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 01:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWHaFtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 01:49:11 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:8100 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750813AbWHaFtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 01:49:09 -0400
Message-ID: <44F67847.6030307@cn.ibm.com>
Date: Thu, 31 Aug 2006 13:48:55 +0800
From: Yao Fei Zhu <walkinair@cn.ibm.com>
Reply-To: walkinair@cn.ibm.com
Organization: IBM
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: haveblue@us.ibm.com, xfs@oss.sgi.com
Subject: kernel BUG in __xfs_get_blocks at fs/xfs/linux-2.6/xfs_aops.c:1293!
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem description:
Run fsstress on xfs file system with -n 1000 and -p 1000, after about 3 hours,
test box will fall into xmon, and get
kernel BUG in __xfs_get_blocks at fs/xfs/linux-2.6/xfs_aops.c:1293!

Hardware Environment
    Machine type (p650, x235, SF2, etc.): B70+
    Cpu type (Power4, Power5, IA-64, etc.): POWER5+
Software Environmnet
    Base OS: SLES10 GM
    Kernel: 2.6.18-rc5

Additional information:
3:mon> e
cpu 0x3: Vector: 700 (Program Check) at [c0000001e16632d0]
    pc: d0000000006daa88: .__xfs_get_blocks+0x1a0/0x2a0 [xfs]
    lr: d0000000006da984: .__xfs_get_blocks+0x9c/0x2a0 [xfs]
    sp: c0000001e1663550
   msr: 8000000000029032
  current = 0xc0000001dde71310
  paca    = 0xc0000000004c4900
    pid   = 9217, comm = fsstress
kernel BUG in __xfs_get_blocks at fs/xfs/linux-2.6/xfs_aops.c:1293!
3:mon> t
[c0000001e1663640] c000000000108344 .__blockdev_direct_IO+0x560/0xcfc
[c0000001e1663760] d0000000006dc43c .xfs_vm_direct_IO+0xec/0x13c [xfs]
[c0000001e1663860] c0000000000a1474 .generic_file_direct_IO+0xe8/0x15c
[c0000001e1663910] c0000000000a1748 .__generic_file_aio_read+0xf4/0x22c
[c0000001e16639e0] d0000000006e4b94 .xfs_read+0x288/0x368 [xfs]
[c0000001e1663ae0] d0000000006e0750 .xfs_file_aio_read+0x88/0x9c [xfs]
[c0000001e1663b70] c0000000000d4df0 .do_sync_read+0xd4/0x130
[c0000001e1663cf0] c0000000000d5c44 .vfs_read+0x118/0x200
[c0000001e1663d90] c0000000000d6128 .sys_read+0x4c/0x8c
[c0000001e1663e30] c00000000000871c syscall_exit+0x0/0x40
--- Exception: c01 (System Call) at 000000000ff4ddf8
SP (fc38ec90) is in userspace
3:mon> r
R00 = 0000000000000004   R16 = 0000000000000003
R01 = c0000001e1663550   R17 = 0000000000020000
R02 = d000000000727dc0   R18 = c0000001adf18e90
R03 = 0000000000000000   R19 = 000000000000000c
R04 = 0000000000000001   R20 = c0000001e1663b50
R05 = c0000001e1663610   R21 = 0000000000000000
R06 = c0000001e1663620   R22 = c0000001d99cfe88
R07 = ffffffffffffffff   R23 = 000000000000000c
R08 = 0000000000000000   R24 = 0000000000000000
R09 = 0000000000000001   R25 = 0000000000000001
R10 = c00000003173f630   R26 = 000000000010c000
R11 = 0000000000000000   R27 = c0000001adf18e90
R12 = d0000000006e8a78   R28 = 0000000000044000
R13 = c0000000004c4900   R29 = c0000001e16635c8
R14 = c0000001e1663be0   R30 = c000000000517378
R15 = 0000000000000000   R31 = c0000001d99cfbf0
pc  = d0000000006daa88 .__xfs_get_blocks+0x1a0/0x2a0 [xfs]
lr  = d0000000006da984 .__xfs_get_blocks+0x9c/0x2a0 [xfs]
msr = 8000000000029032   cr  = 42000422
ctr = c00000000007d12c   xer = 0000000020000001   trap =  700
3:mon> di d0000000006daa88
d0000000006daa88  0b190000      tdnei   r25,0
d0000000006daa8c  2fb80000      cmpdi   cr7,r24,0
d0000000006daa90  419e004c      beq     cr7,d0000000006daadc    #
.__xfs_get_blocks+0x1f4/0x2a0 [xfs]
d0000000006daa94  38000001      li      r0,1
d0000000006daa98  7d20f8a8      ldarx   r9,r0,r31
d0000000006daa9c  7d290378      or      r9,r9,r0
d0000000006daaa0  7d20f9ad      stdcx.  r9,r0,r31
d0000000006daaa4  40a2fff4      bne     d0000000006daa98        #
.__xfs_get_blocks+0x1b0/0x2a0 [xfs]
d0000000006daaa8  38000020      li      r0,32
d0000000006daaac  60000000      nop
d0000000006daab0  7d20f8a8      ldarx   r9,r0,r31
d0000000006daab4  7d290378      or      r9,r9,r0
d0000000006daab8  7d20f9ad      stdcx.  r9,r0,r31
d0000000006daabc  40a2fff4      bne     d0000000006daab0        #
.__xfs_get_blocks+0x1c8/0x2a0 [xfs]
d0000000006daac0  38000200      li      r0,512
d0000000006daac4  60000000      nop
3:mon> mi
Mem-info:
Node 0 DMA per-cpu:
cpu 0 hot: high 6, batch 1 used:5
cpu 0 cold: high 2, batch 1 used:0
cpu 1 hot: high 6, batch 1 used:5
cpu 1 cold: high 2, batch 1 used:0
cpu 2 hot: high 6, batch 1 used:0
cpu 2 cold: high 2, batch 1 used:0
cpu 3 hot: high 6, batch 1 used:0
cpu 3 cold: high 2, batch 1 used:0
Node 0 DMA32 per-cpu: empty
Node 0 Normal per-cpu: empty
Node 0 HighMem per-cpu: empty
Free pages:       36288kB (0kB HighMem)
Active:25944 inactive:88655 dirty:13 writeback:11 unstable:0 free:567 slab:9664
mapped:468 pagetables:3094
Node 0 DMA free:36288kB min:11584kB low:14464kB high:17344kB active:1660416kB
inactive:5673920kB present:8388608kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Node 0 DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Node 0 Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Node 0 HighMem free:0kB min:2048kB low:2048kB high:2048kB active:0kB
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 73*64kB 109*128kB 15*256kB 3*512kB 0*1024kB 2*2048kB 0*4096kB
1*8192kB 0*16384kB = 36288kB
Node 0 DMA32: empty
Node 0 Normal: empty
Node 0 HighMem: empty
Swap cache: add 3054, delete 29, find 2/4, race 0+0
Free swap  = 3932928kB
Total swap = 4127296kB
Free swap:       3932928kB
131072 pages of RAM
601 reserved pages
107626 pages shared
3025 pages swap cached
3:mon>


