Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261299AbSI3S6K>; Mon, 30 Sep 2002 14:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbSI3S6K>; Mon, 30 Sep 2002 14:58:10 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:45271 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S261299AbSI3S6F>;
	Mon, 30 Sep 2002 14:58:05 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: cpufreq@www.linux.org.uk
Date: Mon, 30 Sep 2002 21:03:03 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: 2.5.39-bk crashes here when P4 clock modulation enabled
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <34AD4395CA4@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  if I enable P4_CLOCKMOD on my system (see dmesg below, family=15,
model=1, stepping=2), it oopses on next kmalloc after driver 
initialization. Are there any known problems with cpufreq? Misbehaving 
CPUs? 

  With P4_CLOCKMOD disabled everything works fine.

  I have instrumented kmem_check_poison_obj in my kernel to check that 
every byte in memory region is POISON_BYTE, not only that last byte is 
POISON_END (this is fprob in stack trace), and to my surprise it dies 
inside check because of it tries to access memory at 0x00000756 (ebp is 
start of region kmalloc is trying to use, eax is end-1, edx is currently
checked address). If I remove my patches, it dies simillar way in memchr()
in kmem_check_poision_obj. I did not tried it without slab poisoning.
It is 100% reproducible.
                                        Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz

(I'm not subscribed in cpufreq@www.linux.org.uk, so please CC either
me or linux-kernel)

...  
CONFIG_SMP=y
CONFIG_PREEMPT=y
# CONFIG_X86_NUMA is not set
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_CPU_FREQ=y
# CONFIG_CPU_FREQ_24_API is not set
CONFIG_CPU_FREQ_26_API=y
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_SPEEDSTEP is not set
CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
...
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SPINLOCK=y
...

Linux version 2.5.39-c655a (root@vana) (gcc version 2.95.4 20011002 (Debian prerelease)) #7 SMP Mon Sep 30 19:58:03 CEST 2002
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffc0000 (usable)
 BIOS-e820: 000000001ffc0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131008
  DMA zone: 4096 pages
  Normal zone: 126912 pages
  HighMem zone: 0 pages
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Linux ro root=301 ramdisk=0 devfs=nomount video=matrox:vesa:0x117,fv:100,lower:1 pciorder=1:0 video=scrollback:0 nmi_watchdog=2 console=ttyS0,9600 console=tty0
Found and enabled local APIC!
Initializing CPU#0
Detected 1595.043 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3137.53 BogoMIPS
Memory: 514564k/524032k available (1530k kernel code, 9080k reserved, 797k data, 124k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: Hyper-Threading is disabled
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Intel(R) Pentium(R) 4 CPU 1.60GHz stepping 02
per-CPU timeslice cutoff: 731.13 usecs.
task migration cache decay timeout: 1 msecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
testing NMI watchdog ... OK.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1594.0595 MHz.
..... host bus clock speed is 99.0662 MHz.
cpu: 0, clocks: 99662, slice: 3020
CPU0<T0:99648,T1:96624,D:4,S:3020,C:99662>
Starting migration thread for cpu 0
CPUS done 4294967295
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfda95, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge
PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Unable to handle kernel NULL pointer dereference at virtual address 00000756
 printing eip:
c013a340
*pde = 00000000
Oops: 0000
 
CPU:    0
EIP:    0060:[<c013a340>]    Not tainted
EFLAGS: 00010083
EIP is at fprob+0x10/0x28
eax: 00000795   ebx: c15092a8   ecx: c150e000   edx: 00000756
esi: c15092a0   edi: 00000040   ebp: 00000756   esp: c157ded8
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 1, threadinfo=c157c000 task=c157e080)
Stack: c013be5c 00000756 00000040 c040a560 c02fe784 00000000 c02feae0 00000007 
       c15092c4 00000752 00000246 c15092a0 c019c5c2 00000028 000001d0 c1573d9c 
       c02fe784 00000000 c02b09f5 00000000 c040a560 00198af1 c0198b06 c157df46 
Call Trace:
 [<c013be5c>]kmalloc+0x1e8/0x3d4
 [<c019c5c2>]devfs_alloc_devnum+0xee/0x1fc
 [<c0198b06>]_devfs_get_root_entry+0x13e/0x180
 [<c0198c3c>]_devfs_make_parent_for_leaf+0x24/0x138
 [<c0198d85>]_devfs_prepare_leaf+0x35/0xa4
 [<c0199bdf>]devfs_mk_dir+0x37/0xcc
 [<c01bca25>]misc_register+0xe9/0x170
 [<c0105101>]init+0x75/0x214
 [<c010508c>]init+0x0/0x214
 [<c01055a1>]kernel_thread_helper+0x5/0xc

Code: 80 3a 5a 75 0d 42 39 c2 72 f6 80 3a a5 75 06 31 c0 c3 89 d0 
 <0>Kernel panic: Attempted to kill init!
