Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946536AbWJSVnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946536AbWJSVnc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 17:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946539AbWJSVnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 17:43:32 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:16025 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1946536AbWJSVnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 17:43:31 -0400
Subject: Re: kernel BUG in __cache_alloc_node at
	linux-2.6.git/mm/slab.c:3177!
From: Will Schmidt <will_schmidt@vnet.ibm.com>
Reply-To: will_schmidt@vnet.ibm.com
To: Christoph Lameter <clameter@sgi.com>
Cc: Anton Blanchard <anton@samba.org>, akpm@osdl.org, linuxppc-dev@ozlabs.org,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0610191427270.10316@schroedinger.engr.sgi.com>
References: <1161026409.31903.15.camel@farscape>
	 <Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
	 <1161031821.31903.28.camel@farscape>
	 <Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
	 <17717.50596.248553.816155@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com>
	 <17718.39522.456361.987639@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com>
	 <17719.1849.245776.4501@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com>
	 <20061019163044.GB5819@krispykreme>
	 <Pine.LNX.4.64.0610190959560.8433@schroedinger.engr.sgi.com>
	 <1161290229.8946.51.camel@farscape>
	 <Pine.LNX.4.64.0610191427270.10316@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: IBM
Date: Thu, 19 Oct 2006 16:43:16 -0500
Message-Id: <1161294197.8946.56.camel@farscape>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-19-10 at 14:28 -0700, Christoph Lameter wrote:
> On Thu, 19 Oct 2006, Will Schmidt wrote:
> 
> > This didnt fix the problem on my box.  I tried this both against mm and
> > linux-2.6.git 
> 
> Same failure condition? Would you also apply the printk patch and send 
> me the output?

Yup, here it is:

-----------------------------------------------------
ppc64_pft_size                = 0x18
physicalMemorySize            = 0x22000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0x0000000000000000
htab_hash_mask                = 0x1ffff
-----------------------------------------------------
Linux version 2.6.19-rc2-mm1 (willschm@airbag2) (gcc version 4.1.0 (SUSE
Linux)) #2 SMP Thu Oct 19 16:37:26 CDT 2006
[boot]0012 Setup Arch
NUMA associativity depth for CPU/Memory: 3
adding cpu 0 to node 0
node 0
NODE_DATA() = c000000015ffed80
start_paddr = 8000000
end_paddr = 16000000
bootmap_paddr = 15ffc000
reserve_bootmem ffc0000 40000
reserve_bootmem 15ffc000 2000
reserve_bootmem 15ffed80 1280
node 1
NODE_DATA() = c000000021ff7b80
start_paddr = 0
end_paddr = 22000000
bootmap_paddr = 21ff2000
reserve_bootmem 0 851000
reserve_bootmem 2655000 9000
reserve_bootmem 77b2000 84e000
reserve_bootmem 21ff2000 5000
reserve_bootmem 21ff7b80 1280
reserve_bootmem 21ff8e58 71a4
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
Kernel command line: root=/dev/sda3  xmon=on numa=debug
[boot]0020 XICS Init
[boot]0021 XICS Done
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
freeing bootmem node 0
freeing bootmem node 1
Memory: 530216k/557056k available (5544k kernel code, 30508k reserved,
2232k data, 548k bss, 248k init)
Get cache descritor
__cache_alloc
__cache_alloc_node 0
fallback_alloc
__cache_alloc_node 0
__cache_alloc_node 1
kernel BUG in __cache_alloc_node
at /development/kernels/2.6-mm/mm/slab.c:3193!
cpu 0x0: Vector: 700 (Program Check) at [c00000000079b8d0]
    pc: c0000000000b70f8: .__cache_alloc_node+0x5c/0x208
    lr: c0000000000b70e0: .__cache_alloc_node+0x44/0x208
    sp: c00000000079bb50
   msr: 8000000000021032
  current = 0xc00000000058ca90
  paca    = 0xc00000000058d380
    pid   = 0, comm = swapper
kernel BUG in __cache_alloc_node
at /development/kernels/2.6-mm/mm/slab.c:3193!
enter ? for help
[c00000000079bc00] c0000000000b735c .fallback_alloc+0xb8/0xfc
[c00000000079bca0] c0000000000b7930 .kmem_cache_zalloc+0xd4/0x128
[c00000000079bd40] c0000000000b9af4 .kmem_cache_create+0x1f4/0x604
[c00000000079be30] c000000000546d98 .kmem_cache_init+0x1d8/0x4b0
[c00000000079bef0] c00000000052c748 .start_kernel+0x244/0x328
[c00000000079bf90] c0000000000084f8 .start_here_common+0x54/0x5c
0:mon>  

