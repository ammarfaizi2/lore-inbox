Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVCWStq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVCWStq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 13:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVCWStq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 13:49:46 -0500
Received: from pirx.hexapodia.org ([199.199.212.25]:23335 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S261662AbVCWStU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 13:49:20 -0500
Date: Wed, 23 Mar 2005 10:49:19 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: linux-kernel@vger.kernel.org
Subject: swsusp 'disk' fails in bk-current - intel_agp at fault?
Message-ID: <20050323184919.GA23486@hexapodia.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I was previously running 2.6.11-rc3 and swsusp was working quite nicely:
echo shutdown > /sys/power/disk
echo disk > /sys/power/state

Now I've upgraded to 2.6.12-rc1, 423b66b6oJOGN68OhmSrBFxxLOtIEA, and it
no longer works reliably.  Almost every time I do the above it blocks in
device_resume() (I haven't had time to track it deeper than that).
Here's the output (hand copied):

[    51.782593] [nosave pfn 0x356]<7>[nosave pfn 0x357]swsusp:critical section/: done (122772 pages copied)
[    54.305996] PM: writing image.
[    54.306032] /usr/src/linux-2.6-cvs/kernel/power/swsusp.c:863
[    54.316885] e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
_

(Obviously, I added some printks to track where it's blocking.)

Dmesg is attached; hardware is a Vaio r505te.

Unfortunately, the deadlock (?) is nondeterministic; it *sometimes*
suspends successfully, maybe one time out of 10.  And thinking back, I
*sometimes* saw failures to suspend with 2.6.11-rc3, maybe one failure
out of 20 suspends.

Another interesting tidbit - I had more success when I tried it without
the intel_agp module loaded; I haven't seen a lockup yet.  (But why
can't I rmmod intel_agp?)

-andy

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

[4294667.296000] Linux version 2.6.12-rc1 (adi@sart) (gcc version 3.3.4 (Debian 1:3.3.4-9ubuntu5)) #7 Tue Mar 22 21:30:45 PST 2005
[4294667.296000] BIOS-provided physical RAM map:
[4294667.296000]  BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
[4294667.296000]  BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
[4294667.296000]  BIOS-e820: 00000000000c0000 - 00000000000cc000 (reserved)
[4294667.296000]  BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
[4294667.296000]  BIOS-e820: 0000000000100000 - 0000000013cf0000 (usable)
[4294667.296000]  BIOS-e820: 0000000013cf0000 - 0000000013cfc000 (ACPI data)
[4294667.296000]  BIOS-e820: 0000000013cfc000 - 0000000013d00000 (ACPI NVS)
[4294667.296000]  BIOS-e820: 0000000013d00000 - 0000000013e80000 (usable)
[4294667.296000]  BIOS-e820: 0000000013e80000 - 0000000014000000 (reserved)
[4294667.296000]  BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
[4294667.296000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
[4294667.296000] 318MB LOWMEM available.
[4294667.296000] On node 0 totalpages: 81536
[4294667.296000]   DMA zone: 4096 pages, LIFO batch:1
[4294667.296000]   Normal zone: 77440 pages, LIFO batch:16
[4294667.296000]   HighMem zone: 0 pages, LIFO batch:1
[4294667.296000] DMI present.
[4294667.296000] ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7120
[4294667.296000] ACPI: RSDT (v001 SONY   U1       0x20010312 PTL  0x00000000) @ 0x13cf74cb
[4294667.296000] ACPI: FADT (v001   SONY       U1 0x20010312 PTL  0x01000000) @ 0x13cfbf64
[4294667.296000] ACPI: BOOT (v001   SONY       U1 0x20010312 PTL  0x00000001) @ 0x13cfbfd8
[4294667.296000] ACPI: DSDT (v001   SONY       U1 0x20010312 PTL  0x0100000b) @ 0x00000000
[4294667.296000] Allocating PCI resources starting at 14000000 (gap: 14000000:eb800000)
[4294667.296000] Built 1 zonelists
[4294667.296000] Kernel command line: root=/dev/hda2 ro
[4294667.296000] Local APIC disabled by BIOS -- you can enable it with "lapic"
[4294667.296000] mapped APIC to ffffd000 (0127f000)
[4294667.296000] Initializing CPU#0
[4294667.296000] PID hash table entries: 2048 (order: 11, 32768 bytes)
[    0.000000] Detected 596.225 MHz processor.
[   15.409585] Using tsc for high-res timesource
[   15.411373] Console: colour VGA+ 80x25
[   15.413032] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[   15.414428] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[   15.451391] Memory: 319764k/326144k available (1648k kernel code, 5748k reserved, 769k data, 156k init, 0k highmem)
[   15.451466] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   15.451721] Calibrating delay loop... 1175.55 BogoMIPS (lpj=587776)
[   15.472329] Security Framework v1.0.0 initialized
[   15.472403] Mount-cache hash table entries: 512
[   15.472701] CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
[   15.472723] CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
[   15.472748] CPU: L1 I cache: 16K, L1 D cache: 16K
[   15.472790] CPU: L2 cache: 256K
[   15.472823] CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00000000 00000000
[   15.472840] CPU: Intel Pentium III (Coppermine) stepping 06
[   15.472895] Enabling fast FPU save and restore... done.
[   15.472937] Enabling unmasked SIMD FPU exception support... done.
[   15.472986] Checking 'hlt' instruction... OK.
[   15.516484] ACPI: setting ELCR to 0200 (from 0628)
[   15.552288] NET: Registered protocol family 16
[   15.553529] PCI: PCI BIOS revision 2.10 entry at 0xfd9b0, last bus=1
[   15.553588] PCI: Using configuration type 1
[   15.553626] mtrr: v2.0 (20020519)
[   15.554600] ACPI: Subsystem revision 20050211
[   15.593476] ACPI: Interpreter enabled
[   15.593531] ACPI: Using PIC for interrupt routing
[   15.597099] ACPI: PCI Root Bridge [PCI0] (00:00)
[   15.597142] PCI: Probing PCI hardware (bus 00)
[   15.598428] PCI: Transparent bridge - 0000:00:1e.0
[   15.599531] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   15.600509] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
[   15.604310] ACPI: Embedded Controller [EC0] (gpe 28)
[   15.647350] ACPI: PCI Interrupt Link [LNKA] (IRQs 9) *0
[   15.648458] ACPI: PCI Interrupt Link [LNKB] (IRQs 9) *0
[   15.649416] ACPI: PCI Interrupt Link [LNKC] (IRQs 9) *0, disabled.
[   15.650495] ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
[   15.651565] ACPI: PCI Interrupt Link [LNKE] (IRQs *9)
[   15.652638] ACPI: PCI Interrupt Link [LNKH] (IRQs 9) *0
[   15.653325] PCI: Using ACPI for IRQ routing
[   15.653369] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   15.659519] Simple Boot Flag at 0x36 set to 0x1
[   15.660688] VFS: Disk quotas dquot_6.5.1
[   15.660777] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   15.660920] devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
[   15.660970] devfs: boot_options: 0x0
[   15.661069] Initializing Cryptographic API
[   15.662644] ACPI: AC Adapter [ACAD] (off-line)
[   15.667594] ACPI: Battery Slot [BAT1] (battery present)
[   15.667664] ACPI: Lid Switch [LID]
[   15.667730] ACPI: Power Button (CM) [PWRB]
[   15.700520] ACPI: Video Device [GCH0] (multi-head: yes  rom: yes  post: no)
[   15.701009] ACPI: CPU0 (power states: C1[C1] C2[C2])
[   15.701064] ACPI: Processor [CPU0] (supports 8 throttling states)
[   15.707046] ACPI: Thermal Zone [ATF0] (34 C)
[   15.713858] serio: i8042 AUX port at 0x60,0x64 irq 12
[   15.714069] serio: i8042 KBD port at 0x60,0x64 irq 1
[   15.714109] io scheduler noop registered
[   15.714175] io scheduler anticipatory registered
[   15.714224] io scheduler deadline registered
[   15.714298] io scheduler cfq registered
[   15.715472] RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
[   15.715660] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   15.715708] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   15.715974] ICH2M: IDE controller at PCI slot 0000:00:1f.1
[   15.716039] ICH2M: chipset revision 3
[   15.716073] ICH2M: not 100% native mode: will probe irqs later
[   15.716128]     ide0: BM-DMA at 0x1800-0x1807, BIOS settings: hda:DMA, hdb:pio
[   15.716218] Probing IDE interface ide0...
[   15.738423] hda: TOSHIBA MK4026GAX, ATA DISK drive
[   15.751123] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   15.751512] Probing IDE interface ide1...
[   15.762838] Probing IDE interface ide2...
[   15.783945] Probing IDE interface ide3...
[   15.795219] Probing IDE interface ide4...
[   15.816326] Probing IDE interface ide5...
[   15.837538] hda: max request size: 128KiB
[   15.848237] hda: 78140160 sectors (40007 MB), CHS=65535/16/63, UDMA(100)
[   15.848356] hda: cache flushes supported
[   15.848565]  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
[   15.855880] mice: PS/2 mouse device common for all mice
[   15.855997] NET: Registered protocol family 2
[   15.857032] IP: routing cache hash table of 2048 buckets, 16Kbytes
[   15.857508] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[   15.858088] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[   15.858415] TCP: Hash tables configured (established 16384 bind 16384)
[   15.858737] NET: Registered protocol family 8
[   15.858786] NET: Registered protocol family 20
[   15.858924] PM: Checking swsusp image.
[   15.859289] swsusp: Resume From Partition /dev/hda3
[   15.877786] input: AT Translated Set 2 keyboard on isa0060/serio0
[   15.885595] <3>swsusp: Suspend partition has wrong signature?
[   15.885690] swsusp: Error -22 check for resume file
[   15.885697] PM: Resume from disk failed.
[   15.885743] ACPI wakeup devices: 
[   15.885793] PWRB  LAN CRD0  EC0 COMA USB1 USB2 MODE 
[   15.885869] ACPI: (supports S0 S3 S4 S5)
[   15.888624] kjournald starting.  Commit interval 5 seconds
[   15.888688] EXT3-fs: mounted filesystem with ordered data mode.
[   15.888807] VFS: Mounted root (ext3 filesystem) readonly.
[   15.889516] Freeing unused kernel memory: 156k freed
[   16.141642] NET: Registered protocol family 1
[   19.215308] Adding 987988k swap on /dev/hda3.  Priority:-1 extents:1
[   19.290971] EXT3 FS on hda2, internal journal
[   22.577701] SCSI subsystem initialized
[   23.111022]   Enabling hardware tapping
[   23.144426] input: PS/2 Mouse on isa0060/serio1
[   23.450887] input: AlpsPS/2 ALPS GlidePoint on isa0060/serio1
[   23.542008] ieee1394: Initialized config rom entry `ip1394'
[   24.513902] sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
[   25.341803] kjournald starting.  Commit interval 5 seconds
[   25.341959] EXT3 FS on hda1, internal journal
[   25.342007] EXT3-fs: mounted filesystem with ordered data mode.
[   28.246274] Linux Kernel Card Services
[   28.246343]   options:  [pci] [cardbus] [pm]
[   28.436545] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
[   28.436608] PCI: setting IRQ 9 as level-triggered
[   28.436647] ACPI: PCI interrupt 0000:01:02.0[A] -> GSI 9 (level, low) -> IRQ 9
[   28.436724] Yenta: CardBus bridge found at 0000:01:02.0 [104d:80e0]
[   28.556726] Yenta: ISA IRQ mask 0x0cb8, PCI irq 9
[   28.556764] Socket status: 30000006
[   30.159387] NET: Registered protocol family 10
[   30.159768] Disabled Privacy Extensions on device c032ea20(lo)
[   30.160046] IPv6 over IPv4 tunneling driver
[   34.058359] Linux agpgart interface v0.101 (c) Dave Jones
[   34.148385] agpgart: Detected an Intel i815 Chipset.
[   34.204153] agpgart: AGP aperture is 64M @ 0xf8000000

--zYM0uCDKw75PZbzx--
