Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVDDK52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVDDK52 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 06:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVDDK52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 06:57:28 -0400
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:17294 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S261216AbVDDKye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 06:54:34 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc1-mm4
Date: Mon, 4 Apr 2005 12:54:34 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050331022554.735a1118.akpm@osdl.org>
In-Reply-To: <20050331022554.735a1118.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504041254.35543.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 March 2005 12:25, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.
>6.12-rc1-mm4/
<snip>

Hello Andrew,

I finally managed connecting the target machine over a serial console and run 
gdb debugging session as explained in Documentation/i386/kgdb/kgdb.txt. This 
time I think I'm in the right direction but ... Here's the output:

GNU gdb 6.3-debian
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-linux"...Using host libthread_db library 
"/lib/tls/libthread_db.so.1".

breakpoint () at arch/i386/kernel/traps.c:128
128     }
warning: shared library handler failed to enable breakpoint
(gdb) list
123             set_intr_usr_gate(3,&int3); /* disable ints on trap */
124             set_intr_gate(1,&debug);
125             set_intr_gate(14,&page_fault);
126
127             BREAKPOINT;
128     }
129     #define CHK_REMOTE_DEBUG(trapnr,signr,error_code,regs,after)            
\
130         
{                                                                   \
131             if (!user_mode(regs)  ) \
132             
{                                                               \
(gdb) s
kgdb_console_write (co=0xc03c8000, s=0x603d1c "k", count=6307100) at 
arch/i386/kernel/kgdb_stub.c:2230
2230            kgdb_gdb_message(s, count);
(gdb) s
kgdb_gdb_message (
    s=0xc04e07c3 "[4294667.296000] Linux version 2.6.12-rc1-mm4 (boris@zmei) 
(gcc version 3.3.5 (Debian 1:3.3.5-12)) #1 SMP PREEMPT Mon Apr 4 12:07:40 
CEST 2005\n<6>[4294667.296000] BIOS-provided physical RAM map:\n<4>[4"..., 
count=143) at arch/i386/kernel/kgdb_stub.c:2173
2173            IF_SMP(in_kgdb_console = 1);
(gdb) s
2174            gdbconbuf[0] = 'O';
(gdb) s
2175            bufptr = gdbconbuf + 1;
(gdb) cont
Continuing.
[4294667.296000] Linux version 2.6.12-rc1-mm4 (boris@zmei) (gcc version 3.3.5 
(Debian 1:3.3.5-12)) #1 SMP PREEMPT Mon Apr 4 12:07:40 CEST 2005
[4294667.296000] BIOS-provided physical RAM map:
[4294667.296000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[4294667.296000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[4294667.296000]  BIOS-e820: 00000000000ce000 - 00000000000d60ac (reserved)
[4294667.296000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[4294667.296000]  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
[4294667.296000]  BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
[4294667.296000]  BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
[4294667.296000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[4294667.296000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[4294667.296000]  BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)
[4294667.296000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
[4294667.296000] 511MB LOWMEM available.
[4294667.296000] found SMP MP-table at 000fbad0
[4294667.296000] DMI 2.3 present.
[4294667.296000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[4294667.296000] Processor #0 15:2 APIC version 20
[4294667.296000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[4294667.296000] Processor #1 15:2 APIC version 20
[4294667.296000] Using ACPI for processor (LAPIC) configuration information
[4294667.296000] Intel MultiProcessor Specification v1.4
[4294667.296000]     Virtual Wire compatibility mode.
[4294667.296000] OEM ID: INTEL    Product ID: I845GL       APIC at: 0xFEE00000
[4294667.296000] I/O APIC #2 Version 32 at 0xFEC00000.
[4294667.296000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[4294667.296000] Processors: 2
[4294667.296000] Allocating PCI resources starting at 20000000 (gap: 
20000000:dec00000)
[4294667.296000] Built 1 zonelists
[4294667.296000] Initializing CPU#0
[4294667.296000] Kernel command line: root=/dev/hda1 vga=0 kgdb console=kgdb
[4294667.296000] CPU 0 irqstacks, hard=c04d9000 soft=c04d7000
[4294667.296000] PID hash table entries: 2048 (order: 11, 32768 bytes)
[    0.000000] Detected 2606.669 MHz processor.
[  108.755619] Using tsc for high-res timesource
[  108.791515] Console: colour VGA+ 80x25
[  108.817195] Dentry cache hash table entries: 131072 (order: 7, 524288 
bytes)
[  108.850172] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[  108.892496] Memory: 514608k/524224k available (2444k kernel code, 9128k 
reserved, 1269k data, 192k init, 0k highmem)
[  108.932244] Checking if this processor honours the WP bit even in 
supervisor mode... Ok.
[  109.008290] Security Framework v1.0.0 initialized
[  109.035947] Capability LSM initialized
[  109.061900] Mount-cache hash table entries: 512
[  109.089161] CPU: Trace cache: 12K uops, L1 D cache: 8K
[  109.135687] CPU: L2 cache: 512K
[  109.159631] CPU: Physical Processor ID: 0
[  109.185581] Intel machine check architecture supported.
[  109.214450] Intel machine check reporting enabled on CPU#0.
[  109.243383] CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
[  109.273243] CPU0: Thermal monitoring enabled
[  109.300313] Enabling fast FPU save and restore... done.
[  109.347063] Enabling unmasked SIMD FPU exception support... done.
[  109.394968] Checking 'hlt' instruction... OK.
[  109.443030] CPU0: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
[  109.508676] Booting processor 1/1 eip 2000
[  109.534725] CPU 1 irqstacks, hard=c04da000 soft=c04d8000
[  109.573729] Initializing CPU#1
[  109.596716] CPU: Trace cache: 12K uops, L1 D cache: 8K
[  109.596719] CPU: L2 cache: 512K
[  109.596722] CPU: Physical Processor ID: 0
[  109.596732] Intel machine check architecture supported.
[  109.596738] Intel machine check reporting enabled on CPU#1.
[  109.596741] CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
[  109.596746] CPU1: Thermal monitoring enabled
[  109.596794] CPU1: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
[  109.880703] Total of 2 processors activated (10338.30 BogoMIPS).
[  109.910741] ENABLING IO-APIC IRQs
[  109.935706] ..TIMER: vector=0x31 pin1=2 pin2=0
[  110.074471] checking TSC synchronization across 2 CPUs: passed.
[    0.020384] softlockup thread 0 started up.
[    0.047057] Brought up 2 CPUs
[    0.047060] softlockup thread 1 started up.
[    0.099113] NET: Registered protocol family 16
[    0.132795] PCI: PCI BIOS revision 2.10 entry at 0xfdb51, last bus=3
[    0.163405] PCI: Using configuration type 1
[    0.189361] mtrr: v2.0 (20020519)
[    0.221013] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.250681] usbcore: registered new driver usbfs
[    0.278201] usbcore: registered new driver hub
[    0.305243] PCI: Probing PCI hardware
[    0.331047] PCI: Probing PCI hardware (bus 00)
[    0.358572] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[    0.391333] PCI: Using IRQ router PIIX/ICH [8086/24c0] at 0000:00:1f.0
[    0.422742] PCI->APIC IRQ transform: 0000:00:1d.0[A] -> IRQ 16
[    0.452633] PCI->APIC IRQ transform: 0000:00:1d.1[B] -> IRQ 19
[    0.482616] PCI->APIC IRQ transform: 0000:00:1d.2[C] -> IRQ 18
[    0.511514] PCI->APIC IRQ transform: 0000:00:1d.7[D] -> IRQ 23
[    0.541550] PCI->APIC IRQ transform: 0000:00:1f.1[A] -> IRQ 18
[    0.571329] PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 16
[    0.601273] PCI->APIC IRQ transform: 0000:03:04.0[A] -> IRQ 17
[    0.631319] PCI->APIC IRQ transform: 0000:03:06.0[A] -> IRQ 19
[    0.661153] PCI->APIC IRQ transform: 0000:03:07.0[A] -> IRQ 16
[    0.691113] PCI->APIC IRQ transform: 0000:03:07.1[A] -> IRQ 16
[    0.720943] PCI->APIC IRQ transform: 0000:03:0a.0[A] -> IRQ 17
[    0.756393] Machine check exception polling timer started.
[    0.790054] inotify device minor=63
[    0.815132] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    0.846492] Initializing Cryptographic API
[    0.879833] Linux agpgart interface v0.101 (c) Dave Jones
[    0.909623] agpgart: Detected an Intel 845G Chipset.
[    0.939942] agpgart: AGP aperture is 64M @ 0xe0000000
[    0.968379] [drm] Initialized drm 1.0.0 20040925
[    0.995536] [drm] Initialized radeon 1.16.0 20050311 on minor 0: ATI 
Technologies Inc RV280 [Radeon 9200 SE]
[    1.033790] PNP: No PS/2 controller found. Probing ports directly.
[    1.066501] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.095119] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.122971] Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ 
sharing disabled
[    1.158520] parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
[    1.277486] parport0: irq 7 detected
[    1.302759] io scheduler noop registered
[    1.346503] io scheduler anticipatory registered
[    1.392335] io scheduler deadline registered
[    1.437086] io scheduler cfq registered
[    1.481309] 8139too Fast Ethernet driver 0.9.27
[    1.509327] eth0: RealTek RTL8139 at 0xe0816f00, 00:0c:6e:aa:a2:81, IRQ 17
[    1.540846] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[    1.571805] ide: Assuming 33MHz system bus speed for PIO modes; override 
with idebus=xx
[    1.605675] ICH4: IDE controller at PCI slot 0000:00:1f.1
[    1.634731] ICH4: chipset revision 2
[    1.660462] ICH4: not 100% native mode: will probe irqs later
[    1.690456]     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, 
hdb:DMA
[    1.759264]     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, 
hdd:DMA
[    2.090832] hda: QUANTUM FIREBALLlct10 20, ATA DISK drive
[    2.393040] hdb: IC35L120AVV207-0, ATA DISK drive
[    2.490144] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    3.205907] hdc: _NEC DVD+RW ND-1100A, ATAPI CD/DVD-ROM drive
[    3.544019] hdd: Maxtor 6Y160P0, ATA DISK drive
[    3.640959] ide1 at 0x170-0x177,0x376 on irq 15
[    5.734258] hda: max request size: 128KiB
[    5.764576] hda: 39876480 sectors (20416 MB) w/418KiB Cache, 
CHS=39560/16/63, UDMA(33)
[    5.871412] hda: cache flushes not supported
[    5.903490]  hda: hda1 hda2 hda3
[    6.006605] hdb: max request size: 1024KiB
[    6.041956] hdb: 241254720 sectors (123522 MB) w/1821KiB Cache, 
CHS=16383/255/63, UDMA(100)
[    6.143896] hdb: cache flushes supported
[    6.175952]  hdb: hdb1
[    6.245813] hdd: max request size: 1024KiB
[    6.282154] hdd: 320173056 sectors (163928 MB) w/7936KiB Cache, 
CHS=19929/255/63, UDMA(33)
[    6.393381] hdd: cache flushes supported
[    6.419748]  hdd: hdd1
[    6.494159] hdc: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
[    6.645396] Uniform CD-ROM driver Revision: 3.20
[    6.680014] ehci_hcd 0000:00:1d.7: Intel Corporation 82801DB/DBM 
(ICH4/ICH4-M) USB2 EHCI Controller
[    6.730670] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus 
number 1
[    6.763242] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xdffffc00
[    6.795905] ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 
10 Dec 2004
[    6.829053] usb usb1: Product: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) 
USB2 EHCI Controller
[    6.863855] usb usb1: Manufacturer: Linux 2.6.12-rc1-mm4 ehci_hcd
[    6.892722] usb usb1: SerialNumber: 0000:00:1d.7
[    6.918861] hub 1-0:1.0: USB hub found
[    6.943615] hub 1-0:1.0: 6 ports detected
[    6.989983] USB Universal Host Controller Interface driver v2.2
[    7.019679] uhci_hcd 0000:00:1d.0: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
[    7.119616] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus 
number 2
[    7.152058] uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000e400
[    7.181037] uhci_hcd 0000:00:1d.0: detected 2 ports
[    7.208053] usb usb2: Product: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
[    7.244808] usb usb2: Manufacturer: Linux 2.6.12-rc1-mm4 uhci_hcd
[    7.273715] usb usb2: SerialNumber: 0000:00:1d.0
[    7.299920] hub 2-0:1.0: USB hub found
[    7.324704] hub 2-0:1.0: 2 ports detected
[    7.353024] uhci_hcd 0000:00:1d.1: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
[    7.452750] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus 
number 3
[    7.485181] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000e800
[    7.514288] uhci_hcd 0000:00:1d.1: detected 2 ports
[    7.541135] usb usb3: Product: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
[    7.577951] usb usb3: Manufacturer: Linux 2.6.12-rc1-mm4 uhci_hcd
[    7.606959] usb usb3: SerialNumber: 0000:00:1d.1
[    7.634038] hub 3-0:1.0: USB hub found
[    7.658760] hub 3-0:1.0: 2 ports detected
[    7.687152] uhci_hcd 0000:00:1d.2: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
[    7.786862] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus 
number 4
[    7.819497] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ec00
[    7.848342] uhci_hcd 0000:00:1d.2: detected 2 ports
[    7.875276] usb usb4: Product: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
[    7.912048] usb usb4: Manufacturer: Linux 2.6.12-rc1-mm4 uhci_hcd
[    7.940963] usb usb4: SerialNumber: 0000:00:1d.2
[    7.967176] hub 4-0:1.0: USB hub found
[    7.991868] hub 4-0:1.0: 2 ports detected
[    8.020463] mice: PS/2 mouse device common for all mice
[    8.047747] perfctr/x86.c: hyper-threaded P4s detected: restricting access 
for CPUs 1
[    8.114821] Please email the following PERFCTR INIT lines to 
mikpe@csd.uu.se
[    8.114823] To remove this message, rebuild the driver with 
CONFIG_PERFCTR_INIT_TESTS=n
[    8.179528] PERFCTR INIT: vendor 0, family 15, model 2, stepping 9, clock 
2606669 kHz
[    8.212494] PERFCTR INIT: NITER == 64
[    8.237187] PERFCTR INIT: loop overhead is 584 cycles
[    8.264126] PERFCTR INIT: rdtsc cost is 80.8 cycles (5760 total)
[    8.293081] PERFCTR INIT: rdpmc cost is 145.0 cycles (9868 total)
[    8.322127] PERFCTR INIT: rdmsr (counter) cost is 254.5 cycles (16872 
total)
[    8.352979] PERFCTR INIT: rdmsr (escr) cost is 164.8 cycles (11132 total)
[    8.383802] PERFCTR INIT: wrmsr (counter) cost is 804.3 cycles (52060 
total)
[    8.413943] PERFCTR INIT: wrmsr (escr) cost is 888.1 cycles (57424 total)
[    8.444685] PERFCTR INIT: read cr4 cost is 4.5 cycles (876 total)
[    8.473696] PERFCTR INIT: write cr4 cost is 253.5 cycles (16812 total)
[    8.504584] PERFCTR INIT: rdpmc (fast) cost is 59.8 cycles (4416 total)
[    8.535415] PERFCTR INIT: rdmsr (cccr) cost is 166.4 cycles (11236 total)
[    8.566479] PERFCTR INIT: wrmsr (cccr) cost is 836.2 cycles (54104 total)
[    8.597384] PERFCTR INIT: write LVTPC cost is 36.1 cycles (2900 total)
[    8.628324] PERFCTR INIT: sync_core cost is 263.9 cycles (17476 total)
[    8.659161] perfctr: driver 2.7.14, cpu type Intel P4 at 2606669 kHz
[    8.689072] Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu 
Mar 24 10:33:39 2005 UTC).
[    8.750109] input: AT Translated Set 2 keyboard on isa0060/serio0
[    8.930563] ALSA device list:
[    8.953369]   #0: Yamaha DS-XG (YMF724) at 0xdfef8000, irq 17
[    8.982315] NET: Registered protocol family 2
[    9.023585] IP: routing cache hash table of 2048 buckets, 32Kbytes
[    9.053486] TCP established hash table entries: 32768 (order: 7, 524288 
bytes)
[    9.085634] TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
[    9.116682] TCP: Hash tables configured (established 32768 bind 32768)
[    9.147016] NET: Registered protocol family 1
[    9.172883] NET: Registered protocol family 17
[    9.198895] Testing NMI watchdog ... OK.
[    9.251547] Starting balanced_irq
[    9.278330] VFS: Mounted root (ext2 filesystem) readonly.
[    9.306819] Freeing unused kernel memory: 192k freed
[    9.355059] logips2pp: Detected unknown logitech mouse model 1
[    9.403372] Warning: unable to open an initial console.
[    9.792071] input: PS/2 Logitech Mouse on isa0060/serio1

Program received signal SIGTRAP, Trace/breakpoint trap.
0xc0102f0b in resume_kernelX () at atomic.h:175

yeah, I don't get it - gdb says we're at atomic.h:175 but resume_kernelX() is 
a jump label in arch/i386/kernel/entry.S:272:

    272 resume_kernelX:
    273 #endif
    274     movl EFLAGS(%esp), %eax     # mix EFLAGS, SS and CS
    275     movb OLDSS(%esp), %ah
    276     movb CS(%esp), %al
    277     andl $(VM_MASK | (4 << 8) | 3), %eax
    278     cmpl $((4 << 8) | 3), %eax
    279     je ldt_ss           # returning to user-space with LDT SS

175     {
(gdb) list
170      * Atomically adds @i to @v and returns true
171      * if the result is negative, or false when
172      * result is greater than or equal to zero.
173      */
174     static __inline__ int atomic_add_negative(int i, atomic_t *v)
175     {
176             unsigned char c;
177
178             __asm__ __volatile__(
179                     LOCK "addl %2,%0; sets %1"
(gdb) list +
180                     :"=m" (v->counter), "=qm" (c)
181                     :"ir" (i), "m" (v->counter) : "memory");
182             return c;
183     }
184

and list delivers the source of atomic.h but if I disassemble $eip = 
0xc0102f0b, I get the asm code of  arch/i386/kernel/entry.S:272:

(gdb) disas 0xc0102f0b
Dump of assembler code for function resume_kernelX:
0xc0102f0b <resume_kernelX+0>:  mov    0x30(%esp),%eax
0xc0102f0f <resume_kernelX+4>:  mov    0x38(%esp),%ah
0xc0102f13 <resume_kernelX+8>:  mov    0x2c(%esp),%al
0xc0102f17 <resume_kernelX+12>: and    $0x20403,%eax
0xc0102f1c <resume_kernelX+17>: cmp    $0x403,%eax
0xc0102f21 <resume_kernelX+22>: je     0xc0102f30 <ldt_ss>
End of assembler dump.
(gdb) info all-registers
eax            0x273    627
ecx            0x0      0
edx            0x10000  65536
ebx            0xb7f04c00       -1208988672
esp            0xc15c4fc4       0xc15c4fc4
ebp            0xbfa02654       0xbfa02654
esi            0x0      0
edi            0xb7f00c21       -1209005023
eip            0xc0102f0b       0xc0102f0b
eflags         0x86     134
cs             0x60     96
ss             0x68     104
ds             0xc010007b       -1072693125
es             0xc15c007b       -1050935173
fs             0xffff   65535
gs             0xffff   65535
st0            0        (raw 0x00000000000000000000)
st1            0        (raw 0x00000000000000000000)
st2            0        (raw 0x00000000000000000000)
st3            0        (raw 0x00000000000000000000)
st4            0        (raw 0x00000000000000000000)
st5            0        (raw 0x00000000000000000000)
st6            0        (raw 0x00000000000000000000)
st7            0        (raw 0x00000000000000000000)
fctrl          0x0      0
fstat          0x0      0
ftag           0x0      0
fiseg          0x0      0
fioff          0x0      0
foseg          0x0      0
fooff          0x0      0
fop            0x0      0
xmm0           {v4_float = {0x0, 0x0, 0x0, 0x0}, v2_double = {0x0, 0x0}, 
v16_int8 = {0x0 <repeats 16 times>}, v8_int16 = {0x0, 0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0}, v4_int32 = {
    0x0, 0x0, 0x0, 0x0}, v2_int64 = {0x0, 0x0}, uint128 = 
0x00000000000000000000000000000000}
xmm1           {v4_float = {0x0, 0x0, 0x0, 0x0}, v2_double = {0x0, 0x0}, 
v16_int8 = {0x0 <repeats 16 times>}, v8_int16 = {0x0, 0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0}, v4_int32 = {
    0x0, 0x0, 0x0, 0x0}, v2_int64 = {0x0, 0x0}, uint128 = 
0x00000000000000000000000000000000}
xmm2           {v4_float = {0x0, 0x0, 0x0, 0x0}, v2_double = {0x0, 0x0}, 
v16_int8 = {0x0 <repeats 16 times>}, v8_int16 = {0x0, 0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0}, v4_int32 = {
    0x0, 0x0, 0x0, 0x0}, v2_int64 = {0x0, 0x0}, uint128 = 
0x00000000000000000000000000000000}
xmm3           {v4_float = {0x0, 0x0, 0x0, 0x0}, v2_double = {0x0, 0x0}, 
v16_int8 = {0x0 <repeats 16 times>}, v8_int16 = {0x0, 0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0}, v4_int32 = {
    0x0, 0x0, 0x0, 0x0}, v2_int64 = {0x0, 0x0}, uint128 = 
0x00000000000000000000000000000000}
xmm4           {v4_float = {0x0, 0x0, 0x0, 0x0}, v2_double = {0x0, 0x0}, 
v16_int8 = {0x0 <repeats 16 times>}, v8_int16 = {0x0, 0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0}, v4_int32 = {
    0x0, 0x0, 0x0, 0x0}, v2_int64 = {0x0, 0x0}, uint128 = 
0x00000000000000000000000000000000}
xmm5           {v4_float = {0x0, 0x0, 0x0, 0x0}, v2_double = {0x0, 0x0}, 
v16_int8 = {0x0 <repeats 16 times>}, v8_int16 = {0x0, 0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0}, v4_int32 = {
    0x0, 0x0, 0x0, 0x0}, v2_int64 = {0x0, 0x0}, uint128 = 
0x00000000000000000000000000000000}
xmm6           {v4_float = {0x0, 0x0, 0x0, 0x0}, v2_double = {0x0, 0x0}, 
v16_int8 = {0x0 <repeats 16 times>}, v8_int16 = {0x0, 0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0}, v4_int32 = {
    0x0, 0x0, 0x0, 0x0}, v2_int64 = {0x0, 0x0}, uint128 = 
0x00000000000000000000000000000000}
xmm7           {v4_float = {0x0, 0x0, 0x0, 0x0}, v2_double = {0x0, 0x0}, 
v16_int8 = {0x0 <repeats 16 times>}, v8_int16 = {0x0, 0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0}, v4_int32 = {
---Type <return> to continue, or q <return> to quit---
    0x0, 0x0, 0x0, 0x0}, v2_int64 = {0x0, 0x0}, uint128 = 
0x00000000000000000000000000000000}
mxcsr          0x0      0
mm0            {uint64 = 0x0, v2_int32 = {0x0, 0x0}, v4_int16 = {0x0, 0x0, 
0x0, 0x0}, v8_int8 = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}}
mm1            {uint64 = 0x0, v2_int32 = {0x0, 0x0}, v4_int16 = {0x0, 0x0, 
0x0, 0x0}, v8_int8 = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}}
mm2            {uint64 = 0x0, v2_int32 = {0x0, 0x0}, v4_int16 = {0x0, 0x0, 
0x0, 0x0}, v8_int8 = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}}
mm3            {uint64 = 0x0, v2_int32 = {0x0, 0x0}, v4_int16 = {0x0, 0x0, 
0x0, 0x0}, v8_int8 = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}}
mm4            {uint64 = 0x0, v2_int32 = {0x0, 0x0}, v4_int16 = {0x0, 0x0, 
0x0, 0x0}, v8_int8 = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}}
mm5            {uint64 = 0x0, v2_int32 = {0x0, 0x0}, v4_int16 = {0x0, 0x0, 
0x0, 0x0}, v8_int8 = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}}
mm6            {uint64 = 0x0, v2_int32 = {0x0, 0x0}, v4_int16 = {0x0, 0x0, 
0x0, 0x0}, v8_int8 = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}}
mm7            {uint64 = 0x0, v2_int32 = {0x0, 0x0}, v4_int16 = {0x0, 0x0, 
0x0, 0x0}, v8_int8 = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}}
(gdb) bt
#0  0xc0102f0b in resume_kernelX () at atomic.h:175
#1  0xb7f04c00 in ?? ()
#2  0xbfa026ac in ?? ()
#3  0x00000200 in ?? ()
#4  0x00000000 in ?? ()
#5  0xb7f00c21 in ?? ()
#6  0xbfa02654 in ?? ()
#7  0x00000200 in ?? ()
#8  0x0000007b in ?? ()
#9  0xc010007b in startup_32_smp () at arch/i386/kernel/head.S:146
#10 0x00000200 in ?? ()
#11 0xb7ef3c1e in ?? ()
#12 0x00000073 in ?? ()
#13 0x00000217 in ?? ()
#14 0xbfa025f8 in ?? ()
#15 0x0000007b in ?? ()
#16 0xc13f0180 in ?? ()
#17 0x00000000 in ?? ()
#18 0x1f80c000 in ?? ()
#19 0x00002000 in ?? ()
#20 0xc13f11c0 in ?? ()
#21 0x00000000 in ?? ()
#22 0x1f88e000 in ?? ()
#23 0x00002000 in ?? ()
#24 0xc13f1200 in ?? ()
#25 0x00000000 in ?? ()
#26 0x1f890000 in ?? ()
#27 0x00003000 in ?? ()
#28 0xc102f600 in ?? ()
#29 0x00000000 in ?? ()
#30 0x017b0000 in ?? ()
#31 0x0000b000 in ?? ()
#32 0x5a5a5a5a in ?? ()
#33 0x5a5a5a5a in ?? ()
#34 0x5a5a5a5a in ?? ()
#35 0x5a5a5a5a in ?? ()
#36 0x5a5a5a5a in ?? ()
#37 0x5a5a5a5a in ?? ()
#38 0x5a5a5a5a in ?? ()
#39 0x5a5a5a5a in ?? ()
#40 0x5a5a5a5a in ?? ()
#41 0x5a5a5a5a in ?? ()
#42 0x5a5a5a5a in ?? ()
#43 0x5a5a5a5a in ?? ()
#44 0x5a5a5a5a in ?? ()
#45 0x5a5a5a5a in ?? ()
#46 0x5a5a5a5a in ?? ()
---Type <return> to continue, or q <return> to quit---
#47 0x5a5a5a5a in ?? ()
#48 0x5a5a5a5a in ?? ()
#49 0x5a5a5a5a in ?? ()
#50 0x5a5a5a5a in ?? ()
#51 0x5a5a5a5a in ?? ()
#52 0x5a5a5a5a in ?? ()
#53 0x5a5a5a5a in ?? ()
#54 0x5a5a5a5a in ?? ()
#55 0x5a5a5a5a in ?? ()
#56 0x5a5a5a5a in ?? ()
#57 0x5a5a5a5a in ?? ()
#58 0x5a5a5a5a in ?? ()
#59 0x5a5a5a5a in ?? ()
#60 0x5a5a5a5a in ?? ()
#61 0x5a5a5a5a in ?? ()
#62 0x5a5a5a5a in ?? ()
#63 0x5a5a5a5a in ?? ()
#64 0x5a5a5a5a in ?? ()
#65 0x5a5a5a5a in ?? ()
#66 0x5a5a5a5a in ?? ()
#67 0x5a5a5a5a in ?? ()
#68 0x5a5a5a5a in ?? ()
#69 0x5a5a5a5a in ?? ()
#70 0x5a5a5a5a in ?? ()
#71 0x5a5a5a5a in ?? ()
#72 0x5a5a5a5a in ?? ()
#73 0x5a5a5a5a in ?? ()
#74 0x5a5a5a5a in ?? ()
#75 0x5a5a5a5a in ?? ()
#76 0x5a5a5a5a in ?? ()
#77 0x5a5a5a5a in ?? ()
#78 0x5a5a5a5a in ?? ()
#79 0x5a5a5a5a in ?? ()
#80 0x5a5a5a5a in ?? ()
#81 0x5a5a5a5a in ?? ()
#82 0x5a5a5a5a in ?? ()
#83 0x5a5a5a5a in ?? ()
#84 0x5a5a5a5a in ?? ()
#85 0x5a5a5a5a in ?? ()
#86 0x5a5a5a5a in ?? ()
#87 0x5a5a5a5a in ?? ()
#88 0x5a5a5a5a in ?? ()
#89 0x5a5a5a5a in ?? ()
#90 0x5a5a5a5a in ?? ()
#91 0x5a5a5a5a in ?? ()
#92 0x5a5a5a5a in ?? ()
#93 0x5a5a5a5a in ?? ()
---Type <return> to continue, or q <return> to quit---
#94 0x5a5a5a5a in ?? ()
#95 0x5a5a5a5a in ?? ()
#96 0x5a5a5a5a in ?? ()
#97 0x5a5a5a5a in ?? ()
#98 0x5a5a5a5a in ?? ()
#99 0x5a5a5a5a in ?? ()
#100 0x5a5a5a5a in ?? ()
#101 0x5a5a5a5a in ?? ()
#102 0x5a5a5a5a in ?? ()
#103 0x5a5a5a5a in ?? ()
#104 0x5a5a5a5a in ?? ()
#105 0x5a5a5a5a in ?? ()
#106 0x5a5a5a5a in ?? ()
#107 0x5a5a5a5a in ?? ()
#108 0x5a5a5a5a in ?? ()
#109 0x5a5a5a5a in ?? ()
#110 0x5a5a5a5a in ?? ()
#111 0x5a5a5a5a in ?? ()
#112 0x5a5a5a5a in ?? ()
#113 0x5a5a5a5a in ?? ()
#114 0x5a5a5a5a in ?? ()
#115 0x5a5a5a5a in ?? ()
#116 0x5a5a5a5a in ?? ()
#117 0x5a5a5a5a in ?? ()
#118 0x5a5a5a5a in ?? ()
#119 0x5a5a5a5a in ?? ()
#120 0x5a5a5a5a in ?? ()
#121 0x5a5a5a5a in ?? ()
#122 0x5a5a5a5a in ?? ()
#123 0x5a5a5a5a in ?? ()
#124 0x5a5a5a5a in ?? ()
#125 0x5a5a5a5a in ?? ()
#126 0x5a5a5a5a in ?? ()
#127 0x5a5a5a5a in ?? ()
#128 0x5a5a5a5a in ?? ()
#129 0x5a5a5a5a in ?? ()
#130 0x5a5a5a5a in ?? ()
#131 0x5a5a5a5a in ?? ()
#132 0x5a5a5a5a in ?? ()
#133 0x5a5a5a5a in ?? ()
#134 0x5a5a5a5a in ?? ()
#135 0x5a5a5a5a in ?? ()
#136 0x5a5a5a5a in ?? ()
#137 0x5a5a5a5a in ?? ()
#138 0x5a5a5a5a in ?? ()
#139 0x5a5a5a5a in ?? ()
#140 0x5a5a5a5a in ?? ()
---Type <return> to continue, or q <return> to quit---
#141 0x5a5a5a5a in ?? ()
#142 0x5a5a5a5a in ?? ()
#143 0x5a5a5a5a in ?? ()
#144 0x5a5a5a5a in ?? ()
#145 0x5a5a5a5a in ?? ()
#146 0x5a5a5a5a in ?? ()
#147 0x5a5a5a5a in ?? ()
#148 0x5a5a5a5a in ?? ()
#149 0x5a5a5a5a in ?? ()
#150 0x5a5a5a5a in ?? ()
#151 0x5a5a5a5a in ?? ()
#152 0x5a5a5a5a in ?? ()
#153 0x5a5a5a5a in ?? ()
#154 0x5a5a5a5a in ?? ()
#155 0x5a5a5a5a in ?? ()
#156 0x5a5a5a5a in ?? ()
#157 0x5a5a5a5a in ?? ()
#158 0x5a5a5a5a in ?? ()
#159 0x5a5a5a5a in ?? ()
#160 0x5a5a5a5a in ?? ()
#161 0x5a5a5a5a in ?? ()
#162 0x5a5a5a5a in ?? ()
#163 0x5a5a5a5a in ?? ()
#164 0x5a5a5a5a in ?? ()
#165 0x5a5a5a5a in ?? ()
#166 0x5a5a5a5a in ?? ()
#167 0x5a5a5a5a in ?? ()
#168 0x5a5a5a5a in ?? ()
#169 0x5a5a5a5a in ?? ()
#170 0x5a5a5a5a in ?? ()
#171 0x5a5a5a5a in ?? ()
#172 0x5a5a5a5a in ?? ()
#173 0x5a5a5a5a in ?? ()
#174 0x5a5a5a5a in ?? ()
#175 0x5a5a5a5a in ?? ()
#176 0x5a5a5a5a in ?? ()
#177 0x5a5a5a5a in ?? ()
#178 0x5a5a5a5a in ?? ()
#179 0x5a5a5a5a in ?? ()
#180 0x5a5a5a5a in ?? ()
#181 0x5a5a5a5a in ?? ()
#182 0x5a5a5a5a in ?? ()
#183 0x5a5a5a5a in ?? ()
#184 0x5a5a5a5a in ?? ()
#185 0x5a5a5a5a in ?? ()
#186 0x5a5a5a5a in ?? ()
#187 0x5a5a5a5a in ?? ()
---Type <return> to continue, or q <return> to quit---
#188 0x5a5a5a5a in ?? ()
#189 0x5a5a5a5a in ?? ()
#190 0x5a5a5a5a in ?? ()
#191 0x5a5a5a5a in ?? ()
#192 0x5a5a5a5a in ?? ()
#193 0x5a5a5a5a in ?? ()
#194 0x5a5a5a5a in ?? ()
#195 0x5a5a5a5a in ?? ()
#196 0x5a5a5a5a in ?? ()
#197 0x5a5a5a5a in ?? ()
#198 0x5a5a5a5a in ?? ()
#199 0x5a5a5a5a in ?? ()
#200 0x5a5a5a5a in ?? ()
#201 0x5a5a5a5a in ?? ()
#202 0x5a5a5a5a in ?? ()
#203 0x5a5a5a5a in ?? ()
#204 0x5a5a5a5a in ?? ()
#205 0x5a5a5a5a in ?? ()
#206 0x5a5a5a5a in ?? ()
#207 0x5a5a5a5a in ?? ()
#208 0x5a5a5a5a in ?? ()
#209 0x5a5a5a5a in ?? ()
#210 0x5a5a5a5a in ?? ()
#211 0x5a5a5a5a in ?? ()
#212 0x5a5a5a5a in ?? ()
#213 0x5a5a5a5a in ?? ()
#214 0x5a5a5a5a in ?? ()
#215 0x5a5a5a5a in ?? ()
#216 0x5a5a5a5a in ?? ()
#217 0x5a5a5a5a in ?? ()
#218 0x5a5a5a5a in ?? ()
#219 0x5a5a5a5a in ?? ()
#220 0x5a5a5a5a in ?? ()
#221 0x5a5a5a5a in ?? ()
#222 0x5a5a5a5a in ?? ()
#223 0x5a5a5a5a in ?? ()
#224 0x5a5a5a5a in ?? ()
#225 0x5a5a5a5a in ?? ()
#226 0x5a5a5a5a in ?? ()
#227 0x5a5a5a5a in ?? ()
#228 0x5a5a5a5a in ?? ()
#229 0x5a5a5a5a in ?? ()
#230 0x5a5a5a5a in ?? ()
#231 0x5a5a5a5a in ?? ()
#232 0x5a5a5a5a in ?? ()
#233 0x5a5a5a5a in ?? ()
#234 0x5a5a5a5a in ?? ()
---Type <return> to continue, or q <return> to quit---q
Quit
(gdb) info frame
Stack level 0, frame at 0xc15c4fc8:
 eip = 0xc0102f0b in resume_kernelX (atomic.h:175); saved eip 0xb7f04c00
 called by frame at 0xc15c4fcc
 source language c.
 Arglist at 0xc15c4fc0, args:
 Locals at 0xc15c4fc0, Previous frame's sp is 0xc15c4fc8
 Saved registers:
  eip at 0xc15c4fc4

Backtrace leaves a lot of SLAB_POISON values. Anyhow, this is as far as I can 
get but I'm missing the big picture here and don't know what exactly to look 
for. Probably someone more experienced should look at this ..

Regards,
Boris.
