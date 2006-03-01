Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbWCAE67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWCAE67 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 23:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWCAE66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 23:58:58 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:52132 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750825AbWCAE66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 23:58:58 -0500
Date: Tue, 28 Feb 2006 20:58:50 -0800
From: Paul Jackson <pj@sgi.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
Message-Id: <20060228205850.5f26fbdb.pj@sgi.com>
In-Reply-To: <m1slq2pyyy.fsf@ebiederm.dsl.xmission.com>
References: <200603010120.k211KqVP009559@shell0.pdx.osdl.net>
	<20060228181849.faaf234e.pj@sgi.com>
	<20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
	<m1slq2pyyy.fsf@ebiederm.dsl.xmission.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I turned on the following debug:

> CONFIG_DEBUG_SLAB=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_SPINLOCK_SLEEP=y

and now *with* or *without* the following three patches,
it dies during system boot.

    proc-dont-lock-task_structs-indefinitely.patch
    proc-dont-lock-task_structs-indefinitely-git-nfs-fix.patch
    proc-dont-lock-task_structs-indefinitely-cpuset-fix.patch

I will start poping patches until one boots with these
DEBUG options.

My current config has the following options set:
    CONFIG_PREEMPT=y
    CONFIG_DEBUG_KERNEL=y
    CONFIG_DEBUG_SLAB=y
    CONFIG_DEBUG_SPINLOCK=y
    CONFIG_DEBUG_SPINLOCK_SLEEP=y
    CONFIG_DEBUG_MUTEXES=y

The entire failing boot output is:

Uncompressing Linux... donei(3|0)/Scsi(Pun2,Lun0)/HD(Part8,Sig461D0E2E-AD03-4C5ELoading file initrd...done
Linux version 2.6.16-rc5-mm1 (pj@jackhammer) (gcc version 3.3.3 (SuSE Linux)) #8 SMP PREEMPT Tue Feb 28 20:19:57 PST 2006
EFI v1.10 by INTEL: SALsystab=0x230027c9070 ACPI 2.0=0x230027c9840
Number of logical nodes in system = 2
Number of memory chunks in system = 2
Initial ramdisk at: 0xe00002bc39fa9000 (4386320 bytes)
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
Memory: 7567248k/7730080k available (6903k code, 180272k reserved, 4023k data, 384k init)
McKinley Errata 9 workaround not needed; disabling it
Dentry cache hash table entries: 1048576 (order: 9, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 8, 4194304 bytes)
Mount-cache hash table entries: 1024
Boot processor id 0x0/0x8
Brought up 4 CPUs
Total of 4 processors activated (7782.40 BogoMIPS).
migration_cost=7018,36910
checking if image is initramfs... it is
Freeing initrd memory: 4256kB freed
DMI not present or invalid.
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
psr : 0000101008026018 ifs : 800000000000040b ip  : [<a0000001001f1950>]    Not tainted
ip is at sysfs_create_group+0x30/0x2a0
unat: 0000000000000000 pfs : 0000000000000308 rsc : 0000000000000003
rnat: 0000000002000027 bsps: 0000000000000002 pr  : 0000000000005649
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70433f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a00000010081ad30 b6  : e000023002310080 b7  : a00000010081ad80
f6  : 1003e0000000000000000 f7  : 1003e20c49ba5e353f7cf
f8  : 1003e0000000000002ff0 f9  : 1003e0000000000000068
f10 : 1003e0000000000000000 f11 : 1003e0000000000000000
r1  : a000000100c93a70 r2  : 0000000000000058 r3  : a000000100aa3520
r8  : 0000000000000000 r9  : a000000100cba720 r10 : ffffffffffffffff
r11 : 0000000000000400 r12 : e00002343bdb7d50 r13 : e00002343bdb0000
r14 : a000000100aa4378 r15 : a000000100cba720 r16 : a000000100aa3528
r17 : 00000000000003c0 r18 : 0000000000000001 r19 : 0000000000000002
r20 : ffffffffffffffff r21 : 000000000000000e r22 : 0000000000000000
r23 : a000000100a94e80 r24 : a000000100824c80 r25 : a000000100aa3ad8
r26 : 0000000000004000 r27 : a000000100913e80 r28 : e00002300c6ff918
r29 : 0000000000000001 r30 : a0000001007d4ba8 r31 : a00000010081ad80

Call Trace:
 [<a000000100013280>] show_stack+0x40/0xa0
                                sp=e00002343bdb78e0 bsp=e00002343bdb1298
 [<a000000100013ab0>] show_regs+0x7d0/0x800
                                sp=e00002343bdb7ab0 bsp=e00002343bdb1248
 [<a000000100036970>] die+0x210/0x320
                                sp=e00002343bdb7ab0 bsp=e00002343bdb1200
 [<a00000010005a800>] ia64_do_page_fault+0x900/0xa80
                                sp=e00002343bdb7ad0 bsp=e00002343bdb1198
 [<a00000010000bbc0>] ia64_leave_kernel+0x0/0x290
                                sp=e00002343bdb7b80 bsp=e00002343bdb1198
 [<a0000001001f1950>] sysfs_create_group+0x30/0x2a0
                                sp=e00002343bdb7d50 bsp=e00002343bdb1140
 [<a00000010081ad30>] topology_cpu_callback+0x70/0xc0
                                sp=e00002343bdb7d60 bsp=e00002343bdb1110
 [<a00000010081ae00>] topology_sysfs_init+0x80/0x120
                                sp=e00002343bdb7d60 bsp=e00002343bdb10f0
 [<a000000100009860>] init+0x580/0x8e0
                                sp=e00002343bdb7d60 bsp=e00002343bdb10c8
 [<a000000100011740>] kernel_thread_helper+0xe0/0x100
                                sp=e00002343bdb7e30 bsp=e00002343bdb10a0
 [<a000000100009140>] start_kernel_thread+0x20/0x40
                                sp=e00002343bdb7e30 bsp=e00002343bdb10a0
 <0>Kernel panic - not syncing: Attempted to kill init!


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
