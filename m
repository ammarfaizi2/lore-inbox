Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbUKEMQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbUKEMQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 07:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbUKEMQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 07:16:59 -0500
Received: from mx2.elte.hu ([157.181.151.9]:22144 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261599AbUKEMOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 07:14:41 -0500
Date: Fri, 5 Nov 2004 13:15:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm3
Message-ID: <20041105121528.GA6921@elte.hu>
References: <20041105001328.3ba97e08.akpm@osdl.org> <200411051041.17940.l_allegrucci@yahoo.it> <20041105102204.GA4730@elte.hu> <20041105110951.GA29702@elte.hu> <20041105111751.GC8349@wotan.suse.de> <20041105112404.GA32198@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041105112404.GA32198@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9, BAYES_00 -4.90,
	UPPERCASE_25_50 0.00
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


next problem: the x64 kernel doesnt boot 32-bit userspace anymore. I'm 
getting an endless stream of segfaults:

Freeing unused kernel memory: 148k freed
kjournald starting.  Commit interval 5 seconds
hotplug[890]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd434 error 4
hotplug[891]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd434 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4

full bootlog and .config attached. Same .config produced a working
64-bit kernel on 2.6.10-rc1-mm2.

	Ingo

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=bootlog
Content-Transfer-Encoding: 8bit

Linux version 2.6.10-rc1-mm3 (mingo@jupiter) (gcc version 3.4.0 20040129 (Red Hat Linux 3.4.0-0.3)) #1 Fri Nov 5 14:08:44 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff30000 (usable)
 BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)
 BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
No mptable found.
Looks like a VIA chipset. Disabling IOMMU. Overwrite with "iommu=allowed"
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 16
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/hdb1 3 earlyprintk=serial,ttyS0,38400 console=ttyS0,38400 console=tty0 profile=0 nmi_watchdog=2 idle=poll preempt_thresh=0 kernel_preempt=1
kernel profiling enabled (shift: 0)
using polling idle threads.
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 2040.429 MHz processor.
disabling early console
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Placing software IO TLB between 0x2d46000 - 0x6d46000
Memory: 946056k/1047744k available (3108k kernel code, 100980k reserved, 1209k data, 148k init)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 08
Using local APIC timer interrupts.
Detected 12.752 MHz APIC timer.
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041015
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
agpgart: Detected AGP bridge 0
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 64M @ 0xf8000000
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 5.5.4-k2
Copyright (c) 1999-2004 Intel Corporation.
e100: Intel(R) PRO/100 Network Driver, 3.2.3-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 169
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 169
eth0: 3Com Gigabit LOM (3C940)
      PrefPort:A  RlmtMode:Check Link State
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.30.
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 17 (level, low) -> IRQ 169
eth1: RealTek RTL8139 at 0xffffc20000004000, 00:30:4f:25:80:8a, IRQ 169
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 177
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:pio, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hdb: ST3120022A, <4>warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts
rip release_console_sem+0x16d/0x210
ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-ST GCE-8525B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdb: max request size: 1024KiB
hdb: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 >
hdc: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
3ware Storage Controller device driver for Linux v1.26.02.000.
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 177
sata_via(0000:00:0f.0): routed to hard irq line 5
ata1: SATA max UDMA/133 cmd 0xE800 ctl 0xE402 bmdma 0xD400 irq 177
ata2: SATA max UDMA/133 cmd 0xE000 ctl 0xD802 bmdma 0xD408 irq 177
ata1: no device found (phy stat 00000000)
scsi0 : sata_via
ata2: no device found (phy stat 00000000)
scsi1 : sata_via
Fusion MPT base driver 3.01.17
Copyright (c) 1999-2004 LSI Logic Corporation
Fusion MPT SCSI Host driver 3.01.17
ACPI: PCI interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 185
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: irq 185, pci mem 0xfdf00000
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Intel 810 + AC97 Audio, version 1.01, 14:07:49 Nov  5 2004
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
ACPI: (supports S0 S1 S3 S4 S5)
ACPI wakeup devices: 
PCI0 PS2K PS2M UAR2 UAR1 AC97 USB1 USB2 USB3 USB4 EHCI PWRB SLPB 
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 148k freed
kjournald starting.  Commit interval 5 seconds
hotplug[890]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd434 error 4
hotplug[891]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd434 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe6000 rip 000000004217aab1 rsp 00000000ffffd484 error 4
init[1]: segfault at 00000000fffe600�

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.10-rc1-mm3
# Fri Nov  5 14:07:35 2004
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
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=18
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_EXTRA_PASS=y
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
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_KMOD is not set

#
# Processor type and features
#
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_L1_CACHE_BYTES=128
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
# CONFIG_NUMA is not set
CONFIG_GART_IOMMU=y
CONFIG_SWIOTLB=y
CONFIG_X86_MCE=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y

#
# Power management options
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION=""

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
CONFIG_ACPI_THINKPAD=m
CONFIG_ACPI_IBM=m
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_CONTAINER is not set

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
CONFIG_UNORDERED_IO=y
CONFIG_PCI_MSI=y
# CONFIG_PCI_LEGACY_PROC is not set
# CONFIG_PCI_NAMES is not set

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
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_FAKE is not set
# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_PCIE is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
CONFIG_IA32_EMULATION=y
CONFIG_IA32_AOUT=y
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_UID16=y

#
# Performance-monitoring counters support
#
# CONFIG_PERFCTR is not set
# CONFIG_KEXEC is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_FW_LOADER is not set
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
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_LBD=y
# CONFIG_CDROM_PKTCDVD is not set

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
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_SHARE_IRQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
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
CONFIG_SCSI=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set

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
CONFIG_BLK_DEV_3W_XXXX_RAID=y
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
CONFIG_SCSI_AIC79XX=y
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=2000
# CONFIG_AIC79XX_ENABLE_RD_STRM is not set
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_AHCI is not set
# CONFIG_SCSI_SATA_SVW is not set
CONFIG_SCSI_ATA_PIIX=y
# CONFIG_SCSI_SATA_NV is not set
# CONFIG_SCSI_SATA_PROMISE is not set
# CONFIG_SCSI_SATA_SX4 is not set
# CONFIG_SCSI_SATA_SIL is not set
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_ULI is not set
CONFIG_SCSI_SATA_VIA=y
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
CONFIG_SCSI_QLA2XXX=y
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
# CONFIG_MD is not set

#
# Fusion MPT device support
#
CONFIG_FUSION=y
CONFIG_FUSION_MAX_SGE=40
# CONFIG_FUSION_CTL is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

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
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_IP_TCPDIAG=y
CONFIG_IP_TCPDIAG_IPV6=y
CONFIG_IPV6=y
# CONFIG_IPV6_PRIVACY is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_NETFILTER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
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
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_KGDBOE is not set
CONFIG_NETPOLL=y
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=y
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
CONFIG_FORCEDETH=y
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
CONFIG_E100=y
CONFIG_E100_NAPI=y
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_VIA_RHINE is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=y
# CONFIG_E1000_NAPI is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
CONFIG_SK98LIN=y
# CONFIG_VIA_VELOCITY is not set
CONFIG_TIGON3=y

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
# CONFIG_NET_RADIO is not set

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
CONFIG_NETCONSOLE=y

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
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
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
# CONFIG_INPUT_MISC is not set

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
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=y
# CONFIG_NVRAM is not set
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
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y
CONFIG_MAX_RAW_DEVS=256
CONFIG_HANGCHECK_TIMER=y

#
# I2C support
#
# CONFIG_I2C is not set

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
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
# CONFIG_SND is not set

#
# Open Sound System
#
CONFIG_SOUND_PRIME=y
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
CONFIG_SOUND_ICH=y
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_ALI5455 is not set
# CONFIG_SOUND_FORTE is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_AD1980 is not set

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
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_UHCI_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_STORAGE is not set

#
# USB Input Devices
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set
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

#
# Video4Linux support is needed for USB Multimedia device support
#

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
# CONFIG_USB_SERIAL is not set

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
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISER4_FS is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
# CONFIG_REISERFS_FS_SECURITY is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
CONFIG_AUTOFS_FS=y
# CONFIG_AUTOFS4_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
CONFIG_TMPFS_XATTR=y
CONFIG_TMPFS_SECURITY=y
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
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
# CONFIG_NLS is not set

#
# Profiling support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=y

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_PREEMPT=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_CHECKING is not set
CONFIG_INIT_DEBUG=y
CONFIG_IOMMU_DEBUG=y
# CONFIG_KPROBES is not set
# CONFIG_IOMMU_LEAK is not set
# CONFIG_KGDB is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set

--0OAP2g/MAC+5xKAE--
