Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbTAXWfc>; Fri, 24 Jan 2003 17:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbTAXWfc>; Fri, 24 Jan 2003 17:35:32 -0500
Received: from fmr02.intel.com ([192.55.52.25]:8669 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S261371AbTAXWfM> convert rfc822-to-8bit; Fri, 24 Jan 2003 17:35:12 -0500
content-class: urn:content-classes:message
Subject: RE: 2.5.59-mm5: cpu1 not working
Date: Fri, 24 Jan 2003 14:44:17 -0800
Message-ID: <E88224AA79D2744187E7854CA8D9131DFEE8B7@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.5.59-mm5: cpu1 not working
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcLD8lW1cYKUkC/lEdeNCQBQi+Bs2AABt0zw
From: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
To: "Arador" <diegocg@teleline.es>
Cc: "Andrew Morton" <akpm@digeo.com>, <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
X-OriginalArrivalTime: 24 Jan 2003 22:44:17.0520 (UTC) FILETIME=[208DCF00:01C2C3FA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arador,
  There is nothing wrong with the /proc/interrupts output. The kirq patch balances the interrupts load only when there is sizable load imbalance, which you don't seem to have. In such cases interrupts will not move around.
   Try generating lots of interrupts load in the system, and then the interrupts will get distributed across CPUs.

Thanks, & Regards,
Nitin

> -----Original Message-----
> From: Arador [mailto:diegocg@teleline.es]
> Sent: Friday, January 24, 2003 1:49 PM
> To: Kamble, Nitin A
> Cc: Andrew Morton; linux-kernel@vger.kernel.org
> Subject: 2.5.59-mm5: cpu1 not working
> 
> machine: p3 2x800, 128 mb of ram, via VT82C686 chipset
> The problem is that in 2.5.59-mm kernels;
> /proc/interrupts shows something like this:
> 
> diego@estel:~$ cat /proc/interrupts
>            CPU0       CPU1
>   0:      49316          0    IO-APIC-edge  timer
>   1:         95          0    IO-APIC-edge  i8042
>   2:          0          0          XT-PIC  cascade
>   3:       1859          0  IO-APIC-edge  serial
>   4:        912          0    IO-APIC-edge  serial
>   8:          2          0    IO-APIC-edge  rtc
>  10:       1291          0   IO-APIC-level  VIA686A
>  14:       2407          0    IO-APIC-edge  ide0
>  15:         11          0    IO-APIC-edge  ide1
> NMI:     101404     101288
> LOC:     101258     101296
> ERR:          0
> MIS:          0
> 
> plain 2.5.59 works well. reverting kirq and kirq-up-fix
> patches (as suggested by Andrew Morton) from the -mm patchset
> fixes the problem.
> 
> Config attached
> This dmesg is from a 2.5.59-mm5 kernel with the kirq patch _reverted_
> 
> (BTW, this space
> testing the IO APIC.......................
> 
> IO APIC #2......
> isn't a cut & paste error, it appears in dmesg)
> 
> Linux version 2.5.59-mm5 (diego@estel) (gcc versión 3.2.2 20030109 (Debian
> prerelease)) #4 SMP vie ene 24 22:16:17 CET 2003
> Video mode to be used for restore is 30a
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
>  BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
>  BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
>  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> 255MB LOWMEM available.
> found SMP MP-table at 000f64e0
> hm, page 000f6000 reserved twice.
> hm, page 000f7000 reserved twice.
> hm, page 000f1000 reserved twice.
> hm, page 000f2000 reserved twice.
> On node 0 totalpages: 65520
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 61424 pages, LIFO batch:14
>   HighMem zone: 0 pages, LIFO batch:1
> Intel MultiProcessor Specification v1.4
>     Virtual Wire compatibility mode.
> OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
> Processor #0 6:8 APIC version 17
> Processor #1 6:8 APIC version 17
> I/O APIC #2 Version 17 at 0xFEC00000.
> Enabling APIC mode:  Flat.  Using 1 I/O APICs
> Processors: 2
> Building zonelist for node : 0
> Kernel command line: root=/dev/hda5 ro vga=0x30a profile=2 nmi_watchdog=1
> kernel profiling enabled
> Initializing CPU#0
> PID hash table entries: 1024 (order 10: 8192 bytes)
> Detected 802.853 MHz processor.
> Console: colour VGA+ 132x43
> Calibrating delay loop... 1581.05 BogoMIPS
> Memory: 254552k/262080k available (1665k kernel code, 6792k reserved, 485k
> data, 144k init, 0k highmem)
> Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> -> /dev
> -> /dev/console
> -> /root
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 256K
> CPU serial number disabled.
> CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> CPU0: Intel Pentium III (Coppermine) stepping 06
> per-CPU timeslice cutoff: 732.17 usecs.
> task migration cache decay timeout: 1 msecs.
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Booting processor 1/1 eip 2000
> Initializing CPU#1
> masked ExtINT on CPU#1
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Calibrating delay loop... 1601.53 BogoMIPS
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 256K
> CPU serial number disabled.
> CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#1.
> CPU1: Intel Pentium III (Coppermine) stepping 06
> Total of 2 processors activated (3182.59 BogoMIPS).
> ENABLING IO-APIC IRQs
> Setting 2 in the phys_id_present_map
> ...changing IO-APIC physical APIC ID to 2 ... ok.
> init IO_APIC IRQs
>  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23
> not connected.
> ..TIMER: vector=0x31 pin1=2 pin2=0
> activating NMI Watchdog ... done.
> testing NMI watchdog ... OK.
> number of MP IRQ sources: 19.
> number of IO-APIC #2 registers: 24.
> testing the IO APIC.......................
> 
> IO APIC #2......
> .... register #00: 02000000
> .......    : physical APIC id: 02
> .......    : Delivery Type: 0
> .......    : LTS          : 0
> .... register #01: 00178011
> .......     : max redirection entries: 0017
> .......     : PRQ implemented: 1
> .......     : IO APIC version: 0011
> .... register #02: 00000000
> .......     : arbitration: 00
> .... IRQ redirection table:
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
>  00 000 00  1    0    0   0   0    0    0    00
>  01 001 01  0    0    0   0   0    1    1    39
>  02 001 01  0    0    0   0   0    1    1    31
>  03 001 01  0    0    0   0   0    1    1    41
>  04 001 01  0    0    0   0   0    1    1    49
>  05 001 01  0    0    0   0   0    1    1    51
>  06 001 01  0    0    0   0   0    1    1    59
>  07 001 01  0    0    0   0   0    1    1    61
>  08 001 01  0    0    0   0   0    1    1    69
>  09 001 01  0    0    0   0   0    1    1    71
>  0a 001 01  1    1    0   1   0    1    1    79
>  0b 001 01  1    1    0   1   0    1    1    81
>  0c 001 01  1    1    0   1   0    1    1    89
>  0d 001 01  0    0    0   0   0    1    1    91
>  0e 001 01  0    0    0   0   0    1    1    99
>  0f 001 01  0    0    0   0   0    1    1    A1
>  10 000 00  1    0    0   0   0    0    0    00
>  11 000 00  1    0    0   0   0    0    0    00
>  12 000 00  1    0    0   0   0    0    0    00
>  13 000 00  1    0    0   0   0    0    0    00
>  14 000 00  1    0    0   0   0    0    0    00
>  15 000 00  1    0    0   0   0    0    0    00
>  16 000 00  1    0    0   0   0    0    0    00
>  17 000 00  1    0    0   0   0    0    0    00
> IRQ to pin mappings:
> IRQ0 -> 0:2
> IRQ1 -> 0:1
> IRQ3 -> 0:3
> IRQ4 -> 0:4
> IRQ5 -> 0:5
> IRQ6 -> 0:6
> IRQ7 -> 0:7
> IRQ8 -> 0:8
> IRQ9 -> 0:9
> IRQ10 -> 0:10
> IRQ11 -> 0:11
> IRQ12 -> 0:12
> IRQ13 -> 0:13
> IRQ14 -> 0:14
> IRQ15 -> 0:15
> .................................... done.
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 802.0804 MHz.
> ..... host bus clock speed is 133.0800 MHz.
> checking TSC synchronization across 2 CPUs: passed.
> Starting migration thread for cpu 0
> Bringing up 1
> CPU 1 IS NOW UP!
> Starting migration thread for cpu 1
> CPUS done 2
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> mtrr: v2.0 (20020519)
> mtrr: your CPUs had inconsistent variable MTRR settings
> mtrr: probably your BIOS does not setup all CPUs
> PCI: PCI BIOS revision 2.10 entry at 0xfb250, last bus=1
> PCI: Using configuration type 1
> BIO: pool of 256 setup, 14Kb (56 bytes/bio)
> biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
> biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
> biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
> biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
> biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
> biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
> Linux Plug and Play Support v0.94 (c) Adam Belay
> pnp: Enabling Plug and Play Card Services.
> PnPBIOS: Found PnP BIOS installation structure at 0xc00fbcc0
> PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbcf0, dseg 0xf0000
> PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
> block request queues:
>  128 requests per read queue
>  128 requests per write queue
>  8 requests per batch
>  enter congestion at 15
>  exit congestion at 17
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> PCI: Using IRQ router VIA [1106/0686] at 00:07.0
> PCI->APIC IRQ transform: (B0,I7,P3) -> 12
> PCI->APIC IRQ transform: (B0,I7,P3) -> 12
> PCI->APIC IRQ transform: (B0,I7,P2) -> 10
> PCI->APIC IRQ transform: (B0,I9,P0) -> 11
> PCI->APIC IRQ transform: (B0,I13,P0) -> 11
> Enabling SEP on CPU 0
> Enabling SEP on CPU 1
> aio_setup: sizeof(struct page) = 40
> Journalled Block Device driver loaded
> PCI: Enabling Via external APIC routing
> Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> pty: 256 Unix98 ptys configured
> Real Time Clock Driver v1.11
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> VP_IDE: IDE controller at PCI slot 00:07.1
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
>     ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:DMA
> hda: Maxtor 6Y060L0, ATA DISK drive
> hda: DMA disabled
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: LG CD-ROM CRD-8522B, ATAPI CD/DVD-ROM drive
> hdd: ST340016A, ATA DISK drive
> hdc: DMA disabled
> hdd: DMA disabled
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: host protected area => 1
> hda: 120103200 sectors (61493 MB) w/2048KiB Cache, CHS=119150/16/63,
> UDMA(100)
>  hda: hda1 < hda5 hda6 > hda2 hda3 hda4
> hdd: host protected area => 1
> hdd: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63,
> UDMA(33)
>  hdd: hdd1
> serio: i8042 AUX port at 0x60,0x64 irq 12
> input: AT Set 2 keyboard on isa0060/serio0
> serio: i8042 KBD port at 0x60,0x64 irq 1
> Advanced Linux Sound Architecture Driver Version 0.9.0rc6 (Tue Dec 17
> 19:01:13 2002 UTC).
> request_module[snd-card-0]: not ready
> request_module[snd-card-1]: not ready
> request_module[snd-card-2]: not ready
> request_module[snd-card-3]: not ready
> request_module[snd-card-4]: not ready
> request_module[snd-card-5]: not ready
> request_module[snd-card-6]: not ready
> request_module[snd-card-7]: not ready
> no UART detected at 0xffff
> ALSA sound/drivers/mpu401/mpu401.c:76: specify port
> PCI: Setting latency timer of device 00:07.5 to 64
> ALSA device list:
>   #0: VIA 82C686A/B at 0xcc00, irq 10
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP: routing cache hash table of 1024 buckets, 16Kbytes
> TCP: Hash tables configured (established 8192 bind 10922)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 144k freed
> Adding 530104k swap on /dev/hda6.  Priority:-1 extents:1
> EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,5), internal journal
> parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
> parport0: cpp_daisy: aa5500ff(38)
> parport0: assign_addrs: aa5500ff(38)
> Module parport cannot be unloaded due to unsafe usage in
> include/linux/module.h:430
> Module parport_pc cannot be unloaded due to unsafe usage in
> include/linux/module.h:430
> parport0: cpp_daisy: aa5500ff(38)
> parport0: assign_addrs: aa5500ff(38)
> parport_pc: Via 686A parallel port: io=0x378
> lp0: using parport0 (polling).
> hdc: ATAPI 48X CD-ROM drive, 128kB Cache, DMA
> Uniform CD-ROM driver Revision: 3.12
> end_request: I/O error, dev hdc, sector 0
> CSLIP: code copyright 1989 Regents of the University of California
> PPP generic driver version 2.4.2
> [drm] Initialized tdfx 1.0.0 20010216 on minor 0
> Module ppp_async cannot be unloaded due to unsafe usage in
> include/linux/module.h:430
> PPP BSD Compression module registered
> Module bsd_comp cannot be unloaded due to unsafe usage in
> include/linux/module.h:430
> PPP Deflate Compression module registered
> Module ppp_deflate cannot be unloaded due to unsafe usage in
> include/linux/module.h:430
> end_request: I/O error, dev hdc, sector 0
> end_request: I/O error, dev hdc, sector 0
> end_request: I/O error, dev hdc, sector 0
> cdrom: This disc doesn't have any tracks I recognize!
> 
> 
> 
> 
> Diego Calleja
