Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751803AbWJMSlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbWJMSlo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 14:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbWJMSlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 14:41:44 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:26823 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751805AbWJMSln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 14:41:43 -0400
Subject: kernel BUG in __cache_alloc_node at  linux-2.6.git/mm/slab.c:3177!
From: Will Schmidt <will_schmidt@vnet.ibm.com>
Reply-To: will_schmidt@vnet.ibm.com
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@sgi.com>
Content-Type: text/plain
Organization: IBM
Date: Fri, 13 Oct 2006 13:41:34 -0500
Message-Id: <1160764895.11239.14.camel@farscape>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks, 
    Am seeing a crash on a power5 LPAR when booting the linux-2.6 git
tree.  It's fairly early during boot, so I've included the whole log
below.   This partition has 8 procs, (shared, including threads), and
512M RAM.  

A bisect claims: 
765c4507af71c39aba21006bbd3ec809fe9714ff is first bad commit
commit 765c4507af71c39aba21006bbd3ec809fe9714ff
Author: Christoph Lameter <clameter@sgi.com>
Date:   Wed Sep 27 01:50:08 2006 -0700

    [PATCH] GFP_THISNODE for the slab allocator

Am willing to dig deeper, but looking for pointers on what to poke next.

Thanks, 
-Will

-----------------------------------------------------
ppc64_pft_size                = 0x18
physicalMemorySize            = 0x22000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0x0000000000000000
htab_hash_mask                = 0x1ffff
-----------------------------------------------------
Linux version 2.6.19-rc1-gb8a3ad5b (willschm@airbag2) (gcc version 4.1.0
(SUSE Linux)) #56 SMP Fri Oct 13 13:06:18 CDT 2006
[boot]0012 Setup Arch
No ramdisk, default root is /dev/sda2
EEH: No capable adapters found
PPC64 nvram contains 7168 bytes
Zone PFN ranges:
  DMA             0 ->   139264
  Normal     139264 ->   139264
early_node_map[3] active PFN ranges
    1:        0 ->    32768
    0:    32768 ->    90112
    1:    90112 ->   139264
[boot]0015 Setup Done
Built 2 zonelists.  Total pages: 136576
Kernel command line: root=/dev/sda3  xmon=on
[boot]0020 XICS Init
[boot]0021 XICS Done
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
freeing bootmem node 0
freeing bootmem node 1
Memory: 530256k/557056k available (5508k kernel code, 30468k reserved,
2224k data, 543k bss, 244k init)
kernel BUG in __cache_alloc_node
at /development/kernels/linux-2.6.git/mm/slab.c:3177!
cpu 0x0: Vector: 700 (Program Check) at [c0000000007938d0]
    pc: c0000000000b3c78: .__cache_alloc_node+0x44/0x1e8
    lr: c0000000000b3ec8: .fallback_alloc+0xac/0xf0
    sp: c000000000793b50
   msr: 8000000000021032
  current = 0xc000000000583a90
  paca    = 0xc000000000584300
    pid   = 0, comm = swapper
kernel BUG in __cache_alloc_node
at /development/kernels/linux-2.6.git/mm/slab.c:3177!
enter ? for help
[c000000000793c00] c0000000000b3ec8 .fallback_alloc+0xac/0xf0
[c000000000793ca0] c0000000000b4478 .kmem_cache_zalloc+0xc8/0x11c
[c000000000793d40] c0000000000b6624 .kmem_cache_create+0x1e8/0x5e0
[c000000000793e30] c00000000053e834 .kmem_cache_init+0x1d8/0x4b0
[c000000000793ef0] c000000000524748 .start_kernel+0x244/0x328
[c000000000793f90] c0000000000084f8 .start_here_common+0x54/0x5c
0:mon>

