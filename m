Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbUKGUjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbUKGUjr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 15:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbUKGUjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 15:39:47 -0500
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:14032 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261594AbUKGUgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 15:36:43 -0500
Message-ID: <418E8759.9070408@myrealbox.com>
Date: Sun, 07 Nov 2004 12:36:41 -0800
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041107)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 32-bit segfaults on x86_64 in recent mm kernels
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had segfaults in 32-bit emulation in recent (and not-so-recent) -mm
kernels on x86_64.

2.6.7-gentoo-r11 and 2.6.10-rc1 both work fine (even wine works for the 
most part).

2.6.9-rc3-mm3 can't run wine -- it always segfaults.  Other apps seem OK.

2.6.10-rc1-mm1 can't run anything -- even this segfaults (compiled with both
'gcc -o foo -m32 foo.c' and 'gcc -o foo -m32 -Wl,-zexecstack foo.c'):

#include <stdio.h>

int main()
{
        printf("Hello %d\n", (int)(sizeof(int*)));
        return 0;
}

Sorry, no debug info, since debugging tools segfault too.

This is my syslog for 2.6.10-rc1-mm1, with some userspace stuff stripped:

Nov  7 08:37:41 luto Linux version 2.6.10-rc1-mm3 
(luto@luto.stanford.edu) (gcc version 3.4.2 (Gentoo Linux 3.4.2-r2, 
ssp-3.4.1-1, pie-8.7.6.5)) #2 Sun Nov 7 02:52:01 PST 2004
Nov  7 08:37:41 luto BIOS-provided physical RAM map:
Nov  7 08:37:41 luto BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Nov  7 08:37:41 luto BIOS-e820: 000000000009fc00 - 00000000000a0000 
(reserved)
Nov  7 08:37:41 luto BIOS-e820: 00000000000ce000 - 00000000000d8000 
(reserved)
Nov  7 08:37:41 luto BIOS-e820: 00000000000f0000 - 0000000000100000 
(reserved)
Nov  7 08:37:41 luto BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
Nov  7 08:37:41 luto BIOS-e820: 000000001fff0000 - 000000001fff8000 
(ACPI data)
Nov  7 08:37:41 luto BIOS-e820: 000000001fff8000 - 0000000020000000 
(ACPI NVS)
Nov  7 08:37:41 luto BIOS-e820: 00000000fec00000 - 00000000fec01000 
(reserved)
Nov  7 08:37:41 luto BIOS-e820: 00000000fee00000 - 00000000fee01000 
(reserved)
Nov  7 08:37:41 luto BIOS-e820: 00000000fff80000 - 0000000100000000 
(reserved)
Nov  7 08:37:41 luto No mptable found.
Nov  7 08:37:41 luto On node 0 totalpages: 131056
Nov  7 08:37:41 luto DMA zone: 4096 pages, LIFO batch:1
Nov  7 08:37:41 luto Normal zone: 126960 pages, LIFO batch:16
Nov  7 08:37:41 luto HighMem zone: 0 pages, LIFO batch:1
Nov  7 08:37:41 luto ACPI: RSDP (v000 
AMI                                   ) @ 0x00000000000fa3f0
Nov  7 08:37:41 luto ACPI: RSDT (v001 AMIINT VIA_K8   0x00000010 MSFT 
0x00000097) @ 0x000000001fff0000
Nov  7 08:37:41 luto ACPI: FADT (v001 AMIINT VIA_K8   0x00000011 MSFT 
0x00000097) @ 0x000000001fff0030
Nov  7 08:37:41 luto ACPI: MADT (v001 AMIINT VIA_K8   0x00000009 MSFT 
0x00000097) @ 0x000000001fff00c0
Nov  7 08:37:41 luto ACPI: DSDT (v001    VIA   VIA_K8 0x00001000 MSFT 
0x0100000d) @ 0x0000000000000000
Nov  7 08:37:41 luto ACPI: Local APIC address 0xfee00000
Nov  7 08:37:41 luto ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Nov  7 08:37:41 luto Processor #0 15:4 APIC version 16
Nov  7 08:37:41 luto ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Nov  7 08:37:41 luto IOAPIC[0]: apic_id 2, version 3, address 
0xfec00000, GSI 0-23
Nov  7 08:37:41 luto ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl 
dfl)
Nov  7 08:37:41 luto ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low 
level)
Nov  7 08:37:41 luto ACPI: IRQ0 used by override.
Nov  7 08:37:41 luto ACPI: IRQ2 used by override.
Nov  7 08:37:41 luto ACPI: IRQ9 used by override.
Nov  7 08:37:41 luto Setting APIC routing to flat
Nov  7 08:37:41 luto Using ACPI (MADT) for SMP configuration information
Nov  7 08:37:41 luto Built 1 zonelists
Nov  7 08:37:41 luto Initializing CPU#0
Nov  7 08:37:41 luto Kernel command line: root=/dev/hda1 
console=ttyS0,115200 console=tty0
Nov  7 08:37:41 luto PID hash table entries: 2048 (order: 11, 65536 bytes)
Nov  7 08:37:41 luto time.c: Using 1.193182 MHz PIT timer.
Nov  7 08:37:41 luto time.c: Detected 2000.145 MHz processor.
Nov  7 08:37:41 luto Console: colour VGA+ 80x25
Nov  7 08:37:41 luto Dentry cache hash table entries: 131072 (order: 8, 
1048576 bytes)
Nov  7 08:37:41 luto Inode-cache hash table entries: 65536 (order: 7, 
524288 bytes)
Nov  7 08:37:41 luto Memory: 510712k/524224k available (2407k kernel 
code, 12740k reserved, 1066k data, 152k init)
Nov  7 08:37:41 luto Calibrating delay loop... 3940.35 BogoMIPS 
(lpj=1970176)
Nov  7 08:37:41 luto Mount-cache hash table entries: 256 (order: 0, 4096 
bytes)
Nov  7 08:37:41 luto CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K 
(64 bytes/line)
Nov  7 08:37:41 luto CPU: L2 Cache: 1024K (64 bytes/line)
Nov  7 08:37:41 luto CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 08
Nov  7 08:37:41 luto Using local APIC NMI watchdog using perfctr0
Nov  7 08:37:41 luto Using local APIC timer interrupts.
Nov  7 08:37:41 luto Detected 12.500 MHz APIC timer.
Nov  7 08:37:41 luto NET: Registered protocol family 16
Nov  7 08:37:41 luto PCI: Using configuration type 1
Nov  7 08:37:41 luto mtrr: v2.0 (20020519)
Nov  7 08:37:41 luto ACPI: Subsystem revision 20041015
Nov  7 08:37:41 luto ACPI: Interpreter enabled
Nov  7 08:37:41 luto ACPI: Using IOAPIC for interrupt routing
Nov  7 08:37:41 luto ACPI: PCI Root Bridge [PCI0] (00:00)
Nov  7 08:37:41 luto PCI: Probing PCI hardware (bus 00)
Nov  7 08:37:41 luto ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Nov  7 08:37:41 luto ACPI: Power Resource [URP1] (off)
Nov  7 08:37:41 luto ACPI: Power Resource [URP2] (off)
Nov  7 08:37:41 luto ACPI: Power Resource [FDDP] (off)
Nov  7 08:37:41 luto ACPI: Power Resource [LPTP] (off)
Nov  7 08:37:41 luto ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 
*11 12 14 15)
Nov  7 08:37:41 luto ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 
11 12 14 15)
Nov  7 08:37:41 luto ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 
11 12 14 15)
Nov  7 08:37:41 luto ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 
11 12 14 15)
Nov  7 08:37:41 luto ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 
11 12 14 15) *0, disabled.
Nov  7 08:37:41 luto ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 
11 12 14 15) *0, disabled.
Nov  7 08:37:41 luto ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 
11 12 14 15) *0, disabled.
Nov  7 08:37:41 luto ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 
11 12 14 15) *0, disabled.
Nov  7 08:37:41 luto usbcore: registered new driver usbfs
Nov  7 08:37:41 luto usbcore: registered new driver hub
Nov  7 08:37:41 luto PCI: Using ACPI for IRQ routing
Nov  7 08:37:41 luto ** PCI interrupts are no longer routed 
automatically.  If this
Nov  7 08:37:41 luto ** causes a device to stop working, it is probably 
because the
Nov  7 08:37:41 luto ** driver failed to call pci_enable_device().  As a 
temporary
Nov  7 08:37:41 luto ** workaround, the "pci=routeirq" argument restores 
the old
Nov  7 08:37:41 luto ** behavior.  If this argument makes the device 
work again,
Nov  7 08:37:41 luto ** please email the output of "lspci" to 
bjorn.helgaas@hp.com
Nov  7 08:37:41 luto ** so I can fix the driver.
Nov  7 08:37:41 luto IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 
13:02:28 ak Exp $
Nov  7 08:37:41 luto Total HugeTLB memory allocated, 0
Nov  7 08:37:41 luto VFS: Disk quotas dquot_6.5.1
Nov  7 08:37:41 luto Dquot-cache hash table entries: 512 (order 0, 4096 
bytes)
Nov  7 08:37:41 luto Initializing Cryptographic API
Nov  7 08:37:41 luto vesafb: probe of vesafb0 failed with error -6
Nov  7 08:37:41 luto ACPI: Power Button (FF) [PWRF]
Nov  7 08:37:41 luto ACPI: Sleep Button (CM) [SLPB]
Nov  7 08:37:41 luto Real Time Clock Driver v1.12
Nov  7 08:37:41 luto Linux agpgart interface v0.100 (c) Dave Jones
Nov  7 08:37:41 luto agpgart: Detected AGP bridge 0
Nov  7 08:37:41 luto agpgart: Maximum main memory to use for agp memory: 
439M
Nov  7 08:37:41 luto agpgart: AGP aperture is 256M @ 0xd0000000
Nov  7 08:37:41 luto [drm] Initialized drm 1.0.0 20040925
Nov  7 08:37:41 luto Serial: 8250/16550 driver $Revision: 1.90 $ 8 
ports, IRQ sharing disabled
Nov  7 08:37:41 luto ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Nov  7 08:37:41 luto io scheduler noop registered
Nov  7 08:37:41 luto io scheduler anticipatory registered
Nov  7 08:37:41 luto io scheduler deadline registered
Nov  7 08:37:41 luto io scheduler cfq registered
Nov  7 08:37:41 luto floppy: ignoring I/O port region 0x3f7-0x3f7
Nov  7 08:37:41 luto ACPI: Floppy Controller [FDC0] at I/O 0x3f2-0x3f3, 
0x3f4-0x3f5 irq 6 dma channel 2
Nov  7 08:37:41 luto ACPI: [FDC0] doesn't declare FD_DCR; also claiming 
0x3f7
Nov  7 08:37:41 luto elevator: using anticipatory as default io scheduler
Nov  7 08:37:41 luto Floppy drive(s): fd0 is 1.44M
Nov  7 08:37:41 luto FDC 0 is a post-1991 82077
Nov  7 08:37:41 luto RAMDISK driver initialized: 16 RAM disks of 128000K 
size 1024 blocksize
Nov  7 08:37:41 luto loop: loaded (max 8 devices)
Nov  7 08:37:41 luto Uniform Multi-Platform E-IDE driver Revision: 
7.00alpha2
Nov  7 08:37:41 luto ide: Assuming 33MHz system bus speed for PIO modes; 
override with idebus=xx
Nov  7 08:37:41 luto VP_IDE: IDE controller at PCI slot 0000:00:0f.0
Nov  7 08:37:41 luto ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 20 
(level, low) -> IRQ 20
Nov  7 08:37:41 luto VP_IDE: chipset revision 6
Nov  7 08:37:41 luto VP_IDE: not 100% native mode: will probe irqs later
Nov  7 08:37:41 luto VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller 
on pci0000:00:0f.0
Nov  7 08:37:41 luto ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: 
hda:DMA, hdb:pio
Nov  7 08:37:41 luto ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: 
hdc:DMA, hdd:pio
Nov  7 08:37:41 luto Probing IDE interface ide0...
Nov  7 08:37:41 luto hda: ST3160023A, ATA DISK drive
Nov  7 08:37:41 luto ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov  7 08:37:41 luto Probing IDE interface ide1...
Nov  7 08:37:41 luto hdc: ST3200822A, ATA DISK drive
Nov  7 08:37:41 luto ide1 at 0x170-0x177,0x376 on irq 15
Nov  7 08:37:41 luto Probing IDE interface ide2...
Nov  7 08:37:41 luto ide2: Wait for ready failed before probe !
Nov  7 08:37:41 luto Probing IDE interface ide3...
Nov  7 08:37:41 luto ide3: Wait for ready failed before probe !
Nov  7 08:37:41 luto Probing IDE interface ide4...
Nov  7 08:37:41 luto ide4: Wait for ready failed before probe !
Nov  7 08:37:41 luto Probing IDE interface ide5...
Nov  7 08:37:41 luto ide5: Wait for ready failed before probe !
Nov  7 08:37:41 luto hda: max request size: 1024KiB
Nov  7 08:37:41 luto hda: 312581808 sectors (160041 MB) w/8192KiB Cache, 
CHS=19457/255/63, UDMA(100)
Nov  7 08:37:41 luto hda: cache flushes supported
Nov  7 08:37:41 luto hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
Nov  7 08:37:41 luto hdc: max request size: 1024KiB
Nov  7 08:37:41 luto hdc: 390721968 sectors (200049 MB) w/8192KiB Cache, 
CHS=24321/255/63, UDMA(100)
Nov  7 08:37:41 luto hdc: cache flushes supported
Nov  7 08:37:41 luto hdc: hdc1 hdc2 hdc3 < hdc5 hdc6 >
Nov  7 08:37:41 luto ACPI: PCI interrupt 0000:00:10.4[C] -> GSI 21 
(level, low) -> IRQ 21
Nov  7 08:37:41 luto ehci_hcd 0000:00:10.4: VIA Technologies, Inc. USB 2.0
Nov  7 08:37:41 luto ehci_hcd 0000:00:10.4: irq 21, pci mem 0xcfffcd00
Nov  7 08:37:41 luto ehci_hcd 0000:00:10.4: new USB bus registered, 
assigned bus number 1
Nov  7 08:37:41 luto ehci_hcd 0000:00:10.4: USB 2.0 initialized, EHCI 
1.00, driver 26 Oct 2004
Nov  7 08:37:41 luto hub 1-0:1.0: USB hub found
Nov  7 08:37:41 luto hub 1-0:1.0: 8 ports detected
Nov  7 08:37:41 luto USB Universal Host Controller Interface driver v2.2
Nov  7 08:37:41 luto ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 
(level, low) -> IRQ 21
Nov  7 08:37:41 luto warning: many lost ticks.
Nov  7 08:37:41 luto Your time source seems to be instable or some 
driver is hogging interupts
Nov  7 08:37:41 luto rip release_console_sem+0x16f/0x210
Nov  7 08:37:41 luto PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 5
Nov  7 08:37:41 luto uhci_hcd 0000:00:10.0: VIA Technologies, Inc. 
VT82xxxxx UHCI USB 1.1 Controller
Nov  7 08:37:41 luto uhci_hcd 0000:00:10.0: irq 21, io base 0xc800
Nov  7 08:37:41 luto uhci_hcd 0000:00:10.0: new USB bus registered, 
assigned bus number 2
Nov  7 08:37:41 luto hub 2-0:1.0: USB hub found
Nov  7 08:37:41 luto hub 2-0:1.0: 2 ports detected
Nov  7 08:37:41 luto ACPI: PCI interrupt 0000:00:10.1[A] -> GSI 21 
(level, low) -> IRQ 21
Nov  7 08:37:41 luto PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 5
Nov  7 08:37:41 luto uhci_hcd 0000:00:10.1: VIA Technologies, Inc. 
VT82xxxxx UHCI USB 1.1 Controller (#2)
Nov  7 08:37:41 luto uhci_hcd 0000:00:10.1: irq 21, io base 0xcc00
Nov  7 08:37:41 luto uhci_hcd 0000:00:10.1: new USB bus registered, 
assigned bus number 3
Nov  7 08:37:41 luto hub 3-0:1.0: USB hub found
Nov  7 08:37:41 luto hub 3-0:1.0: 2 ports detected
Nov  7 08:37:41 luto ACPI: PCI interrupt 0000:00:10.2[B] -> GSI 21 
(level, low) -> IRQ 21
Nov  7 08:37:41 luto PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 5
Nov  7 08:37:41 luto uhci_hcd 0000:00:10.2: VIA Technologies, Inc. 
VT82xxxxx UHCI USB 1.1 Controller (#3)
Nov  7 08:37:41 luto uhci_hcd 0000:00:10.2: irq 21, io base 0xd000
Nov  7 08:37:41 luto uhci_hcd 0000:00:10.2: new USB bus registered, 
assigned bus number 4
Nov  7 08:37:41 luto hub 4-0:1.0: USB hub found
Nov  7 08:37:41 luto hub 4-0:1.0: 2 ports detected
Nov  7 08:37:41 luto ACPI: PCI interrupt 0000:00:10.3[B] -> GSI 21 
(level, low) -> IRQ 21
Nov  7 08:37:41 luto PCI: Via IRQ fixup for 0000:00:10.3, from 10 to 5
Nov  7 08:37:41 luto uhci_hcd 0000:00:10.3: VIA Technologies, Inc. 
VT82xxxxx UHCI USB 1.1 Controller (#4)
Nov  7 08:37:41 luto uhci_hcd 0000:00:10.3: irq 21, io base 0xd400
Nov  7 08:37:41 luto uhci_hcd 0000:00:10.3: new USB bus registered, 
assigned bus number 5
Nov  7 08:37:41 luto hub 5-0:1.0: USB hub found
Nov  7 08:37:41 luto hub 5-0:1.0: 2 ports detected
Nov  7 08:37:41 luto usb 3-1: new full speed USB device using uhci_hcd 
and address 2
Nov  7 08:37:41 luto hub 3-1:1.0: USB hub found
Nov  7 08:37:41 luto hub 3-1:1.0: 4 ports detected
Nov  7 08:37:41 luto usbcore: registered new driver hiddev
Nov  7 08:37:41 luto usbcore: registered new driver usbhid
Nov  7 08:37:41 luto drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Nov  7 08:37:41 luto mice: PS/2 mouse device common for all mice
Nov  7 08:37:41 luto md: raid1 personality registered as nr 3
Nov  7 08:37:41 luto md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
Nov  7 08:37:41 luto perfctr: driver 2.7.6, cpu type AMD K7/K8 at 
2000145 kHz
Nov  7 08:37:41 luto NET: Registered protocol family 2
Nov  7 08:37:41 luto IP: routing cache hash table of 4096 buckets, 32Kbytes
Nov  7 08:37:41 luto TCP: Hash tables configured (established 32768 bind 
32768)
Nov  7 08:37:41 luto NET: Registered protocol family 1
Nov  7 08:37:41 luto NET: Registered protocol family 17
Nov  7 08:37:41 luto ACPI: (supports S0 S3 S4 S5)
Nov  7 08:37:41 luto ACPI wakeup devices:
Nov  7 08:37:41 luto PCI0 UAR1 USB1 USB2 USB3 USB4 EHCI USBD  AC9  MC9 
ILAN SLPB
Nov  7 08:37:41 luto md: Autodetecting RAID arrays.
Nov  7 08:37:41 luto md: autorun ...
Nov  7 08:37:41 luto md: ... autorun DONE.
Nov  7 08:37:41 luto EXT3-fs: hda1: orphan cleanup on readonly fs
Nov  7 08:37:41 luto kjournald starting.  Commit interval 5 seconds
Nov  7 08:37:41 luto ext3_orphan_cleanup: deleting unreferenced inode 6709
Nov  7 08:37:41 luto ext3_orphan_cleanup: deleting unreferenced inode 115771
Nov  7 08:37:41 luto EXT3-fs: hda1: 2 orphan inodes deleted
Nov  7 08:37:41 luto EXT3-fs: recovery complete.
Nov  7 08:37:41 luto EXT3-fs: mounted filesystem with ordered data mode.
Nov  7 08:37:41 luto VFS: Mounted root (ext3 filesystem) readonly.
Nov  7 08:37:41 luto Freeing unused kernel memory: 152k freed
Nov  7 08:37:41 luto usb 3-1.3: new low speed USB device using uhci_hcd 
and address 3
Nov  7 08:37:41 luto input: USB HID v1.10 Keyboard [Logitech USB 
Receiver] on usb-0000:00:10.1-1.3
Nov  7 08:37:41 luto input: USB HID v1.10 Mouse [Logitech USB Receiver] 
on usb-0000:00:10.1-1.3
Nov  7 08:37:41 luto usb 3-1.4: new low speed USB device using uhci_hcd 
and address 4
Nov  7 08:37:41 luto input: USB HID v1.10 Mouse [Logitech USB-PS/2 
Optical Mouse] on usb-0000:00:10.1-1.4
Nov  7 08:37:41 luto Adding 1004052k swap on /dev/hda3.  Priority:-1 
extents:1
Nov  7 08:37:41 luto EXT3 FS on hda1, internal journal
Nov  7 08:37:41 luto md: md0 stopped.
Nov  7 08:37:41 luto md: bind<hdc5>
Nov  7 08:37:41 luto md: bind<hda5>
Nov  7 08:37:41 luto md: kicking non-fresh hdc5 from array!
Nov  7 08:37:41 luto md: unbind<hdc5>
Nov  7 08:37:41 luto md: export_rdev(hdc5)
Nov  7 08:37:41 luto raid1: raid set md0 active with 1 out of 2 mirrors
Nov  7 08:37:41 luto ReiserFS: md0: found reiserfs format "3.6" with 
standard journal
Nov  7 08:37:41 luto ReiserFS: md0: using ordered data mode
Nov  7 08:37:41 luto ReiserFS: md0: journal params: device md0, size 
8192, journal first block 18, max trans len 1024, max batch 900, max 
commit age 30, max trans age 30
Nov  7 08:37:41 luto ReiserFS: md0: checking transaction log (md0)
Nov  7 08:37:41 luto ReiserFS: md0: Using r5 hash to sort names
Nov  7 08:37:41 luto ReiserFS: hda6: found reiserfs format "3.6" with 
standard journal
Nov  7 08:37:41 luto ReiserFS: hda6: using ordered data mode
Nov  7 08:37:41 luto ReiserFS: hda6: journal params: device hda6, size 
8192, journal first block 18, max trans len 1024, max batch 900, max 
commit age 30, max trans age 30
Nov  7 08:37:41 luto ReiserFS: hda6: checking transaction log (hda6)
Nov  7 08:37:41 luto ReiserFS: hda6: Using r5 hash to sort names
Nov  7 08:37:41 luto ReiserFS: hda7: warning: read_super_block: found 
reiserfs format "3.6" with non-standard journal
Nov  7 08:37:41 luto ReiserFS: hda7: using ordered data mode
Nov  7 08:37:41 luto ReiserFS: hda7: journal params: device hda7, size 
16384, journal first block 18, max trans len 1024, max batch 900, max 
commit age 30, max trans age 30
Nov  7 08:37:41 luto ReiserFS: hda7: checking transaction log (hda7)
Nov  7 08:37:41 luto ReiserFS: hda7: Using r5 hash to sort names
Nov  7 08:37:41 luto ReiserFS: hdc1: found reiserfs format "3.6" with 
standard journal
Nov  7 08:37:41 luto ReiserFS: hdc1: using ordered data mode
Nov  7 08:37:41 luto ReiserFS: hdc1: journal params: device hdc1, size 
8192, journal first block 18, max trans len 1024, max batch 900, max 
commit age 30, max trans age 30
Nov  7 08:37:41 luto ReiserFS: hdc1: checking transaction log (hdc1)
Nov  7 08:37:41 luto ReiserFS: hdc1: Using r5 hash to sort names
Nov  7 08:37:41 luto SGI XFS with ACLs, large block/inode numbers, no 
debug enabled
Nov  7 08:37:41 luto SGI XFS Quota Management subsystem
Nov  7 08:37:41 luto XFS mounting filesystem hdc6
Nov  7 08:37:41 luto Ending clean XFS mount for filesystem: hdc6
Nov  7 08:37:41 luto via82xx: Assuming DXS channels with 48k fixed 
sample rate.
Nov  7 08:37:41 luto Please try dxs_support=1 or dxs_support=4 option
Nov  7 08:37:41 luto and report if it works on your machine.
Nov  7 08:37:41 luto ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22 
(level, low) -> IRQ 22
Nov  7 08:37:41 luto PCI: Setting latency timer of device 0000:00:11.5 to 64
Nov  7 08:37:41 luto ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 17 
(level, low) -> IRQ 17
Nov  7 08:37:42 luto natsemi dp8381x driver, version 1.07+LK1.0.17, Sep 
27, 2002
Nov  7 08:37:42 luto originally by Donald Becker <becker@scyld.com>
Nov  7 08:37:42 luto http://www.scyld.com/network/natsemi.html
Nov  7 08:37:42 luto 2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
Nov  7 08:37:42 luto ACPI: PCI interrupt 0000:00:07.0[A] -> GSI 18 
(level, low) -> IRQ 18
Nov  7 08:37:42 luto natsemi eth0: NatSemi DP8381[56] at 0xcfffd000 
(0000:00:07.0), 00:40:f4:58:9c:a9, IRQ 18, port TP.
Nov  7 08:37:42 luto Linux video capture interface: v1.00
Nov  7 08:37:42 luto bttv: Unknown parameter `card'
Nov  7 08:37:42 luto bttv: Ignoring new-style parameters in presence of 
obsolete ones
Nov  7 08:37:42 luto bttv: driver version 0.9.15 loaded
Nov  7 08:37:42 luto bttv: using 8 buffers with 2080k (520 pages) each 
for capture
Nov  7 08:37:42 luto bttv: Bt8xx card found (0).
Nov  7 08:37:42 luto ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17 
(level, low) -> IRQ 17
Nov  7 08:37:42 luto bttv0: Bt878 (rev 17) at 0000:00:0a.0, irq: 17, 
latency: 32, mmio: 0xcddfe000
Nov  7 08:37:42 luto bttv0: using:  *** UNKNOWN/GENERIC ***  
[card=0,autodetected]
Nov  7 08:37:42 luto bttv0: gpio: en=00000000, out=00000000 in=003fffff 
[init]
Nov  7 08:37:42 luto bttv: readee error
Nov  7 08:37:42 luto bttv0: using tuner=-1
Nov  7 08:37:42 luto bttv0: i2c: checking for MSP34xx @ 0x80... not found
Nov  7 08:37:42 luto bttv0: i2c: checking for TDA9875 @ 0xb0... not found
Nov  7 08:37:42 luto bttv0: i2c: checking for TDA7432 @ 0x8a... not found
Nov  7 08:37:42 luto bttv0: i2c: checking for TDA9887 @ 0x86... not found
Nov  7 08:37:42 luto bttv0: registered device video0
Nov  7 08:37:42 luto bttv0: registered device vbi0
Nov  7 08:37:42 luto ACPI: PCI interrupt 0000:00:0a.1[A] -> GSI 17 
(level, low) -> IRQ 17
Nov  7 08:37:42 luto r8169 Gigabit Ethernet driver 1.6LK loaded
Nov  7 08:37:42 luto ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 16 
(level, low) -> IRQ 16
Nov  7 08:37:42 luto r8169: NAPI enabled
Nov  7 08:37:42 luto eth1: Identified chip type is 'RTL8169s/8110s'.
Nov  7 08:37:42 luto eth1: RTL8169 at 0xffffc200007fef00, 
00:0c:76:4e:df:cc, IRQ 16
Nov  7 08:37:43 luto SCSI subsystem initialized
Nov  7 08:37:43 luto libata version 1.02 loaded.
Nov  7 08:37:43 luto sata_promise version 1.00
Nov  7 08:37:43 luto ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 17 
(level, low) -> IRQ 17
Nov  7 08:37:43 luto ata1: SATA max UDMA/133 cmd 0xFFFFC20000854200 ctl 
0xFFFFC20000854238 bmdma 0x0 irq 17
Nov  7 08:37:43 luto ata2: SATA max UDMA/133 cmd 0xFFFFC20000854280 ctl 
0xFFFFC200008542B8 bmdma 0x0 irq 17
Nov  7 08:37:43 luto ata1: no device found (phy stat 00000000)
Nov  7 08:37:43 luto scsi0 : sata_promise
Nov  7 08:37:43 luto ata2: no device found (phy stat 00000000)
Nov  7 08:37:43 luto scsi1 : sata_promise
Nov  7 08:37:43 luto ieee1394: Initialized config rom entry `ip1394'
Nov  7 08:37:43 luto ohci1394: $Rev: 1223 $ Ben Collins 
<bcollins@debian.org>
Nov  7 08:37:43 luto ACPI: PCI interrupt 0000:00:0e.0[A] -> GSI 19 
(level, low) -> IRQ 19
Nov  7 08:37:43 luto ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[19]  
MMIO=[cfffc000-cfffc7ff]  Max Packet=[2048]
Nov  7 08:37:43 luto ieee1394.agent[9006]: ... no drivers for IEEE1394 
product 0x/0x/0x
Nov  7 08:37:44 luto ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 
(level, low) -> IRQ 16
Nov  7 08:37:44 luto rivafb: nVidia device/chipset 10DE0110
Nov  7 08:37:44 luto rivafb: nVidia Corporation NV11 [GeForce2 MX/MX 400]
Nov  7 08:37:44 luto rivafb: Detected CRTC controller 0 being used
Nov  7 08:37:44 luto rivafb: RIVA MTRR set to ON
Nov  7 08:37:44 luto rivafb: setting virtual Y resolution to 52428
Nov  7 08:37:44 luto Console: switching to colour frame buffer device 80x30
Nov  7 08:37:44 luto rivafb: PCI nVidia NV11 framebuffer ver 0.9.5b 
(32MB @ 0xC0000000)
Nov  7 08:37:45 luto ieee1394: Host added: ID:BUS[0-00:1023]  
GUID[0010dc00002c7728]
Nov  7 08:37:45 luto eth1394: $Rev: 1224 $ Ben Collins <bcollins@debian.org>
Nov  7 08:37:45 luto eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet 
(fw-host0)
Nov  7 08:37:45 luto ieee1394.agent[9445]: ... no drivers for IEEE1394 
product 0x/0x/0x
Nov  7 08:37:45 luto ieee1394.agent[9454]: ... no drivers for IEEE1394 
product 0x/0x/0x
Nov  7 08:37:45 luto r8169: eth1: link up
Nov  7 08:37:46 luto eth0: DSPCFG accepted after 0 usec.
Nov  7 08:37:46 luto eth0: link up.
Nov  7 08:37:46 luto eth0: Setting full-duplex based on negotiated link 
capability.
Nov  7 08:37:52 luto ip_tables: (C) 2000-2002 Netfilter core team
Nov  7 08:37:52 luto ip_conntrack version 2.1 (2047 buckets, 16376 max) 
- 456 bytes per conntrack
Nov  7 08:38:04 luto init: Activating demand-procedures for 'A'
Nov  7 08:38:04 luto Bridge firewalling registered
Nov  7 08:38:07 luto drivers/usb/input/hid-input.c: event field not found
Nov  7 08:38:07 luto drivers/usb/input/hid-input.c: event field not found
Nov  7 08:38:07 luto drivers/usb/input/hid-input.c: event field not found
Nov  7 08:38:07 luto drivers/usb/input/hid-input.c: event field not found
Nov  7 08:38:19 luto (luto-10935): starting (version 2.8.0.1), pid 10935 
user 'luto'
Nov  7 08:38:19 luto (luto-10935): Resolved address 
"xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only 
configuration source at position 0
Nov  7 08:38:19 luto (luto-10935): Resolved address 
"xml:readwrite:/home/luto/.gconf" to a writable configuration source at 
position 1
Nov  7 08:38:19 luto (luto-10935): Resolved address 
"xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only 
configuration source at position 2
Nov  7 08:38:27 luto (luto-10935): Resolved address 
"xml:readwrite:/home/luto/.gconf" to a writable configuration source at 
position 0
Nov  7 08:39:44 luto su(pam_unix)[11078]: session opened for user root 
by luto(uid=500)
Nov  7 08:39:54 luto su(pam_unix)[11078]: session closed for user root
Nov  7 08:40:00 luto CRON[11099]: (root) CMD (test -x 
/usr/sbin/run-crons && /usr/sbin/run-crons )
Nov  7 08:40:36 luto login(pam_unix)[10750]: session opened for user 
root by (uid=0)
Nov  7 08:40:40 luto drivers/usb/input/hid-input.c: event field not found
Nov  7 08:40:40 luto drivers/usb/input/hid-input.c: event field not found
Nov  7 08:40:40 luto drivers/usb/input/hid-input.c: event field not found
Nov  7 08:40:40 luto drivers/usb/input/hid-input.c: event field not found
Nov  7 08:40:43 luto login(pam_unix)[10750]: session closed for user root
Nov  7 08:41:27 luto a.out[11492]: segfault at 00000000bffd7000 rip 
000000004fc87533 rsp 00000000bfffe920 error 4
Nov  7 08:42:27 luto a.out[11677]: segfault at 00000000fffd5000 rip 
000000004fc87533 rsp 00000000ffffca00 error 4
Nov  7 08:42:43 luto foo[11689]: segfault at 00000000fffd5000 rip 
000000004fc87533 rsp 00000000ffffca10 error 4

.config:

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.10-rc1-mm3
# Sun Nov  7 02:27:50 2004
#
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_MK8=y
# CONFIG_MPSC is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_L1_CACHE_BYTES=64
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
# CONFIG_PREEMPT_BKL is not set
# CONFIG_NUMA is not set
# CONFIG_GART_IOMMU is not set
CONFIG_DUMMY_IOMMU=y
CONFIG_X86_MCE=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y

#
# Power management options
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_THINKPAD is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_CONTAINER=m

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_UNORDERED_IO is not set
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PC-card bridges
#

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_UID16=y

#
# Performance-monitoring counters support
#
CONFIG_PERFCTR=y
# CONFIG_PERFCTR_INIT_TESTS is not set
CONFIG_PERFCTR_VIRTUAL=y
CONFIG_PERFCTR_INTERRUPT_SUPPORT=y
CONFIG_KEXEC=y

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
# CONFIG_DEBUG_DRIVER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=128000
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_LBD=y
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_IDE_TASK_IOCTL=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
CONFIG_BLK_DEV_PDC202XX_OLD=m
# CONFIG_PDC202XX_BURST is not set
CONFIG_BLK_DEV_PDC202XX_NEW=m
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=m
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=1500
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_AHCI is not set
# CONFIG_SCSI_SATA_SVW is not set
# CONFIG_SCSI_ATA_PIIX is not set
# CONFIG_SCSI_SATA_NV is not set
CONFIG_SCSI_SATA_PROMISE=m
# CONFIG_SCSI_SATA_SX4 is not set
# CONFIG_SCSI_SATA_SIL is not set
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_ULI is not set
CONFIG_SCSI_SATA_VIA=m
# CONFIG_SCSI_SATA_VITESSE is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLOGIC_1280_1040 is not set
CONFIG_SCSI_QLA2XXX=m
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=y
# CONFIG_MD_RAID10 is not set
CONFIG_MD_RAID5=m
CONFIG_MD_RAID6=m
# CONFIG_MD_MULTIPATH is not set
# CONFIG_MD_FAULTY is not set
CONFIG_BLK_DEV_DM=m
CONFIG_DM_CRYPT=m
# CONFIG_DM_SNAPSHOT is not set
CONFIG_DM_MIRROR=m
# CONFIG_DM_ZERO is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=m

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
CONFIG_IEEE1394_OUI_DB=y
CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=y
CONFIG_IEEE1394_CONFIG_ROM_IP1394=y

#
# Device Drivers
#
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m
CONFIG_IEEE1394_AMDTP=m

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_TUNNEL=m
CONFIG_IP_TCPDIAG=m
# CONFIG_IP_TCPDIAG_IPV6 is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_BRIDGE_NETFILTER=y

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_CT_ACCT=y
CONFIG_IP_NF_CONNTRACK_MARK=y
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_PHYSDEV=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_REALM=m
# CONFIG_IP_NF_MATCH_SCTP is not set
# CONFIG_IP_NF_MATCH_COMMENT is not set
CONFIG_IP_NF_MATCH_CONNMARK=m
CONFIG_IP_NF_MATCH_HASHLIMIT=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_TARGET_CONNMARK=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_TARGET_NOTRACK=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set

#
# Bridge: Netfilter Configuration
#
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_XFRM=y
CONFIG_XFRM_USER=m

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
CONFIG_BRIDGE=m
CONFIG_VLAN_8021Q=m
# CONFIG_DECNET is not set
CONFIG_LLC=m
CONFIG_LLC2=m
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CLK_JIFFIES=y
# CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
# CONFIG_NET_SCH_CLK_CPU is not set
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
# CONFIG_NET_SCH_NETEM is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
# CONFIG_CLS_U32_PERF is not set
# CONFIG_NET_CLS_IND is not set
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_KGDBOE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_ETHERTAP is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
# CONFIG_DE2104X is not set
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
CONFIG_TULIP_NAPI=y
CONFIG_TULIP_NAPI_HW_MITIGATION=y
# CONFIG_DE4X5 is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_DM9102 is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
CONFIG_NATSEMI=m
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_VIA_RHINE is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_R8169=m
CONFIG_R8169_NAPI=y
CONFIG_R8169_VLAN=y
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set

#
# Wireless 802.11b ISA/PCI cards support
#
# CONFIG_HERMES is not set
# CONFIG_ATMEL is not set

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
# CONFIG_PRISM54 is not set
CONFIG_NET_WIRELESS=y

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_UINPUT=m

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
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set

#
# IPMI
#
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
# CONFIG_IPMI_SI is not set
CONFIG_IPMI_WATCHDOG=m
# CONFIG_IPMI_POWEROFF is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I8XX_TCO is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_SCx200_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_MACHZ_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_HW_RANDOM=m
CONFIG_NVRAM=m
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
# CONFIG_AGP_INTEL_MCH is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
CONFIG_I2C_ISA=m
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=m
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83627HF=m

#
# Other I2C Chip support
#
CONFIG_SENSORS_EEPROM=m
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#

#
# Video Adapters
#
CONFIG_VIDEO_BT848=m
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5246A is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_CX88 is not set
# CONFIG_VIDEO_OVCAMCHIP is not set

#
# Radio Adapters
#
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_BTCX=m
CONFIG_VIDEO_IR=m

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=m
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
CONFIG_FB_RIVA=m
# CONFIG_FB_RIVA_I2C is not set
# CONFIG_FB_RIVA_DEBUG is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
# CONFIG_LOGO is not set

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_BIT32_EMUL=m
CONFIG_SND_RTCTIMER=m
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
CONFIG_SND_BT87X_OVERCLOCK=y
# CONFIG_SND_CS46XX is not set
CONFIG_SND_CS4281=m
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_VIA82XX=m
# CONFIG_SND_VX222 is not set

#
# USB devices
#
CONFIG_SND_USB_AUDIO=m
# CONFIG_SND_USB_USX2Y is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_SUSPEND=y
# CONFIG_USB_OTG is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
# CONFIG_USB_BLUETOOTH_TTY is not set
CONFIG_USB_MIDI=m
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_RW_DETECT=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y

#
# USB Input Devices
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_SN9C102 is not set
# CONFIG_USB_STV680 is not set

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_IPW is not set
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KEYSPAN_MPR=y
CONFIG_USB_SERIAL_KEYSPAN_USA28=y
CONFIG_USB_SERIAL_KEYSPAN_USA28X=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
CONFIG_USB_SERIAL_KEYSPAN_USA19=y
CONFIG_USB_SERIAL_KEYSPAN_USA18X=y
CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_PL2303=m
# CONFIG_USB_SERIAL_SAFE is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_EZUSB=y

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_TEST is not set

#
# USB ATM/DSL drivers
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FS_MBCACHE=y
# CONFIG_REISER4_FS is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
# CONFIG_REISERFS_FS_SECURITY is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=m
# CONFIG_XFS_RT is not set
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_SECURITY is not set
CONFIG_XFS_POSIX_ACL=y
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_CACHEFS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS_XATTR=y
# CONFIG_DEVPTS_FS_SECURITY is not set
CONFIG_TMPFS=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_SECURITY is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_EXPORTFS is not set
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_OSF_PARTITION=y
# CONFIG_AMIGA_PARTITION is not set
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_EFI_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
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
CONFIG_NLS_ASCII=m
# CONFIG_NLS_ISO8859_1 is not set
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
# Profiling support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=m

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_PREEMPT is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_CHECKING is not set
# CONFIG_INIT_DEBUG is not set
# CONFIG_KPROBES is not set
# CONFIG_KGDB is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_DEBUG_PROC_KEYS=y
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_WP512 is not set
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
# CONFIG_CRYPTO_SERPENT is not set
CONFIG_CRYPTO_AES=m
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_ARC4=m
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_DEFLATE=m
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_CRC32C=m
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m

