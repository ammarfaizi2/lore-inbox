Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264106AbUKZVSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264106AbUKZVSM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 16:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264102AbUKZVRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 16:17:22 -0500
Received: from alpha.lic1.vsi.ru ([80.82.34.34]:27339 "EHLO alpha.lic1.vsi.ru")
	by vger.kernel.org with ESMTP id S264018AbUKZUpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 15:45:23 -0500
Message-ID: <41A795CF.9020304@lic1.vsi.ru>
Date: Fri, 26 Nov 2004 23:45:03 +0300
From: "Igor A. Valcov" <viaprog@lic1.vsi.ru>
Reply-To: viaprog@niif.vsu.ru, viaprog@lic1.vsi.ru
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-bugs@nvidia.com, Sergey Kondratiev <serkon@box.vsi.ru>
Subject: 2.6.9-ac11 kernel crash with nvidia 6629
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I have kernel crash with nvidia kernel module. Xorg-6.8.1.

ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 12 (level, low) -> IRQ 12
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6629  Wed Nov
3 13:12:51 PST 2004
  [<c0133036>] bad_page+0x73/0x9f
  [<c0133368>] prep_new_page+0x26/0x3f
  [<c013387f>] buffered_rmqueue+0xea/0x1a0
  [<c0133c2e>] __alloc_pages+0x2f9/0x31a
  [<c013d768>] do_anonymous_page+0x74/0x1ae
  [<c013d903>] do_no_page+0x61/0x378
  [<c013ddeb>] handle_mm_fault+0xbe/0x15c
  [<c01136d5>] do_page_fault+0x322/0x51e
  [<c021cb3d>] i8042_timer_func+0x0/0xb
  [<c011fa8d>] run_timer_softirq+0xcb/0x18a
  [<c011fc23>] do_timer+0xcd/0xd2
  [<c011c263>] __do_softirq+0x77/0x80
  [<c0106032>] do_IRQ+0x101/0x136
  [<c01133b3>] do_page_fault+0x0/0x51e
  [<c0104101>] error_code+0x2d/0x38
------------[ cut here ]------------
PREEMPT
Modules linked in: nvidia vmnet vmmon
CPU:    0
EIP:    0060:[<c014204d>]    Tainted: P   VLI
EFLAGS: 00013286   (2.6.9-ac11)
EIP is at page_remove_rmap+0x29/0x3d
eax: ffffffff   ebx: 000da000   ecx: c16a8c20   edx: c16a8c20
esi: ffff5910   edi: 00100000   ebp: c16a8c20   esp: f76bfea8
ds: 007b   es: 007b   ss: 0068
Process X (pid: 7056, threadinfo=f76be000 task=f768c560)
Stack: c013c0e6 f76bfeb8 0000f0f0 03919700 00000000 35461067 00000000
0896a000
        c0421f40 08d6a000 f76b508c 08a6a000 c0421f40 c013c229 00100000
00000000
        f765b300 f7ed1d78 0896a000 f76b508c 08a6a000 c0421f40 c013c282
00100000
Call Trace:
  [<c013c0e6>] zap_pte_range+0x14d/0x251
  [<c013c229>] zap_pmd_range+0x3f/0x5b
  [<c013c282>] unmap_page_range+0x3d/0x63
  [<c013c39e>] unmap_vmas+0xf6/0x1b4
  [<c013ff1c>] unmap_region+0x72/0xd6
  [<c01401a2>] do_munmap+0x101/0x147
  [<c013e9b2>] sys_brk+0xe4/0xe8
  [<c0103e85>] sysenter_past_esp+0x52/0x71
Code: eb c5 89 c2 8b 00 f6 c4 08 75 2a 83 42 08 ff 0f 98 c0 84 c0 74 14
8b 42 08 83 c0 01 78 0d 9c 58 fa 83 2d d0 9d 42 c0 01 50 9d c3 <0f> 0b
da 01 30 74 32 c0 eb e9 0f 0b d7 01 30 74 32 c0 eb cc 55
  <6>note: X[7056] exited with preempt_count 2
  [<c03127f5>] schedule+0x4c1/0x4c6
  [<c0217000>] vt_console_print+0x0/0x2da
  [<c011827e>] __call_console_drivers+0x44/0x46
  [<c0118360>] call_console_drivers+0x76/0xfb
  [<c0312d80>] rwsem_down_read_failed+0x8f/0x176
  [<c011b56b>] .text.lock.exit+0x6b/0xc8
  [<c01048a5>] do_divide_error+0x0/0x10e
  [<c0104bcf>] do_invalid_op+0x0/0xed
  [<c0127499>] search_exception_tables+0x21/0x23
  [<c0104bcf>] do_invalid_op+0x0/0xed
  [<c0104cba>] do_invalid_op+0xeb/0xed
  [<f8d7229c>] rm_enable_interrupts+0x44/0x58 [nvidia]
  [<c014204d>] page_remove_rmap+0x29/0x3d
  [<f8f566a9>] os_release_sema+0x13/0x78 [nvidia]
  [<f8d6c4ee>] _nv001726rm+0x12/0x18 [nvidia]
  [<c0104101>] error_code+0x2d/0x38
  [<c014204d>] page_remove_rmap+0x29/0x3d
  [<c013c0e6>] zap_pte_range+0x14d/0x251
  [<c013c229>] zap_pmd_range+0x3f/0x5b
  [<c013c282>] unmap_page_range+0x3d/0x63
  [<c013c39e>] unmap_vmas+0xf6/0x1b4
  [<c013ff1c>] unmap_region+0x72/0xd6
  [<c01401a2>] do_munmap+0x101/0x147
  [<c013e9b2>] sys_brk+0xe4/0xe8
  [<c0103e85>] sysenter_past_esp+0x52/0x71
  [<c0133036>] bad_page+0x73/0x9f
  [<c0133368>] prep_new_page+0x26/0x3f
  [<c013387f>] buffered_rmqueue+0xea/0x1a0
  [<c0133c2e>] __alloc_pages+0x2f9/0x31a
  [<c022722c>] get_device+0xe/0x14
  [<c013d768>] do_anonymous_page+0x74/0x1ae
  [<c013d903>] do_no_page+0x61/0x378
  [<c013ddeb>] handle_mm_fault+0xbe/0x15c
  [<c01136d5>] do_page_fault+0x322/0x51e
  [<c028f175>] uhci_irq+0x1a5/0x1ca
  [<c0105ae8>] handle_IRQ_event+0x25/0x51
  [<c0105fe7>] do_IRQ+0xb6/0x136
  [<c01133b3>] do_page_fault+0x0/0x51e
  [<c0104101>] error_code+0x2d/0x38

=================================================================

My dmesg:


Linux version 2.6.9-ac11 (root@alpha-viaprog) (gcc version 3.3.4
20040623 (Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)) #1 Wed Nov 24
22:43:43 MSK 2004
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f4880
On node 0 totalpages: 262128
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 225280 pages, LIFO batch:16
   HighMem zone: 32752 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 GBT                                   ) @ 0x000f6360
ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3000
ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040
ACPI: MADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff6740
ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
     Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Built 1 zonelists
Kernel command line: root=/dev/hda2
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2391.881 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1035452k/1048512k available (2128k kernel code, 12476k reserved,
904k data, 140k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4734.97 BogoMIPS (lpj=2367488)
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 3febfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  3febfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps:        3febfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 1.80GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Level Trigger.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb1e0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 12
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 12 (level, low) -> IRQ 12
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 12 (level, low) -> IRQ 12
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNK0] enabled at IRQ 11
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1, 2 throttling states)
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 9 (level, low) -> IRQ 9
ttyS4 at I/O 0x9400 (irq = 9) is a 16550A
parport0: PC-style at 0x378 [PCSPP(,...)]
lp0: using parport0 (polling).
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
nbd: registered device at major 43
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 10 (level, low) -> IRQ 10
eth0: RealTek RTL8139 at 0xf8802000, 00:05:1c:18:5f:50, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xcc00-0xcc07, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: ST3120026A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: _NEC DVD_RW ND-3500AG, ATAPI CD/DVD-ROM drive
hdd: ST3120026A, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20269: IDE controller at PCI slot 0000:02:02.0
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
PDC20269: chipset revision 2
PDC20269: 100% native mode on irq 11
     ide2: BM-DMA at 0xa800-0xa807, BIOS settings: hde:pio, hdf:pio
     ide3: BM-DMA at 0xa808-0xa80f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: ST3200822A, ATA DISK drive
ide2 at 0x9800-0x9807,0x9c02 on irq 11
Probing IDE interface ide3...
hdg: ST340810A, ATA DISK drive
ide3 at 0xa000-0xa007,0xa402 on irq 11
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 1024KiB
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63,
UDMA(100)
hda: cache flushes supported
  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hdd: max request size: 1024KiB
hdd: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63,
UDMA(100)
hdd: cache flushes supported
  /dev/ide/host0/bus1/target1/lun0: p1 p2 p3 p4
hde: max request size: 1024KiB
hde: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63,
UDMA(100)
hde: cache flushes supported
  /dev/ide/host2/bus0/target0/lun0: p1 p2
hdg: max request size: 128KiB
hdg: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hdg: cache flushes not supported
  /dev/ide/host2/bus1/target0/lun0: p1
hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.02 loaded.
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0
EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 11, pci mem f880e000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 12 (level, low) -> IRQ 12
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
USB UHCI Controller #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 12, io base 0000b800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
USB UHCI Controller #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 10, io base 0000b000
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
USB UHCI Controller #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 10, io base 0000b400
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
usb 4-2: new low speed USB device using address 2
input: PC Speaker
Intel 810 + AC97 Audio, version 1.01, 22:41:11 Nov 24 2004
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.5 to 64
i810: Intel ICH4 found at IO 0xd800 and 0xd400, MEM 0xec002000 and
0xec003000, IRQ 5
i810: Intel ICH4 mmio at 0xf8810000 and 0xf8812000
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on
usb-0000:00:1d.2-2
i810_audio: Primary codec has ID 0
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 0
ac97_codec: AC97 Audio codec, id: ALG32 (ALC650)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 6
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.1 (8191 buckets, 65528 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
ACPI: (supports S0 S3 S4 S5)
ACPI wakeup devices:
SLPB PCI0 HUB0 USB0 USB1 USB2 USB3
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
EXT3-fs: recovery complete.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 140k freed
Adding 1028152k swap on /dev/hda1.  Priority:43 extents:1
Adding 1004020k swap on /dev/hde1.  Priority:43 extents:1
EXT3 FS on hda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdg1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: link down
vmmon: module license 'unspecified' taints kernel.
/dev/vmmon: Module vmmon: registered with major=10 minor=165
/dev/vmmon: Module vmmon: initialized
/dev/vmnet: open called by PID 6400 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth0: enabling the bridge
bridge-eth0: up
bridge-eth0: already up
bridge-eth0: attached
process `named' is using obsolete setsockopt SO_BSDCOMPAT
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 12 (level, low) -> IRQ 12
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6629  Wed Nov
3 13:12:51 PST 2004

-- 
Igor A. Valcov



