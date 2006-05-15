Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWEOIXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWEOIXS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 04:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWEOIXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 04:23:18 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:8202 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S964800AbWEOIXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 04:23:17 -0400
Message-ID: <44683A09.2060404@shadowen.org>
Date: Mon, 15 May 2006 09:21:29 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Mel Gorman <mel@csn.ul.ie>, davej@codemonkey.org.uk, tony.luck@intel.com,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, ak@suse.de,
       linux-mm@kvack.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/6] Have ia64 use add_active_range() and free_area_init_nodes
References: <20060508141030.26912.93090.sendpatchset@skynet>	<20060508141211.26912.48278.sendpatchset@skynet> <20060514203158.216a966e.akpm@osdl.org>
In-Reply-To: <20060514203158.216a966e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Mel Gorman <mel@csn.ul.ie> wrote:
> 
>>Size zones and holes in an architecture independent manner for ia64.
>>
> 
> 
> This one makes my ia64 die very early in boot.   The trace is pretty useless.
> 
> config at http://www.zip.com.au/~akpm/linux/patches/stuff/config-ia64
> 
> EFI v1.10 by INTEL: SALsystab=0x3fe4c8c0 ACPI=0x3ff84000 ACPI 2.0=0x3ff83000 MP0
> Early serial console at I/O port 0x2f8 (options '9600n8')
> SAL 3.1: Intel Corp                       SR870BN4                         vers0
> SAL Platform features: BusLock IRQ_Redirection
> SAL: AP wakeup using external interrupt vector 0xf0
> No logical to physical processor mapping available
> iosapic_system_init: Disabling PC-AT compatible 8259 interrupts
> ACPI: Local APIC address c0000000fee00000
> PLATFORM int CPEI (0x3): GSI 22 (level, low) -> CPU 0 (0xc618) vector 30
> register_intr: changing vector 39 from IO-SAPIC-edge to IO-SAPIC-level
> 4 CPUs available, 4 CPUs total
> MCA related initialization done
> node 0 zone DMA missaligned start pfn, enable UNALIGNED_ZONE_BOUNDRIES
> node 0 zone DMA32 missaligned start pfn, enable UNALIGNED_ZONE_BOUNDRIES
> node 0 zone Normal missaligned start pfn, enable UNALIGNED_ZONE_BOUNDRIES
> node 0 zone HighMem missaligned start pfn, enable UNALIGNED_ZONE_BOUNDRIES
> SMP: Allowing 4 CPUs, 0 hotplug CPUs
> Built 1 zonelists
> Kernel command line: BOOT_IMAGE=scsi0:\EFI\redhat\vmlinuz-2.6.17-rc4-mm1 root=/o
> PID hash table entries: 4096 (order: 12, 32768 bytes)
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 131072 (order: 6, 1048576 bytes)
> Inode-cache hash table entries: 65536 (order: 5, 524288 bytes)
> Placing software IO TLB between 0x4a30000 - 0x8a30000
> Unable to handle kernel NULL pointer dereference (address 0000000000000008)
> swapper[0]: Oops 8813272891392 [1]
> Modules linked in:
> 
> Pid: 0, CPU 0, comm:              swapper
> psr : 00001010084a6010 ifs : 800000000000060f ip  : [<a0000001000e6750>]    Notd
> ip is at __free_pages_ok+0x190/0x3c0
> unat: 0000000000000000 pfs : 000000000000060f rsc : 0000000000000003
> rnat: 0000000000ffffff bsps: 00000000000002f9 pr  : 80000000afb5956b
> ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70433f
> csd : 0930ffff00090000 ssd : 0930ffff00090000
> b0  : a0000001000e6660 b6  : e00000003fe52940 b7  : a000000100790120
> f6  : 1003e6db6db6db6db6db7 f7  : 1003e000000000006dec0
> f8  : 1003e000000000000fb80 f9  : 1003e000000000006e080
> f10 : 1003e000000000000fb40 f11 : 1003e000000000006dec0
> r1  : a000000100af2db0 r2  : 0000000000000001 r3  : 0000000000000000
> r8  : a0000001008f3d38 r9  : 0000000000004000 r10 : 0000000000370400
> r11 : 0000000000004000 r12 : a0000001007b7e10 r13 : a0000001007b0000
> r14 : 0000000000000001 r15 : 0000000100000001 r16 : 0000000100000001
> r17 : 0000000100000001 r18 : 0000000000001041 r19 : 0000000000000000
> r20 : e00000000149df00 r21 : 0000000100000000 r22 : 0000000055555155
> r23 : 00000000ffffffff r24 : e00000000149df08 r25 : 1555555555555155
> r26 : 0000000000000032 r27 : 0000000000000000 r28 : 0000000000000008
> r29 : 0000000000001041 r30 : 0000000000001041 r31 : 0000000000000001
> Unable to handle kernel NULL pointer dereference (address 0000000000000000)
> swapper[0]: Oops 8813272891392 [2]
> Modules linked in:
> 
> Pid: 0, CPU 0, comm:              swapper
> psr : 0000101008022018 ifs : 8000000000000287 ip  : [<a0000001001236c0>]    Notd
> ip is at kmem_cache_alloc+0x40/0x100
> unat: 0000000000000000 pfs : 0000000000000712 rsc : 0000000000000003
> rnat: 0000000000000000 bsps: 0000000000000000 pr  : 80000000afb59967
> ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
> csd : 0930ffff00090000 ssd : 0930ffff00090000
> b0  : a00000010003e450 b6  : a000000100001b50 b7  : a00000010003f320
> f6  : 1003e9e3779b97f4a7c16 f7  : 0ffdb8000000000000000
> f8  : 1003e000000000000007f f9  : 1003e0000000000000379
> f10 : 1003e6db6db6db6db6db7 f11 : 1003e000000000000007f
> r1  : a000000100af2db0 r2  : 0000000000000000 r3  : 0000000000000000
> r8  : 0000000000000000 r9  : 0000000000000000 r10 : a0000001007b0f24
> r11 : 0000000000000000 r12 : a0000001007b7280 r13 : a0000001007b0000
> r14 : 0000000000000000 r15 : 0000000000000000 r16 : a0000001007b7310
> r17 : 0000000000000000 r18 : a0000001007b7478 r19 : 0000000000000000
> r20 : 0000000000000000 r21 : 0000000000000018 r22 : 0000000000000000
> r23 : 0000000000000000 r24 : 0000000000000000 r25 : a0000001007b7308
> r26 : 000000007fffffff r27 : a000000100825520 r28 : a0000001008f3c40
> r29 : a000000100816ca8 r30 : 0000000000000018 r31 : 0000000000000018
> 
> 
> 
> (gdb) l *0xa0000001000e6750
> 0xa0000001000e6750 is in __free_pages_ok (mm.h:324).
> 319     extern void FASTCALL(__page_cache_release(struct page *));
> 320     
> 321     static inline int page_count(struct page *page)
> 322     {
> 323             if (unlikely(PageCompound(page)))
> 324                     page = (struct page *)page_private(page);
> 325             return atomic_read(&page->_count);
> 326     }
> 327     
> 328     static inline void get_page(struct page *page)
> 
> 
> Note the misaligned pfns.
> 
> Andy's (misspelled) CONFIG_UNALIGNED_ZONE_BOUNDRIES patch didn't actually
> include an update to any Kconfig files.  But hacking that in by hand didn't
> help.

Interesting.  You are correct there was no config component, at the time
I didn't have direct evidence that any architecture needed it, only that
we had an unchecked requirement on zones, a requirement that had only
recently arrived with the changes to free buddy detection.  I note that
MAX_ORDER is 17 for ia64 so that probabally accounts for the
missalignment.  It is clear that the reporting is slightly over-zelous
as I am reporting zero-sized zones.  I'll get that fixed and patch to
you.  I'll also have a look at the patch as added to -mm and try and get
the rest of the spelling sorted :-/.

I'll go see if we currently have a machine to test this config on.

-apw
