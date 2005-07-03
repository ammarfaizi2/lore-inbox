Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVGCLSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVGCLSB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 07:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVGCLSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 07:18:00 -0400
Received: from nproxy.gmail.com ([64.233.182.196]:44568 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261306AbVGCLQ4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 07:16:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=epkeR+lisW0Dp4WWM3mxN23T5L4WZC96m/paRSTInUNHclrkZkzDGAZlDqhqpkMF206u9HY/xRkhLWz81ZQfVUqC0olc0BSB/a4ZjcD6ZoNUeNVbSfTu35lbTlFR/zn4Us18xyDVGyQSVwz8SdpVPZwhJ6JWET1yG4C9dIJSfN4=
Message-ID: <9cfa10eb05070304167e1cd051@mail.gmail.com>
Date: Sun, 3 Jul 2005 14:16:53 +0300
From: Marko Kohtala <marko.kohtala@gmail.com>
Reply-To: Marko Kohtala <marko.kohtala@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: IRQ routing problem
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been having interrupt problems. 2.6.12 worked fine, but soon
after it got broken and was still broken just now that I checked git
version.

Interrupts get somehow misrouted.

Here is a part from the syslog showing the problem:

Jul  3 13:17:09 kohtala kernel: USB Universal Host Controller
Interface driver v2.3
Jul  3 13:17:09 kohtala kernel: <7>Pin 2-12 already programmed
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt 0000:00:11.2[D] ->
GSI 12 (level, low) -> IRQ 20
Jul  3 13:17:09 kohtala kernel: PCI: Via IRQ fixup for 0000:00:11.2,
from 12 to 4
Jul  3 13:17:09 kohtala kernel: uhci_hcd 0000:00:11.2: VIA
Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
Jul  3 13:17:09 kohtala kernel: uhci_hcd 0000:00:11.2: new USB bus
registered, assigned bus number 4
Jul  3 13:17:09 kohtala kernel: uhci_hcd 0000:00:11.2: irq 20, io base
0x0000cc00
Jul  3 13:17:09 kohtala kernel: hub 4-0:1.0: USB hub found
Jul  3 13:17:09 kohtala kernel: hub 4-0:1.0: 2 ports detected
Jul  3 13:17:09 kohtala kernel: usb 3-1: new low speed USB device
using ohci_hcd and address 2
Jul  3 13:17:09 kohtala kernel: irq 20: nobody cared (try booting with
the "irqpoll" option)

Working kernel uses IRQ 12.

Motherboard is MSI-6380 ver 2, i.e. K7T266 Pro2-RU

I do not know what exactly do to help you trace this down, but e-mail
me preferably directly and I'll try to give you what you need to fix
this.


This is the whole syslog

Jul  3 13:17:09 kohtala syslogd 1.4.1#17: restart.
Jul  3 13:17:09 kohtala kernel: klogd 1.4.1#17, log source = /proc/kmsg started.
Jul  3 13:17:09 kohtala kernel: Inspecting /boot/System.map-2.6.13-rc1
Jul  3 13:17:09 kohtala kernel: Loaded 31540 symbols from
/boot/System.map-2.6.13-rc1.
Jul  3 13:17:09 kohtala kernel: Symbols match kernel version 2.6.13.
Jul  3 13:17:09 kohtala kernel: No module symbols loaded - kernel
modules not enabled.
Jul  3 13:17:09 kohtala kernel: 
Jul  3 13:17:09 kohtala kernel:     Floating point unit present.
Jul  3 13:17:09 kohtala kernel:     Machine Exception supported.
Jul  3 13:17:09 kohtala kernel:     64 bit compare & exchange supported.
Jul  3 13:17:09 kohtala kernel:     Internal APIC present.
Jul  3 13:17:09 kohtala kernel:     SEP present.
Jul  3 13:17:09 kohtala kernel:     MTRR  present.
Jul  3 13:17:09 kohtala kernel:     PGE  present.
Jul  3 13:17:09 kohtala kernel:     MCA  present.
Jul  3 13:17:09 kohtala kernel:     CMOV  present.
Jul  3 13:17:09 kohtala kernel:     PAT  present.
Jul  3 13:17:09 kohtala kernel:     PSE  present.
Jul  3 13:17:09 kohtala kernel:     MMX  present.
Jul  3 13:17:09 kohtala kernel:     FXSR  present.
Jul  3 13:17:09 kohtala kernel:     XMM  present.
Jul  3 13:17:09 kohtala kernel:     Bootup CPU
Jul  3 13:17:09 kohtala kernel: ACPI: IOAPIC (id[0x02]
address[0xfec00000] gsi_base[0])
Jul  3 13:17:09 kohtala kernel: IOAPIC[0]: apic_id 2, version 17,
address 0xfec00000, GSI 0-23
Jul  3 13:17:09 kohtala kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0
global_irq 2 dfl dfl)
Jul  3 13:17:09 kohtala kernel: Int: type 0, pol 0, trig 0, bus 0, irq 0, 2-2
Jul  3 13:17:09 kohtala kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9
global_irq 9 low level)
Jul  3 13:17:09 kohtala kernel: Int: type 0, pol 3, trig 3, bus 0, irq 9, 2-9
Jul  3 13:17:09 kohtala kernel: Bus #0 is ISA
Jul  3 13:17:09 kohtala kernel: ACPI: IRQ0 used by override.
Jul  3 13:17:09 kohtala kernel: Int: type 0, pol 0, trig 0, bus 0, irq 1, 2-1
Jul  3 13:17:09 kohtala kernel: ACPI: IRQ2 used by override.
Jul  3 13:17:09 kohtala kernel: Int: type 0, pol 0, trig 0, bus 0, irq 3, 2-3
Jul  3 13:17:09 kohtala kernel: Int: type 0, pol 0, trig 0, bus 0, irq 4, 2-4
Jul  3 13:17:09 kohtala kernel: Int: type 0, pol 0, trig 0, bus 0, irq 5, 2-5
Jul  3 13:17:09 kohtala kernel: Int: type 0, pol 0, trig 0, bus 0, irq 6, 2-6
Jul  3 13:17:09 kohtala kernel: Int: type 0, pol 0, trig 0, bus 0, irq 7, 2-7
Jul  3 13:17:09 kohtala kernel: Int: type 0, pol 0, trig 0, bus 0, irq 8, 2-8
Jul  3 13:17:09 kohtala kernel: ACPI: IRQ9 used by override.
Jul  3 13:17:09 kohtala kernel: Int: type 0, pol 0, trig 0, bus 0, irq 10, 2-10
Jul  3 13:17:09 kohtala kernel: Int: type 0, pol 0, trig 0, bus 0, irq 11, 2-11
Jul  3 13:17:09 kohtala kernel: Int: type 0, pol 0, trig 0, bus 0, irq 12, 2-12
Jul  3 13:17:09 kohtala kernel: Int: type 0, pol 0, trig 0, bus 0, irq 13, 2-13
Jul  3 13:17:09 kohtala kernel: Int: type 0, pol 0, trig 0, bus 0, irq 14, 2-14
Jul  3 13:17:09 kohtala kernel: Int: type 0, pol 0, trig 0, bus 0, irq 15, 2-15
Jul  3 13:17:09 kohtala kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Jul  3 13:17:09 kohtala kernel: Using ACPI (MADT) for SMP
configuration information
Jul  3 13:17:09 kohtala kernel: Allocating PCI resources starting at
20000000 (gap: 20000000:dec00000)
Jul  3 13:17:09 kohtala kernel: Built 1 zonelists
Jul  3 13:17:09 kohtala kernel: Kernel command line:
BOOT_IMAGE=2.6.13-rc1 ro root=303 parport_pc.parport=auto
snd-via82xx.dxs_support=1 acpi=debug pci=routeirq 3
Jul  3 13:17:09 kohtala kernel: Unknown boot option
`parport_pc.parport=auto': ignoring
Jul  3 13:17:09 kohtala kernel: mapped APIC to ffffd000 (fee00000)
Jul  3 13:17:09 kohtala kernel: mapped IOAPIC to ffffc000 (fec00000)
Jul  3 13:17:09 kohtala kernel: Initializing CPU#0
Jul  3 13:17:09 kohtala kernel: PID hash table entries: 2048 (order:
11, 32768 bytes)
Jul  3 13:17:09 kohtala kernel: Detected 1466.601 MHz processor.
Jul  3 13:17:09 kohtala kernel: Using tsc for high-res timesource
Jul  3 13:17:09 kohtala kernel: Console: colour VGA+ 80x25
Jul  3 13:17:09 kohtala kernel: Dentry cache hash table entries:
131072 (order: 7, 524288 bytes)
Jul  3 13:17:09 kohtala kernel: Inode-cache hash table entries: 65536
(order: 6, 262144 bytes)
Jul  3 13:17:09 kohtala kernel: Memory: 514736k/524224k available
(2488k kernel code, 8936k reserved, 1068k data, 180k init, 0k highmem)
Jul  3 13:17:09 kohtala kernel: Checking if this processor honours the
WP bit even in supervisor mode... Ok.
Jul  3 13:17:09 kohtala kernel: Calibrating delay using timer specific
routine.. 2936.76 BogoMIPS (lpj=1468380)
Jul  3 13:17:09 kohtala kernel: Mount-cache hash table entries: 512
Jul  3 13:17:09 kohtala kernel: CPU: After generic identify, caps:
0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
Jul  3 13:17:09 kohtala kernel: CPU: After vendor identify, caps:
0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
Jul  3 13:17:09 kohtala kernel: CPU: L1 I Cache: 64K (64 bytes/line),
D cache 64K (64 bytes/line)
Jul  3 13:17:09 kohtala kernel: CPU: L2 Cache: 256K (64 bytes/line)
Jul  3 13:17:09 kohtala kernel: CPU: After all inits, caps: 0383fbff
c1cbfbff 00000000 00000020 00000000 00000000 00000000
Jul  3 13:17:09 kohtala kernel: Intel machine check architecture supported.
Jul  3 13:17:09 kohtala kernel: Intel machine check reporting enabled on CPU#0.
Jul  3 13:17:09 kohtala kernel: CPU: AMD Athlon(tm) XP 1700+ stepping 02
Jul  3 13:17:09 kohtala kernel: Enabling fast FPU save and restore... done.
Jul  3 13:17:09 kohtala kernel: Enabling unmasked SIMD FPU exception
support... done.
Jul  3 13:17:09 kohtala kernel: Checking 'hlt' instruction... OK.
Jul  3 13:17:09 kohtala kernel:  tbxface-0118 [02] acpi_load_tables   
  : ACPI Tables successfully acquired
Jul  3 13:17:09 kohtala kernel: Parsing all Control
Methods:................................................................................................................................
Jul  3 13:17:09 kohtala kernel: Table [DSDT](id F004) - 480 Objects
with 39 Devices 128 Methods 23 Regions
Jul  3 13:17:09 kohtala kernel: ACPI Namespace successfully loaded at
root c04c3e80
Jul  3 13:17:09 kohtala kernel: evxfevnt-0094 [03] acpi_enable        
  : Transition to ACPI mode successful
Jul  3 13:17:09 kohtala kernel: ENABLING IO-APIC IRQs
Jul  3 13:17:09 kohtala kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Jul  3 13:17:09 kohtala kernel: NET: Registered protocol family 16
Jul  3 13:17:09 kohtala kernel: PCI: PCI BIOS revision 2.10 entry at
0xfdb21, last bus=1
Jul  3 13:17:09 kohtala kernel: PCI: Using configuration type 1
Jul  3 13:17:09 kohtala kernel: mtrr: v2.0 (20020519)
Jul  3 13:17:09 kohtala kernel: ACPI: Subsystem revision 20050309
Jul  3 13:17:09 kohtala kernel: evgpeblk-0979 [06] ev_create_gpe_block
  : GPE 00 to 0F [_GPE] 2 regs on int 0x9
Jul  3 13:17:09 kohtala kernel: evgpeblk-0987 [06] ev_create_gpe_block
  : Found 6 Wake, Enabled 0 Runtime GPEs in this block
Jul  3 13:17:09 kohtala kernel: Completing Region/Field/Buffer/Package
initialization:..................................................................................
Jul  3 13:17:09 kohtala kernel: Initialized 23/23 Regions 9/9 Fields
41/41 Buffers 9/18 Packages (489 nodes)
Jul  3 13:17:09 kohtala kernel: Executing all Device _STA and_INI
methods:..........................................
Jul  3 13:17:09 kohtala kernel: 42 Devices found containing: 42 _STA,
1 _INI methods
Jul  3 13:17:09 kohtala kernel: ACPI: Interpreter enabled
Jul  3 13:17:09 kohtala kernel: ACPI: Using IOAPIC for interrupt routing
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Jul  3 13:17:09 kohtala kernel: PCI: Probing PCI hardware (bus 00)
Jul  3 13:17:09 kohtala kernel: Boot video device is 0000:01:00.0
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0._PRT]
Jul  3 13:17:09 kohtala kernel: ACPI: Power Resource [URP1] (off)
Jul  3 13:17:09 kohtala kernel: ACPI: Power Resource [URP2] (off)
Jul  3 13:17:09 kohtala kernel: ACPI: Power Resource [FDDP] (off)
Jul  3 13:17:09 kohtala kernel: ACPI: Power Resource [LPTP] (off)
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs
3 4 5 6 7 10 *11 12 14 15)
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs
3 4 5 6 7 *10 11 12 14 15)
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs
*3 4 5 6 7 10 11 12 14 15)
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs
3 4 5 6 7 10 11 *12 14 15)
Jul  3 13:17:09 kohtala kernel: usbcore: registered new driver usbfs
Jul  3 13:17:09 kohtala kernel: usbcore: registered new driver hub
Jul  3 13:17:09 kohtala kernel: PCI: Using ACPI for IRQ routing
Jul  3 13:17:09 kohtala kernel: PCI: Routing PCI interrupts for all
devices because "pci=routeirq" specified
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt 0000:00:05.0[A] ->
GSI 16 (level, low) -> IRQ 16
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt 0000:00:06.0[A] ->
GSI 17 (level, low) -> IRQ 17
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt 0000:00:08.0[A] ->
GSI 19 (level, low) -> IRQ 18
Jul  3 13:17:09 kohtala kernel: <7>Pin 2-16 already programmed
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt 0000:00:0b.0[A] ->
GSI 16 (level, low) -> IRQ 16
Jul  3 13:17:09 kohtala kernel: <7>Pin 2-17 already programmed
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt 0000:00:0b.1[B] ->
GSI 17 (level, low) -> IRQ 17
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt 0000:00:0b.2[C] ->
GSI 18 (level, low) -> IRQ 19
Jul  3 13:17:09 kohtala kernel: <7>Pin 2-17 already programmed
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt 0000:00:0c.0[A] ->
GSI 17 (level, low) -> IRQ 17
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt 0000:00:11.2[D] ->
GSI 12 (level, low) -> IRQ 20
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt 0000:00:11.5[C] ->
GSI 3 (level, low) -> IRQ 21
Jul  3 13:17:09 kohtala kernel: <7>Pin 2-16 already programmed
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt 0000:01:00.0[A] ->
GSI 16 (level, low) -> IRQ 16
Jul  3 13:17:09 kohtala kernel: Machine check exception polling timer started.
Jul  3 13:17:09 kohtala kernel: Initializing Cryptographic API
Jul  3 13:17:09 kohtala kernel: ACPI: Power Button (FF) [PWRF]
Jul  3 13:17:09 kohtala kernel: ACPI: Sleep Button (CM) [SLPB]
Jul  3 13:17:09 kohtala kernel: ACPI: Processor [CPU1] (supports 16
throttling states)
Jul  3 13:17:09 kohtala kernel: Real Time Clock Driver v1.12
Jul  3 13:17:09 kohtala kernel: Linux agpgart interface v0.101 (c) Dave Jones
Jul  3 13:17:09 kohtala kernel: agpgart: Detected VIA KT266/KY266x/KT333 chipset
Jul  3 13:17:09 kohtala kernel: agpgart: AGP aperture is 64M @ 0xe0000000
Jul  3 13:17:09 kohtala kernel: [drm] Initialized drm 1.0.0 20040925
Jul  3 13:17:09 kohtala kernel: <7>Pin 2-16 already programmed
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt 0000:01:00.0[A] ->
GSI 16 (level, low) -> IRQ 16
Jul  3 13:17:09 kohtala kernel: [drm] Initialized mga 3.1.0 20021029
on minor 0: Matrox Graphics, Inc. MGA G550 AGP
Jul  3 13:17:09 kohtala kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jul  3 13:17:09 kohtala kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jul  3 13:17:09 kohtala kernel: Serial: 8250/16550 driver $Revision:
1.90 $ 4 ports, IRQ sharing disabled
Jul  3 13:17:09 kohtala kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jul  3 13:17:09 kohtala kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jul  3 13:17:09 kohtala kernel: io scheduler noop registered
Jul  3 13:17:09 kohtala kernel: io scheduler anticipatory registered
Jul  3 13:17:09 kohtala kernel: io scheduler deadline registered
Jul  3 13:17:09 kohtala kernel: io scheduler cfq registered
Jul  3 13:17:09 kohtala kernel: Floppy drive(s): fd0 is 1.44M
Jul  3 13:17:09 kohtala kernel: FDC 0 is a post-1991 82077
Jul  3 13:17:09 kohtala kernel: 8139too Fast Ethernet driver 0.9.27
Jul  3 13:17:09 kohtala kernel: <7>Pin 2-16 already programmed
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt 0000:00:05.0[A] ->
GSI 16 (level, low) -> IRQ 16
Jul  3 13:17:09 kohtala kernel: eth0: RealTek RTL8139 at 0xe080ef00,
00:50:fc:69:c6:e7, IRQ 16
Jul  3 13:17:09 kohtala kernel: eth0:  Identified 8139 chip type 'RTL-8139C'
Jul  3 13:17:09 kohtala kernel: Uniform Multi-Platform E-IDE driver
Revision: 7.00alpha2
Jul  3 13:17:09 kohtala kernel: ide: Assuming 33MHz system bus speed
for PIO modes; override with idebus=xx
Jul  3 13:17:09 kohtala kernel: PDC20265: IDE controller at PCI slot
0000:00:0c.0
Jul  3 13:17:09 kohtala kernel: <7>Pin 2-17 already programmed
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt 0000:00:0c.0[A] ->
GSI 17 (level, low) -> IRQ 17
Jul  3 13:17:09 kohtala kernel: PDC20265: chipset revision 2
Jul  3 13:17:09 kohtala kernel: PDC20265: ROM enabled at 0xdffd0000
Jul  3 13:17:09 kohtala kernel: PDC20265: 100%% native mode on irq 17
Jul  3 13:17:09 kohtala kernel: PDC20265: (U)DMA Burst Bit ENABLED
Primary MASTER Mode Secondary MASTER Mode.
Jul  3 13:17:09 kohtala kernel:     ide2: BM-DMA at 0xdc00-0xdc07,
BIOS settings: hde:pio, hdf:pio
Jul  3 13:17:09 kohtala kernel:     ide3: BM-DMA at 0xdc08-0xdc0f,
BIOS settings: hdg:pio, hdh:pio
Jul  3 13:17:09 kohtala kernel: Probing IDE interface ide2...
Jul  3 13:17:09 kohtala kernel: hde: IC35L120AVVA07-0, ATA DISK drive
Jul  3 13:17:09 kohtala kernel: ide2 at 0xec00-0xec07,0xe802 on irq 17
Jul  3 13:17:09 kohtala kernel: Probing IDE interface ide3...
Jul  3 13:17:09 kohtala kernel: hdg: SAMSUNG SP1614N, ATA DISK drive
Jul  3 13:17:09 kohtala kernel: hdh: Maxtor 85120 A8 -, ATA DISK drive
Jul  3 13:17:09 kohtala kernel: ide3 at 0xe400-0xe407,0xe002 on irq 17
Jul  3 13:17:09 kohtala kernel: VP_IDE: IDE controller at PCI slot 0000:00:11.1
Jul  3 13:17:09 kohtala kernel: PCI: Via IRQ fixup for 0000:00:11.1,
from 255 to 0
Jul  3 13:17:09 kohtala kernel: VP_IDE: chipset revision 6
Jul  3 13:17:09 kohtala kernel: VP_IDE: not 100%% native mode: will
probe irqs later
Jul  3 13:17:09 kohtala kernel: VP_IDE: VIA vt8233 (rev 00) IDE
UDMA100 controller on pci0000:00:11.1
Jul  3 13:17:09 kohtala kernel:     ide0: BM-DMA at 0xfc00-0xfc07,
BIOS settings: hda:DMA, hdb:DMA
Jul  3 13:17:09 kohtala kernel:     ide1: BM-DMA at 0xfc08-0xfc0f,
BIOS settings: hdc:DMA, hdd:pio
Jul  3 13:17:09 kohtala kernel: Probing IDE interface ide0...
Jul  3 13:17:09 kohtala kernel: hda: IBM-DPTA-372050, ATA DISK drive
Jul  3 13:17:09 kohtala kernel: hdb: Pioneer DVD-ROM ATAPIModel
DVD-106S 012, ATAPI CD/DVD-ROM drive
Jul  3 13:17:09 kohtala kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jul  3 13:17:09 kohtala kernel: Probing IDE interface ide1...
Jul  3 13:17:09 kohtala kernel: hdc: LITE-ON LTR-52246S, ATAPI CD/DVD-ROM drive
Jul  3 13:17:09 kohtala kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jul  3 13:17:09 kohtala kernel: hde: max request size: 128KiB
Jul  3 13:17:09 kohtala kernel: hde: 241254720 sectors (123522 MB)
w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
Jul  3 13:17:09 kohtala kernel: hde: cache flushes supported
Jul  3 13:17:09 kohtala kernel:  hde: hde1 hde2
Jul  3 13:17:09 kohtala kernel: hdg: max request size: 128KiB
Jul  3 13:17:09 kohtala kernel: hdg: 312581808 sectors (160041 MB)
w/8192KiB Cache, CHS=19457/255/63, UDMA(100)
Jul  3 13:17:09 kohtala kernel: hdg: cache flushes supported
Jul  3 13:17:09 kohtala kernel:  hdg: hdg1 hdg2
Jul  3 13:17:09 kohtala kernel: hdh: max request size: 128KiB
Jul  3 13:17:09 kohtala kernel: hdh: 10003456 sectors (5121 MB)
w/256KiB Cache, CHS=9924/16/63, DMA
Jul  3 13:17:09 kohtala kernel: hdh: cache flushes not supported
Jul  3 13:17:09 kohtala kernel:  hdh: hdh1 hdh2
Jul  3 13:17:09 kohtala kernel: hda: max request size: 128KiB
Jul  3 13:17:09 kohtala kernel: hda: 40088160 sectors (20525 MB)
w/1961KiB Cache, CHS=39770/16/63, UDMA(66)
Jul  3 13:17:09 kohtala kernel: hda: cache flushes not supported
Jul  3 13:17:09 kohtala kernel:  hda: hda1 hda2 hda3
Jul  3 13:17:09 kohtala kernel: hdb: ATAPI 40X DVD-ROM drive, 256kB
Cache, UDMA(66)
Jul  3 13:17:09 kohtala kernel: Uniform CD-ROM driver Revision: 3.20
Jul  3 13:17:09 kohtala kernel: hdc: ATAPI 52X CD-ROM CD-R/RW drive,
2048kB Cache, UDMA(33)
Jul  3 13:17:09 kohtala kernel: <7>Pin 2-18 already programmed
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt 0000:00:0b.2[C] ->
GSI 18 (level, low) -> IRQ 19
Jul  3 13:17:09 kohtala kernel: ehci_hcd 0000:00:0b.2: NEC Corporation USB 2.0
Jul  3 13:17:09 kohtala kernel: ehci_hcd 0000:00:0b.2: new USB bus
registered, assigned bus number 1
Jul  3 13:17:09 kohtala kernel: ehci_hcd 0000:00:0b.2: irq 19, io mem 0xdffcfe00
Jul  3 13:17:09 kohtala kernel: ehci_hcd 0000:00:0b.2: USB 2.0
initialized, EHCI 0.95, driver 10 Dec 2004
Jul  3 13:17:09 kohtala kernel: hub 1-0:1.0: USB hub found
Jul  3 13:17:09 kohtala kernel: hub 1-0:1.0: 5 ports detected
Jul  3 13:17:09 kohtala kernel: ohci_hcd: 2005 April 22 USB 1.1 'Open'
Host Controller (OHCI) Driver (PCI)
Jul  3 13:17:09 kohtala kernel: <7>Pin 2-16 already programmed
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt 0000:00:0b.0[A] ->
GSI 16 (level, low) -> IRQ 16
Jul  3 13:17:09 kohtala kernel: ohci_hcd 0000:00:0b.0: NEC Corporation USB
Jul  3 13:17:09 kohtala kernel: ohci_hcd 0000:00:0b.0: new USB bus
registered, assigned bus number 2
Jul  3 13:17:09 kohtala kernel: ohci_hcd 0000:00:0b.0: irq 16, io mem 0xdffcd000
Jul  3 13:17:09 kohtala kernel: hub 2-0:1.0: USB hub found
Jul  3 13:17:09 kohtala kernel: hub 2-0:1.0: 3 ports detected
Jul  3 13:17:09 kohtala kernel: <7>Pin 2-17 already programmed
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt 0000:00:0b.1[B] ->
GSI 17 (level, low) -> IRQ 17
Jul  3 13:17:09 kohtala kernel: ohci_hcd 0000:00:0b.1: NEC Corporation USB (#2)
Jul  3 13:17:09 kohtala kernel: ohci_hcd 0000:00:0b.1: new USB bus
registered, assigned bus number 3
Jul  3 13:17:09 kohtala kernel: ohci_hcd 0000:00:0b.1: irq 17, io mem 0xdffce000
Jul  3 13:17:09 kohtala kernel: hub 3-0:1.0: USB hub found
Jul  3 13:17:09 kohtala kernel: hub 3-0:1.0: 2 ports detected
Jul  3 13:17:09 kohtala kernel: USB Universal Host Controller
Interface driver v2.3
Jul  3 13:17:09 kohtala kernel: <7>Pin 2-12 already programmed
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt 0000:00:11.2[D] ->
GSI 12 (level, low) -> IRQ 20
Jul  3 13:17:09 kohtala kernel: PCI: Via IRQ fixup for 0000:00:11.2,
from 12 to 4
Jul  3 13:17:09 kohtala kernel: uhci_hcd 0000:00:11.2: VIA
Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
Jul  3 13:17:09 kohtala kernel: uhci_hcd 0000:00:11.2: new USB bus
registered, assigned bus number 4
Jul  3 13:17:09 kohtala kernel: uhci_hcd 0000:00:11.2: irq 20, io base
0x0000cc00
Jul  3 13:17:09 kohtala kernel: hub 4-0:1.0: USB hub found
Jul  3 13:17:09 kohtala kernel: hub 4-0:1.0: 2 ports detected
Jul  3 13:17:09 kohtala kernel: usb 3-1: new low speed USB device
using ohci_hcd and address 2
Jul  3 13:17:09 kohtala kernel: irq 20: nobody cared (try booting with
the "irqpoll" option)
Jul  3 13:17:09 kohtala kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
Jul  3 13:17:09 kohtala kernel:  [__report_bad_irq+43/144]
__report_bad_irq+0x2b/0x90
Jul  3 13:17:09 kohtala kernel:  [note_interrupt+113/208]
note_interrupt+0x71/0xd0
Jul  3 13:17:09 kohtala kernel:  [__do_IRQ+306/336] __do_IRQ+0x132/0x150
Jul  3 13:17:09 kohtala kernel:  [do_IRQ+51/96] do_IRQ+0x33/0x60
Jul  3 13:17:09 kohtala kernel:  [common_interrupt+26/32]
common_interrupt+0x1a/0x20
Jul  3 13:17:09 kohtala kernel:  [cpu_idle+87/96] cpu_idle+0x57/0x60
Jul  3 13:17:09 kohtala kernel:  [rest_init+59/64] rest_init+0x3b/0x40
Jul  3 13:17:09 kohtala kernel:  [start_kernel+344/384] start_kernel+0x158/0x180
Jul  3 13:17:09 kohtala kernel:  [L6+0/2] 0xc0100199
Jul  3 13:17:09 kohtala kernel: handlers:
Jul  3 13:17:09 kohtala kernel: [usb_hcd_irq+0/112] (usb_hcd_irq+0x0/0x70)
Jul  3 13:17:09 kohtala kernel: Disabling IRQ #20
Jul  3 13:17:09 kohtala kernel: drivers/usb/input/hid-core.c: timeout
initializing reports
Jul  3 13:17:09 kohtala kernel: 
Jul  3 13:17:09 kohtala kernel: input: USB HID v1.00 Joystick
[Logitech  Logitech MOMO Force ] on usb-0000:00:0b.1-1
Jul  3 13:17:09 kohtala kernel: usbcore: registered new driver usbhid
Jul  3 13:17:09 kohtala kernel: drivers/usb/input/hid-core.c:
v2.01:USB HID core driver
Jul  3 13:17:09 kohtala kernel: mice: PS/2 mouse device common for all mice
Jul  3 13:17:09 kohtala kernel: input: PC Speaker
Jul  3 13:17:09 kohtala kernel: Advanced Linux Sound Architecture
Driver Version 1.0.9 (Sun May 29 07:31:02 2005 UTC).
Jul  3 13:17:09 kohtala kernel: <7>Pin 2-3 already programmed
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt 0000:00:11.5[C] ->
GSI 3 (level, low) -> IRQ 21
Jul  3 13:17:09 kohtala kernel: PCI: Via IRQ fixup for 0000:00:11.5, from 3 to 5
Jul  3 13:17:09 kohtala kernel: PCI: Setting latency timer of device
0000:00:11.5 to 64
Jul  3 13:17:09 kohtala kernel: usb 4-1: new low speed USB device
using uhci_hcd and address 2
Jul  3 13:17:09 kohtala kernel: input: AT Translated Set 2 keyboard on
isa0060/serio0
Jul  3 13:17:09 kohtala kernel: ALSA device list:
Jul  3 13:17:09 kohtala kernel:   #0: VIA 8233-Pre with ALC200,200P at
0xd000, irq 21
Jul  3 13:17:09 kohtala kernel: NET: Registered protocol family 2
Jul  3 13:17:09 kohtala kernel: IP: routing cache hash table of 4096
buckets, 32Kbytes
Jul  3 13:17:09 kohtala kernel: TCP established hash table entries:
32768 (order: 6, 262144 bytes)
Jul  3 13:17:09 kohtala kernel: TCP bind hash table entries: 32768
(order: 5, 131072 bytes)
Jul  3 13:17:09 kohtala kernel: TCP: Hash tables configured
(established 32768 bind 32768)
Jul  3 13:17:09 kohtala kernel: TCP reno registered
Jul  3 13:17:09 kohtala kernel: ip_conntrack version 2.1 (4095
buckets, 32760 max) - 212 bytes per conntrack
Jul  3 13:17:09 kohtala kernel: ip_tables: (C) 2000-2002 Netfilter core team
Jul  3 13:17:09 kohtala kernel: TCP bic registered
Jul  3 13:17:09 kohtala kernel: NET: Registered protocol family 1
Jul  3 13:17:09 kohtala kernel: NET: Registered protocol family 17
Jul  3 13:17:09 kohtala kernel: Using IPI Shortcut mode
Jul  3 13:17:09 kohtala kernel: PM: Checking swsusp image.
Jul  3 13:17:09 kohtala kernel: PM: Resume from disk failed.
Jul  3 13:17:09 kohtala kernel: ACPI wakeup devices: 
Jul  3 13:17:09 kohtala kernel: PCI0 UAR1  USB USB1 USB2  AC9  MC9 ILAN SLPB 
Jul  3 13:17:09 kohtala kernel: ACPI: (supports S0 S3 S4 S5)
Jul  3 13:17:09 kohtala kernel: BIOS EDD facility v0.16 2004-Jun-25, 4
devices found
Jul  3 13:17:09 kohtala kernel: kjournald starting.  Commit interval 5 seconds
Jul  3 13:17:09 kohtala kernel: EXT3-fs: mounted filesystem with
ordered data mode.
Jul  3 13:17:09 kohtala kernel: VFS: Mounted root (ext3 filesystem) readonly.
Jul  3 13:17:09 kohtala kernel: Freeing unused kernel memory: 180k freed
Jul  3 13:17:09 kohtala kernel: input: USB HID v1.10 Mouse [Logitech
USB-PS/2 Optical Mouse] on usb-0000:00:11.2-1
Jul  3 13:17:09 kohtala kernel: EXT3 FS on hda3, internal journal
Jul  3 13:17:09 kohtala kernel: parport0: PC-style at 0x378, irq 7
[PCSPP,TRISTATE,EPP]
Jul  3 13:17:09 kohtala kernel: lp0: using parport0 (interrupt-driven).
Jul  3 13:17:09 kohtala kernel: ReiserFS: hdg1: found reiserfs format
"3.6" with standard journal
Jul  3 13:17:09 kohtala kernel: ReiserFS: hdg1: using ordered data mode
Jul  3 13:17:09 kohtala kernel: ReiserFS: hdg1: journal params: device
hdg1, size 8192, journal first block 18, max trans len 1024, max batch
900, max commit age 30, max trans age 30
Jul  3 13:17:09 kohtala kernel: ReiserFS: hdg1: checking transaction log (hdg1)
Jul  3 13:17:09 kohtala kernel: ReiserFS: hdg1: Using r5 hash to sort names
Jul  3 13:17:09 kohtala kernel: ReiserFS: hdg2: found reiserfs format
"3.6" with standard journal
Jul  3 13:17:09 kohtala kernel: ReiserFS: hdg2: using ordered data mode
Jul  3 13:17:09 kohtala kernel: ReiserFS: hdg2: journal params: device
hdg2, size 8192, journal first block 18, max trans len 1024, max batch
900, max commit age 30, max trans age 30
Jul  3 13:17:09 kohtala kernel: ReiserFS: hdg2: checking transaction log (hdg2)
Jul  3 13:17:09 kohtala kernel: ReiserFS: hdg2: Using r5 hash to sort names
Jul  3 13:17:09 kohtala kernel: kjournald starting.  Commit interval 5 seconds
Jul  3 13:17:09 kohtala kernel: EXT3 FS on hdh2, internal journal
Jul  3 13:17:09 kohtala kernel: EXT3-fs: mounted filesystem with
ordered data mode.
Jul  3 13:17:09 kohtala kernel: NTFS driver 2.1.22 [Flags: R/O MODULE].
Jul  3 13:17:09 kohtala kernel: NTFS volume version 3.0.
Jul  3 13:17:09 kohtala kernel: kjournald starting.  Commit interval 5 seconds
Jul  3 13:17:09 kohtala kernel: EXT3 FS on hde2, internal journal
Jul  3 13:17:09 kohtala kernel: EXT3-fs: mounted filesystem with
ordered data mode.
Jul  3 13:17:09 kohtala kernel: Adding 131064k swap on
/discc2/swapfile.  Priority:-1 extents:34
Jul  3 13:17:09 kohtala kernel: saa7146: register extension 'budget dvb'.
Jul  3 13:17:09 kohtala kernel: <7>Pin 2-17 already programmed
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt 0000:00:06.0[A] ->
GSI 17 (level, low) -> IRQ 17
Jul  3 13:17:09 kohtala kernel: saa7146: found saa7146 @ mem e0ae4c00
(revision 1, irq 17) (0x13c2,0x1005).
Jul  3 13:17:09 kohtala kernel: DVB: registering new adapter
(TT-Budget/WinTV-NOVA-T  PCI).
Jul  3 13:17:09 kohtala kernel: adapter has MAC addr = 00:d0:5c:20:34:9f
Jul  3 13:17:09 kohtala kernel: DVB: registering frontend 0 (LSI
L64781 DVB-T)...
Jul  3 13:17:09 kohtala kernel: ohci1394: $Rev: 1250 $ Ben Collins
<bcollins@debian.org>
Jul  3 13:17:09 kohtala kernel: <7>Pin 2-19 already programmed
Jul  3 13:17:09 kohtala kernel: ACPI: PCI Interrupt 0000:00:08.0[A] ->
GSI 19 (level, low) -> IRQ 18
Jul  3 13:17:09 kohtala kernel: PCI: Via IRQ fixup for 0000:00:08.0,
from 12 to 2
Jul  3 13:17:09 kohtala kernel: ohci1394: fw-host0: OHCI-1394 1.0
(PCI): IRQ=[18]  MMIO=[dffcf000-dffcf7ff]  Max Packet=[2]
Jul  3 13:17:09 kohtala kernel: ohci1394: fw-host0: Serial EEPROM has
suspicious values, attempting to setting max_packet_size to 512 bytes
Jul  3 13:17:09 kohtala kernel: ieee1394: Host added:
ID:BUS[0-00:1023]  GUID[4d5a900003000000]
