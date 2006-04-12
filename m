Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWDLRH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWDLRH3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 13:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWDLRH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 13:07:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:62140 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932254AbWDLRH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 13:07:28 -0400
X-IronPort-AV: i="4.04,115,1144047600"; 
   d="scan'208"; a="22446653:sNHT55990067"
Date: Wed, 12 Apr 2006 10:07:26 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Mel Gorman <mel@skynet.ie>
Cc: linuxppc-dev@ozlabs.org, davej@codemonkey.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ak@suse.de,
       bob.picco@hp.com
Subject: Re: [PATCH 0/6] [RFC] Sizing zones and holes in an architecture independent manner
Message-ID: <20060412170726.GA11143@agluck-lia64.sc.intel.com>
References: <20060411103946.18153.83059.sendpatchset@skynet> <20060411222029.GA7743@agluck-lia64.sc.intel.com> <Pine.LNX.4.64.0604112352230.6624@skynet.skynet.ie> <20060412000500.GA8532@agluck-lia64.sc.intel.com> <Pine.LNX.4.64.0604121001590.24819@skynet.skynet.ie> <20060412154633.GA10589@agluck-lia64.sc.intel.com> <Pine.LNX.4.64.0604121657380.24819@skynet.skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604121657380.24819@skynet.skynet.ie>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2006 at 05:00:32PM +0100, Mel Gorman wrote:
> Patch is attached as 105-ia64_use_init_nodes.patch until I beat sense into 
> my mail setup. I've added Bob Picco to the cc list as he will hit the same 
> issue with whitespace corruption.

Next I tried building a "generic" kernel (using arch/ia64/defconfig). This
has NUMA=y and DISCONTIG=y).  This crashes with the following console log.


-Tony

Linux version 2.6.17-rc1-tiger-smpxx (aegl@linux-t10) (gcc version 3.4.3 20050227 (Red Hat 3.4.3-22.1)) #2 SMP Wed Apr 12 09:41:12 PDT 2006
EFI v1.10 by INTEL: SALsystab=0x7fe54980 ACPI=0x7ff84000 ACPI 2.0=0x7ff83000 MPS=0x7ff82000 SMBIOS=0xf0000
booting generic kernel on platform dig
Early serial console at I/O port 0x2f8 (options '115200')
Initial ramdisk at: 0xe0000001fedf5000 (1303564 bytes)
SAL 3.20: Intel Corp                       SR870BN4                         version 3.0
SAL Platform features: BusLock IRQ_Redirection
SAL: AP wakeup using external interrupt vector 0xf0
No logical to physical processor mapping available
iosapic_system_init: Disabling PC-AT compatible 8259 interrupts
ACPI: Local APIC address c0000000fee00000
PLATFORM int CPEI (0x3): GSI 22 (level, low) -> CPU 0 (0xc618) vector 30
register_intr: changing vector 39 from IO-SAPIC-edge to IO-SAPIC-level
4 CPUs available, 4 CPUs total
MCA related initialization done
add_active_range(0, 0, 4096): New
add_active_range(0, 0, 131072): New
add_active_range(0, 0, 131072): New
add_active_range(0, 393216, 523264): New
add_active_range(0, 393216, 523264): New
add_active_range(0, 393216, 524288): New
add_active_range(0, 393216, 524288): New
Virtual mem_map starts at 0xa0007ffffe400000
Dumping sorted node map
entry 0: 0  0 -> 131072
entry 1: 0  0 -> 4096
entry 2: 0  0 -> 131072
entry 3: 0  393216 -> 523264
entry 4: 0  393216 -> 524288
entry 5: 0  393216 -> 524288
entry 6: 0  393216 -> 523264
Hole found index 0: 0 -> 0
prev_end > start_pfn : 131072 > 0
kernel BUG at mm/mem_init.c:775!
swapper[0]: bugcheck! 0 [1]
Modules linked in:

Pid: 0, CPU 0, comm:              swapper
psr : 00001010084a2010 ifs : 800000000000048d ip  : [<a000000100803b40>]    Not tainted
ip is at zone_absent_pages_in_node+0x1c0/0x260
unat: 0000000000000000 pfs : 000000000000048d rsc : 0000000000000003
rnat: 0000000000000090 bsps: 000000000001003e pr  : 80000000afb566ab
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70433f
csd : 0930ffff00090000 ssd : 0930ffff00090000
b0  : a000000100803b40 b6  : a0000001003bfe00 b7  : a0000001003bfbc0
f6  : 0fffbccccccccc8c00000 f7  : 0ffdc8dc0000000000000
f8  : 10001e000000000000000 f9  : 10002a000000000000000
f10 : 0fffeb33333332fa80000 f11 : 1003e0000000000000000
r1  : a000000100bfb890 r2  : 0000000000000000 r3  : a000000100a125d8
r8  : 0000000000000024 r9  : a000000100a125c8 r10 : 0000000000000fff
r11 : 0000000000ffffff r12 : a00000010084fd60 r13 : a000000100848000
r14 : 0000000000004000 r15 : a000000100a125e0 r16 : 00000000000002f9
r17 : a000000100a125d0 r18 : ffffffffffffffff r19 : 0000000000000000
r20 : a000000100a37a20 r21 : a000000100a117c0 r22 : 0000000000000000
r23 : a000000100a125f0 r24 : a0000001008cfaa8 r25 : a0000001008cfaa0
r26 : a0000001009fbae0 r27 : 00000010084a2010 r28 : a000000100ac9221
r29 : 0000000000000809 r30 : 0000000000000000 r31 : a000000100a125a0
Unable to handle kernel NULL pointer dereference (address 0000000000000000)
swapper[0]: Oops 8813272891392 [2]
Modules linked in:

Pid: 0, CPU 0, comm:              swapper
psr : 0000101008022018 ifs : 8000000000000308 ip  : [<a000000100124940>]    Not tainted
ip is at kmem_cache_alloc+0xa0/0x160
unat: 0000000000000000 pfs : 0000000000000793 rsc : 0000000000000003
rnat: 0000000000000000 bsps: 0000000000000000 pr  : 80000000afb56967
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0930ffff00090000 ssd : 0930ffff00090000
b0  : a00000010003e6c0 b6  : a00000010003f4a0 b7  : a00000010000d090
f6  : 1003ea321ff35f9fb4c36 f7  : 1003e9e3779b97f4a7c16
f8  : 1003e0a00000010001231 f9  : 1003e000000000000007f
f10 : 1003e0000000000000379 f11 : 1003e6db6db6db6db6db7
r1  : a000000100bfb890 r2  : 0000000000000000 r3  : a000000100848018
r8  : 0000000000000000 r9  : 0000000000000000 r10 : 0000000000000000
r11 : 0000000000000000 r12 : a00000010084f1b0 r13 : a000000100848000
r14 : 0000000000000000 r15 : 0000000018000000 r16 : a00000010084f240
r17 : a000000100848f64 r18 : a0000001008c6cb8 r19 : a00000010084f23c
r20 : a00000010084f238 r21 : 000000007fffffff r22 : 0000000000000000
r23 : 0000000000000050 r24 : a000000100012310 r25 : a0000001000122c0
r26 : a0000001008d7870 r27 : a0000001009fc818 r28 : a0000001008ce020
r29 : 0000000000000002 r30 : 0000000000000002 r31 : 00000000000000c8
