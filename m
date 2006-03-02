Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWCBGOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWCBGOv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 01:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWCBGOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 01:14:51 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:3987 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751271AbWCBGOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 01:14:50 -0500
Date: Wed, 1 Mar 2006 22:14:29 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       yanmin.zhang@intel.com, neilb@cse.unsw.edu.au
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
Message-Id: <20060301221429.c61b4ae6.pj@sgi.com>
In-Reply-To: <20060301202058.42975408.akpm@osdl.org>
References: <20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
	<20060228201040.34a1e8f5.pj@sgi.com>
	<m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
	<20060228212501.25464659.pj@sgi.com>
	<20060228234807.55f1b25f.pj@sgi.com>
	<20060301002631.48e3800e.akpm@osdl.org>
	<20060301015338.b296b7ad.pj@sgi.com>
	<20060301192103.GA14320@kroah.com>
	<20060301125802.cce9ef51.pj@sgi.com>
	<20060301213048.GA17251@kroah.com>
	<20060301142631.22738f2d.akpm@osdl.org>
	<20060301151000.5fff8ec5.pj@sgi.com>
	<20060301154040.a7cb2afd.pj@sgi.com>
	<20060301202058.42975408.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It'd be interesting to see if just the data structure expansion:

Nice guess.

It still crashes on boot.

Details:

 1) Working in your 2.6.16-rc5-mm1 stack.
 2) Commented out gregkh-driver-put_device-might_sleep.patch
 3) With gregkh-driver-empty_release_functions_are_broken.patch on top
 4) Then push your "just the data structure expansion" patch on top of that
 5) If CONFIG_DEBUG_SPINLOCK and CONFIG_DEBUG_SPINLOCK_SLEEP enabled:
	dies trying to boot
 6) But if these SPINLOCK debug are not enabled:
	boots fine

The boot panic this time looks like the others at first glance:

========================== begin ==========================
Uncompressing Linux... donei(3|0)/Scsi(Pun2,Lun0)/HD(Part8,Sig461D0E2E-AD03-4C5ELoading file initrd...done
Linux version 2.6.16-rc5 (pj@jackhammer) (gcc version 3.3.3 (SuSE Linux)) #35 SMP PREEMPT Wed Mar 1 22:01:20 PST 2006
EFI v1.10 by INTEL: SALsystab=0x230027c9070 ACPI 2.0=0x230027c9840
Number of logical nodes in system = 2
Number of memory chunks in system = 2
Initial ramdisk at: 0xe00002bc39fa3000 (4386320 bytes)
SAL 2.9: SGI SN2 version 4.32
SAL Platform features: ITC_Drift
SAL: AP wakeup using external interrupt vector 0x12
No logical to physical processor mapping available
ACPI: Local APIC address c0000000fee00000
ACPI: Error parsing MADT - no IOSAPIC entries
register_intr: No IOSAPIC for GSI 52
4 CPUs available, 4 CPUs total
Increasing MCA rendezvous timeout from 20000 to 49000 milliseconds
MCA related initialization done
SGI SAL version 4.32
Virtual mem_map starts at 0xa0007ffd43c40000
Built 2 zonelists
Kernel command line: BOOT_IMAGE=scsi2:\efi\SuSE\vmlinuz.pj5 root=/dev/sdb6 selinux=0  console=ttySG0 splash=silent thash_entries=2097152 ro
PID hash table entries: 4096 (order: 12, 131072 bytes)
Console: colour dummy device 80x25
Memory: 7567392k/7730224k available (6861k code, 180128k reserved, 3925k data, 368k init)
McKinley Errata 9 workaround not needed; disabling it
Dentry cache hash table entries: 1048576 (order: 9, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 8, 4194304 bytes)
Mount-cache hash table entries: 1024
Boot processor id 0x0/0x8
Brought up 4 CPUs
Total of 4 processors activated (7782.40 BogoMIPS).
migration_cost=7609,38217
checking if image is initramfs... it is
Freeing initrd memory: 4272kB freed
NET: Registered protocol family 16
ACPI: bus type pci registered

                Altix IO Topology Information
                *****************************


Serial Number:N0000015

PCI SEGMENT PCIBUS NUMBER     BRICK  RACK:SLOT  BUS       CONNECTION TOPOLOGY
----------- -------------     ---------------------       -------------------
  0x0001        0x01         IXbrick  001:27    01      001c24:slab0:widget12:bus0
  0x0002        0x01         IXbrick  001:27    02      001c24:slab0:widget12:bus1
  0x0003        0x01         IXbrick  001:27    03      001c24:slab0:widget15:bus0
  0x0004        0x01         IXbrick  001:27    04      001c24:slab0:widget15:bus1
  0x0005        0x01         IXbrick  001:27    05      001c24:slab0:widget13:bus0
  0x0006        0x01         IXbrick  001:27    06      001c24:slab0:widget13:bus1

PROM version < 4.50 -- implementing old PROM flush WAR
ACPI: Subsystem revision 20060210
ACPI: SCI (ACPI GSI 52) not registered
ACPI: Interpreter enabled
ACPI: Using IOSAPIC for interrupt routing
SCSI subsystem initialized
perfmon: version 2.0 IRQ 238
perfmon: Itanium 2 PMU detected, 16 PMCs, 18 PMDs, 4 counters (47 bits)
PAL Information Facility v0.5
perfmon: added sampling format default_format
perfmon_default_smpl: default_format v2.0 registered
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 2048 (order 0, 16384 bytes)
SGI XFS with ACLs, realtime, large block/inode numbers, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
SGI Altix RTC Timer: v2.1, 20 MHz
EFI Time Services Driver v0.4
Linux agpgart interface v0.101 (c) Dave Jones
sn_console: Console driver init
ttySG0 at I/O 0x0 (irq = 0) is a SGI SN L1
Unable to handle kernel NULL pointer dereference (address 0000000000000058)
swapper[1]: Oops 8813272891392 [1]
Modules linked in:

Pid: 1, CPU 0, comm:              swapper
psr : 0000101008026018 ifs : 800000000000040b ip  : [<a0000001001ea870>]    Not tainted
ip is at sysfs_create_group+0x30/0x2a0
unat: 0000000000000000 pfs : 0000000000000308 rsc : 0000000000000003
rnat: 0000000002000027 bsps: 0000000000000002 pr  : 0000000000005649
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70433f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a000000100809190 b6  : e000023002310080 b7  : a0000001008091e0
f6  : 1003e0000000000000000 f7  : 1003e20c49ba5e353f7cf
f8  : 1003e0000000000003398 f9  : 1003e000000000000007f
f10 : 1003e0000000000000000 f11 : 1003e0000000000000000
r1  : a000000100c70c70 r2  : 0000000000000058 r3  : a000000100a80fa0
r8  : 0000000000000000 r9  : a000000100c95820 r10 : ffffffffffffffff
r11 : 0000000000000400 r12 : e00002343bd97d50 r13 : e00002343bd90000
r14 : a000000100a831e8 r15 : a000000100c95820 r16 : a000000100a80fa8
r17 : 00000000000003c0 r18 : 0000000000000001 r19 : 0000000000000002
r20 : ffffffffffffffff r21 : 0000000000000000 r22 : 000000000000000e
r23 : a000000100a72058 r24 : a000000100812c40 r25 : a000000100a77648
r26 : a000000100a88b10 r27 : a0000001008f3b88 r28 : e00002bc3a0432f0
r29 : 0000000000000001 r30 : a0000001007cfdc8 r31 : a0000001008091e0

Call Trace:
 [<a0000001000132c0>] show_stack+0x40/0xa0
                                sp=e00002343bd978e0 bsp=e00002343bd91278
 [<a000000100013af0>] show_regs+0x7d0/0x800
                                sp=e00002343bd97ab0 bsp=e00002343bd91228
 [<a000000100036df0>] die+0x210/0x320
                                sp=e00002343bd97ab0 bsp=e00002343bd911d8
 [<a00000010005a840>] ia64_do_page_fault+0x900/0xa80
                                sp=e00002343bd97ad0 bsp=e00002343bd91178
 [<a00000010000bd00>] ia64_leave_kernel+0x0/0x290
                                sp=e00002343bd97b80 bsp=e00002343bd91178
 [<a0000001001ea870>] sysfs_create_group+0x30/0x2a0
                                sp=e00002343bd97d50 bsp=e00002343bd91120
 [<a000000100809190>] topology_cpu_callback+0x70/0xc0
                                sp=e00002343bd97d60 bsp=e00002343bd910f0
 [<a000000100809260>] topology_sysfs_init+0x80/0x120
                                sp=e00002343bd97d60 bsp=e00002343bd910d0
 [<a000000100009860>] init+0x580/0x8e0
                                sp=e00002343bd97d60 bsp=e00002343bd910a8
 [<a000000100011780>] kernel_thread_helper+0xe0/0x100
                                sp=e00002343bd97e30 bsp=e00002343bd91080
 [<a000000100009140>] start_kernel_thread+0x20/0x40
                                sp=e00002343bd97e30 bsp=e00002343bd91080
 <0>Kernel panic - not syncing: Attempted to kill init!
=========================== end ===========================

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
