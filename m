Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161065AbWJPUud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161065AbWJPUud (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 16:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161063AbWJPUud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 16:50:33 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:57787 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161065AbWJPUuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 16:50:32 -0400
Subject: Re: kernel BUG in __cache_alloc_node at
	linux-2.6.git/mm/slab.c:3177!
From: Will Schmidt <will_schmidt@vnet.ibm.com>
Reply-To: will_schmidt@vnet.ibm.com
To: Christoph Lameter <clameter@sgi.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
References: <1160764895.11239.14.camel@farscape>
	 <Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
	 <1160769226.11239.22.camel@farscape> <1160773040.11239.28.camel@farscape>
	 <Pine.LNX.4.64.0610131515200.28279@schroedinger.engr.sgi.com>
	 <1161026409.31903.15.camel@farscape>
	 <Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: IBM
Date: Mon, 16 Oct 2006 15:50:20 -0500
Message-Id: <1161031821.31903.28.camel@farscape>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-16-10 at 12:25 -0700, Christoph Lameter wrote:


> zero slab??? That cannot be. The slab allocator always allocs on each 
> node. Or is this <2.6.18 with the strange counters that we had before?

This is output from 2.6.18-rc2.   MemFree, MemTotal, MemUsed still
wrong.  Node0 slab is still zero.  I've also attached the numa=debug
boot log from this boot, in case it has any clues that were missing from
the other boot log. 

15:40:53 0 willschm@airbag2:~> find /sys/devices/system/node/ -type f -exec cat {} \;
20 10
numa_hit 4952
numa_miss 152776
numa_foreign 0
interleave_hit 3176
local_node 0
other_node 157761

Node 1 MemTotal:       327680 kB
Node 1 MemFree:        441136 kB
Node 1 MemUsed:      18446744073709438160 kB
Node 1 Active:          39008 kB
Node 1 Inactive:        18040 kB
Node 1 HighTotal:           0 kB
Node 1 HighFree:            0 kB
Node 1 LowTotal:       327680 kB
Node 1 LowFree:        441136 kB
Node 1 Dirty:               0 kB
Node 1 Writeback:           0 kB
Node 1 FilePages:       39868 kB
Node 1 Mapped:          15080 kB
Node 1 AnonPages:       17172 kB
Node 1 PageTables:        956 kB
Node 1 NFS Unstable:        0 kB
Node 1 Bounce:              0 kB
Node 1 Slab:            26036 kB
Node 1 HugePages_Total:     0
Node 1 HugePages_Free:      0
00000000,00000000,00000000,00000000
10 20
numa_hit 0
numa_miss 0
numa_foreign 152941
interleave_hit 0
local_node 0
other_node 0

Node 0 MemTotal:       229376 kB
Node 0 MemFree:             0 kB
Node 0 MemUsed:        229376 kB
Node 0 Active:              0 kB
Node 0 Inactive:            0 kB
Node 0 HighTotal:           0 kB
Node 0 HighFree:            0 kB
Node 0 LowTotal:       229376 kB
Node 0 LowFree:             0 kB
Node 0 Dirty:               0 kB
Node 0 Writeback:           0 kB
Node 0 FilePages:           0 kB
Node 0 Mapped:              0 kB
Node 0 AnonPages:           0 kB
Node 0 PageTables:          0 kB
Node 0 NFS Unstable:        0 kB
Node 0 Bounce:              0 kB
Node 0 Slab:                0 kB
Node 0 HugePages_Total:     0
Node 0 HugePages_Free:      0
00000000,00000000,00000000,000000ff
15:40:57 0 willschm@airbag2:~>                

-
-----------------------------------------------------
ppc64_pft_size                = 0x18
physicalMemorySize            = 0x22000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0x0000000000000000
htab_hash_mask                = 0x1ffff
-----------------------------------------------------
Linux version 2.6.18-rc2 (willschm@airbag2) (gcc version 4.1.0 (SUSE
Linux)) #1 SMP Mon Oct 16 15:27:37 CDT 2006
[boot]0012 Setup Arch
NUMA associativity depth for CPU/Memory: 3
add_region nid 1 start_pfn 0x0 pages 0x8000
add_region nid 0 start_pfn 0x8000 pages 0x2000
add_region nid 0 start_pfn 0xa000 pages 0x2000
add_region nid 0 start_pfn 0xc000 pages 0x2000
add_region nid 0 start_pfn 0xe000 pages 0x2000
add_region nid 0 start_pfn 0x10000 pages 0x2000
add_region nid 0 start_pfn 0x12000 pages 0x2000
add_region nid 0 start_pfn 0x14000 pages 0x2000
add_region nid 1 start_pfn 0x16000 pages 0x2000
add_region nid 1 start_pfn 0x18000 pages 0x2000
add_region nid 1 start_pfn 0x1a000 pages 0x2000
add_region nid 1 start_pfn 0x1c000 pages 0x2000
add_region nid 1 start_pfn 0x1e000 pages 0x2000
add_region nid 1 start_pfn 0x20000 pages 0x2000
Node 0 Memory: 0x8000000-0x16000000
Node 1 Memory: 0x0-0x8000000 0x16000000-0x22000000
adding cpu 0 to node 0
node 0
NODE_DATA() = c000000015ffd780
start_paddr = 8000000
end_paddr = 16000000
bootmap_paddr = 15ffb000
free_bootmem 8000000 e000000
reserve_bootmem ffc0000 40000
reserve_bootmem 15ffb000 2000
reserve_bootmem 15ffd780 2880
node 1
NODE_DATA() = c000000021ff6580
start_paddr = 0
end_paddr = 22000000
bootmap_paddr = 21ff1000
free_bootmem 0 8000000
free_bootmem 16000000 c000000
reserve_bootmem 0 802000
reserve_bootmem 2606000 9000
reserve_bootmem 77b2000 84e000
reserve_bootmem 21ff1000 5000
reserve_bootmem 21ff6580 2880
reserve_bootmem 21ff8e58 71a4
No ramdisk, default root is /dev/sda2
EEH: No capable adapters found
PPC64 nvram contains 7168 bytes
Using shared processor idle loop
free_area_init node 0 e000 8000 (hole: 0)
On node 0 totalpages: 57344
  DMA zone: 57344 pages, LIFO batch:15
free_area_init node 1 22000 0 (hole: e000)
On node 1 totalpages: 81920
  DMA zone: 81920 pages, LIFO batch:15
[boot]0015 Setup Done
Built 2 zonelists.  Total pages: 139264


