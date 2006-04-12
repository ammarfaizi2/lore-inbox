Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWDLAFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWDLAFE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 20:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWDLAFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 20:05:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:36509 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751141AbWDLAFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 20:05:02 -0400
X-IronPort-AV: i="4.04,113,1144047600"; 
   d="scan'208"; a="22139125:sNHT454514081"
Date: Tue, 11 Apr 2006 17:05:00 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Mel Gorman <mel@skynet.ie>
Cc: linuxppc-dev@ozlabs.org, davej@codemonkey.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: Re: [PATCH 0/6] [RFC] Sizing zones and holes in an architecture independent manner
Message-ID: <20060412000500.GA8532@agluck-lia64.sc.intel.com>
References: <20060411103946.18153.83059.sendpatchset@skynet> <20060411222029.GA7743@agluck-lia64.sc.intel.com> <Pine.LNX.4.64.0604112352230.6624@skynet.skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604112352230.6624@skynet.skynet.ie>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2006 at 12:23:45AM +0100, Mel Gorman wrote:
> Darn.
> 
> o Did it boot on other IA64 machines or was the Tiger the first boot failure?

I only tried to boot on the Tiger.

> o Possibly a stupid question but does the Tiger configuration use the
>    flatmem memory model, sparsemem or discontig?

I built using arch/ia64/configs/tiger_defconfig - a FLATMEM config with
VIRT_MEM_MAP=y.  The machine has 4G of memory, 2G at 0-2G, and 2G at 6G-8G
(so it is somewhat sparse ... but this is pretty normal for an ia64 with
>2G).

> If it's flatmem, I noticed I made a stupid mistake where vmem_map is not 
> getting set to (void *)0 for machines with small memory holes. Nothing 
> else really obvious jumped out at me.
> 
> I've attached a patch called "105-ia64_use_init_nodes.patch". Can you 
> reverse Patch 5/6 and apply this one instead please? I've also attached 
> 107-debug.diff that applies on top of patch 6/6. It just prints out 
> debugging information during startup that may tell me where I went wrong 
> in arch/ia64. I'd really appreciate it if you could use both patches, let 
> me know if it still fails to boot and send me the console log of the 
> machine starting up if it fails so I can make guesses as to what is going 
> wrong.
> 
> Thanks a lot for trying the patches out on ia64. It was the one arch of 
> the set I had no chance to test with at all :/

Ok, I cloned a branch from patch4, applied the new patch 5, git-cherry-picked
patch 6, and then applied the debug patch7.

Here's the console log:

Linux version 2.6.17-rc1-tiger-smpxx (aegl@linux-t10) (gcc version 3.4.3 20050227 (Red Hat 3.4.3-22.1)) #2 SMP Tue Apr 11 16:45:31 PDT 2006
EFI v1.10 by INTEL: SALsystab=0x7fe54980 ACPI=0x7ff84000 ACPI 2.0=0x7ff83000 MPS=0x7ff82000 SMBIOS=0xf0000
Early serial console at I/O port 0x2f8 (options '115200')
Initial ramdisk at: 0xe0000001fedf5000 (1303568 bytes)
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
add_active_range(0, 16140901064512634880, 16140901066637049856): New
add_active_range(0, 16140901066641899520, 16140901066642489344): New
add_active_range(0, 16140901070938308608, 16140901073083760640): New
add_active_range(0, 16140901073084219392, 16140901073085480960): New
Dumping sorted node map
entry 0: 0  16140901064512634880 -> 16140901066637049856
entry 1: 0  16140901066641899520 -> 16140901066642489344
entry 2: 0  16140901070938308608 -> 16140901073083760640
entry 3: 0  16140901073084219392 -> 16140901073085480960
Virtual mem_map starts at 0x0000000000000000
SMP: Allowing 4 CPUs, 0 hotplug CPUs
Built 1 zonelists
Kernel command line: BOOT_IMAGE=scsi0:EFI\redhat\l-tiger-smpxx.gz  root=LABEL=/ console=uart,io,0x2f8 ro
PID hash table entries: 16 (order: 4, 128 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 1 (order: -11, 8 bytes)
Inode-cache hash table entries: 1 (order: -11, 8 bytes)
Placing software IO TLB between 0x4a84000 - 0x8a84000
kernel BUG at arch/ia64/mm/init.c:609!
swapper[0]: bugcheck! 0 [1]
Modules linked in:

Pid: 0, CPU 0, comm:              swapper
psr : 00001010084a6010 ifs : 800000000000040f ip  : [<a0000001007dd620>]    Not tainted
ip is at mem_init+0x80/0x580
unat: 0000000000000000 pfs : 000000000000040f rsc : 0000000000000003
rnat: a00000010095fd80 bsps: 00000000000002f9 pr  : 80000000afb5666b
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70433f
csd : 0930ffff00090000 ssd : 0930ffff00090000
b0  : a0000001007dd620 b6  : a0000001007f6ba0 b7  : a0000001003c27e0
f6  : 0fffbccccccccc8c00000 f7  : 0ffdbf300000000000000
f8  : 10001c000000000000000 f9  : 10002a000000000000000
f10 : 0fffe9999999996900000 f11 : 1003e0000000000000000
r1  : a000000100b460d0 r2  : 0000000000000000 r3  : a00000010095cba0
r8  : 000000000000002a r9  : a00000010095cb90 r10 : 00000000000002f9
r11 : 00000000000be000 r12 : a00000010080fe10 r13 : a000000100808000
r14 : 0000000000004000 r15 : a00000010095cba8 r16 : 0000000000000001
r17 : a00000010095cb98 r18 : ffffffffffffffff r19 : a00000010095fd88
r20 : 00000000000000be r21 : a00000010095bd50 r22 : 0000000000000000
r23 : a00000010095cbb8 r24 : a00000010087f7e8 r25 : a00000010087f7e0
r26 : a000000100946308 r27 : 00000010084a6010 r28 : 00000000000002f9
r29 : 00000000000002f8 r30 : 0000000000000000 r31 : a00000010095cb68
Unable to handle kernel NULL pointer dereference (address 0000000000000000)
swapper[0]: Oops 11012296146944 [2]
Modules linked in:

Pid: 0, CPU 0, comm:              swapper
psr : 0000121008022018 ifs : 8000000000000287 ip  : [<a000000100116b81>]    Not tainted
ip is at kmem_cache_alloc+0x41/0x100
unat: 0000000000000000 pfs : 0000000000000793 rsc : 0000000000000003
rnat: 0000000000000000 bsps: 0000000000000000 pr  : 80000000afb56967
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0930ffff00090000 ssd : 0930ffff00090000
b0  : a00000010003d820 b6  : a00000010003e600 b7  : a00000010000c9d0
f6  : 1003ea08f5c3b783104ea f7  : 1003e9e3779b97f4a7c16
f8  : 1003e0a0000001000117f f9  : 1003e000000000000007f
f10 : 1003e0000000000000379 f11 : 1003e6db6db6db6db6db7
r1  : a000000100b460d0 r2  : 0000000000000000 r3  : a000000100949240
r8  : 0000000000000000 r9  : 0000000000000000 r10 : 0000000000000000
r11 : a000000100808f14 r12 : a00000010080f260 r13 : a000000100808000
r14 : 0000000000000000 r15 : 000000000000000f r16 : a00000010080f2f0
r17 : 0000000000000000 r18 : a000000100876bd8 r19 : a00000010080f2ec
r20 : a00000010080f2e8 r21 : 000000007fffffff r22 : 0000000000000000
r23 : 0000000000000050 r24 : a0000001000117f0 r25 : a0000001000117a0
r26 : a000000100885480 r27 : a000000100946fb0 r28 : a00000010087df40
r29 : 0000000000000002 r30 : 0000000000000002 r31 : 00000000000000c0
