Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267527AbUIWWnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267527AbUIWWnG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 18:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267526AbUIWWl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 18:41:57 -0400
Received: from [66.160.135.114] ([66.160.135.114]:28932 "EHLO lvsbox")
	by vger.kernel.org with ESMTP id S267535AbUIWWjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 18:39:20 -0400
Message-ID: <4153503A.6040801@bushytails.net>
Date: Thu, 23 Sep 2004 15:37:46 -0700
From: Randy Gardner <lkml@bushytails.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1 OOM on hard drive copy
Content-Type: multipart/mixed;
 boundary="------------060006050704060902090506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060006050704060902090506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Bartlomiej Zolnierkiewicz wrote:
> It shouldn't be like that. Please send dmesg output for this system.

> ditto

D'oh!  *kicks self*  somehow last time I upgraded, I got
CONFIG_BLK_DEV_VIA82CXXX as a module, and I just never noticed dma was
off until I checked with the 8gb drive.  The module was being loaded,
but too late I'd guess.  Not quite sure how it ended up a module, as I
always hit y for it...  *hides in shame*

[insert ~10 minute pause here as I recompile and reboot]

There's DMA back on...


The 8gb drive, however, would always give:
Sep 17 19:58:46 furbox kernel: hda: dma_timer_expiry: dma status == 0x21
Sep 17 19:58:56 furbox kernel: hda: DMA timeout error
Sep 17 19:58:56 furbox kernel: hda: dma timeout error: status=0x58 {
DriveReady SeekComplete DataRequest }
Sep 17 19:58:56 furbox kernel:

whenever you tried enabling dma on the computer I removed it from.
(yes, the 4th line was always blank)


And right now it's giving:
Sep 23 15:09:03 localhost kernel: hdc: dma_intr: status=0x51 {
DriveReady SeekComplete Error }
Sep 23 15:09:03 localhost kernel: hdc: dma_intr: error=0x84 {
DriveStatusError BadCRC }

with it in this computer.  (I can't put it back in the other computer...
  care of a cheap cpu fan it's been transformed into a paperweight)


Either way, I've had the drive for about 2 years, and have never once
gotten DMA to work with it, so I'd guess probably the drive is to blame,
not the kernel.  And I'd certainly like to copy the data off the drive
and retire it, as crc errors sound worse than general timeouts...


However, I don't think this is related to the OOM problem...  and even
if it were, broken dma shouldn't cause false OOMs.  :)


dmesg output from this box is mime-attached, even though you probably 
don't need it now that I fixed the via driver...


Thanks again,
--Randy
(who's about to grab -rc2 and see if it helps the OOMs)

--------------060006050704060902090506
Content-Type: text/plain;
 name="dmesg-randyg-Thu Sep 23 15:30:09 PDT 2004.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-randyg-Thu Sep 23 15:30:09 PDT 2004.txt"

Linux version 2.6.8.1 (root@dualbox) (gcc version 3.3.4 (Debian 1:3.3.4-6sarge1)) #3 SMP Thu Sep 23 14:59:51 PDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)
 BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5fd0
On node 0 totalpages: 524272
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 294896 pages, LIFO batch:16
DMI 2.2 present.
ACPI: RSDP (v000 VIA694                                    ) @ 0x000f78c0
ACPI: RSDT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x7fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x7fff3040
ACPI: MADT (v001 VIA694          0x00000000  0x00000000) @ 0x7fff5740
ACPI: DSDT (v001 VIA694 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 17
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: root=/dev/hda1 ro 
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 869.183 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2075572k/2097088k available (1761k kernel code, 20388k reserved, 751k data, 164k init, 1179584k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1703.93 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps:        0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 730.88 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1732.60 BogoMIPS
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps:        0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (3436.54 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 868.0440 MHz.
..... host bus clock speed is 133.0606 MHz.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
CPU0:  online
 domain 0: span 3
  groups: 1 2
CPU1:  online
 domain 0: span 3
  groups: 2 1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb2c0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:07.5[C] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:0e.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    1    0   1   0    1    1    71
 0a 003 03  1    1    0   1   0    1    1    79
 0b 003 03  1    1    0   1   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
 10 003 03  1    1    0   1   0    1    1    A9
 11 003 03  1    1    0   1   0    1    1    B1
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
.................................... done.
vesafb: probe of vesafb0 failed with error -6
Starting balanced_irq
highmem bounce pool size: 64 pages
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
PCI: Enabling Via external APIC routing
PCI: Via IRQ fixup for 0000:00:07.2, from 5 to 11
PCI: Via IRQ fixup for 0000:00:07.3, from 5 to 11
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:07.1
    ide0: BM-DMA at 0x9000-0x9007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x9008-0x900f, BIOS settings: hdc:DMA, hdd:pio
hda: MAXTOR 6L080L4, ATA DISK drive
hdb: Maxtor 6Y160P0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Maxtor 90845U3, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=65535/16/63, UDMA(66)
 /dev/ide/host0/bus0/target0/lun0: p1 p2
hdb: max request size: 1024KiB
hdb: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(66)
 /dev/ide/host0/bus0/target1/lun0: p1 p2 p3
hdc: max request size: 128KiB
hdc: 16514064 sectors (8455 MB) w/2048KiB Cache, CHS=16383/16/63, UDMA(66)
 /dev/ide/host0/bus1/target0/lun0: p1 p2
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 15
ACPI: (supports S0 S1 S4bios S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 164k freed
Adding 3958912k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU] (supports C1)
ACPI: Processor [CPU1] (supports C1)
inserting floppy driver for 2.6.8.1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
nbd: registered device at major 43
ipmi message handler version v32
ipmi device interface version v32
i2c /dev entries driver
Linux video capture interface: v1.00
V4L-Driver for Vision CPiA based cameras v1.2.3
usbcore: registered new driver usbfs
usbcore: registered new driver hub
cpia_usb: Unknown symbol cpia_register_camera
cpia_usb: Unknown symbol cpia_unregister_camera
USB driver for Vision CPiA based cameras v1.2.3
usbcore: registered new driver cpia
SCSI subsystem initialized
usbcore: registered new driver audio
drivers/usb/class/audio.c: v1.0.0:USB Audio Class driver
usbcore: registered new driver cdc_acm
drivers/usb/class/cdc-acm.c: v0.23:USB Abstract Control Model driver for USB modems and ISDN adapters
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
usbcore: registered new driver aiptek
drivers/usb/input/aiptek.c: v1.5 (May-15-2004): Bryan W. Headley/Chris Atenasio
drivers/usb/input/aiptek.c: Aiptek HyperPen USB Tablet Driver (Linux 2.6.x)
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
usbcore: registered new driver wacom
drivers/usb/input/wacom.c: v1.40 - 2.6.6-dwb-0.1:USB Wacom Graphire and Wacom Intuos tablet driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
usbcore: registered new driver snd-usb-audio
Linux agpgart interface v0.100 (c) Dave Jones
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport_pc: Via 686A parallel port: io=0x378
Linux Tulip driver version 1.1.13 (May 11, 2002)
ACPI: PCI interrupt 0000:00:0e.0[A] -> GSI 16 (level, low) -> IRQ 16
tulip0:  MII transceiver #1 config 3100 status 7829 advertising 01e1.
eth0: Lite-On 82c168 PNIC rev 32 at 0xc000, 00:C0:F0:3E:1B:0A, IRQ 16.
ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 17 (level, low) -> IRQ 17
eth1: Lite-On PNIC-II rev 37 at 0xc800, 00:C0:F0:6D:96:02, IRQ 17.
ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 17 (level, low) -> IRQ 17
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Single Channel A, SCSI Id=7, 16/253 SCBs

agpgart: Detected VIA Apollo Pro 133 chipset
agpgart: Maximum main memory to use for agp memory: 1919M
agpgart: AGP aperture is 64M @ 0xd8000000
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:07.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:07.2: irq 11, io base 00009400
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:07.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:07.3: irq 11, io base 00009800
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-1: new low speed USB device using address 2
input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-0000:00:07.2-1
ACPI: PCI interrupt 0000:00:07.5[C] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:07.5 to 64
NET: Registered protocol family 17
eth0: Setting half-duplex based on MII#1 link partner capability of 00a1.
lp0: using parport0 (polling).
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6111  Tue Jul 27 07:55:38 PDT 2004
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode

--------------060006050704060902090506--
