Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbUKHLBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbUKHLBF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 06:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbUKHLBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 06:01:05 -0500
Received: from os.inf.tu-dresden.de ([141.76.48.99]:43171 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S261475AbUKHK77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 05:59:59 -0500
Date: Mon, 8 Nov 2004 11:59:55 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>
Subject: Spurious interrupts when SCI shared with e100
Message-ID: <20041108115955.1c8bf10f.us15@os.inf.tu-dresden.de>
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My laptop has IRQ9 configured as ACPI SCI. When IRQ9 is shared between ACPI
and e100 an IRQ9 storm occurs when e100 is enabled, as can be seen in the
dmesg output below. The kernel then disables IRQ9, thus preventing e100 from
working properly. The problem does not occur, if I override the default PCI
steering in the BIOS, e.g. by routing LNKA to IRQ11.

Nonetheless it would be good if someone could figure out why sharing IRQ9 
is problematic.

Thanks,
-Udo.

Linux version 2.6.10-rc1 (root@laptop.delusion.de) (gcc version 3.4.2) #2 Sun Nov 7 12:17:47 PST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fffec00 (ACPI data)
 BIOS-e820: 000000000fffec00 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f71a0
ACPI: RSDT (v001 PTLTD    RSDT   0x06041160  LTP 0x00000000) @ 0x0fff4e5e
ACPI: FADT (v001 IBM    TP-T20   0x06041160  0x00000000) @ 0x0fffeb65
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06041160  LTP 0x00000001) @ 0x0fffebd9
ACPI: DSDT (v001 IBM    TP-T20   0x06041160 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Built 1 zonelists
Kernel command line: parport=auto resume=/dev/hda2 video=vesa:mtrr vga=0x317
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 746.857 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 254700k/262080k available (2909k kernel code, 6812k reserved, 949k data, 156k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1478.65 BogoMIPS (lpj=739328)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps:        0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Level Trigger.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd94f, last bus=7
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: Power Resource [PSER] (on)
ACPI: Power Resource [PSIO] (on)
ACPI: Embedded Controller [EC] (gpe 9)
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:00:03.1[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:00:05.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
Simple Boot Flag at 0x35 set to 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.21 [Flags: R/O].
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
vesafb: framebuffer at 0xf0000000, mapped to 0xd0880000, using 3072k, total 8192k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at c000:87f7
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THM0] (59 C)
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xf8000000
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI interrupt 0000:00:03.1[A] -> GSI 9 (level, low) -> IRQ 9
parport0: PC-style at 0x3bc (0x7bc), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
io scheduler noop registered
io scheduler deadline registered
elevator: using deadline as default io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
e100: Intel(R) PRO/100 Network Driver, 3.0.27-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 9 (level, low) -> IRQ 9
irq 9: nobody cared!
 [<c0132544>] __report_bad_irq+0x24/0x80
 [<c013265e>] note_interrupt+0x8e/0xb0
 [<c0131ec4>] handle_IRQ_event+0x34/0x70
 [<c013205b>] __do_IRQ+0x15b/0x180
 [<c0105c06>] do_IRQ+0x26/0x40
 [<c0104228>] common_interrupt+0x18/0x20
 [<c011f30d>] __do_softirq+0x2d/0x90
 [<c011f397>] do_softirq+0x27/0x30
 [<c0131e85>] irq_exit+0x35/0x40
 [<c0105c0b>] do_IRQ+0x2b/0x40
 [<c0104228>] common_interrupt+0x18/0x20
 [<c01480f6>] __get_vm_area+0x146/0x220
 [<c0216ccd>] pci_bus_read_config_byte+0x6d/0x70
 [<c01481f7>] get_vm_area+0x27/0x30
 [<c0113a86>] __ioremap+0xc6/0x120
 [<c028f6a1>] e100_probe+0x241/0x530
 [<c0168814>] d_alloc+0x154/0x180
 [<c0168f76>] d_rehash+0x66/0x70
 [<c0169986>] alloc_inode+0xd6/0x180
 [<c016889f>] d_instantiate+0x5f/0x80
 [<c0183c3b>] sysfs_create+0x7b/0xe0
 [<c021a5c6>] pci_device_probe_static+0x46/0x70
 [<c021a629>] __pci_device_probe+0x39/0x50
 [<c021a663>] pci_device_probe+0x23/0x50
 [<c0277132>] bus_match+0x32/0x70
 [<c027726d>] driver_attach+0x4d/0x90
 [<c020c052>] kobject_register+0x22/0x60
 [<c027775f>] bus_add_driver+0x8f/0xc0
 [<c0277cc8>] driver_register+0x28/0x30
 [<c011b087>] printk+0x17/0x20
 [<c021a909>] pci_register_driver+0x59/0x80
 [<c04c87b4>] do_initcalls+0x54/0xc0
 [<c0100440>] init+0x0/0x140
 [<c0100440>] init+0x0/0x140
 [<c0100475>] init+0x35/0x140
 [<c01022a8>] kernel_thread_helper+0x0/0x18
 [<c01022ad>] kernel_thread_helper+0x5/0x18
handlers:
[<c022a06f>] (acpi_irq+0x0/0x14)
Disabling IRQ #9
e100: eth0: e100_probe: addr 0xe8120000, irq 9, MAC addr 00:02:B3:06:0A:A8
