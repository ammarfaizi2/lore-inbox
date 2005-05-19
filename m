Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVESVtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVESVtP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 17:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVESVtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 17:49:14 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:18415 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261274AbVESVqP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 17:46:15 -0400
Message-ID: <428D091C.9020902@us.ibm.com>
Date: Thu, 19 May 2005 14:46:04 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
CC: Dave Hansen <haveblue@us.ibm.com>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       shai@scalex86.org, steiner@sgi.com
Subject: Re: NUMA aware slab allocator V3
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com>  <Pine.LNX.4.62.0505161046430.1653@schroedinger.engr.sgi.com>  <714210000.1116266915@flay> <200505161410.43382.jbarnes@virtuousgeek.org>  <740100000.1116278461@flay>  <Pine.LNX.4.62.0505161713130.21512@graphe.net> <1116289613.26955.14.camel@localhost> <428A800D.8050902@us.ibm.com> <Pine.LNX.4.62.0505171648370.17681@graphe.net> <428B7B16.10204@us.ibm.com> <Pine.LNX.4.62.0505181046320.20978@schroedinger.engr.sgi.com> <428BB05B.6090704@us.ibm.com> <Pine.LNX.4.62.0505181439080.10598@graphe.net> <Pine.LNX.4.62.0505182105310.17811@graphe.net>
In-Reply-To: <Pine.LNX.4.62.0505182105310.17811@graphe.net>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060307040505090503050109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060307040505090503050109
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Christoph Lameter wrote:
> On Wed, 18 May 2005, Christoph Lameter wrote:
> 
> 
>>Fixes to the slab allocator in 2.6.12-rc4-mm2
>>- Remove MAX_NUMNODES check
>>- use for_each_node/cpu
>>- Fix determination of INDEX_AC
> 
> 
> Rats! The whole thing with cpu online and node online is not as easy as I 
> thought. There may be bugs in V3 of the numa slab allocator 
> because offline cpus and offline are not properly handled. Maybe 
> that also contributed to the ppc64 issues. 
>  
> The earlier patch fails if I boot an x86_64 NUMA kernel on a x86_64 single 
> processor system.
> 
> Here is a revised patch. Would be good if someone could review my use 
> of online_cpu / online_node etc. Is there some way to bring cpus 
> online and offline to test if this really works? Seems that the code in 
> alloc_percpu is suspect even in the old allocator because it may have
> to allocate memory for non present cpus.

I ran this patch on top of rc4-mm2 w/ my topology fix (to get it to
compile) and booting it resulted in this log.  Looks like it's hitting a
bug in mempolicy code?  My intuition tells me this is because Andrew
changed PPC64 to have a NODES_SHIFT of 0 (and hence a MAX_NUMNODES of 1),
so I'm retrying w/ that patch reverted.  I'll poke around to see it
anything else comes up, but this seems promising, since I got a completely
different panic with your old patch (and the NODES_SHIFT set to 0).

-Matt

--------------060307040505090503050109
Content-Type: text/plain;
 name="console.log.new"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="console.log.new"

IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 

          1 = SMS Menu                          5 = Default Boot List
          8 = Open Firmware Prompt              6 = Stored Boot List


     memory      keyboard     network     scsi     speaker 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM                                 IBM IBM IBM IBM IBM IBM
IBM IBM IBM IBM IBM IBM       STARTING SOFTWARE         IBM IBM IBM IBM IBM IBM
IBM IBM IBM IBM IBM IBM          PLEASE WAIT...         IBM IBM IBM IBM IBM IBM
IBM IBM IBM IBM IBM IBM                                 IBM IBM IBM IBM IBM IBM
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/
Elapsed time since release of system processors: 174425 mins 56 secs

Config file read, 1336 bytes
Welcome to yaboot version 1.3.11.SuSE
Enter "help" to get some basic usage information
boot: -- 0:conmux-control -- time-stamp -- May/19/05 13:39:50 --
autobench 
Please wait, loading kernel...
   Elf32 kernel loaded...

zImage starting: loaded at 0x400000
Allocating 0x8aa000 bytes for kernel ...
gunzipping (0x1c00000 <- 0x407000:0x67125a)...done 0x6ea568 bytes
0xd7e8 bytes of heap consumed, max in use 0xa248
initrd head: 0x0
OF stdout device is: /vdevice/vty@30000000
Hypertas detected, assuming LPAR !
command line: root=/dev/sda3 selinux=0 elevator=cfq autobench_args:   
memory layout at init:
  memory_limit : 0000000000000000 (16 MB aligned)
  alloc_bottom : 00000000023be000
  alloc_top    : 0000000008000000
  alloc_top_hi : 0000000100000000
  rmo_top      : 0000000008000000
  ram_top      : 0000000100000000
Looking for displays
instantiating rtas at 0x00000000077d9000... done
0000000000000000 : boot cpu     0000000000000000
0000000000000002 : starting cpu hw idx 0000000000000002... done
copying OF device tree ...
Building dt strings...
Building dt structure...
Device tree strings 0x00000000024bf000 -> 0x00000000024c01a9
Device tree struct  0x00000000024c1000 -> 0x00000000024c9000
Calling quiesce ...
returning from prom_init
firmware_features = 0x1ffd5f
Partition configured for 4 cpus.
Starting Linux PPC64 2.6.12-rc4-mm2-autokern1
-----------------------------------------------------
ppc64_pft_size                = 0x1a
ppc64_debug_switch            = 0x0
ppc64_interrupt_controller    = 0x2
systemcfg                     = 0xc000000000520000
systemcfg->platform           = 0x101
systemcfg->processorCount     = 0x4
systemcfg->physicalMemorySize = 0x100000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0x0000000000000000
htab_hash_mask                = 0x7ffff
-----------------------------------------------------
[boot]0100 MM Init
[boot]0100 MM Init Done
Linux version 2.6.12-rc4-mm2-autokern1 (root@gekko-lp1) (gcc version 3.3.3-hammer) #1 SMP Thu May 19 17:39:58 CDT 2005
[boot]0012 Setup Arch
WARNING: memory at 48000000 maps to invalid NUMA node 1
WARNING: memory at 50000000 maps to invalid NUMA node 1
WARNING: memory at 58000000 maps to invalid NUMA node 1
WARNING: memory at 60000000 maps to invalid NUMA node 1
WARNING: memory at 68000000 maps to invalid NUMA node 1
WARNING: memory at 70000000 maps to invalid NUMA node 1
WARNING: memory at 78000000 maps to invalid NUMA node 1
WARNING: memory at 80000000 maps to invalid NUMA node 1
WARNING: memory at 88000000 maps to invalid NUMA node 2
WARNING: memory at 90000000 maps to invalid NUMA node 2
WARNING: memory at 98000000 maps to invalid NUMA node 2
WARNING: memory at a0000000 maps to invalid NUMA node 2
WARNING: memory at a8000000 maps to invalid NUMA node 2
WARNING: memory at b0000000 maps to invalid NUMA node 2
WARNING: memory at b8000000 maps to invalid NUMA node 2
WARNING: memory at c0000000 maps to invalid NUMA node 2
WARNING: memory at c8000000 maps to invalid NUMA node 3
WARNING: memory at d0000000 maps to invalid NUMA node 3
WARNING: memory at d8000000 maps to invalid NUMA node 3
WARNING: memory at e0000000 maps to invalid NUMA node 3
WARNING: memory at e8000000 maps to invalid NUMA node 3
WARNING: memory at f0000000 maps to invalid NUMA node 3
WARNING: memory at f8000000 maps to invalid NUMA node 3
Node 0 Memory: 0x0-0x100000000
Syscall map setup, 234 32 bits and 210 64 bits syscalls
No ramdisk, default root is /dev/sda2
EEH: PCI Enhanced I/O Error Handling Enabled
PPC64 nvram contains 7168 bytes
Using dedicated idle loop
[boot]0015 Setup Done
Built 1 zonelists
Kernel command line: root=/dev/sda3 selinux=0 elevator=cfq autobench_args:   
[boot]0020 XICS Init
xics: no ISA interrupt controller
[boot]0021 XICS Done
PID hash table entries: 4096 (order: 12, 131072 bytes)
time_init: decrementer frequency = 238.058000 MHz
time_init: processor frequency   = 1904.464000 MHz
firmware_features = 0x1ffd5f
Partition configured for 4 cpus.
Starting Linux PPC64 2.6.12-rc4-mm2-autokern1
-----------------------------------------------------
ppc64_pft_size                = 0x1a
ppc64_debug_switch            = 0x0
ppc64_interrupt_controller    = 0x2
systemcfg                     = 0xc000000000520000
systemcfg->platform           = 0x101
systemcfg->processorCount     = 0x4
systemcfg->physicalMemorySize = 0x100000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0x0000000000000000
htab_hash_mask                = 0x7ffff
-----------------------------------------------------
[boot]0100 MM Init
[boot]0100 MM Init Done
Linux version 2.6.12-rc4-mm2-autokern1 (root@gekko-lp1) (gcc version 3.3.3-hammer) #1 SMP Thu May 19 17:39:58 CDT 2005
[boot]0012 Setup Arch
WARNING: memory at 48000000 maps to invalid NUMA node 1
WARNING: memory at 50000000 maps to invalid NUMA node 1
WARNING: memory at 58000000 maps to invalid NUMA node 1
WARNING: memory at 60000000 maps to invalid NUMA node 1
WARNING: memory at 68000000 maps to invalid NUMA node 1
WARNING: memory at 70000000 maps to invalid NUMA node 1
WARNING: memory at 78000000 maps to invalid NUMA node 1
WARNING: memory at 80000000 maps to invalid NUMA node 1
WARNING: memory at 88000000 maps to invalid NUMA node 2
WARNING: memory at 90000000 maps to invalid NUMA node 2
WARNING: memory at 98000000 maps to invalid NUMA node 2
WARNING: memory at a0000000 maps to invalid NUMA node 2
WARNING: memory at a8000000 maps to invalid NUMA node 2
WARNING: memory at b0000000 maps to invalid NUMA node 2
WARNING: memory at b8000000 maps to invalid NUMA node 2
WARNING: memory at c0000000 maps to invalid NUMA node 2
WARNING: memory at c8000000 maps to invalid NUMA node 3
WARNING: memory at d0000000 maps to invalid NUMA node 3
WARNING: memory at d8000000 maps to invalid NUMA node 3
WARNING: memory at e0000000 maps to invalid NUMA node 3
WARNING: memory at e8000000 maps to invalid NUMA node 3
WARNING: memory at f0000000 maps to invalid NUMA node 3
WARNING: memory at f8000000 maps to invalid NUMA node 3
Node 0 Memory: 0x0-0x100000000
Syscall map setup, 234 32 bits and 210 64 bits syscalls
No ramdisk, default root is /dev/sda2
EEH: PCI Enhanced I/O Error Handling Enabled
PPC64 nvram contains 7168 bytes
Using dedicated idle loop
[boot]0015 Setup Done
Built 1 zonelists
Kernel command line: root=/dev/sda3 selinux=0 elevator=cfq autobench_args:   
[boot]0020 XICS Init
xics: no ISA interrupt controller
[boot]0021 XICS Done
PID hash table entries: 4096 (order: 12, 131072 bytes)
time_init: decrementer frequency = 238.058000 MHz
time_init: processor frequency   = 1904.464000 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
freeing bootmem node 0
Memory: 1088636k/4194304k available (4352k kernel code, 3104944k reserved, 1764k data, 849k bss, 280k init)
kernel BUG in interleave_nodes at mm/mempolicy.c:701!
Oops: Exception in kernel mode, sig: 5 [#1]
SMP NR_CPUS=128 NUMA PSERIES LPAR 
Modules linked in:
NIP: C0000000000AC6DC XER: 0000000D LR: C0000000000AD0CC CTR: C000000000267760
REGS: c00000000051fa10 TRAP: 0700   Not tainted  (2.6.12-rc4-mm2-autokern1)
MSR: 8000000000029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11 CR: 24004022
DAR: ffffffffffffffff DSISR: c0000000006e38e7
TASK: c0000000005bedb0[0] 'swapper' THREAD: c00000000051c000 CPU: 0
GPR00: 0000000000000001 C00000000051FC90 C0000000006D7380 C00000000FFDF590 
GPR04: 0000000000000000 FFFFFFFFFFFFFFFF C0000000006E39F8 C0000000005D8B24 
GPR08: C0000000005D8B18 0000000000000000 C0000000006E39F0 C0000000006E3910 
GPR12: 000000000000000A C000000000579C00 0000000000000000 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000001C10000 
GPR20: 0000000002111830 0000000002111830 BFFFFFFFFE3F0000 000000000199F9C0 
GPR24: C000000000579C00 C0000000006D5208 C000000000518E78 0000000000008000 
GPR28: 0000000000000000 00000000000080D0 C0000000005BEDB0 0000000000000001 
NIP [c0000000000ac6dc] .interleave_nodes+0x38/0xd0
LR [c0000000000ad0cc] .alloc_pages_current+0x100/0x134
Call Trace:
[c00000000051fc90] [000000000000001d] 0x1d (unreliable)
[c00000000051fd20] [c0000000000ad0cc] .alloc_pages_current+0x100/0x134
[c00000000051fdc0] [c00000000008c6c8] .get_zeroed_page+0x28/0x90
[c00000000051fe40] [c0000000004ec2e8] .pidmap_init+0x24/0xa0
[c00000000051fed0] [c0000000004d6734] .start_kernel+0x21c/0x314
[c00000000051ff90] [c00000000000bfb4] .__setup_cpu_power3+0x0/0x4
Instruction dump:
fba1ffe8 fbc1fff0 f8010010 f821ff71 60000000 ebcd0170 a93e07a0 793f0020 
7fe9fe70 7d20fa78 7c004850 54000ffe <0b000000> 3ba30010 38bf0001 38800001 
 <0>Kernel panic - not syncing: Attempted to kill the idle task!
 























IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 

          1 = SMS Menu                          5 = Default Boot List
          8 = Open Firmware Prompt              6 = Stored Boot List


     memory      keyboard     network     scsi     speaker 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM                                 IBM IBM IBM IBM IBM IBM
IBM IBM IBM IBM IBM IBM       STARTING SOFTWARE         IBM IBM IBM IBM IBM IBM
IBM IBM IBM IBM IBM IBM          PLEASE WAIT...         IBM IBM IBM IBM IBM IBM
IBM IBM IBM IBM IBM IBM                                 IBM IBM IBM IBM IBM IBM
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM IBM 
-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/
Elapsed time since release of system processors: 174429 mins 12 secs

Config file read, 1336 bytes
Welcome to yaboot version 1.3.11.SuSE
Enter "help" to get some basic usage information
boot: -- 0:conmux-control -- time-stamp -- May/19/05 13:43:05 --
autobench 
Please wait, loading kernel...
   Elf32 kernel loaded...

zImage starting: loaded at 0x400000
Allocating 0x8aa000 bytes for kernel ...
gunzipping (0x1c00000 <- 0x407000:0x67125a)...done 0x6ea568 bytes
0xd7e8 bytes of heap consumed, max in use 0xa248
initrd head: 0x0
OF stdout device is: /vdevice/vty@30000000
Hypertas detected, assuming LPAR !
command line: root=/dev/sda3 selinux=0 elevator=cfq autobench_args:   
memory layout at init:
  memory_limit : 0000000000000000 (16 MB aligned)
  alloc_bottom : 00000000023be000
  alloc_top    : 0000000008000000
  alloc_top_hi : 0000000100000000
  rmo_top      : 0000000008000000
  ram_top      : 0000000100000000
Looking for displays
instantiating rtas at 0x00000000077d9000... done
0000000000000000 : boot cpu     0000000000000000
0000000000000002 : starting cpu hw idx 0000000000000002... done
copying OF device tree ...
Building dt strings...
Building dt structure...
Device tree strings 0x00000000024bf000 -> 0x00000000024c01a9
Device tree struct  0x00000000024c1000 -> 0x00000000024c9000
Calling quiesce ...
returning from prom_init
firmware_features = 0x1ffd5f
Partition configured for 4 cpus.
Starting Linux PPC64 2.6.12-rc4-mm2-autokern1
-----------------------------------------------------
ppc64_pft_size                = 0x1a
ppc64_debug_switch            = 0x0
ppc64_interrupt_controller    = 0x2
systemcfg                     = 0xc000000000520000
systemcfg->platform           = 0x101
systemcfg->processorCount     = 0x4
systemcfg->physicalMemorySize = 0x100000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0x0000000000000000
htab_hash_mask                = 0x7ffff
-----------------------------------------------------
[boot]0100 MM Init
[boot]0100 MM Init Done
Linux version 2.6.12-rc4-mm2-autokern1 (root@gekko-lp1) (gcc version 3.3.3-hammer) #1 SMP Thu May 19 17:39:58 CDT 2005
[boot]0012 Setup Arch
WARNING: memory at 48000000 maps to invalid NUMA node 1
WARNING: memory at 50000000 maps to invalid NUMA node 1
WARNING: memory at 58000000 maps to invalid NUMA node 1
WARNING: memory at 60000000 maps to invalid NUMA node 1
WARNING: memory at 68000000 maps to invalid NUMA node 1
WARNING: memory at 70000000 maps to invalid NUMA node 1
WARNING: memory at 78000000 maps to invalid NUMA node 1
WARNING: memory at 80000000 maps to invalid NUMA node 1
WARNING: memory at 88000000 maps to invalid NUMA node 2
WARNING: memory at 90000000 maps to invalid NUMA node 2
WARNING: memory at 98000000 maps to invalid NUMA node 2
WARNING: memory at a0000000 maps to invalid NUMA node 2
WARNING: memory at a8000000 maps to invalid NUMA node 2
WARNING: memory at b0000000 maps to invalid NUMA node 2
WARNING: memory at b8000000 maps to invalid NUMA node 2
WARNING: memory at c0000000 maps to invalid NUMA node 2
WARNING: memory at c8000000 maps to invalid NUMA node 3
WARNING: memory at d0000000 maps to invalid NUMA node 3
WARNING: memory at d8000000 maps to invalid NUMA node 3
WARNING: memory at e0000000 maps to invalid NUMA node 3
WARNING: memory at e8000000 maps to invalid NUMA node 3
WARNING: memory at f0000000 maps to invalid NUMA node 3
WARNING: memory at f8000000 maps to invalid NUMA node 3
Node 0 Memory: 0x0-0x100000000
Syscall map setup, 234 32 bits and 210 64 bits syscalls
No ramdisk, default root is /dev/sda2
EEH: PCI Enhanced I/O Error Handling Enabled
PPC64 nvram contains 7168 bytes
Using dedicated idle loop
[boot]0015 Setup Done
Built 1 zonelists
Kernel command line: root=/dev/sda3 selinux=0 elevator=cfq autobench_args:   
[boot]0020 XICS Init
xics: no ISA interrupt controller
[boot]0021 XICS Done
PID hash table entries: 4096 (order: 12, 131072 bytes)
time_init: decrementer frequency = 238.058000 MHz
time_init: processor frequency   = 1904.464000 MHz
firmware_features = 0x1ffd5f
Partition configured for 4 cpus.
Starting Linux PPC64 2.6.12-rc4-mm2-autokern1
-----------------------------------------------------
ppc64_pft_size                = 0x1a
ppc64_debug_switch            = 0x0
ppc64_interrupt_controller    = 0x2
systemcfg                     = 0xc000000000520000
systemcfg->platform           = 0x101
systemcfg->processorCount     = 0x4
systemcfg->physicalMemorySize = 0x100000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0x0000000000000000
htab_hash_mask                = 0x7ffff
-----------------------------------------------------
[boot]0100 MM Init
[boot]0100 MM Init Done
Linux version 2.6.12-rc4-mm2-autokern1 (root@gekko-lp1) (gcc version 3.3.3-hammer) #1 SMP Thu May 19 17:39:58 CDT 2005
[boot]0012 Setup Arch
WARNING: memory at 48000000 maps to invalid NUMA node 1
WARNING: memory at 50000000 maps to invalid NUMA node 1
WARNING: memory at 58000000 maps to invalid NUMA node 1
WARNING: memory at 60000000 maps to invalid NUMA node 1
WARNING: memory at 68000000 maps to invalid NUMA node 1
WARNING: memory at 70000000 maps to invalid NUMA node 1
WARNING: memory at 78000000 maps to invalid NUMA node 1
WARNING: memory at 80000000 maps to invalid NUMA node 1
WARNING: memory at 88000000 maps to invalid NUMA node 2
WARNING: memory at 90000000 maps to invalid NUMA node 2
WARNING: memory at 98000000 maps to invalid NUMA node 2
WARNING: memory at a0000000 maps to invalid NUMA node 2
WARNING: memory at a8000000 maps to invalid NUMA node 2
WARNING: memory at b0000000 maps to invalid NUMA node 2
WARNING: memory at b8000000 maps to invalid NUMA node 2
WARNING: memory at c0000000 maps to invalid NUMA node 2
WARNING: memory at c8000000 maps to invalid NUMA node 3
WARNING: memory at d0000000 maps to invalid NUMA node 3
WARNING: memory at d8000000 maps to invalid NUMA node 3
WARNING: memory at e0000000 maps to invalid NUMA node 3
WARNING: memory at e8000000 maps to invalid NUMA node 3
WARNING: memory at f0000000 maps to invalid NUMA node 3
WARNING: memory at f8000000 maps to invalid NUMA node 3
Node 0 Memory: 0x0-0x100000000
Syscall map setup, 234 32 bits and 210 64 bits syscalls
No ramdisk, default root is /dev/sda2
EEH: PCI Enhanced I/O Error Handling Enabled
PPC64 nvram contains 7168 bytes
Using dedicated idle loop
[boot]0015 Setup Done
Built 1 zonelists
Kernel command line: root=/dev/sda3 selinux=0 elevator=cfq autobench_args:   
[boot]0020 XICS Init
xics: no ISA interrupt controller
[boot]0021 XICS Done
PID hash table entries: 4096 (order: 12, 131072 bytes)
time_init: decrementer frequency = 238.058000 MHz
time_init: processor frequency   = 1904.464000 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
freeing bootmem node 0
Memory: 1088636k/4194304k available (4352k kernel code, 3104944k reserved, 1764k data, 849k bss, 280k init)
kernel BUG in interleave_nodes at mm/mempolicy.c:701!
Oops: Exception in kernel mode, sig: 5 [#1]
SMP NR_CPUS=128 NUMA PSERIES LPAR 
Modules linked in:
NIP: C0000000000AC6DC XER: 0000000D LR: C0000000000AD0CC CTR: C000000000267760
REGS: c00000000051fa10 TRAP: 0700   Not tainted  (2.6.12-rc4-mm2-autokern1)
MSR: 8000000000029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11 CR: 24004022
DAR: ffffffffffffffff DSISR: c0000000006e38e7
TASK: c0000000005bedb0[0] 'swapper' THREAD: c00000000051c000 CPU: 0
GPR00: 0000000000000001 C00000000051FC90 C0000000006D7380 C00000000FFDF590 
GPR04: 0000000000000000 FFFFFFFFFFFFFFFF C0000000006E39F8 C0000000005D8B24 
GPR08: C0000000005D8B18 0000000000000000 C0000000006E39F0 C0000000006E3910 
GPR12: 000000000000000A C000000000579C00 0000000000000000 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000001C10000 
GPR20: 0000000002111830 0000000002111830 BFFFFFFFFE3F0000 000000000199F9C0 
GPR24: C000000000579C00 C0000000006D5208 C000000000518E78 0000000000008000 
GPR28: 0000000000000000 00000000000080D0 C0000000005BEDB0 0000000000000001 
NIP [c0000000000ac6dc] .interleave_nodes+0x38/0xd0
LR [c0000000000ad0cc] .alloc_pages_current+0x100/0x134
Call Trace:
[c00000000051fc90] [000000000000001d] 0x1d (unreliable)
[c00000000051fd20] [c0000000000ad0cc] .alloc_pages_current+0x100/0x134
[c00000000051fdc0] [c00000000008c6c8] .get_zeroed_page+0x28/0x90
[c00000000051fe40] [c0000000004ec2e8] .pidmap_init+0x24/0xa0
[c00000000051fed0] [c0000000004d6734] .start_kernel+0x21c/0x314
[c00000000051ff90] [c00000000000bfb4] .__setup_cpu_power3+0x0/0x4
Instruction dump:
fba1ffe8 fbc1fff0 f8010010 f821ff71 60000000 ebcd0170 a93e07a0 793f0020 
7fe9fe70 7d20fa78 7c004850 54000ffe <0b000000> 3ba30010 38bf0001 38800001 
 <0>Kernel panic - not syncing: Attempted to kill the idle task!
 -- 0:conmux-control -- time-stamp -- May/19/05 13:45:33 --

--------------060307040505090503050109--
