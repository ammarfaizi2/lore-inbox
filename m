Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVCFAwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVCFAwx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 19:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVCFAwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 19:52:53 -0500
Received: from innocence.nightwish.hu ([217.20.130.196]:44258 "EHLO
	innocence.nightwish.hu") by vger.kernel.org with ESMTP
	id S261263AbVCFAw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 19:52:27 -0500
Subject: NMI watchdog question
From: Pallai Roland <dap@mail.index.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 06 Mar 2005 01:53:25 +0100
Message-Id: <1110070406.8018.127.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
 I'm playing with the NMI watchdog (nmi_watchdog=1) on a reproductable
hard lockup (no keyboard, etc) but seems like it doesn't works and I
can't understand why, please explain to me the possible causes.. I
belive it should work in this situation..

environment:
 P4C800 motherboard, P4-2.4 cpu (APIC 2.0 on)
 Promise 20378 SATA controller on the motherboard (sil_promise driver)
 Maxtor diamondmax plus 9 200G sata disk
 (and an empty PCI expander plus some more other under-testing hardware
which doesn't matter in the experiment)

 mainline kernel 2.6.11
 serial and VGA console, root on NFS


steps to the lockup:
 1. booting the machine with sata drive on the promise controller
 2. dd if=/dev/sda of=/dev/null bs=4k
 3. unplug the power from drive
 4. waiting about 2 seconds
 5. plug the power back

 dd stucked in 'D' here for 10-15 seconds and than the kernel say:
  ata1: command timeout

 and voila, the box is dead, but without any message from the NMI
watchdog :(


 thanks in advance!



dap:# cat /proc/interrupts 
           CPU0       
  0:     685561    IO-APIC-edge  timer
  1:          8    IO-APIC-edge  i8042
  4:       2666    IO-APIC-edge  serial
  8:          4    IO-APIC-edge  rtc
  9:          1   IO-APIC-level  acpi
 12:         93    IO-APIC-edge  i8042
 14:      12810    IO-APIC-edge  ide0
169:      90085   IO-APIC-level  eth0, uhci_hcd
177:          4   IO-APIC-level  ehci_hcd, libata
185:          7   IO-APIC-level  ide2
193:          0   IO-APIC-level  uhci_hcd, uhci_hcd
201:        103   IO-APIC-level  uhci_hcd
209:          0   IO-APIC-level  Intel ICH5
NMI:     686357 
LOC:     685462 
ERR:          0
MIS:          0

dap:# lspci 
0000:00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
0000:00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02)
0000:00:03.0 PCI bridge: Intel Corp. 82875P Processor to PCI to CSA Bridge (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 02)
0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02)
0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 Storage Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev a1)
0000:02:01.0 Ethernet controller: Intel Corp. 82547EI Gigabit Ethernet Controller (LOM)
0000:03:04.0 RAID bus controller: Promise Technology, Inc. PDC20378 (FastTrak 378/SATA 378) (rev 02)
0000:03:0b.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 05)
0000:03:0c.0 RAID bus controller: Silicon Image, Inc. (formerly CMD Technology Inc) PCI0680 Ultra ATA-133 Host Controller (rev 02)
0000:03:0d.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 04)
0000:04:04.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 04)
0000:05:04.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 04)
0000:05:08.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 04)

dmesg:
Linux version 2.6.11 (dap@localhost.localdomain) (gcc version 3.4.2 20041017 (Red Hat 3.4.2-6.f
c3)) #1 SMP Sat Mar 5 17:01:53 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff30000 (usable)
 BIOS-e820: 000000001ff30000 - 000000001ff40000 (ACPI data)
 BIOS-e820: 000000001ff40000 - 000000001fff0000 (ACPI NVS)
 BIOS-e820: 000000001fff0000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 130864
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126768 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v002 ACPIAM                                ) @ 0x000f9e30
ACPI: XSDT (v001 A M I  OEMXSDT  0x11000321 MSFT 0x00000097) @ 0x1ff30100
ACPI: FADT (v003 A M I  OEMFACP  0x11000321 MSFT 0x00000097) @ 0x1ff30290
ACPI: MADT (v001 A M I  OEMAPIC  0x11000321 MSFT 0x00000097) @ 0x1ff30390
ACPI: OEMB (v001 A M I  OEMBIOS  0x11000321 MSFT 0x00000097) @ 0x1ff40040
ACPI: DSDT (v001  P4CED P4CED096 0x00000096 INTL 0x02002026) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 20000000 (gap: 20000000:dfb80000)
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=l2611-1S0 ro nfsroot=192.168.4.254:/mnt/daproot,v3 ip=192.
168.4.5::192.168.4.254:255.255.255.0::eth0:none console=tty0 console=ttyS0,115200 nmi_watchdog=
1 3
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2406.272 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 513272k/523456k available (2853k kernel code, 9620k reserved, 1039k data, 244k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4751.36 BogoMIPS (lpj=2375680)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 07
per-CPU timeslice cutoff: 1462.47 usecs.
task migration cache decay timeout: 2 msecs.
Total of 1 processors activated (4751.36 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
testing NMI watchdog ... OK.
Brought up 1 CPUs
CPU0 attaching sched-domain:
 domain 0: span 01
  groups: 01
  domain 1: span 01
   groups: 01
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=7
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050211
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Machine check exception polling timer started.
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
Real Time Clock Driver v1.12
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
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Compaq SMART2 Driver (v 2.6.0)
Intel(R) PRO/1000 Network Driver - version 5.6.10.1-k2
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 18 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:02:01.0 to 64
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> an
d others
ACPI: PCI interrupt 0000:03:0b.0[A] -> GSI 23 (level, low) -> IRQ 177
eth1: OEM i82557/i82558 10/100 Ethernet, 00:50:8B:6A:30:AF, IRQ 177.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 702536-009, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 169
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: QUANTUM FIREBALLlct10 05, ATA DISK drive
hdb: QUANTUM FIREBALLlct15 20, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
SiI680: IDE controller at PCI slot 0000:03:0c.0
ACPI: PCI interrupt 0000:03:0c.0[A] -> GSI 20 (level, low) -> IRQ 185
SiI680: chipset revision 2
SiI680: BASE CLOCK == 133
SiI680: 100% native mode on irq 185
    ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hdf: MAXTOR 4K060H3, ATA DISK drive
ide2 at 0xe0806c80-0xe0806c87,0xe0806c8a on irq 185
Probing IDE interface ide3...
Probing IDE interface ide1...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 10002825 sectors (5121 MB) w/418KiB Cache, CHS=10585/15/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2 hda3 hda4 < hda5 >
hdb: max request size: 128KiB
hdb: 39876480 sectors (20416 MB) w/418KiB Cache, CHS=39560/16/63, UDMA(66)
hdb: cache flushes not supported
 hdb: hdb1 hdb2 hdb3 < hdb5 >
hdf: max request size: 64KiB
hdf: 117266688 sectors (60040 MB) w/2000KiB Cache, CHS=65535/16/63, UDMA(100)
hdf: cache flushes supported
 hdf: hdf1 hdf2
Red Hat/Adaptec aacraid driver (1.1.2-lk2 Mar  5 2005)
3ware Storage Controller device driver for Linux v1.26.02.000.
libata version 1.10 loaded.
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  3136.000 MB/sec
raid5: using function: pIII_sse (3136.000 MB/sec)
md: multipath personality registered as nr 7
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
IPv4 over IPv4 tunneling driver
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
P0P4 MC97 USB1 USB2 USB3 USB4 EUSB PS2K PS2M ILAN 
ACPI: (supports S0 S1 S3 S4 S5)
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
IP-Config: Complete:
      device=eth0, addr=192.168.4.5, mask=255.255.255.0, gw=192.168.4.254,
     host=192.168.4.5, domain=, nis-domain=(none),
     bootserver=255.255.255.255, rootserver=192.168.4.254, rootpath=
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Looking up port of RPC 100003/3 on 192.168.4.254
Looking up port of RPC 100005/3 on 192.168.4.254
VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 244k freed

-- modules --
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i875 Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xf4000000
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 193
uhci_hcd 0000:00:1d.0: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 193, io base 0xef00
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 201
uhci_hcd 0000:00:1d.1: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 201, io base 0xef20
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 169
uhci_hcd 0000:00:1d.2: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 169, io base 0xef40
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 193
uhci_hcd 0000:00:1d.3: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4
usb 2-2: new low speed USB device using uhci_hcd and address 2
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: irq 193, io base 0xef80
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
input: USB HID v1.00 Joystick [Logitech  Logitech MOMO Racing ] on usb-0000:00:1d.1-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 177
ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 177, pci mem 0xfebffc00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
usb 2-2: USB disconnect, address 2
usb 2-2: new low speed USB device using uhci_hcd and address 3
input: USB HID v1.00 Joystick [Logitech  Logitech MOMO Racing ] on usb-0000:00:1d.1-2
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 209
PCI: Setting latency timer of device 0000:00:1f.5 to 64
AC'97 0 analog subsections not ready
intel8x0_measure_ac97_clock: measured 49496 usecs
intel8x0: clocking to 48000
sata_promise version 1.01
ACPI: PCI interrupt 0000:03:04.0[A] -> GSI 23 (level, low) -> IRQ 177
ata1: SATA max UDMA/133 cmd 0xE087E200 ctl 0xE087E238 bmdma 0x0 irq 177
ata2: SATA max UDMA/133 cmd 0xE087E280 ctl 0xE087E2B8 bmdma 0x0 irq 177
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:407f
ata1: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_promise
ata2: no device found (phy stat 00000000)
scsi1 : sata_promise
  Vendor: ATA       Model: Maxtor 6Y200M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sda: drive cache: write back
 sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0

