Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbSJIMKl>; Wed, 9 Oct 2002 08:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261582AbSJIMKl>; Wed, 9 Oct 2002 08:10:41 -0400
Received: from web40306.mail.yahoo.com ([66.218.78.85]:50290 "HELO
	web40306.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261581AbSJIMJ7>; Wed, 9 Oct 2002 08:09:59 -0400
Message-ID: <20021009121537.80243.qmail@web40306.mail.yahoo.com>
Date: Wed, 9 Oct 2002 14:15:37 +0200 (CEST)
From: =?iso-8859-1?q?Konstantin=20Artiouchine?= <artiouchine@yahoo.fr>
Reply-To: Konstantin.Artiouchine@polytechnique.org
Subject: 2.5: sleeping function called from illegal context
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a following problem with 2.5.[39,40,41]:

Debug: sleeping function called from illegal context at slab.c:1374

Here is a part of /var/log/messages and .config:

--
Konstantin


Oct  9 15:42:30 kappa kernel: klogd 1.4.1, log source = /proc/kmsg started.
Oct  9 15:42:30 kappa partmon: Checking if partitions have enough free
diskspace: 
Oct  9 15:42:30 kappa kernel: Inspecting /boot/System.map-2.5.40
Oct  9 15:42:31 kappa kernel: Loaded 19039 symbols from
/boot/System.map-2.5.40.
Oct  9 15:42:31 kappa kernel: Symbols match kernel version 2.5.40.
Oct  9 15:42:31 kappa kernel: No module symbols loaded.
Oct  9 15:42:31 kappa kernel: Linux version 2.5.40 (root@kappa) (gcc version
3.2 (Mandrake Linux 9.0 3.2-1mdk)) #2 Wed Oct 9 13:41:07 CEST 2002
Oct  9 15:42:31 kappa kernel: Video mode to be used for restore is 314
Oct  9 15:42:31 kappa kernel: BIOS-provided physical RAM map:
Oct  9 15:42:31 kappa kernel:  BIOS-e820: 0000000000000000 - 000000000009ec00
(usable)
Oct  9 15:42:31 kappa kernel:  BIOS-e820: 000000000009ec00 - 00000000000a0000
(reserved)
Oct  9 15:42:31 kappa kernel:  BIOS-e820: 00000000000c0000 - 00000000000d0000
(reserved)
Oct  9 15:42:31 kappa kernel:  BIOS-e820: 00000000000d4000 - 00000000000d8000
(reserved)
Oct  9 15:42:31 kappa kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000
(reserved)
Oct  9 15:42:31 kappa kernel:  BIOS-e820: 0000000000100000 - 0000000017ef0000
(usable)
Oct  9 15:42:31 kappa kernel:  BIOS-e820: 0000000017ef0000 - 0000000017eff000
(ACPI data)
Oct  9 15:42:31 kappa kernel:  BIOS-e820: 0000000017eff000 - 0000000017f00000
(ACPI NVS)
Oct  9 15:42:31 kappa kernel:  BIOS-e820: 0000000017f00000 - 0000000018000000
(usable)
Oct  9 15:42:31 kappa kernel:  BIOS-e820: 00000000fffc0000 - 0000000100000000
(reserved)
Oct  9 15:42:31 kappa kernel: 384MB LOWMEM available.
Oct  9 15:42:31 kappa kernel: On node 0 totalpages: 98304
Oct  9 15:42:31 kappa kernel:   DMA zone: 4096 pages
Oct  9 15:42:31 kappa kernel:   Normal zone: 94208 pages
Oct  9 15:42:31 kappa kernel:   HighMem zone: 0 pages
Oct  9 15:42:31 kappa kernel: ACPI: RSDP (v000 PTLTD                      ) @
0x000f6cc0
Oct  9 15:42:31 kappa kernel: ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @
0x17eface9
Oct  9 15:42:31 kappa kernel: ACPI: FADT (v001 SMDVIA VT5228C  01540.00000) @
0x17efef8c
Oct  9 15:42:31 kappa kernel: ACPI: DSDT (v001  VIA   PTL_ACPI 01540.00000) @
0x00000000
Oct  9 15:42:31 kappa kernel: ACPI: BIOS passes blacklist
Oct  9 15:42:31 kappa kernel: ACPI: MADT not present
Oct  9 15:42:31 kappa kernel: Building zonelist for node : 0
Oct  9 15:42:31 kappa kernel: Kernel command line: BOOT_IMAGE=linux ro root=305
quiet devfs=mount
Oct  9 15:42:31 kappa kernel: Local APIC disabled by BIOS -- reenabling.
Oct  9 15:42:31 kappa kernel: Found and enabled local APIC!
Oct  9 15:42:31 kappa kernel: Initializing CPU#0
Oct  9 15:42:31 kappa kernel: Detected 1100.035 MHz processor.
Oct  9 15:42:31 kappa kernel: Calibrating delay loop... 2162.68 BogoMIPS
Oct  9 15:42:31 kappa kernel: Memory: 385644k/393216k available (1602k kernel
code, 7116k reserved, 541k data, 104k init, 0k highmem)
Oct  9 15:42:31 kappa kernel: Security Scaffold v1.0.0 initialized
Oct  9 15:42:31 kappa kernel: Dentry-cache hash table entries: 65536 (order: 7,
524288 bytes)
Oct  9 15:42:31 kappa kernel: Inode-cache hash table entries: 32768 (order: 6,
262144 bytes)
Oct  9 15:42:31 kappa kernel: Mount-cache hash table entries: 512 (order: 0,
4096 bytes)
Oct  9 15:42:31 kappa kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Oct  9 15:42:31 kappa kernel: CPU: L2 cache: 256K
Oct  9 15:42:31 kappa kernel: Intel machine check architecture supported.
Oct  9 15:42:31 kappa kernel: Intel machine check reporting enabled on CPU#0.
Oct  9 15:42:31 kappa kernel: CPU: Intel Pentium III (Coppermine) stepping 0a
Oct  9 15:42:31 kappa kernel: Enabling fast FPU save and restore... done.
Oct  9 15:42:31 kappa kernel: Enabling unmasked SIMD FPU exception support...
done.
Oct  9 15:42:31 kappa kernel: Checking 'hlt' instruction... OK.
Oct  9 15:42:31 kappa kernel: POSIX conformance testing by UNIFIX
Oct  9 15:42:31 kappa kernel: enabled ExtINT on CPU#0
Oct  9 15:42:31 kappa kernel: ESR value before enabling vector: 00000000
Oct  9 15:42:31 kappa kernel: ESR value after enabling vector: 00000000
Oct  9 15:42:31 kappa kernel: Using local APIC timer interrupts.
Oct  9 15:42:31 kappa kernel: calibrating APIC timer ...
Oct  9 15:42:31 kappa kernel: ..... CPU clock speed is 1110.0856 MHz.
Oct  9 15:42:31 kappa kernel: ..... host bus clock speed is 100.0986 MHz.
Oct  9 15:42:31 kappa kernel: cpu: 0, clocks: 100986, slice: 50493
Oct  9 15:42:31 kappa kernel: CPU0<T0:100976,T1:50480,D:3,S:50493,C:100986>
Oct  9 15:42:31 kappa kernel: Linux NET4.0 for Linux 2.4
Oct  9 15:42:31 kappa kernel: Based upon Swansea University Computer Society
NET3.039
Oct  9 15:42:31 kappa kernel: Initializing RT netlink socket
Oct  9 15:42:31 kappa kernel: mtrr: v2.0 (20020519)
Oct  9 15:42:31 kappa kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd82e,
last bus=1
Oct  9 15:42:31 kappa kernel: PCI: Using configuration type 1
Oct  9 15:42:31 kappa kernel: ACPI: Subsystem revision 20021002
Oct  9 15:42:31 kappa kernel:  tbxface-0099 [03] Acpi_load_tables      : ACPI
Tables successfully acquired
Oct  9 15:42:31 kappa kernel: Parsing
Methods:...................................................................................................
Oct  9 15:42:31 kappa kernel: Table [DSDT] - 351 Objects with 38 Devices 99
Methods 13 Regions
Oct  9 15:42:31 kappa kernel: ACPI Namespace successfully loaded at root
c036a1fc
Oct  9 15:42:31 kappa kernel: evxfevnt-0074 [04] Acpi_enable           :
Transition to ACPI mode successful
Oct  9 15:42:31 kappa kernel: Executing all Device _STA and_INI
methods:...[ACPI Debug] String: __________________________________
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String: 
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String: BAT0_STA
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String:
__________________________________
Oct  9 15:42:31 kappa kernel: ...................................
Oct  9 15:42:31 kappa kernel: 38 Devices found containing: 38 _STA, 2 _INI
methods
Oct  9 15:42:31 kappa kernel: Completing Region/Field/Buffer/Package
initialization:...........................................................
Oct  9 15:42:31 kappa kernel: Initialized 8/13 Regions 10/11 Fields 24/25
Buffers 17/17 Packages (351 nodes)
Oct  9 15:42:31 kappa kernel: ACPI: Interpreter enabled
Oct  9 15:42:31 kappa kernel: ACPI: Using PIC for interrupt routing
Oct  9 15:42:31 kappa kernel: ACPI: (supports S0 S1 S4 S5)
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String:
__________________________________
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String: 
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String: BAT0_STA
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String:
__________________________________
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String:
__________________________________
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String: 
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String: BAT0_STA
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String:
__________________________________
Oct  9 15:42:31 kappa kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Oct  9 15:42:31 kappa kernel: PCI: Probing PCI hardware (bus 00)
Oct  9 15:42:31 kappa kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
Oct  9 15:42:31 kappa kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
Oct  9 15:42:31 kappa kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs *5)
Oct  9 15:42:31 kappa kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
Oct  9 15:42:31 kappa kernel: pci_bind-0191 [06] acpi_pci_bind         : Device
00:00:06.01 not present in PCI namespace
Oct  9 15:42:31 kappa kernel: ACPI: Power Resource [PFAN] (on)
Oct  9 15:42:31 kappa kernel: PCI: Using ACPI for IRQ routing
Oct  9 15:42:31 kappa kernel: PCI: if you experience problems, try using option
'pci=noacpi' or even 'acpi=off'
Oct  9 15:42:31 kappa kernel: IA-32 Microcode Update Driver: v1.11
<tigran@veritas.com>
Oct  9 15:42:31 kappa kernel: Starting kswapd
Oct  9 15:42:31 kappa kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Oct  9 15:42:31 kappa kernel: biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
Oct  9 15:42:31 kappa kernel: biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
Oct  9 15:42:31 kappa kernel: biovec pool[2]:  16 bvecs: 256 entries (192
bytes)
Oct  9 15:42:31 kappa kernel: biovec pool[3]:  64 bvecs: 256 entries (768
bytes)
Oct  9 15:42:31 kappa kernel: biovec pool[4]: 128 bvecs: 256 entries (1536
bytes)
Oct  9 15:42:31 kappa kernel: biovec pool[5]: 256 bvecs: 256 entries (3072
bytes)
Oct  9 15:42:31 kappa kernel: aio_setup: sizeof(struct page) = 40
Oct  9 15:42:31 kappa kernel: VFS: Disk quotas vdquot_6.5.1
Oct  9 15:42:31 kappa kernel: Journalled Block Device driver loaded
Oct  9 15:42:31 kappa kernel: devfs: v1.21 (20020820) Richard Gooch
(rgooch@atnf.csiro.au)
Oct  9 15:42:31 kappa kernel: devfs: devfs_debug: 0x0
Oct  9 15:42:31 kappa kernel: devfs: boot_options: 0x1
Oct  9 15:42:31 kappa kernel: Capability LSM initialized
Oct  9 15:42:31 kappa kernel: PCI: Disabling Via external APIC routing
Oct  9 15:42:31 kappa kernel: PCI: Via IRQ fixup for 00:07.5, from 255 to 5
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String:
__________________________________
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String: 
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String: ACAD_PSR
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String:
__________________________________
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String:
__________________________________
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String: 
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String: ACAD_PSR Return
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String:
__________________________________
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String:
__________________________________
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String: 
Oct  9 15:42:31 kappa kernel: [ACPI Debug] Integer: 0000000000000001
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String:
__________________________________
Oct  9 15:42:31 kappa kernel: ACPI: AC Adapter [ACAD] (on-line)
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String:
__________________________________
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String: 
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String: BAT0_STA
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String:
__________________________________
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String:
__________________________________
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String: 
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String: BAT0_BIF
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String:
__________________________________
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String:
__________________________________
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String: 
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String: BAT0_BIF_RETURN:
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String:
__________________________________
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String:
__________________________________
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String: 
Oct  9 15:42:31 kappa kernel: [ACPI Debug] Package: Elements Ptr - d7ed48c4
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String:
__________________________________
Oct  9 15:42:31 kappa kernel: ACPI: Battery Slot [BAT0] (battery present)
Oct  9 15:42:31 kappa kernel: ACPI: Power Button (FF) [PWRF]
Oct  9 15:42:31 kappa kernel: ACPI: Lid Switch [LID]
Oct  9 15:42:31 kappa kernel: ACPI: Fan [FAN] (on)
Oct  9 15:42:31 kappa kernel: ACPI: Processor [CPU0] (supports C1 C2, 16
throttling states)
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String:
__________________________________
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String: 
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String: THRM_TMP
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String:
__________________________________
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String:
__________________________________
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String: 
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String: THRM_TMP
Oct  9 15:42:31 kappa kernel: [ACPI Debug] String:
__________________________________
Oct  9 15:42:31 kappa kernel: ACPI: Thermal Zone [THRM] (63 C)
Oct  9 15:42:31 kappa kernel: pty: 256 Unix98 ptys configured
Oct  9 15:42:31 kappa kernel: block request queues:
Oct  9 15:42:31 kappa kernel:  128 requests per read queue
Oct  9 15:42:31 kappa kernel:  128 requests per write queue
Oct  9 15:42:31 kappa kernel:  8 requests per batch
Oct  9 15:42:31 kappa kernel:  enter congestion at 31
Oct  9 15:42:31 kappa kernel:  exit congestion at 33
Oct  9 15:42:31 kappa kernel: RAMDISK driver initialized: 16 RAM disks of 4096K
size 1024 blocksize
Oct  9 15:42:31 kappa kernel: loop: loaded (max 8 devices)
Oct  9 15:42:31 kappa kernel: Uniform Multi-Platform E-IDE driver Revision:
7.00alpha2
Oct  9 15:42:31 kappa kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Oct  9 15:42:31 kappa kernel: VP_IDE: IDE controller at PCI slot 00:07.1
Oct  9 15:42:31 kappa kernel: VP_IDE: chipset revision 6
Oct  9 15:42:31 kappa kernel: VP_IDE: not 100%% native mode: will probe irqs
later
Oct  9 15:42:31 kappa kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Oct  9 15:42:31 kappa kernel: VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100
controller on pci00:07.1
Oct  9 15:42:31 kappa kernel:     ide0: BM-DMA at 0x1000-0x1007, BIOS settings:
hda:DMA, hdb:pio
Oct  9 15:42:31 kappa kernel:     ide1: BM-DMA at 0x1008-0x100f, BIOS settings:
hdc:DMA, hdd:pio
Oct  9 15:42:31 kappa kernel: hda: IC25N020ATDA04-0, ATA DISK drive
Oct  9 15:42:31 kappa kernel: hda: DMA disabled
Oct  9 15:42:31 kappa kernel: Debug: sleeping function called from illegal
context at slab.c:1374
Oct  9 15:42:31 kappa kernel: d7ed3e14 d7ed3e34 c013e405 c02a2461 0000055e
c038d31c c038d354 c038d31c 
Oct  9 15:42:31 kappa kernel:        d7ed3e6c c021af55 d7d48480 000001d0
00000000 c038d368 00000000 00000000 
Oct  9 15:42:31 kappa kernel:        00000000 0000005c d7d1e000 c038d31c
c038d30c c038d260 d7ed3eb4 c021affa 
Oct  9 15:42:31 kappa kernel: Call Trace:
Oct  9 15:42:31 kappa kernel: 
[__kmem_cache_alloc+197/208]__kmem_cache_alloc+0xc5/0xd0
Oct  9 15:42:31 kappa kernel:  [<c013e405>]__kmem_cache_alloc+0xc5/0xd0
Oct  9 15:42:31 kappa kernel: 
[blk_init_free_list+101/240]blk_init_free_list+0x65/0xf0
Oct  9 15:42:31 kappa kernel:  [<c021af55>]blk_init_free_list+0x65/0xf0
Oct  9 15:42:31 kappa kernel:  [blk_init_queue+26/272]blk_init_queue+0x1a/0x110
Oct  9 15:42:31 kappa kernel:  [<c021affa>]blk_init_queue+0x1a/0x110
Oct  9 15:42:31 kappa kernel:  [setup_irq+169/224]setup_irq+0xa9/0xe0
Oct  9 15:42:31 kappa kernel:  [<c010bdb9>]setup_irq+0xa9/0xe0
Oct  9 15:42:31 kappa kernel:  [ide_init_queue+57/160]ide_init_queue+0x39/0xa0
Oct  9 15:42:31 kappa kernel:  [<c0224549>]ide_init_queue+0x39/0xa0
Oct  9 15:42:31 kappa kernel:  [do_ide_request+0/48]do_ide_request+0x0/0x30
Oct  9 15:42:31 kappa kernel:  [<c022c070>]do_ide_request+0x0/0x30
Oct  9 15:42:31 kappa kernel:  [init_irq+468/928]init_irq+0x1d4/0x3a0
Oct  9 15:42:31 kappa kernel:  [<c0224784>]init_irq+0x1d4/0x3a0
Oct  9 15:42:31 kappa kernel:  [ide_intr+0/400]ide_intr+0x0/0x190
Oct  9 15:42:31 kappa kernel:  [<c022c430>]ide_intr+0x0/0x190
Oct  9 15:42:31 kappa kernel:  [hwif_init+216/608]hwif_init+0xd8/0x260
Oct  9 15:42:31 kappa kernel:  [<c0224c18>]hwif_init+0xd8/0x260
Oct  9 15:42:31 kappa kernel: 
[probe_hwif_init+38/128]probe_hwif_init+0x26/0x80
Oct  9 15:42:31 kappa kernel:  [<c0224436>]probe_hwif_init+0x26/0x80
Oct  9 15:42:31 kappa kernel: 
[ide_setup_pci_device+78/128]ide_setup_pci_device+0x4e/0x80
Oct  9 15:42:31 kappa kernel:  [<c023846e>]ide_setup_pci_device+0x4e/0x80
Oct  9 15:42:31 kappa kernel:  [via_init_one+57/64]via_init_one+0x39/0x40
Oct  9 15:42:31 kappa kernel:  [<c0223679>]via_init_one+0x39/0x40
Oct  9 15:42:31 kappa kernel:  [init+61/368]init+0x3d/0x170
Oct  9 15:42:31 kappa kernel:  [<c010507d>]init+0x3d/0x170
Oct  9 15:42:31 kappa kernel:  [init+0/368]init+0x0/0x170
Oct  9 15:42:31 kappa kernel:  [<c0105040>]init+0x0/0x170
Oct  9 15:42:31 kappa kernel: 
[kernel_thread_helper+5/16]kernel_thread_helper+0x5/0x10
Oct  9 15:42:31 kappa kernel:  [<c0107515>]kernel_thread_helper+0x5/0x10
Oct  9 15:42:31 kappa kernel: 
Oct  9 15:42:31 kappa kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Oct  9 15:42:31 kappa kernel: hdc: TOSHIBA DVD-ROM SD-C2512, ATAPI CD/DVD-ROM
drive
Oct  9 15:42:31 kappa kernel: hdc: DMA disabled
Oct  9 15:42:31 kappa kernel: Debug: sleeping function called from illegal
context at slab.c:1374
Oct  9 15:42:31 kappa kernel: d7ed3e14 d7ed3e34 c013e405 c02a2461 0000055e
c038d8d8 c038d910 c038d8d8 
Oct  9 15:42:31 kappa kernel:        d7ed3e6c c021af55 d7d48480 000001d0
00000039 c038d924 00000000 000000e4 
Oct  9 15:42:31 kappa kernel:        d7ed3ec8 00000002 d7ffa400 c038d8d8
c038d8c8 c038d81c d7ed3eb4 c021affa 
Oct  9 15:42:31 kappa kernel: Call Trace:
Oct  9 15:42:31 kappa kernel: 
[__kmem_cache_alloc+197/208]__kmem_cache_alloc+0xc5/0xd0
Oct  9 15:42:31 kappa kernel:  [<c013e405>]__kmem_cache_alloc+0xc5/0xd0
Oct  9 15:42:31 kappa kernel: 
[blk_init_free_list+101/240]blk_init_free_list+0x65/0xf0
Oct  9 15:42:31 kappa kernel:  [<c021af55>]blk_init_free_list+0x65/0xf0
Oct  9 15:42:31 kappa kernel:  [blk_init_queue+26/272]blk_init_queue+0x1a/0x110
Oct  9 15:42:31 kappa kernel:  [<c021affa>]blk_init_queue+0x1a/0x110
Oct  9 15:42:31 kappa kernel:  [setup_irq+169/224]setup_irq+0xa9/0xe0
Oct  9 15:42:31 kappa kernel:  [<c010bdb9>]setup_irq+0xa9/0xe0
Oct  9 15:42:31 kappa kernel:  [ide_init_queue+57/160]ide_init_queue+0x39/0xa0
Oct  9 15:42:31 kappa kernel:  [<c0224549>]ide_init_queue+0x39/0xa0
Oct  9 15:42:31 kappa kernel:  [do_ide_request+0/48]do_ide_request+0x0/0x30
Oct  9 15:42:31 kappa kernel:  [<c022c070>]do_ide_request+0x0/0x30
Oct  9 15:42:31 kappa kernel:  [init_irq+468/928]init_irq+0x1d4/0x3a0
Oct  9 15:42:31 kappa kernel:  [<c0224784>]init_irq+0x1d4/0x3a0
Oct  9 15:42:31 kappa kernel:  [ide_intr+0/400]ide_intr+0x0/0x190
Oct  9 15:42:31 kappa kernel:  [<c022c430>]ide_intr+0x0/0x190
Oct  9 15:42:31 kappa kernel:  [hwif_init+216/608]hwif_init+0xd8/0x260
Oct  9 15:42:31 kappa kernel:  [<c0224c18>]hwif_init+0xd8/0x260
Oct  9 15:42:31 kappa kernel: 
[probe_hwif_init+38/128]probe_hwif_init+0x26/0x80
Oct  9 15:42:31 kappa kernel:  [<c0224436>]probe_hwif_init+0x26/0x80
Oct  9 15:42:31 kappa kernel: 
[ide_setup_pci_device+109/128]ide_setup_pci_device+0x6d/0x80
Oct  9 15:42:31 kappa kernel:  [<c023848d>]ide_setup_pci_device+0x6d/0x80
Oct  9 15:42:31 kappa kernel:  [via_init_one+57/64]via_init_one+0x39/0x40
Oct  9 15:42:31 kappa kernel:  [<c0223679>]via_init_one+0x39/0x40
Oct  9 15:42:31 kappa kernel:  [init+61/368]init+0x3d/0x170
Oct  9 15:42:31 kappa kernel:  [<c010507d>]init+0x3d/0x170
Oct  9 15:42:31 kappa kernel:  [init+0/368]init+0x0/0x170
Oct  9 15:42:31 kappa kernel:  [<c0105040>]init+0x0/0x170
Oct  9 15:42:31 kappa kernel: 
[kernel_thread_helper+5/16]kernel_thread_helper+0x5/0x10
Oct  9 15:42:31 kappa kernel:  [<c0107515>]kernel_thread_helper+0x5/0x10
Oct  9 15:42:31 kappa kernel: 
Oct  9 15:42:31 kappa kernel: ide1 at 0x170-0x177,0x376 on irq 15
Oct  9 15:42:31 kappa kernel: hda: host protected area => 1
Oct  9 15:42:31 kappa kernel: hda: 39070080 sectors (20004 MB) w/1806KiB Cache,
CHS=2432/255/63, UDMA(33)
Oct  9 15:42:31 kappa kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6
p7 >
Oct  9 15:42:31 kappa kernel: hdc: ATAPI 24X DVD-ROM drive, 512kB Cache,
UDMA(33)
Oct  9 15:42:31 kappa kernel: Uniform CD-ROM driver Revision: 3.12
Oct  9 15:42:31 kappa kernel: mice: PS/2 mouse device common for all mice
Oct  9 15:42:31 kappa kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Oct  9 15:42:31 kappa kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Oct  9 15:42:31 kappa kernel: IP: routing cache hash table of 4096 buckets,
32Kbytes
Oct  9 15:42:31 kappa kernel: TCP: Hash tables configured (established 32768
bind 65536)
Oct  9 15:42:31 kappa kernel: NET4: Unix domain sockets 1.0/SMP for Linux
NET4.0.
Oct  9 15:42:31 kappa kernel: RAMDISK: Compressed image found at block 0
Oct  9 15:42:31 kappa kernel: Freeing initrd memory: 51k freed
Oct  9 15:42:31 kappa kernel: VFS: Mounted root (ext2 filesystem).
Oct  9 15:42:31 kappa kernel: Mounted devfs on /dev
Oct  9 15:42:31 kappa kernel: kjournald starting.  Commit interval 5 seconds
Oct  9 15:42:31 kappa kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Oct  9 15:42:31 kappa kernel: VFS: Mounted root (ext3 filesystem) readonly.
Oct  9 15:42:31 kappa kernel: Trying to move old root to /initrd ... okay
Oct  9 15:42:31 kappa kernel: Mounted devfs on /dev
Oct  9 15:42:31 kappa kernel: Freeing unused kernel memory: 104k freed
Oct  9 15:42:31 kappa kernel: Warning: unable to open an initial console.
Oct  9 15:42:31 kappa kernel: Unable to handle kernel NULL pointer dereference
at virtual address 00000004
Oct  9 15:42:31 kappa kernel:  printing eip:
Oct  9 15:42:31 kappa kernel: c0214288
Oct  9 15:42:31 kappa kernel: *pde = 00000000
Oct  9 15:42:31 kappa kernel: Oops: 0000
Oct  9 15:42:31 kappa kernel:  
Oct  9 15:42:31 kappa kernel: CPU:    0
Oct  9 15:42:31 kappa kernel: EIP:    0060:[visual_init+168/272]    Not tainted
Oct  9 15:42:31 kappa kernel: EIP:    0060:[<c0214288>]    Not tainted
Oct  9 15:42:31 kappa kernel: EFLAGS: 00010246
Oct  9 15:42:31 kappa kernel: EIP is at visual_init+0xa8/0x110
Oct  9 15:42:31 kappa kernel: eax: 00000001   ebx: 00000000   ecx: c0370988  
edx: 00000000
Oct  9 15:42:31 kappa kernel: esi: c0370480   edi: d7ce9200   ebp: d756fe48  
esp: d756fe3c
Oct  9 15:42:31 kappa kernel: ds: 0068   es: 0068   ss: 0068
Oct  9 15:42:31 kappa kernel: Process hwclock (pid: 143, threadinfo=d756e000
task=d7aa46a0)
Oct  9 15:42:31 kappa kernel: Stack: d7ce9200 00000001 00000000 d756fe6c
c021437e 00000000 00000001 0000013c 
Oct  9 15:42:31 kappa kernel:        c0370780 00000000 d7ce8000 d7cf9e64
d756fe84 c0217b64 00000000 d78feb8c 
Oct  9 15:42:31 kappa kernel:        d78feb8c 00000000 d756fef8 c02061f8
d7ce8000 d78feb8c c13c8368 d756feb0 
Oct  9 15:42:31 kappa kernel: Call Trace:
Oct  9 15:42:31 kappa kernel:  [vc_allocate+142/368]vc_allocate+0x8e/0x170
Oct  9 15:42:31 kappa kernel:  [<c021437e>]vc_allocate+0x8e/0x170
Oct  9 15:42:31 kappa kernel:  [con_open+36/160]con_open+0x24/0xa0
Oct  9 15:42:31 kappa kernel:  [<c0217b64>]con_open+0x24/0xa0
Oct  9 15:42:31 kappa kernel:  [tty_open+616/992]tty_open+0x268/0x3e0
Oct  9 15:42:31 kappa kernel:  [<c02061f8>]tty_open+0x268/0x3e0
Oct  9 15:42:31 kappa kernel:  [dput+48/336]dput+0x30/0x150
Oct  9 15:42:31 kappa kernel:  [<c0161180>]dput+0x30/0x150
Oct  9 15:42:31 kappa kernel:  [unlock_nd+84/144]unlock_nd+0x54/0x90
Oct  9 15:42:31 kappa kernel:  [<c015b134>]unlock_nd+0x54/0x90
Oct  9 15:42:31 kappa kernel: 
[link_path_walk+1414/2048]link_path_walk+0x586/0x800
Oct  9 15:42:31 kappa kernel:  [<c01580e6>]link_path_walk+0x586/0x800
Oct  9 15:42:31 kappa kernel:  [devfs_get_ops+178/256]devfs_get_ops+0xb2/0x100
Oct  9 15:42:31 kappa kernel:  [<c01a69b2>]devfs_get_ops+0xb2/0x100
Oct  9 15:42:31 kappa kernel:  [devfs_open+377/480]devfs_open+0x179/0x1e0
Oct  9 15:42:31 kappa kernel:  [<c01a7ab9>]devfs_open+0x179/0x1e0
Oct  9 15:42:31 kappa kernel: 
[get_empty_filp+105/448]get_empty_filp+0x69/0x1c0
Oct  9 15:42:31 kappa kernel:  [<c014c1d9>]get_empty_filp+0x69/0x1c0
Oct  9 15:42:31 kappa kernel:  [dentry_open+382/464]dentry_open+0x17e/0x1d0
Oct  9 15:42:31 kappa kernel:  [<c0149dce>]dentry_open+0x17e/0x1d0
Oct  9 15:42:31 kappa kernel:  [filp_open+102/112]filp_open+0x66/0x70
Oct  9 15:42:31 kappa kernel:  [<c0149c46>]filp_open+0x66/0x70
Oct  9 15:42:31 kappa kernel:  [sys_open+85/144]sys_open+0x55/0x90
Oct  9 15:42:31 kappa kernel:  [<c014a095>]sys_open+0x55/0x90
Oct  9 15:42:31 kappa kernel:  [syscall_call+7/11]syscall_call+0x7/0xb
Oct  9 15:42:31 kappa kernel:  [<c01096cb>]syscall_call+0x7/0xb
Oct  9 15:42:31 kappa kernel: 
Oct  9 15:42:31 kappa kernel: Code: ff 52 04 8b 04 9d 80 04 37 c0 66 83 78 22
00 75 12 f6 80 a2 
Oct  9 15:42:31 kappa kernel:  <6>EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,5),
internal journal
Oct  9 15:42:31 kappa kernel: Adding 506036k swap on /dev/hda7.  Priority:-1
extents:1
Oct  9 15:42:31 kappa kernel: kjournald starting.  Commit interval 5 seconds
Oct  9 15:42:31 kappa kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,6),
internal journal
Oct  9 15:42:31 kappa kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Oct  9 15:42:31 kappa kernel: FAT: codepage cp850 not found
Oct  9 15:42:31 kappa kernel: Unable to handle kernel NULL pointer dereference
at virtual address 00000004
Oct  9 15:42:31 kappa kernel:  printing eip:
Oct  9 15:42:31 kappa kernel: c0214288
Oct  9 15:42:31 kappa kernel: *pde = 00000000
Oct  9 15:42:31 kappa kernel: Oops: 0000
Oct  9 15:42:31 kappa kernel:  
Oct  9 15:42:31 kappa kernel: CPU:    0
Oct  9 15:42:31 kappa kernel: EIP:    0060:[visual_init+168/272]    Not tainted
Oct  9 15:42:31 kappa kernel: EIP:    0060:[<c0214288>]    Not tainted
Oct  9 15:42:31 kappa kernel: EFLAGS: 00010246
Oct  9 15:42:31 kappa kernel: EIP is at visual_init+0xa8/0x110
Oct  9 15:42:31 kappa kernel: eax: 00000001   ebx: 00000001   ecx: c0370988  
edx: 00000000
Oct  9 15:42:31 kappa kernel: esi: c0370480   edi: d7ce9600   ebp: d7af9e48  
esp: d7af9e3c
Oct  9 15:42:31 kappa kernel: ds: 0068   es: 0068   ss: 0068
Oct  9 15:42:31 kappa kernel: Process rc.sysinit (pid: 11, threadinfo=d7af8000
task=d7fd58e0)
Oct  9 15:42:31 kappa kernel: Stack: d7ce9600 00000001 00000001 d7af9e6c
c021437e 00000001 00000001 0000013c 
Oct  9 15:42:31 kappa kernel:        c0370784 00000001 d78c8000 d77512f4
d7af9e84 c0217b64 00000001 d783dabc 
Oct  9 15:42:31 kappa kernel:        d783dabc 00000000 d7af9ef8 c02061f8
d78c8000 d783dabc c13c70a8 d7af9eb4 
Oct  9 15:42:31 kappa kernel: Call Trace:
Oct  9 15:42:31 kappa kernel:  [vc_allocate+142/368]vc_allocate+0x8e/0x170
Oct  9 15:42:31 kappa kernel:  [<c021437e>]vc_allocate+0x8e/0x170
Oct  9 15:42:31 kappa kernel:  [con_open+36/160]con_open+0x24/0xa0
Oct  9 15:42:31 kappa kernel:  [<c0217b64>]con_open+0x24/0xa0
Oct  9 15:42:31 kappa kernel:  [tty_open+616/992]tty_open+0x268/0x3e0
Oct  9 15:42:31 kappa kernel:  [<c02061f8>]tty_open+0x268/0x3e0
Oct  9 15:42:31 kappa kernel:  [devfs_get_ops+178/256]devfs_get_ops+0xb2/0x100
Oct  9 15:42:31 kappa kernel:  [<c01a69b2>]devfs_get_ops+0xb2/0x100
Oct  9 15:42:31 kappa kernel:  [devfs_open+377/480]devfs_open+0x179/0x1e0
Oct  9 15:42:31 kappa kernel:  [<c01a7ab9>]devfs_open+0x179/0x1e0
Oct  9 15:42:31 kappa kernel: 
[get_empty_filp+105/448]get_empty_filp+0x69/0x1c0
Oct  9 15:42:31 kappa kernel:  [<c014c1d9>]get_empty_filp+0x69/0x1c0
Oct  9 15:42:31 kappa kernel:  [dentry_open+382/464]dentry_open+0x17e/0x1d0
Oct  9 15:42:31 kappa kernel:  [<c0149dce>]dentry_open+0x17e/0x1d0
Oct  9 15:42:31 kappa kernel:  [filp_open+102/112]filp_open+0x66/0x70
Oct  9 15:42:31 kappa kernel:  [<c0149c46>]filp_open+0x66/0x70
Oct  9 15:42:31 kappa kernel:  [sys_open+85/144]sys_open+0x55/0x90
Oct  9 15:42:31 kappa kernel:  [<c014a095>]sys_open+0x55/0x90
Oct  9 15:42:31 kappa kernel:  [syscall_call+7/11]syscall_call+0x7/0xb
Oct  9 15:42:31 kappa kernel:  [<c01096cb>]syscall_call+0x7/0xb
Oct  9 15:42:31 kappa kernel: 
Oct  9 15:42:31 kappa kernel: Code: ff 52 04 8b 04 9d 80 04 37 c0 66 83 78 22
00 75 12 f6 80 a2 
Oct  9 15:42:31 kappa partmon: [
Oct  9 15:42:31 kappa partmon: 
Oct  9 15:42:31 kappa rc: Starting partmon:  succeeded

etc...

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_24_API=y
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_LONGHAUL is not set
CONFIG_X86_SPEEDSTEP=y
# CONFIG_X86_P4_CLOCKMOD is not set
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

#
# Power management options (ACPI, APM)
#

#
# ACPI Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PM=y
# CONFIG_APM is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
# CONFIG_HOTPLUG_PCI_IBM is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y

#
# ATA/ATAPI/MFM/RLL device support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
CONFIG_IDEDMA_NEW_DRIVE_LISTINGS=y
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NFORCE is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Old non-SCSI/ATAPI CD-ROM drives
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set

#
#    SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=y
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_E1000_NAPI is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_VORTEX is not set
# CONFIG_GAMEPORT_FM801 is not set
# CONFIG_GAMEPORT_CS461x is not set
# CONFIG_SERIO is not set
# CONFIG_SERIO_I8042 is not set
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ATKBD is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDDLER is not set
# CONFIG_JOYSTICK_DB9 is not set
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set
# CONFIG_INPUT_JOYDUMP is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_MULTIPORT is not set
# CONFIG_SERIAL_8250_RSA is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=y
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_TMPFS is not set
CONFIG_RAMFS=y
# CONFIG_ISO9660_FS is not set
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVFS_DEBUG=y
# CONFIG_DEVPTS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
CONFIG_ROMFS_FS=y
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_XFS_FS is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_QUOTA is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_NFS_FS is not set
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
# CONFIG_EXPORTFS is not set
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
# CONFIG_VGA_CONSOLE is not set
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_KALLSYMS=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
CONFIG_SECURITY_CAPABILITIES=y

#
# Library routines
#
# CONFIG_CRC32 is not set
# CONFIG_ZLIB_INFLATE is not set
# CONFIG_ZLIB_DEFLATE is not set
CONFIG_X86_BIOS_REBOOT=y


=====
KBA

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
