Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751765AbWJGID2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbWJGID2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 04:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbWJGID2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 04:03:28 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:56189 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751765AbWJGIDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 04:03:23 -0400
Date: Sat, 7 Oct 2006 10:03:15 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>
Subject: Re: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot handle IRQ -1"
Message-ID: <20061007080315.GM14186@rhun.haifa.ibm.com>
References: <20061005212216.GA10912@rhun.haifa.ibm.com> <m11wpl328i.fsf@ebiederm.dsl.xmission.com> <20061006155021.GE14186@rhun.haifa.ibm.com> <m1d5951gm7.fsf@ebiederm.dsl.xmission.com> <20061006202324.GJ14186@rhun.haifa.ibm.com> <m1y7rtxb7z.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1y7rtxb7z.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 05:42:40PM -0600, Eric W. Biederman wrote:

> If I read your bootlog right. You have logical cpus, but only two
> sockets, and I think only two cores.  The other two logical cpus
> being hyperthreaded.

Yes, 2 sockets each of which is HT. Here's a /proc/cpuinfo from a
distro kernel:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 4
model name	:                Intel(R) Xeon(TM) MP CPU 3.16GHz
stepping	: 1
cpu MHz		: 3169.572
cache size	: 1024 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall lm pni monitor ds_cpl tm2 est cid cmpxchg16b
bogomips	: 6225.92
clflush size	: 64
cache_alignment	: 128
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 4
model name	:                Intel(R) Xeon(TM) MP CPU 3.16GHz
stepping	: 1
cpu MHz		: 3169.572
cache size	: 1024 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall lm pni monitor ds_cpl tm2 est cid cmpxchg16b
bogomips	: 6324.22
clflush size	: 64
cache_alignment	: 128
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 15
model		: 4
model name	:               Intel(R) Pentium(R) 4 CPU 3.16GHz
stepping	: 9
cpu MHz		: 3169.572
cache size	: 1024 KB
physical id	: 3
siblings	: 2
core id		: 3
cpu cores	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall lm pni monitor ds_cpl tm2 est cid cmpxchg16b
bogomips	: 6324.22
clflush size	: 64
cache_alignment	: 128
address sizes	: 40 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 15
model		: 4
model name	:               Intel(R) Pentium(R) 4 CPU 3.16GHz
stepping	: 9
cpu MHz		: 3169.572
cache size	: 1024 KB
physical id	: 3
siblings	: 2
core id		: 3
cpu cores	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall lm pni monitor ds_cpl tm2 est cid cmpxchg16b
bogomips	: 6324.22
clflush size	: 64
cache_alignment	: 128
address sizes	: 40 bits physical, 48 bits virtual
power management:

> Thanks for your help,

Thank you!

Here's the slightly modified patch I used:

diff -r 7e996b460ee5 arch/x86_64/kernel/io_apic.c
--- a/arch/x86_64/kernel/io_apic.c	Sat Oct 07 08:58:19 2006 +0200
+++ b/arch/x86_64/kernel/io_apic.c	Sat Oct 07 09:22:50 2006 +0200
@@ -46,6 +46,9 @@
 #include <asm/nmi.h>
 #include <asm/msidef.h>
 #include <asm/hypertransport.h>
+
+#undef KERN_DEBUG
+#define KERN_DEBUG ""
 
 static int assign_irq_vector(int irq, cpumask_t mask);
 
@@ -778,7 +781,7 @@ void __init UNEXPECTED_IO_APIC(void)
 {
 }
 
-void __apicdebuginit print_IO_APIC(void)
+void print_IO_APIC(void)
 {
 	int apic, i;
 	union IO_APIC_reg_00 reg_00;
@@ -786,8 +789,10 @@ void __apicdebuginit print_IO_APIC(void)
 	union IO_APIC_reg_02 reg_02;
 	unsigned long flags;
 
+#if 0
 	if (apic_verbosity == APIC_QUIET)
 		return;
+#endif /* 0 */
 
 	printk(KERN_DEBUG "number of MP IRQ sources: %d.\n", mp_irq_entries);
 	for (i = 0; i < nr_ioapics; i++)
diff -r 7e996b460ee5 arch/x86_64/kernel/irq.c
--- a/arch/x86_64/kernel/irq.c	Sat Oct 07 08:58:19 2006 +0200
+++ b/arch/x86_64/kernel/irq.c	Sat Oct 07 09:00:18 2006 +0200
@@ -18,6 +18,7 @@
 #include <asm/uaccess.h>
 #include <asm/io_apic.h>
 #include <asm/idle.h>
+#include <asm/hw_irq.h>
 
 atomic_t irq_err_count;
 
@@ -115,9 +116,17 @@ asmlinkage unsigned int do_IRQ(struct pt
 	irq = __get_cpu_var(vector_irq)[vector];
 
 	if (unlikely(irq >= NR_IRQS)) {
-		printk(KERN_EMERG "%s: cannot handle IRQ %d\n",
-					__FUNCTION__, irq);
-		BUG();
+		if (printk_ratelimit()) {
+			printk(KERN_EMERG "%s: cannot handle IRQ %d vector: %d cpu: %d\n",
+				__FUNCTION__, irq, vector, smp_processor_id());
+			irq = per_cpu(vector_irq, 0)[vector];
+			printk("v[0][%d] -> %d\n", vector, irq);
+			print_IO_APIC();
+		}
+		irq_exit();
+
+		set_irq_regs(old_regs);
+		return 1;
 	}
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW

And here are two logs from booting with above patch applied to the tip
of the repository (each has different interesting bits missing, thank
you SOL!)

kernel (hd0,1)/boot/calgary/bzImage root=/dev/sda2 console=tty0 console=ttyS1,1
9200
   [Linux-bzImage, setup=0x1c00, size=0x2e4590]
initrd (hd0,1)/boot/calgary/aic94xxfw.initramfs.gz
   [Linux-initrd @ 0x37e3f000, 0x1b0794 bytes]
savedefault
                                                                                
[    0.000000] Linux version 2.6.19-rc1mx (muli@rhun) (gcc version 3.4.1) #164 SMP Sat Oct 7 09:23:16 IST 2006
[    0.000000] Command line: root=/dev/sda2 console=tty0 console=ttyS1,19200
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 0000000000099000 (usable) [    0.000000]  BIOS-e820: 0000000000099000 - 00000000000a0000 (reserved) [    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000e7f9c640 (usable)
[    0.000000]  BIOS-e820: 00000000e7f9c640 - 00000000e7fa6a40 (ACPI data)
[    0.000000]  BIOS-e820: 00000000e7fa6a40 - 00000000e8000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000198000000 (usable)
[    0.000000] end_pfn_map = 1671168
[    0.000000] DMI 2.3 present.
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1671168
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0:        0 ->      153
[    0.000000]     0:      256 ->   950172
[    0.000000]     0:  1048576 ->  1671168
[    0.000000] ACPI: PM-Timer IO Port: 0x9c
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
[    0.000000] Processor #6
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
[    0.000000] Processor #7
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl linec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 15, address 0xfec00000, GSI 0-35
[    0.000000] ACPI: IOAPIC (id[0x0e] address[0xfec01000] gsi_base[35])
[    0.000000] IOAPIC[1]: apic_id 14, address 0xfec01000, GSI 35-70
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_iror SMP configuration information
[    0.000000] Nosave address range: 0000000000099000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 00000000000e0000
[    0.000000] Nosave address range: 00000000000e0000 - 0000000000100000
[    0.000000] Nosave address range: 00000000e7f9c000 - 00000000e7f9d000
[    0.000000] Nosave address range: 00000000e7f9d000 - 00000000e7fa6000
[    0.000000] Nosave address range: 00000000e7fa6000 - 00000000e7fa7000
[    0.000000] Nosave address range: 00000000e7fa7000 - 00000000e8000000
[    0.000000] Nosave address range: 00000000e8000000 - 00000000fec00000
[    0.000000] Nosave address range: 00000000fec00000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at ea000000 (gap: e8000000:16c00000)
[    0.000000] PERCPU: Allocating 34432 bytes of per cpu data
[    0.000000] Built 1 zonelists.  Total pages: 1534050
[    0.000000] Kernel command line: root=/dev/sda2 console=tty0 console=ttyS1,192... MAX_LOCKDEP_SUBCLASSES:    8
[  159.715176] ... MAX_LOCK_DEPTH:          30
[  159.740333] ... MAX_LOCKDEP_KEYS:        2048
[  159.766528] ... CLASSHASH_SIZE:           1024
[  159.793244] ... MAX_LOCKDEP_ENTRIES:     8192
[  159.819436] ... MAX_LOCKDEP_CHAINS:      8192
[  159.845631] ... CHAINHASH_SIZE:          4096
[  159.871823]  memory used by lock dependency info: 1328 kB
[  159.904261]  per task-struct memory footprint: 1680 bytes
[  159.943893] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[  159.998800] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[  160.045221] Checking aperture...
[  160.087607] PCI-DMA: Calgary IOMMU detected.
[  160.113316] PCI-DMA: Calgary TCE table spec is 7, CONFIG_IOMMU_DEBUG is enabled.
[  160.274406] Memory: 6096436k/6684672k available (3789k kernel code, 193708k reserved, 2726k data, 276k init)
[  160.411584] Calibrating delay using timer specific routine.. 6346.37 BogoMIPS (lpj=12692759)
[  160.462605] Mount-cache hash table entries: 256
[  160.491448] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  160.522964] CPU: L2 cache: 1024K
[  160.542362] using mwait in idle threads.
[  160.565962] CPU: Physical Processor ID: 0
[  160.590081] CPU: Processor Core ID: 0
[  160.612141] CPU0: Thermal monitoring enabled (TM1)
[  160.640932] Freeing SMP alternatives: 32k freed
[  160.668182] ACPI: Core revision 20060707
[  160.738903] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[  160.813953] Using local APIC timer interrupts.
[  160.872189] result 10425635
[  160.888969] Detected 10.425 MHz APIC timer.
[  160.916601] lockdep: not fixing up alternatives.
[  160.944889] Booting processor 1/4 APIC 0x1
[  160.979898] Initializing CPU#1
[  161.059409] Calibrating delay using timer specific routine.. 6339.03 BogoMIPS (lpj=12678074)
[  161.059426] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  161.059430] CPU: L2 cache: 1024K
[  161.059434] CPU: Physical Processor ID: 0
[  161.059436] CPU: Processor Core ID: 0
[  161.059448] CPU1: Thermal monitoring enabled (TM1)
[  161.059723]                Intel(R) Xeon(TM) MP CPU 3.16GHz stepping 01
[  161.063730] lockdep: not fixing up alternatives.
[  161.325811] Booting processor 2/4 APIC 0x6
[  161.360829] Initializing CPU#2
[  161.439312] Calibrating delay using timer specific routine.. 6339.24 BogoMIPS (lpj=12678480)
[  161.439325] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  161.439328] CPU: L2 cache: 1024K
[  161.439331] CPU: Physical Processor ID: 3
[  161.439333] CP[  161.740761] Initializing CPU#3
[  161.819217] Calibrating delay using timer specific routine.. 6339.71 BogoMIPS (lpj=12679423)
[  161.819231] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  161.819234] CPU: L2 cache: 1024K
[  161.819238] CPU: Physical Processor ID: 3
[  161.819239] CPU: Processor Core ID: 0
[  161.819250] CPU3: Thermal monitoring enabled (TM1)
[  161.819488]               Intel(R) Pentium(R) 4 CPU 3.16GHz stepping 09
[  161.823246] Brought up 4 CPUs
[  162.075472] testing NMI watchdog ... OK.
[  162.139199] time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
[  162.176289] time.c: Detected 3169.430 MHz processor.
[  162.388152] migration_cost=13,712
[  162.409150] checking if image is initramfs... it is
[  162.600804] Freeing initrd memory: 1729k freed
[  162.630531] NET: Registered protocol family 16
[  162.667595] ACPI: bus type pci registered
[  162.691693] PCI: Using configuration type 1
[  162.847444] ACPI: Interpreter enabled
[  162.869451] ACPI: Using IOAPIC for interrupt routing
[  162.905945] ACPI: PCI Root Bridge [VP00] (0000:00)
[  162.938198] PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
[  162.993446] ACPI: PCI Root Bridge [VP01] (0000:01)
[  163.029072] ACPI: PCI Root Bridge [VP02] (0000:02)
[  163.068114] ACPI: PCI Root Bridge [VP03] (0000:04)
[  163.106797] ACPI: PCI Root Bridge [VP04] (0000:06)
[  163.145750] ACPI: PCI Root Bridge [VP05] (0000:08)
[  163.184685] ACPI: PCI Root Bridge [VP06] (0000:0a)
[  163.223525] ACPI: PCI Root Bridge [VP07] (0000:0c)
[  163.262317] SCSI subsystem initialized
[  163.285134] usbcore: registered new interface driver usbfs
[  163.318234] usbcore: registered new interface driver hub
[  163.351294] usbcore: registered new device driver usb
[  163.382771] PCI: Using ACPI for IRQ routing
[  163.407931] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[  163.457579] number of MP IRQ sources: 15.
[  163.481692] number of IO-APIC #15 registers: 36.
[  163.509453] number of IO-APIC #14 registers: 36.
[  163.537210] testing the IO APIC.......................
[  163.568090]
[  163.577112emented: 0
[  163.724332] .......     : IO APIC version: 0011
[  163.751568] .... register #02: 00000000
[  163.774648] .......     : arbitration: 00
[  163.798768] .... IRQ redirection table:
[  163.821847]  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
[  163.858458]  00 000 00  1    0    0   0   0    0    0    00
[  163.892078]  01 001 01  0    0    0   0   0    1    1    39
[  163.925659]  02 001 01  1    0    0   0   0    0    0    20
[  163.959243]  03 001 01  0    0    0   0   0    1    1    41
[  163.992872]  04 001 01  0    0    0   0   0    1    1    49
[  164.026458]  05 001 01  0    0    0   0   0    1    1    51
[  164.060040]  06 001 01  0    0    0   0   0    1    1    59
[  164.093622]  07 001 01  0    0    0   0   0    1    1    61
[  164.127205]  08 001 01  0    0    0   1   0    1    1    69
[  164.160786]  09 001 01  0    1    0   1   0    1    1    71
[  164.194369]  0a 001 01  0    0    0   0   0    1    1    79
[  164.227998]  0b 001 01  0    0    0   0   0    1    1    81
[  164.261579]  0c 001 01  0    0    0   0   0    1    1    89
[  164.295156]  0d 001 01  0    0    0   0   0    1    1    91
[  164.328737]  0e 001 01  0    0    0   1   0    1    1    99
[  164.362314]  0f 001 01  0    0    0   0   0    1    1    A1
[  164.395893]  10 000 00  1    0    0   0   0    0    0    00
[  164.429471]  11 000 00  1    0    0   0   0    0    0    00
[  164.463053]  12 000 00  1    0    0   0   0    0    0    00
[  164.496636]  13 000 00  1    0    0   0   0    0    0    00
[  164.530213]  14 000 00  1    0    0   0   0    0    0    00
[  164.563795]  15 000 00  1    0    0   0   0    0    0    00
[  164.597377]  16 000 00  1    0    0   0   0    0    0    00
[  164.765276]  1b 000 00  1    0    0   0   0    0    0    00
[  164.798855]  1c 000 00  1    0    0   0   0    0    0    00
[  164.832433]  1d 000 00  1    0    0   0   0    0    0    00
[  164.866013]  1e 000 00  1    0    0   0   0    0    0    00
[  164.899504]  23 000 00  1    0    0   0   0    0    0    00
[  165.067483]
[  165.076463] IO APIC #14......
[  165.094301] .... register #00: 0E000000
[  165.117332] .......    : physical APIC id: 0E
[  165.143479] .... register #01: 00230011
[  165.166557] .......     : max redirection entries: 0023
[  165.197960] .......     : PRQ implemented: 0
[  165.223633] .......     : IO APIC version: 0011
[  165.250871] .... register #02: 00000000
[  165.273945] .......     : arbitration: 00
[  165.298014] .... IRQ redirection table:
[  165.321092]  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
[  165.357648]  00 000 00  1    0    0   0   0    0    0    00
[  165.391269]  01 000 00  1    0    0   0   0    0    0    00
[  165.424849]  02 000 00  1    0    0   0   0    0    0    00
[  165.458428]  03 000 00  1    0    0   0   0    0    0    00
[  165.492012]  04 000 00  1    0    0   0   0    0    0    00
[  165.525591]  05 000 00  1    0    0   0   0    0    0    00
[  165.559171]  06 000 00  1    0    0   0   0    0    0    00
[  165.592749]  07 000 00  1    0    0   0   0    0    0    00
[  165.626329]  08 000 00  1    0    0   0   0    0    0    00
[  165.794220]  0d 000 00  1    0    0   0   0    0    0    00
[  165.827796]  0e 000 00  1    0    0   0   0    0    0    00
[  165.861376]  0f 000 00  1    0    0   0   0    0    0    00
[  165.894954]  10 000 00  1    0    0   0   0    0    0    00
[  165.928532]  11 000 00  1    0    0   0   0    0    0    00
[  165.962110]  12 000 00  1    0    0   0   0    0    0    00
[  165.995688]  13 000 00  1    0    0   0   0    0    0    00
[  166.029266]  14 000 00  1    0    0   0   0    0    0    00
[  166.062846]  15 000 00  1    0    0   0   0    0    0    00
[  166.096425]  16 000 00  1    0    0   0   0    0    0    00
[  166.130004]  17 000 00  1    0    0   0   0    0    0    00
[  166.163587]  18 000 00  1    0    0   0   0    0    0    00
[  166.197164]  19 000 00  1    0    0   0   0    0    0    00
[  166.230745]  1a 000 00  1    0    0   0   0    0    0    00
[  166.264325]  1b 000 00  1    0    0   0   0    0    0    00
[  166.297910]  1c 000 00  1    0    0   0   0    0    0    00
[  166.331541]  1d 000 00  1    0    0   0   0    0    0    00
[  166.365124]  1e 000 00  1    0    0   0   0    0    0    00
[  166.398704]  1f 000 00  1    0    0   0   0    0    0    00
[  166.432284]  20 000 00  1    0    0   0   0    0    0    00
[  166.465864]  21 000 00  1    0    0   0   0    0    0    00
[  166.499446]  22 000 00  1    0    0   0   0    0    0    00
[  166.533029]  23 000 00  1    0    0   0   0    0    0    00
[  166.566608] IRQ to pin mappings:
[  166.586000] IRQ0 -> 0:2
[  166.600951] IRQ1 -> 0:1
[  166.615924] IRQ3 -> 0:3
[  166.630900] IRQ4 -> 0:4
[  166.645870] IRQ5 -> 0:5
[  166.660834] IRQ6 -> 0:6
[  166.6758066.816774] .................................... done.
[  166.847916] PCI-DMA: Using Calgary IOMMU
[  167.226948] Calgary: enabling translation on PHB 0x0
[  167.256752] Calgary: errant DMAs will now be prevented on this bus.
[  167.649298] Calgary: enabling translation on PHB 0x1
[  167.679145] Calgary: errant DMAs will now be prevented on this bus.
[  168.072000] Calgary: enabling translation on PHB 0x2
[  168.101803] Calgary: errant DMAs will now be prevented on this bus.
[  168.139495] PCI-GART: No AMD northbridge found.
[  168.177257] NET: Registered protocol family 2
[  168.253624] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
[  168.299544] TCP established hash table entries: 65536 (order: 9, 3670016 bytes)
[  168.352200] TCP bind hash table entries: 32768 (order: 8, 1835008 bytes)
[  168.395982] TCP: Hash tables configured (established 65536 bind 32768)
[  168.435240] TCP reno registered
[  168.477799] Total HugeTLB memory allocated, 0
[  168.505707] Installing knfsd (copyright (C) 199pt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
[  168.703200] radeonfb: Found Intel x86 BIOS ROM Image
[  168.745203] radeonfb: Retrieved PLL infos from BIOS
[  168.774491] radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=143.00 Mhz, System=143.00 MHz
[  168.824155] radeonfb: PLL min 12000 max 35000
[  168.954703] i2c_adapter i2c-1: unable to read EDID block.
[  169.146556] i2c_adapter i2c-1: unable to read EDID block.
[  169.338499] i2c_adapter i2c-1: unable to read EDID block.
[  169.802364] i2c_adapter i2c-2: unable to read EDID block.
[  169.994307] i2c_adapter i2c-2: unable to read EDID block.
[  170.186252] i2c_adapter i2c-2: unable to read EDID block.
[  170.340745] radeonfb: Monitor 1 type DFP found
[  170.367444] radeonfb: EDID probed
[  170.387399] radeonfb: Monitor 2 type CRT found
[  171.445892] Console: switching to colour frame buffer device 128x48
[  172.157807] radeonfb (0000:00:01.0): ATI Radeon QY
[  172.190527] tridentfb: Trident framebuffer 0.7.8-NEWAPI initializing
[  172.230329] hgafb: HGA card not detected.
[  172.254639] hgafb: probe of hgafb.0 failed with error -22
[  172.289812] vga16fb: mapped to 0xffff8100000a0000
[  172.319392] fb1: VGA16 VGA frame buffer device
[  172.347627] fb2: Virtual frame buffer device, using 1024K of video memory
[  172.389093] ACPI: Power Button (FF) [PWRF]
[  172.414559] ibm_acpi: ec object not found
[  172.826196] Linux agpgart interface v0.101 (c) Dave Jones
[  172.859065] ipmi message handler version 39.0
[  172.885336] ipmi device interface
[  172.905675] Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
[  172.959801] Hangcheck: Using monotonic_clock().
[  172.987184] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[  173.034835] do_IRQ: cannot handle IRQ -1 vector: 73 cpu: 1
[  173.034848] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[  173.067882] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[  173.144126] v[0][73] -> 4
[  173.144131] number of MP IRQ sources: 15.
[  173.185670] number of IO-APIC #15 registers: 36.
[  173.214801] number of IO-APIC #14 registers: 36.
[  173.243853] testing the IO APIC.......................
[  173.310563]
[  173.355937] IO APIC #15......
[  173.411003] .... register #00: 0F000000
[  173.471712] .......    : physical APIC id: 0F
[  173.537310] .... register #01: 00230011
[  173.600372] .......     : max redirection entries: 0023
[  173.673337] .......     : PRQ implemented: 0
[  173.741310] .......     : IO APIC version: 0011
[  173.812025] .... register #02: 00000000
[  173.878873] .......     : arbitration: 00
[  173.947147] .... IRQ redirection table:
[  174.015401]  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
[  174.098994]  00 000 00  1    0    0   0   0    0    0    00
[  174.182973]  01 001 01  0    0    0   0   0    1    1    39
[  174.265977]  02 001 01  1    0    0   0   0    0    0    20
[  174.349387]  03 001 01  0    0    0   0   0    1    1    41
[  174.432753]  04 001 01  0    0    0   0   0    1    1    49
[  174.516545]  05 001 01  0    0    0   0   0    1    1    51
[  174.601131]  06 001 01  0    0    0   0   0    1    1    59
[  174.685489]  07 001 01  0    0    0   0   0    1    1    61
[  174.770828]  08 001 01  0    0    0   1   0    1    1    69
[  174.856338]  09 001 01  0    1    0   1   0    1    1    71
[  174.942583]  0a 001 01  0    0    0   0   0    1    1    79
[  175.028737]  0b 001 01  0    0    0   0   0    1    1    81
[  175.113592]  0c 001 01  0    0    0   0   0    1    1    89
[  175.196746]  0d 001 01  0    0    0   0   0    1    1    91
[  175.278042]  0e 001 01  0    0    0   1   0    1    1    99
[  175.358284]  0f 001 01  0    0    0   0   0    1    1    A1
[  175.438277]  10 001 01  1    1    0   1   0    1    1    A9
[  175.516525]  11 000 00  1    0    0   0   0    0    0    00
[  175.594250]  12 000 00  1    0    0   0   0    0    0    00
[  175.670566]  13 000 00  1    0    0   0   0    0    0    00
[  175.744982]  14 000 00  1    0    0   0   0    0    0    00
[  175.819438]  15 000 00  1    0    0   0   0    0    0    00
[  175.891995]  16 000 00  1    0    0   0   0    0    0    00
[  175.963970]  17 000 00  1    0    0   0   0    0    0    00
[  176.035218]  18 000 00  1    0    0   0   0    0    0    00
[  176.103913]  19 000 00  1    0    0   0   0    0    0    00
[  176.171391]  1a 000 00  1    0    0   0   0    0    0    00
[  176.236302]  1b 000 00  1    0    0   0   0    0    0    00
[  176.299290]  1c 000 00  1    0    0   0   0    0    0    00
[  176.361328]  1d 000 00  1    0    0   0   0    0    0    00
[  176.423472]  1e 000 00  1    0    0   0   0    0    0    00
[  176.484175]  1f 000 00  1    0    0   0   0    0    0    00
[  176.544404]  20 000 00  1    0    0   0   0    0    0    00
[  176.603905]  21 000 00  1    0    0   0   0    0    0    00
[  176.662658]  22 000 00  1    0    0   0   0    0    0    00
[  176.721041]  23 000 00  1    0    0   0   0    0    0    00
[  176.778326]
[  176.809970] IO APIC #14......
[  176.850818] .... register #00: 0E000000
[  176.896838] .......    : physical APIC id: 0E
[  176.945618] .... register #01: 00230011
[  176.991279] .......     : max redirection entries: 0023
[  177.046099] .......     : PRQ implemented: 0
[  177.094945] .......     : IO APIC version: 0011
[  177.145511] .... register #02: 00000000
[  177.191741] .......     : arbitration: 00
[  177.238924] .... IRQ redirection table:
[  177.284087]  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
[  177.343564]  00 000 00  1    0    0   0   0    0    0    00
[  177.401238]  01 000 00  1    0    0   0   0    0    0    00
[  177.458475]  02 000 00  1    0    0   0   0    0    0    00
[  177.515601]  03 000 00  1    0    0   0   0    0    0    00
[  177.572714]  04 000 00  1    0    0   0   0    0    0    00
[  177.629406]  05 000 00  1    0    0   0   0    0    0    00
[  177.686218]  06 000 00  1    0    0   0   0    0    0    00
[  177.742974]  07 000 00  1    0    0   0   0    0    0    00
[  177.799598]  08 000 00  1    0    0   0   0    0    0    00
[  177.856157]  09 000 00  1    0    0   0   0    0    0    00
[  177.912395]  0a 000 00  1    0    0   0   0    0    0    00
[  177.968615]  0b 000 00  1    0    0   0   0    0    0    00
[  178.024711]  0c 000 00  1    0    0   0   0    0    0    00
[  178.080957]  0d 000 00  1    0    0   0   0    0    0    00
[  178.137205]  0e 000 00  1    0    0   0   0    0    0    00
[  178.193008]  0f 000 00  1    0    0   0   0    0    0    00
[  178.248833]  10 000 00  1    0    0   0   0    0    0    00
[  178.304384]  11 000 00  1    0    0   0   0    0    0    00
[  178.359429]  12 000 00  1    0    0   0   0    0    0    00
[  178.415344]  13 000 00  1    0    0   0   0    0    0    00
[  178.471047]  14 000 00  1    0    0   0   0    0    0    00
[  178.526538]  15 000 00  1    0    0   0   0    0    0    00
[  178.581924]  16 000 00  1    0    0   0   0    0    0    00
[  178.637489]  17 000 00  1    0    0   0   0    0    0    00
[  178.693260]  18 000 00  1    0    0   0   0    0    0    00
[  178.748506]  19 000 00  1    0    0   0   0    0    0    00
[  178.804012]  1a 000 00  1    0    0   0   0    0    0    00
[  178.859381]  1b 000 00  1    0    0   0   0    0    0    00
[  178.914721]  1c 000 00  1    0    0   0   0    0    0    00
[  178.970304]  1d 000 00  1    0    0   0   0    0    0    00
[  179.025934]  1e 000 00  1    0    0   0   0    0    0    00
[  179.081632]  1f 000 00  1    0    0   0   0    0    0    00
[  179.137372]  20 000 00  1    0    0   0   0    0    0    00
[  179.193054]  21 000 00  1    0    0   0   0    0    0    00
[  179.248435]  22 000 00  1    0    0   0   0    0    0    00
[  179.303584]  23 000 00  1    0    0   0   0    0    0    00
[  179.358129] IRQ to pin mappings:
[  179.398163] IRQ0 -> 0:2
[  179.433497] IRQ1 -> 0:1
[  179.468578] IRQ3 -> 0:3
[  179.502723] IRQ4 -> 0:4
[  179.535751] IRQ5 -> 0:5
[  179.567898] IRQ6 -> 0:6
[  179.599575] IRQ7 -> 0:7
[  179.630636] IRQ8 -> 0:8
[  179.661388] IRQ9 -> 0:9
[  179.691365] IRQ10 -> 0:10
[  179.721289] IRQ11 -> 0:11
[  179.750107] IRQ12 -> 0:12
[  179.779057] IRQ13 -> 0:13
[  179.807867] IRQ14 -> 0:14
[  179.836816] IRQ15 -> 0:15
[  179.865827] IRQ16 -> 0:16
[  179.894889] .................................... done.
[  179.954564] RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
[  180.016728] loop: loaded (max 8 devices)
[  180.052659] ibmasm: IBM ASM Service Processor Driver version 1.0 loaded
[  180.105233] ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 18 (level, low) -> IRQ 18
[  180.163772] 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
[  180.220788] 0000:02:01.0: 3Com PCI 3c905C Tornado at ffffc20000042000.
[  180.297869] tg3.c:v3.66 (September 23, 2006)
[  180.338200] ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 24 (level, low) -> IRQ 24
[  180.434904] eth1: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:98:74:22
[  180.539771] eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[0]
[  180.609267] eth1: dma_rwctrl[769f0000] dma_mask[64-bit]
[  180.660741] ACPI: PCI Interrupt 0000:01:01.1[B] -> GSI 28 (level, low) -> IRQ 28
[  180.762926] eth2: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:98:74:23
[  180.879099] eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
[  180.954434] eth2: dma_rwctrl[769f0000] dma_mask[64-bit]
[  181.012309] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[  181.077149] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[  181.152505] SvrWks CSB6: IDE controller at PCI slot 0000:00:0f.1
[  181.216463] SvrWks CSB6: chipset revision 160
[  181.271080] SvrWks CSB6: not 100% native mode: will probe irqs later
[  181.338471]     ide0: BM-DMA at 0x0700-0x0707, BIOS settings: hda:DMA, hdb:DMA
[  181.412045] SvrWks CSB6: simplex device: DMA disabled
[  181.472639] ide1: SvrWks CSB6 Bus-Master DMA disabled (BIOS)
[  182.277658] hda: HL-DT-STDVD-ROM GDR8082N, ATAPI CD/DVD-ROM drive
[  182.685216] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[  183.312085] do_IRQ: cannot handle IRQ -1 vector: 153 cpu: 1
[  183.378484] v[0][153] -> 14
[  183.428886] number of MP IRQ sources: 15.
[  183.486190] number of IO-APIC #15 registers: 36.
[  183.486197] number of IO-APIC #14 registers: 36.
[  183.486199] testing the IO APIC.......................
[  183.486206]
[  183.486207] IO APIC #15......
[  183.486209] .... register #00: 0F000000
[  183.486211] .......    : physical APIC id: 0F
[  183.486213] .... register #01: 00230011
[  183.486214] .......     : max redirection entries: 0023
[  183.486217] .......     : PRQ implemented: 0
[  183.486219] .......     : IO APIC version: 0011
[  183.486221] .... register #02: 00000000
[  183.486228] .......     : arbitration: 00
[  183.486230] .... IRQ redirection table:
[  183.486231]  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
[  183.486248]  00 000 00  1    0    0   0   0    0    0    00
[  183.486254]  01 001 01  0    0    0   0   0    1    1    39
[  183.486260]  02 001 01  1    0    0   0   0    0    0    20
[  183.486265]  03 001 01  0    0    0   0   0    1    1    41
[  183.486270]  04 001 01  0    0    0   0   0    1    1    49
[  183.486275]  05 001 01  0    0    0   0   0    1    1    51
[  183.486280]  06 001 01  0    0    0   0   0    1    1    59
[  183.486285]  07 001 01  0    0    0   0   0    1    1    61
[  183.486291]  08 001 01  0    0    0   1   0    1    1    69
[  183.486296]  09 001 01  0    1    0   1   0    1    1    71
[  183.486301]  0a 001 01  0    0    0   0   0    1    1    79
[  183.486306]  0b 001 01  0    0    0   0   0    1    1    81
[  183.486311]  0c 001 01  0    0    0   0   0    1    1    89
[  183.486316]  0d 001 01  0    0    0   0   0    1    1    91
[  183.486322]  0e 001 01  0    0    0   1   0    1    1    99
[  183.486327]  0f 001 01  0    0    0   0   0    1    1    A1
[  183.486332]  10 001 01  1    1    0   1   0    1    1    A9
[  183.486337]  11 000 00  1    0    0   0   0    0    0    00
[  183.486342]  12 001 01  1    1    0   1   0    1    1    B1
[  183.486348]  13 000 00  1    0    0   0   0    0    0    00
[  183.486353]  14 000 00  1    0    0   0   0    0    0    00
[  183.486358]  15 000 00  1    0    0   0   0    0    0    00
[  183.486363]  16 000 00  1    0    0   0   0    0    0    00
[  183.486368]  17 000 00  1    0    0   0   0    0    0    00
[  183.486373]  18 001 01  1    1    0   1   0    1    1    B9
[  183.486378]  19 000 00  1    0    0   0   0    0    0    00
[  183.486383]  1a 000 00  1    0    0   0   0    0    0    00
[  183.486388]  1b 000 00  1    0    0   0   0    0    0    00
[  183.486394]  1c 001 01  1    1    0   1   0    1    1    C1
[  183.486399]  1d 000 00  1    0    0   0   0    0    0    00
[  183.486404]  1e 000 00  1    0    0   0   0    0    0    00
[  183.486409]  1f 000 00  1    0    0   0   0    0    0    00
[  183.486414]  20 000 00  1    0    0   0   0    0    0    00
[  183.486419]  21 000 00  1    0    0   0   0    0    0    00
[  183.486424]  22 000 00  1    0    0   0   0    0    0    00
[  183.486429]  23 000 00  1    0    0   0   0    0    0    00
[  183.486435]
[  183.486436] IO APIC #14......
[  183.486438] .... register #00: 0E000000
[  183.486439] .......    : physical APIC id: 0E
[  183.486441] .... register #01: 00230011
[  183.486443] .......     : max redirection entries: 0023
[  183.486445] .......     : PRQ implemented: 0
[  183.486446] .......     : IO APIC version: 0011
[  183.486448] .... register #02: 00000000
[  183.486449] .......     : arbitration: 00
[  183.486451] .... IRQ redirection table:
[  183.486452]  NR Log Phy Mask  1    0    0   0   0    0    0    00
[  183.486477]  04 000 00  1    0    0   0   0    0    0    00
[  183.486482]  05 000 00  1    0    0   0   0    0    0    00
[  183.486487]  06 000 00  1    0    0   0   0    0    0    00
[  183.486492]  07 000 00  1    0    0   0   0    0    0    00
[  183.486497]  08 000 00  1    0    0   0   0    0    0    00
[  183.486502]  09 000 00  1    0    0   0   0    0    0    00
[  183.486506]  0a 000 00  1    0    0   0   0    0    0    00
[  183.486511]  0b 000 00  1    0    0   0   0    0    0    00
[  183.486516]  0c 000 00  1    0    0   0   0    0    0    00
[  183.486521]  0d 000 00  1    0    0   0   0    0    0    00
[  183.486526]  0e 000 00  1    0    0   0   0    0    0    00
[  183.486531]  0f 000 00  1    0    0   0   0    0    0    00
[  183.486536]  10 000 00  1    0    0   0   0    0    0    00
[  183.486541]  11 000 00  1    0    0   0   0    0    0    00
[  183.486546]  12 000 00  1    0    0   0   0    0    0    00
[  183.486551]  13 000 00  1    0    0   0   0    0    0    00
[  183.486556]  14 000 00  1    0    0   0   0    0    0    00
[  183.486561]  15 000 00  1    0    0   0   0    0    0    00
[  183.486566]  16 000 00  1    0    0   0   0    0    0    00
[  183.486571]  17 000 00  1    0    0   0   0    0    0    00
[  183.486576]  18 000 00  1    0    0   0   0    0    0    00
[  183.486581]  19 000 00  1    0    0   0   0    0    0    00
[  183.486586]  1a 000 00  1    0    0   0   0    0    0    00
[  183.486591]  1b 000 00  1    0    0   0   0    0    0    00
[  183.486596]  1c 000 00  1    0    0   0   0    0    0    00
[  183.486602]  1d 000 00  1    0    0   0   0    0    0    00
[  183.486607]  1e 000 00  1    0    0   0   0    0    0    00
[  183.486612]  1f 000 00  1    0    0   0   0    0    0    00
[  183.486617]  20 000 00  1    0    0   0   0    0    0    00
[  183.486622]  21 000 00  1    0    0   0   0    0    0    00
[  183.486627]  22 000 00  1    0    0   0   0    0    0    00
[  183.486632]  23 000 00  1    0    0   0   0    0    0    00
[  183.486634] IRQ to pin mappings:
[  183.486636] IRQ0 -> 0:2
[  183.486638] IRQ1 -> 0:1
[  183.486640] IRQ3 -> 0:3
[  183.486643] IRQ4 -> 0:4
[  183.486645] IRQ5 -> 0:5
[  183.486647] IRQ6 -> 0:6
[  183.486649] IRQ7 -> 0:7
[  183.486651] IRQ8 -> 0:8
[  183.486654] IRQ9 -> 0:9
[  183.486656] IRQ10 -> 0:10
[  183.486658] I 183.486680] .................................... done.
[  189.048897] hda: lost interrupt
[  194.049815] hda: lost interrupt
[  194.075698] hda: ATAPI 24X DVD-ROM drive, 256kB Cache
[  194.114939] Uniform CD-ROM driver Revision: 3.20
 
kernel (hd0,1)/boot/calgary/bzImage root=/dev/sda2 console=tty0 console=ttyS1,1
9200
   [Linux-bzImage, setup=0x1c00, size=0x2e4590] initrd (hd0,1)/boot/calgary/aic94xxfw.initramfs.gz
   [Linux-initrd @ 0x37e3f000, 0x1b0794 bytes]
savedefault
                                                                                
[    0.000000] Linux version 2.6.19-rc1mx (muli@rhun) (gcc version 3.4.1) #164 S MP Sat Oct 7 09:23:16 IST 2006 [    0.000000] Command line: root=/dev/sda2 console=tty0 console=ttyS1,19200
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 0000000000099000 (usable)
[    0.000000]  BIOS-e820: 0000000000099000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000e7f9c640 (usable)
[    0.000000]  BIOS-e820: 00000000e7f9c640 - 00000000e7fa6a40 (ACPI data)
[    0.000000]  BIOS-e820: 00000000e7fa6a40 - 00000000e8000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000198000000 (usable)
[    0.000000] end_pfn_map = 1671168
[    0.000000] DMI 2.3 present.
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1671168
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0:        0 ->      153
[    0.000000]     0:      256 ->   950172
[    0.000000]     0:  1048576 ->  1671168
[    0.000000] ACPI: PM-Timer IO Port: 0x9c
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[       0.000000] Processor #7
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x0f] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 15, address 0xfec00000, GSI 0-35
[    0.000000] ACPI: IOAPIC (id[0x0e] address[0xfec01000] gsi_base[35])
[    0.000000] IOAPIC[1]: apic_id 14, address 0xfec01000, GSI 35-70
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 8 global_irq 8 low edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 low edge)
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Nosave address range: 0000000000099000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 00000000000e0000
[    0.000000] Nosave address range: 00000000000e0000 - 0000000000100000
[    0.000000] Nosave address range: 00000000e7f9c000 - 00000000e7f9d000
[    0.000000] Nosave address range: 00000000e7f9d000 - 00000000e7fa6000
[    0.000000] Nosave address range: 00000000e7fa6000 - 00000000e7fa7000
[    0.000000] Nosave address range: 00000000e7fa7000 - 00000000e8000000
[    0.000000] Nosave address range: 00000000e8000000 - 00000000fec00000
[    0.000000] Nosave address range: 00000000fec00000 - 0000000100000000
[    0.le=tty0 console=ttyS1,19200
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[  172.269585] Console: colour VGA+ 80x25
[  174.207832] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[  174.254348X_LOCKDEP_CHAINS:      8192
[  174.410495] ... CHAINHASH_SIZE:          4096
[  174.436695]  memory used by lock dependency info: 1328 kB
[  174.469139]  per task-struct memory footprint: 1680 bytes
[  174.508784] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[  174.563704] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[  174.610140] Checking aperture...
[  174.652498] PCI-DMA: Calgary IOMMU detected.
[  174.678165] PCI-DMA: Calgary TCE table spec is 7, CONFIG_IOMMU_DEBUG is enabled.
[  174.839187] Memory: 6096436k/6684672k available (3789k kernel code, 193708k reserved, 2726k data, 276k init)
[  174.976352] Calibrating delay using timer specific rohysical Processor ID: 0
[  175.154816] CPU: Processor Core ID: 0
[  175.176863] CPU0: Thermal monitoring enabled (TM1)
[  175.205667] Freeing SMP alternatives: 32k freed
[  175.232919] ACPI: Core revision 20060707
[  175.303638] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[  175.378690] Using local APIC timer interrupts.
[  175.436932] result 10425543
[  175.453717] Detected 10.425 MHz APIC timer.
[  175.481377] lockdep: not fixing up alternatives.
[  175.509644] Booting processor 1/4 APIC 0x1
[  175.544653] Initializing CPU#1
[  175.624177] Calibrating delay using timer specific routine.. 6339.04 BogoMIPS (lpj=12678092)
[  175.624194] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  175.624197] CPU: L2 cache: 1024K
[  175.624201] CPU: Physical Processor ID: 0
[  175.624203] CPU: Processor Core ID: 0
[  175.624216] CPU1: Thermal monitoring enabled (TM1)
[  175.624491]                Intel(R) Xeon(TM) MP CPU 3.16GHz stepping 01
[  175.628500] lockdep: not fixing up alternatives.
[  175.890549] Booting processor 2/4 APIC 0x6
[  175.925565] Initializing CPU#2
[  176.004081] Calibrating delay using timer specific routine.. 6339.19 BogoMIPS (lpj=12678389)
[  176.004094] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  176.004097] CPU: L2 cache: 1024K
[ lternatives.
[  176.270481] Booting processor 3/4 APIC 0x7
[  176.305497] Initializing CPU#3
[  176.383983] Calibrating delay using timer specific routine.. 6339.28 BogoMIPS (lpj=12678572)
[  176.383998] CPU: Trace cache: 12K uops, L1 D cache: 16K
[  176.384000] CPU: L2 cache: 1024K
[  176.384004] CPU: Physical Processor ID: 3
[  176.384006] CPU: Processor Core ID: 0
[  176.384017] CPU3: Thermal monitoring enabled (TM1)
[  176.384255]               Intel(R) Pentium(R) 4 CPU 3.16GHz stepping 09
[  176.388010] Brought up 4 CPUs
[  176.640222] testing NMI watchdog ... OK.
[  176.703947] time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
[  176.741029] time.c: Detected 3169.383 MHz processor.
[  176.946524] migration_cost=4,717
[  176.967015] checking if image is initramfs... it is
[  177.158953] Freeing initrd memory: 1729k freed
[  177.188710] NET: Registered protocol family 16
[  177.225760] ACPI: bus type pci registered
[  177.249871] PCI: Using configuration type 1
[  177.406437] ACPI: Interpreter enabled
[  177.428447] ACPI: Using IOAPIC for interrupt routing
[  177.465159] ACPI: PCI Root Bridge [VP00] (0000:00)
[  177.497384] PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
[  177.553272] ACPI: PCI Root Bridge [VP01] (0000:01)
[  177.587765] ACPI: PCI Root Bridge [VP02] (0000:02)
[  177.626676] ACPI: PCI Root Bridge [VP03] (0000:04)
[  177.665479] ACPI: PCI Root Bridge [VP04] (0000:06)
[  177.704132] ACPI: PCI Root Bridge [VP05] (0000:08)
[  177.743342] ACPI: PCI Root Bridge [VP06] (0000:0a)
[  177.781137] ACPI: PCI Root Bridge [VP07] (0000:0c)
[  177.820249] SCSI subsystem initialized
[  177.843003] usbcore: registered new interface driver usbfs
[  177.876123] usbcore: registered new interface driver hub
[  177.908180] usbcore: registered new device driver usb
[  177.938909] PCI: Using ACPI for IRQ routing
[  177.964045] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[  178.013694] number of MP IRQ sources: 15.
[  178.037795] number of IO-APIC #15 registers: 36.
[  178.065551] number of IO-APIC #14 registers: 36.
[  178.093308] testing the IO APIC........... 0023
[  178.254698] .......     : PRQ implemented: 0
[  178.280368] .......     : IO APIC version: 0011
[  178.307606] 178.447982]  01 001 01  0    0    0   0   0    1    1    39
[  178.481610]  02 001 01  1    0    0   0   0    0    0    20
[  178.515184]  03 001 01  0    0    0   0   0    1    1    41
[  178.548762]  04 001 01  0    0    0   0   0    1    1    49
[  178.582336]  05 001 01  0    0    0   0   0    1    1    51
[  178.615909]  06 001 01  0    0    0   0   0    1    1    59
[  178.649534]  07 001 01  0    0    0   0   0    1    1    61
[  178.683109]  08 001 01  0    0    0   1   0    1    1    69
[  178.716687]  09 001 01  0    1    0   1   0    1    1    71
[  178.750260]  0a 001 01  0    0    0   0   0    1    1    79
[  178.783838]  0b 001 01  0    0    0   0   0    1    1    81
[  178.817465]  0c 001 01  0    0    0   0   0    1    1    89
[  178.851038]  0d 001 01  0    0    0   0   0    1    1    91
[  178.884613]  0e 001 01  0    0    0   1   0    1    1    99
[  178.918187]  0f 001 01  0    0    0   0   0    1    1    A1
[  178.951760]  10 000 00  1    0    0   0   0    0    0    00
[  179.119642]  15 000 00  1    0    0   0   0    0    0    00
[  179.153272]  16 000 00  1    0    0   0   0    0    0    00
[  179.186848]  17 000 00  1    0    0   0   0    0    0    00
[  179.220426]  18 000 00  1    0    0   0   0    0    0    00
[  179.254005]  19 000 00  1    0    0   0   0    0    0    00
[  179.287585]  1a 000 00  1    0    0   0   0    0    0    00
[  179.321164]  1b 000 00  1    0    0   0   0    0    0    00
[  179.354743]  1c 000 00  1    0    0   0   0    0    0    00
[  179.388322]  1d 000 00  1    0    0   0   0    0    0    00
[  179.421896]  1e 000 00  1    0    0   0   0    0    0    00
[  179.455474]  1f 000 00  1    0    0   0   0    0    0    00
[  179.489050]  20 000 00  1    0    0   0   0    0    0    00
[  179.522626]  21 000 00  1    0    0   0   0    0    0    00
[  179.556203]  22 000 00  1    0    0   0   0    0    0    00
[  179.589782]  23 000 00  1    0    0   0   0    0    0    00
[  179.623362]
[  179.632394] IO APIC #14......
[  179.650230] .... register #00: 0E000000
[  179.673261] .......    : physical APIC id: 0E
[  179.699408] .... register #01: 00230011
[  179.722484] .......     : max redirection entries: 0023
[  179.753885] .......     : PRQ implemented: 0
[  179.779560] .......     : IO APIC version: 0011
[  179.806797] .... register #02: 00000000
[  179.829872] .......     : arbitration: 00
[  179.853939] .... IRQ redirection table:
[  179.877016]  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
[  179.913571]  00 000 00  1    0    0   0   0    0    0    00
[  179.947189]  01 000 00  1    0    0   0   0    0    0    00
[  179.980764]  02 000 00  1    0    0   0   0    0    0    00
[  180.014344]  03 000 00  1    0    0   0   0    0    0    00
[  180.047921]  08 000 00  1    0    0   0   0    0    0    00
[  180.215808]  09 000 00  1    0    0   0   0    0    0    00
[  180.249384]  0a 000 00  1    0    0   0   0    0    0    00
[  180.282960]  0b 000 00  1    0    0   0   0    0    0    00
[  180.450890]  10 000 00  1    0    0   0   0    0    0    00
[  180.484467]  11 000 00  1    0    0   0   0    0    0    00
[  180.518046]  12 000 00  1    0    0   0   0    0    0    00
[  180.551625]  13 000 00  1    0    0   0   0    0    0    00
[  180.585198]  14 000 00  1    0    0   0   0    0    0    00
[  180.618771]  15 000 00  1    0    0   0   0    0    0    00
[  180.652345]  16 000 00  1    0    0   0   0    0    0    00
[  180.685919]  17 000 00  1    0    0   0   0    0    0    00
[  180.719492]  18 000 00  1    0    0   0   0    0    0    00
[  180.753068]  19 000 00  1    0    0   0   0    0    0    00
[  180.786644]  1a 000 00  1    0    0   0   0    0    0    00
[  180.820218]  1b 000 00  1    0    0   0   0    0    0    00
[  180.853788]  1c 000 00  1    0    0   0   0    0    0    00
[  180.887362]  1d 000 00  1    0    0   0   0    0    0    00
[  180.920935]  1e 000 00  1    0    0   0   0    0    0    00
[  180.954508]  1f 000 00  1    0    0   0   0    0    0    00
[  180.988083]  2Q to pin mappings:
[  181.141747] IRQ0 -> 0:2
[  181.156693] IRQ1 -> 0:1
[  181.171663] IRQ3 -> 0:3
[  181.186631] IRQ4 -> 0:4
[  181.201593] IRQ5 -> 0:5
[  181.216562] IRQ6 -> 0:6
[  181.231534] IRQ7 -> 0:7
[  181.246499] IRQ8 -> 0:8
[  181.261464] IRQ9 -> 0:9
[  181.276432] IRQ10 -> 0:10
[  181.292438] IRQ11 -> 0:11
[  181.308442] IRQ12 -> 0:12
[  181.324449] IRQ13 -> 0:13
[  181.340456] IRQ14 -> 0:14
[  181.356464] IRQ15 -> 0:15
[  181.372473] .................................... done.
[  181.403593] PCI-DMA: Using Calgary IOMMU
[  181.782763] Calgary: enabling translation on PHB 0x0
[  181.812583] Calgary: errant DMAs will now be prevented on this bus.
[  182.205279] Calgary: enabling translation on PHB 0x1
[  182.235103] Calgary: errant DMAs will now be prevented on this bus.
[  182.628096] Calgary: enabling translation on PHB 0x2
[  182.657919] Calgary: errant DMAs will now be prevented on this bus.
[  182.695604] PCI-GART: No AMD northbridge found.
[  182.733315] NET: Registered protocol family 2
[  182.822361] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
[  182.868576] TCP established hash table entries: 65536 (order: 9, 3670016 bytes)
[  182.920726] TCP bind hash table entries: 32768 (order: 8, 1835008  io scheduler noop registered
[  183.135880] io scheduler anticipatory registered (default)
[  183.169040] io scheduler deadline registered
[  183.194855] io scheduler cfq registered
[  183.225523] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
[  183.270354] radeonfb: Found Intel x86 BIOS ROM Image
[  183.314007] radeonfb: Retrieved PLL infos from BIOS
[  183.343298] radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=143.00 Mhz, System=143.00 MHz
[  183.392936] radeonfb: PLL min 12000 max 35000
[  183.523460] i2c_adapter i2c-1: unable to read EDID block.
[  183.715306] i2c_adapter i2c-1: unable to read EDID block.
[  183.907251] i2c_adapter i2c-1: unable to read EDID block.
[  184.371115] i2c_adapter i2c-2: unable to read EDID block.
[  184.563059] i2c_adapter i2c-2: unable to read EDID block.
[  184.755003] i2c_adapter i2c-2: unable to read EDID block.
[  184.909498] radeonfb: Monitor 1 type DFP found
[  184.936196] radeonfb: EDID probed
[  184.956150] radeonfb: Monitor 2 type CRT found
[  186.014806] Console: switching to colour frame buffer device 128x48
[  186.727128] radeonfb (0000:00:01.0): ATI Radeon QY
[  186.758984] tridentfb: Trident framebuffer 0.7.8-NEWAPI initializing
[  186.799024] hgafb: HGA card not detected.
[  186.823298] hgafb: probe of hgafb.0 failed with error -22
[  186.859121] vga16fb: mapped to 0xffff8100000a0000
[  186.887837] fb1: VGA16 VGA frame buffer device
[  186.916353] fb2: Virtual frame buffer device, using 1024K of video memory
[  186.957679] ACPI: Power Button (FF) [PWRF]
[  186.983088] ibm_acpi: ec object not found
[  187.393897] Linux agpgart interface v0.101 (c) Dave Jones
[  187.427426] ipmi message handler version 39.0
[  187.453736] ipmi device interface
[  187.474098] Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
[  187.528219] Hangcheck: Using monotonic_clock().
[  187.555620] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[  187.603262] do_IRQ: cannot handle IRQ -1 vector: 73 cpu: 1
[  187.603275] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[  187.636664] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[  187.690829] RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
[  187.697456] loop: loaded (max 8 devices)
[  187.698825] ibmasm: IBM ASM Service Processor Driver version 1.0 loaded
[  187.699070] ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 18 (level, low) -> IRQ 18
[  187.863222] v[0][73] -> 4
[  187.863228] number of MP IRQ sources: 15.
[  187.863232] number of IO-APIC #15 registers: 36.
[  187.863234] number of IO-APIC #14 registers: 36.
[  187.863235] testing the IO APIC.......................
[  187.863283]
[  187.863285] IO APIC #15......
[  187.863287] .... register #00: 0F000000
[  187.863289] .......    : physical APIC id: 0F
[  187.863291] .... register #01: 00230011
[  187.863293] .......     : max redirection entries: 0023
[  187.863294] .......     : PRQ implemented: 0
[  187.863296] .......     : IO APIC version: 0011
[  187.863298] .... register #02: 00000000
[  187.863299] .......     : arbitration: 00
[  187.863301] .... IRQ redirection table:
[  187.863302]  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
[  187.863307]  00 000 00  1    0    0   0   0    0    0    00
[  187.863313]  01 001 01  0    0    0   0   0    1    1    39
[  187.863319]  02 001 01  1    0    0   0   0    0    0    20
[  187.863324]  03 001 01  0    0    0   0   0    1    1    41
[  187.863329]  04 001 01  0    0    0   0   0    1    1    49
[  187.863334]  05 001 01  0    0    0   0   0    1    1    51
[  187.863340]  06 001 01  0    0    0   0   0    1    1    59
[  187.863345]  07 001 01  0    0    0   0   0    1    1    61
[  187.863350]  08 001 01  0    0    0   1   0    1    1    69
[  187.863355]  09 001 01  0    1    0   1   0    1    1    71
[  187.863361]  0a 001 01  0    0    0   0   0    1    1    79
[  187.863366]  0b 001 01  0    0    0   0   0    1    1    81
[  187.863371]  0c 001 01  0    0    0   0   0    1    1    89
[  187.863376]  0d 001 01  0    0    0   0   0    1    1    91
[  187.863381]  0e 001 01  0    0    0   1   0    1    1    99
[  187.863387]  0f 001 01  0    0    0   0   0    1    1    A1
[  187.863392]  10 001 01  1    1    0   1   0    1    1    A9
[  187.863397]  11 000 00  1    0    0   0   0    0    0    00
[  187.863403]  12 001 01  1    1    0   1   0    1    1    B1
[  187.863408]  13 000 00  1    0    0   0   0    0    0    00
[  187.863413]  14 000 00  1    0    0   0   0    0    0    00
[  187.863418]  15 000 00  1    0    0   0   0    0    0    00
[  187.863423]  16 000 00  1    0    0   0   0    0    0    00
[  187.863428]  17 000 00  1    0    0   0   0    0    0    00
[  187.863434]  18 000 00  1    0    0   0   0    0    0    00
[  187.863439]  19 000 00  1    0    0   0   0    0    0    00
[  187.863464]  1e 000 00  1    0    0   0   0    0    0    00
[  187.863469]  1f 000 00  1    0    0   0   0    0    0    00
[  187.863474]  20 000 00  1    0    0   0   0    0    0    00
[  187.863479]  21 000 00  1    0    0   0   0    0    0    00
[  187.863484]  22 000 00  1    0    0   0   0    0    0    00
[  187.863489]  23 000 00  1    0    0   0   0    0    0    00
[  187.863495]
[  187.863497] IO APIC #14......
[  187.863499] .... register #00: 0E000000
[  187.863500] .......    : physical APIC id: 0E
[  187.863502] .... register #01: 00230011
[  187.863504] .......     : max redirection entries: 0023
[  187.863505] .......     : PRQ implemented: 0
[  187.863507] .......     : IO APIC version: 0011
[  187.863509] .... register #02: 00000000
[  187.863510] .......     : arbitration: 00
[  187.863512] .... IRQ redirection table:
[  187.863513]  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
[  187.863518]  00 000 00  1    0    0   0   0    0    0    00
[  187.863523]  01 000 00  1    0    0   0   0    0    0    00
[  187.863528]  02 000 00  1    0    0   0   0    0    0    00
[  187.863533]  03 000 00  1    0    0   0   0    0    0    00
[  187.863538]  04 000 00  1    0    0   0   0    0    0    00
[  187.863543]  05 000 00  1    0    0   0   0    0    0    00
[  187.863548]  06 000 00  1    0    0   0   0    0    0    00
[  187.863553]  07 000 00  1    0    0   0   0    0    0    00
[  187.863558]  08 000 00  1    0    0   0   0    0    0    00
[  187.863563]  09 000 00  1    0    0   0   0    0    0    00
[  187.863568]  0a 000 00  1    0    0   0   0    0    0    00
[  187.863573]  0b 000 00  1    0    0   0   0    0    0    00
[  187.863578]  0c 000 00  1    0    0   0   0    0    0    00
[  187.863584]  0d 000 00  1    0    0   0   0    0    0    00
[  187.863589]  0e 000 00  1    0    0   0   0    0    0    00
[  187.863594]  0f 000 00  1    0    0   0   0    0    0    00
[  187.863599]  10 000 00  1    0    0   0   0    0    0    00
[  187.863604]  11 000 00  1    0    0   0   0    0    0    00
[  187.863609]  12 000 00  1    0    0   0   0    0    0    00
[  187.863614]  13 000 00  1    0    0   0   0    0    0    00
[  187.863640]  18 000 00  1    0    0   0   0    0    0    00
[  187.863645]  19 000 00  1    0    0   0   0    0    0    00
[  187.863650]  1a 000 00  1    0    0   0   0    0    0    00
[  187.863655]  1b 000 00  1    0    0   0   0    0    0    00
[  187.863660]  1c 000 00  1    0    0   0   0    0    0    00
[  187.863665]  1d 000 00  1    0    0   0   0    0    0    00
[  187.863670]  1e 000 00  1    0    0   0   0    0    0    00
[  187.863675]  1f 000 00  1    0    0   0   0    0    0    00
[  187.863680]  20 000 00  1    0    0   0   0    0    0    00
[  187.863685]  21 000 00  1    0    0   0   0    0    0    00
[  187.863690]  22 000 00  1    0    0   0   0    0    0    00
[  187.863696]  23 000 00  1    0    0   0   0    0    0    00
[  187.863698] IRQ to pin mappings:
[  187.863700] IRQ0 -> 0:2
[  187.863703] IRQ1 -> 0:1
[  187.863705] IRQ3 -> 0:3
[  187.863707] IRQ4 -> 0:4
[  187.863709] IRQ5 -> 0:5
[  187.863712] IRQ6 -> 0:6
[  187.863714] IRQ7 -> 0:7
[  187.863716] IRQ8 -> 0:8
[  187.863719] IRQ9 -> 0:9
[  187.863721] IRQ10 -> 0:10
[  187.863723] IRQ11 -> 0:11
[  187.863726] IRQ12 -> 0:12
[  187.863728] IRQ13 -> 0:13
[  187.863730] IRQ14 -> 0:14
[  187.863733] IRQ15 -> 0:15
[  187.863735] IRQ16 -> 0:16
[  187.863738] IRQ18 -> 0:18
[  187.863741] .................................... done.
[  187.864068] 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
[  187.864082] 0000:02:01.0: 3Com PCI 3c905C Tornado at ffffc20000042000.
[  187.903216] tg3.c:v3.66 (September 23, 2006)
[  187.903383] ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 24 (level, low) -> IRQ 24
[  188.146236] eth1: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:98:74:22
[  188.146247] eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[0]
[  188.146252] eth1: dma_rwctrl[769f0000] dma_mask[64-bit]
[  188.146345] ACPI: PCI Interrupt 0000:01:01.1[B] -> GSI 28 (level, low) -> IRQ 28
[  193.455989] eth2: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:98:74:23
[  193.456001] eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
[  193.456005] eth2: dma_rwctrl[769f0000] dma_mask[64-bit]
[  193.456770] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[  193.456777] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[  193.456883] SvrWks CSB6: IDE controller at PCI slot 0000:00:0f.1
[  193.456908] SvrWks CSB6: chipset revision 160
[  193.456911] SvrWks CSB6: not 100% native mode: will probe irqs later
[  193.456937]     ide0: BM-DMA at 0x0700-0x0707, BIOS settings: hda:DMA, hdb:DMA
[  193.456959] SvrWks CSB6: simplex device: DMA disabled
[  193.456962] ide1: SvrWks CSB6 Bus-Master DMA disabled (BIOS)
[  194.196864] hda: HL-DT-STDVD-ROM GDR8082N, ATAPI CD/DVD-ROM drive
[  194.534776] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[  195.156832] do_IRQ: cannot handle IRQ -1 vector: 153 cpu: 1
[  195.217657] v[0][153] -> 14
[  195.217664] number of MP IRQ sources: 15.
[  195.217667] number of IO-APIC #15 registers: 36.
[  195.217669] number of IO-APIC #14 registers: 36.
[  195.217670] testing the IO APIC.......................
[  195.217676]
[  195.217677] IO APIC #15......
[  195.217679] .... register #00: 0F000000
[  195.217681] .......    : physical APIC id: 0F
[  195.217683] .... register #01: 00230011
[  195.217685] .......     : max redirection entries: 0023
[  195.217686] .......     : PRQ implemented: 0
[  195.217688] .......     : IO APIC version: 0011
[  195.217696] .... register #02: 00000000
[  195.217697] .......     : arbitration: 00
[  195.217699] .... IRQ redirection table:
[  195.217700]  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
[  195.217716]  00 000 00  1    0    0   0   0    0    0    00
[  195.217722]  01 001 01  0    0    0   0   0    1    1    39
[  195.217727]  02 001 01  1    0    0   0   0    0    0    20
[  195.217732]  03 001 01  0    0    0   0   0    1    1    41
[  195.217737]  04 001 01  0    0    0   0   0    1    1    49
[  195.217742]  05 001 01  0    0    0   0   0    1    1    51
[  195.217747]  06 001 01  0    0    0   0   0    1    1    59
[  195.217752]  07 001 01  0    0    0   0   0    1    1    61
[  195.217757]  08 001 01  0    0    0   1   0    1    1    69
[  195.217762]  09 001 01  0    1    0   1   0    1    1    71
[  195.217768]  0a 001 01  0    0    0   0   0    1    1    79
[  195.217773]  0b 001 01  0    0    0   0   0    1    1    81
[  195.217778]  0c 001 01  0    0    0   0   0    1    1    89
[  195.217783]  0d 001 01  0    0    0   0   0    1    1    91
[  195.217788]  0e 001 01  0    0    0   1   0    1    1    99
[  195.217793]  0f 001 01  0    0    0   0   0    1    1    A1
[  195.217798]  10 001 01  1    1    0   1   0    1    1    A9
[  195.217803]  11 000 00  1    0    0   0   0    0    0    00
[  195.217808]  12 001 01  1    1    0   1   0    1    1    B1
[  195.217814]  13 000 00  1    0    0   0   0    0    0    00
[  195.217819]  14 000 00  1    0    0   0   0    0    0    00
[  195.217823]  15 000 00  1    0    0   0   0    0    0    00
[  195.217828]  16 000 00  1    0    0   0   0    0    0    00
[  195.217833]  17 000 00  1    0    0   0   0    0    0    00
[  195.217838]  18 001 01  1    1    0   1   0    1    1    B9
[  195.217844]  19 000 00  1    0    0   0   0    0    0    00
[  195.217848]  1a 000 00  1    0    0   0   0    0    0    00
[  195.217853]  1b 000 00  1    0    0   0   0    0    0    00
[  195.217858]  1c 001 01  1    1    0   1   0    1    1    C1
[  195.217864]  1d 000 00  1    0    0   0   0    0    0    00
[  195.217869]  1e 000 00  1    0    0   0   0    0    0    00
[  195.217873]  1f 000 00  1    0    0   0   0    0    0    00
[  195.217878]  20 000 00  1    0    0   0   0 ..
[  195.217902] .... register #00: 0E000000
[  195.217903] .......    : physical APIC id: 0E
[  195.217905] .... register #01: 00230011
[  195.217907] .......     : max redirection entries: 0023
[  195.217909] .......     : PRQ implemented: 0
[  195.217910] .......     : IO APIC version: 0011
[  195.217912] .... register #02: 00000000
[  195.217913] .......     : arbitration: 00
[  195.217915] .... IRQ redirection table:
[  195.217916]  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
[  195.217920]  00 000 00  1    0    0   0   0    0    0    00
[  195.217925]  01 000 00  1    0    0   0   0    0    0    00
[  195.217930]  02 000 00  1    0    0   0   0    0    0    00
[  195.217935]  03 000 00  1    0    0   0   0    0    0    00
[  195.217940]  04 000 00  1    0    0   0   0    0    0    00
[  195.217945]  05 000 00  1    0    0   0   0    0    0    00
[  195.217950]  06 000 00  1    0    0   0   0    0    0    00
[  195.217955]  07 000 00  1    0    0   0   0    0    0    00
[  195.217960]  08 000 00  1    0    0   0   0    0    0    00
[  195.217965]  09 000 00  1    0    0   0   0    0    0    00
[  195.217970]  0a 000 00  1    0    0   0   0    0    0    00
[  195.217974]  0b 000 00  1    0    0   0   0    0    0    00
[  195.217979]  0c 000 00  1    0    0   0   0    0    0    00
[  195.217984]  0d 000 00  1    0    0   0   0    0    0    00
[  195.217989]  0e 000 00  1    0    0   0   0    0    0    00
[  195.217994]  0f 000 00  1    0    0   0   0    0    0    00
[  195.217999]  10 000 00  1    0    0   0   0    0    0    00
[  195.218004]  11 000 00  1    0    0   0   0    0    0    00
[  195.218009]  12 000 00  1    0    0   0   0    0    0    00
[  195.218014]  13 000 00  1    0    0   0   0    0    0    00
[  195.218019]  14 000 00  1    0    0   0   0    0    0    00
[  195.218024]  15 000 00  1    0    0   0   0    0    0    00
[  195.218028]  16 000 00  1    0    0   0   0    0    0    00
[  195.218033]  17 000 00  1    0    0   0   0    0    0    00
[  195.218038]  18 000 00  1    0    0   0   0    0    0    00
[  195.218043]  19 000 00  1    0    0   0   0    0    0    00
[  195.218048]  1a 000 00  1    0    0   0   0    0    0    00
[  195.218053]  1b 000 00  1    0    0   0   0    0    0    00
[  195.218058]  1c 000 00  1    0    0   0   0    0    0    00
[  195.218063]  1d 000 00  1    0    0   0   0    0    0    00
[  195.218068]  1e 000 00  1    0    0   0   0    0    0    00
[  195.218092]  23 000 00  1    0    0   0   0    0    0    00
[  195.218095] IRQ to pin mappings:
[  195.218097] IRQ0 -> 0:2
[  195.218099] IRQ1 -> 0:1
[  195.218101] IRQ3 -> 0:3
[  195.218103] IRQ4 -> 0:4
[  195.218106] IRQ5 -> 0:5
[  195.218108] IRQ6 -> 0:6
[  195.218110] IRQ7 -> 0:7
[  195.218112] IRQ8 -> 0:8
[  195.218114] IRQ9 -> 0:9
[  195.218117] IRQ10 -> 0:10
[  195.218119] IRQ11 -> 0:11
[  195.218121] IRQ12 -> 0:12
[  195.218123] IRQ13 -> 0:13
[  195.218126] IRQ14 -> 0:14
[  195.218128] IRQ15 -> 0:15
[  195.218130] IRQ16 -> 0:16
[  195.218133] IRQ18 -> 0:18
[  195.218135] IRQ24 -> 0:24
[  195.218137] IRQ28 -> 0:28
[  195.218141] .................................... done.
[  200.775517] hda: lost interrupt
 
