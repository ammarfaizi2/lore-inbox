Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbULGJci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbULGJci (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 04:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbULGJci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 04:32:38 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:7824 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261734AbULGJbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 04:31:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=lh3A0nNTQgOa8I9O4vVYYdlFS7rUiHsQLCAHnNE2jQdu9lysUqILhFnb45z9P7MFbFTRP/l52yt8Oy3iFpKhsdZCXeLjesuIgqFbCpv9YrO4B+cQvpVDx52M1USHPjmyiYT8Kaj+bJlg4BqKjBUCOyeWUpWNDNVKQjIFTphvH5A=
Message-ID: <14dd4ead041206215713fd1646@mail.gmail.com>
Date: Tue, 7 Dec 2004 13:57:14 +0800
From: jonathan li <spiderium@gmail.com>
Reply-To: jonathan li <spiderium@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: usb does not work on via's smp mainboard
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, all
I installed kernel 2.4.21 on an via's mainboard, it seems that the usb
host controller does not work. when a connect my flash disk to it,it
reports the messages as follows:

hub.c: new USB device 00:10.1-1, assigned address 2
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=2 (error=-110)

There is no inpterrupt of xhci, the following is /proc/interrupts:

[root@dev3-169 root]# cat /proc/interrupts
           CPU0       CPU1
  0:        127     333200    IO-APIC-edge  timer
  1:          0          4    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  5:          0          0    IO-APIC-edge  ehci-hcd, VIA8237
  9:          0          0   IO-APIC-level  acpi
 10:          0          0    IO-APIC-edge  usb-uhci, usb-uhci
 11:          0          0    IO-APIC-edge  usb-uhci
 14:          4      39261    IO-APIC-edge  ide0
 15:          1          4    IO-APIC-edge  ide1
 16:         11      48515   IO-APIC-level  eth0
NMI:        705        953
LOC:     333252     333196
ERR:          0
MIS:          0

It seems that this question was caused by via's APIC, because i boot
kernel with noapic, usb is work, but eth0 is down.

the following is my dmesg witch CONFIG_USB_DEBUG=y:
eout: 10 msecs.
Booting processor 1/1 rip 6000 page 0000010037fc8000
Initializing CPU#1
Calibrating delay loop... 4810.34 BogoMIPS
CPU: L1 I Cache: 64K (64 bytes/line/2 way), D cache 64K (64 bytes/line/2 way)
CPU: L2 Cache: 1024K (64 bytes/line/8 way)
Machine Check Reporting enabled for CPU#1
CPU1: AMD Opteron(tm) Processor 250 stepping 0a
Total of 2 processors activated (9607.57 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22,
2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
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
 09 003 03  1    1    0   1   0    1    1    71
 0a 003 03  0    0    0   0   0    1    1    79
 0b 003 03  0    0    0   0   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
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
.................................... done.
Using local APIC timer interrupts.
Detected 12.528 MHz APIC timer.
cpu: 0, clocks: 2004606, slice: 668202
CPU0<T0:2004592,T1:1336384,D:6,S:668202,C:2004606>
cpu: 1, clocks: 2004606, slice: 668202
CPU1<T0:2004592,T1:668176,D:12,S:668202,C:2004606>
checking TSC synchronization across CPUs: passed.
time.c: Using PIT based timekeeping.
Starting migration thread for cpu 0
Starting migration thread for cpu 1
ACPI: Subsystem revision 20030619
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 *10 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 10 11 12, enabled at IRQ 5)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 10 11 12, disabled)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12, disabled)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11 12, disabled)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 6 7 10 11 12, disabled)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 6 7 10 11 12, disabled)
ACPI: PCI Interrupt Link [ALKA] (IRQs 20, disabled)
ACPI: PCI Interrupt Link [ALKB] (IRQs 21, disabled)
ACPI: PCI Interrupt Link [ALKC] (IRQs 22, disabled)
ACPI: PCI Interrupt Link [ALKD] (IRQs 23, disabled)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 0
ACPI: PCI Interrupt Link [LNK0] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 10
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 0
ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 0
ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 0
ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 0
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xa9 -> IRQ 18) Mode:1 Active:1
00:00:07[A] -> 2-18 -> vector 0xa9 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xb1 -> IRQ 19) Mode:1 Active:1
00:00:07[B] -> 2-19 -> vector 0xb1 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xb9 -> IRQ 16) Mode:1 Active:1
00:00:07[C] -> 2-16 -> vector 0xb9 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xc1 -> IRQ 17) Mode:1 Active:1
00:00:07[D] -> 2-17 -> vector 0xc1 -> IRQ 17
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
PCI: No IRQ known for interrupt pin B of device 00:0f.0
PCI: No IRQ known for interrupt pin A of device 00:0f.1 - using IRQ 255
PCI: No IRQ known for interrupt pin A of device 00:10.0
PCI: No IRQ known for interrupt pin A of device 00:10.1
PCI: No IRQ known for interrupt pin B of device 00:10.2
PCI: No IRQ known for interrupt pin C of device 00:10.4
PCI: No IRQ known for interrupt pin C of device 00:11.5
PCI: Using ACPI for IRQ routing
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 940M
agpgart: no supported devices found.
PCI-DMA: Disabling IOMMU.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
aio_setup: num_physpages = 65464
aio_setup: sizeof(struct page) = 104
Hugetlbfs mounted.
Total HugeTLB memory allocated, 0
IA32 emulation $Id: sys_ia32.c,v 1.56 2003/04/10 10:45:37 ak Exp $
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT
SHARE_IRQ SERIAL_PCI SERIAL_ACPI enabled
ttyS0 at 0x03f8 (irq = 4) is a 16550A
ttyS1 at 0x02f8 (irq = 3) is a 16550A
register_serial(): autoconfig failed
register_serial(): autoconfig failed
Real Time Clock Driver v1.10e
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 256 RAM disks of 8192K size 1024 blocksize
HDLC support module revision 1.12
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:0f.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci00:0f.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:DMA
hda: ST340014A, ATA DISK drive
hdd: ATAPI CD-ROM 52XMax, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, UDMA(100)
hdd: attached ide-cdrom driver.
hdd: ATAPI 52X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.99.newide
Partition check:
 hda: [PTBL] [4865/255/63] hda1 hda2 hda3 hda4
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
Initializing IPsec netlink socket
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Journalled Block Device driver loaded
EXT2-fs warning (device ide0(3,2)): ext2_read_super: mounting ext3
filesystem as ext2

VFS: Mounted root (ext2 filesystem) readonly.
Trying to move old root to /initrd ... okay
Freeing unused kernel memory: 228k freed
Adding Swap: 2096440k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 10:20:17 Dec  7 2004
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xdc00, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF 0000010004a2c9c0, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: dc00
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface 0000010004a2c9c0
usb.c: kusbd: /sbin/hotplug add 1
usb-uhci.c: USB UHCI at I/O 0xe000, IRQ 10
usb-uhci.c: Detected 2 ports
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 1, portstatus 100, change 2, 12 Mb/s
hub.c: port 1 enable change, status 100
hub.c: port 2, portstatus 300, change 2, 1.5 Mb/s
hub.c: port 2 enable change, status 300
usb.c: new USB bus registered, assigned bus number 2
usb.c: kmalloc IF 0000010004a2ccc0, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: e000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface 0000010004a2ccc0
usb.c: kusbd: /sbin/hotplug add 1
usb-uhci.c: USB UHCI at I/O 0xe400, IRQ 11
usb-uhci.c: Detected 2 ports
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 2, portstatus 100, change 3, 12 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 100, change 3, 12 Mb/s
hub.c: port 1, portstatus 100, change 2, 12 Mb/s
hub.c: port 1 enable change, status 100
hub.c: port 2, portstatus 100, change 2, 12 Mb/s
hub.c: port 2 enable change, status 100
usb.c: new USB bus registered, assigned bus number 3
usb.c: kmalloc IF 0000010004a2ce40, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: e400
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface 0000010004a2ce40
usb.c: kusbd: /sbin/hotplug add 1
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 2, portstatus 100, change 3, 12 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 100, change 3, 12 Mb/s
hub.c: port 1, portstatus 100, change 2, 12 Mb/s
hub.c: port 1 enable change, status 100
hub.c: port 2, portstatus 100, change 2, 12 Mb/s
hub.c: port 2 enable change, status 100
ehci-hcd.c: 2003-Jan-22 USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-hcd.c: block sizes: qh 160 qtd 96 itd 160 sitd 96
ehci-hcd 00:10.4: VIA Technologies, Inc. USB 2.0
ehci-hcd 00:10.4: irq 5, pci mem ffffff0000120000
usb.c: new USB bus registered, assigned bus number 4
ehci-hcd 00:10.4: ehci_start hcs_params 0x3206 dbg=0 cc=3 pcc=2
ordered !ppc ports=6
ehci-hcd 00:10.4: ehci_start hcc_params 6872 thresh 7 uframes 256/512/1024
ehci-hcd 00:10.4: capability 0001 at 68
ehci-hcd 00:10.4: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
PCI: 00:10.4 PCI cache line size set incorrectly (32 bytes) by BIOS/FW.
PCI: 00:10.4 PCI cache line size corrected to 64.
ehci-hcd 00:10.4: init command 010009 (park)=0 ithresh=1 period=256 RUN
ehci-hcd 00:10.4: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
hcd.c: 00:10.4 root hub device address 1
usb.c: kmalloc IF 000001000486fd40, numif 1
usb.c: new device strings: Mfr=3, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Manufacturer: Linux 2.4.21-18.1 ehci-hcd
Product: VIA Technologies, Inc. USB 2.0
SerialNumber: 00:10.4
hub.c: USB hub found
hub.c: 6 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: individual port over-current protection
hub.c: Single TT
hub.c: TT requires at most 8 FS bit times
hub.c: Port indicators are not supported
hub.c: power on to power good time: 0ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RRRRRR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface 000001000486fd40
usb.c: kusbd: /sbin/hotplug add 1
tg3.c:v3.6RH (June 12, 2004)
divert: allocating divert_blk for eth0
eth0: Tigon3 [partno(BCM95705A50) rev 3003 PHY(5705)]
(PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:0c:76:ad:84:e2
eth0: HostTXDS[1] RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0]
WireSpeed[0] TSOcap[0]
tg3: eth0: Link is up at 100 Mbps, half duplex.
tg3: eth0: Flow control is off for TX and off for RX.
tg3: eth0: Link is up at 100 Mbps, half duplex.
tg3: eth0: Flow control is off for TX and off for RX.
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 or dxs_support=4 option
         and report if it works on your machine.
PCI: Setting latency timer of device 00:11.5 to 64
application bug: parallel(537) has SIGCHLD set to SIG_IGN but calls wait().
(see the NOTES section of 'man 2 wait'). Workaround activated.
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
lp0: using parport0 (polling).
lp0: console ready
application bug: crond(600) has SIGCHLD set to SIG_IGN but calls wait().
(see the NOTES section of 'man 2 wait'). Workaround activated.


the following is the output of lspci -vvvxxx:
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3188 (rev 01)
	Subsystem: Micro-star International Co Ltd: Unknown device 1300
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [80] AGP version 3.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] #08 [0060]
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #08 [8001]
00: 06 11 88 31 06 00 30 22 01 00 00 06 00 08 00 00
10: 08 00 00 e8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00
40: 00 19 88 80 82 44 00 00 13 39 88 80 82 44 00 00
50: 03 00 10 b1 30 2c 00 40 08 00 01 80 03 80 17 00
60: 00 aa 00 20 03 00 00 00 01 58 02 00 00 00 00 00
70: 00 e8 ec 01 44 37 00 08 01 00 00 00 7f 00 00 02
80: 02 c0 30 00 1b 0a 00 1f 00 00 00 00 28 00 00 00
90: 00 01 00 00 20 0f 01 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 06 08 00 88
b0: 40 00 10 00 46 00 00 02 68 00 00 01 00 00 00 00
c0: 08 68 60 00 20 00 11 11 d0 00 00 00 22 05 35 00
d0: 02 00 35 00 00 00 00 00 00 00 22 22 34 00 22 40
e0: 00 00 00 00 00 ff 1d 00 00 00 00 00 00 40 00 00
f0: 00 00 00 00 00 00 81 00 00 00 00 00 00 04 00 00

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b188
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f8000000-f9ffffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 88 b1 07 01 30 02 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 20 22
20: 00 f8 f0 f9 00 f0 f0 f7 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 08 00
40: c3 da 00 44 34 3e 88 b1 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 02 02 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.0 Ethernet controller: Broadcom Corporation: Unknown device 1653 (rev 03)
	Subsystem: Micro-star International Co Ltd: Unknown device 1300
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (16000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fa000000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: fffbfbfffefdfdf8  Data: effb
00: e4 14 53 16 06 00 b0 02 03 00 00 02 08 20 00 00
10: 04 00 00 fa 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 07 00 00 00 62 14 00 13
30: 00 00 00 00 48 00 00 00 00 00 00 00 10 01 40 00
40: 00 00 00 00 00 00 00 00 01 50 02 c0 00 20 00 64
50: 03 58 f4 00 00 00 00 00 05 00 86 00 f8 fd fd fe
60: ff fb fb ff fb ef 00 00 98 00 03 30 00 00 3f 76
70: f6 10 00 00 20 00 00 80 50 00 00 00 00 00 00 00
80: 03 58 f4 00 00 00 00 00 34 00 13 04 82 10 08 04
90: 09 07 00 01 00 00 00 00 00 00 00 00 92 00 00 00
a0: 00 00 00 00 ca 01 00 00 00 00 00 00 85 01 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0f.0 RAID bus controller: VIA Technologies, Inc.: Unknown device
3149 (rev 80)
	Subsystem: Micro-star International Co Ltd: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at c000 [size=8]
	Region 1: I/O ports at c400 [size=4]
	Region 2: I/O ports at c800 [size=8]
	Region 3: I/O ports at cc00 [size=4]
	Region 4: I/O ports at d000 [size=16]
	Region 5: I/O ports at d400 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 49 31 07 00 90 02 80 00 04 01 00 20 80 00
10: 01 c0 00 00 01 c4 00 00 01 c8 00 00 01 cc 00 00
20: 01 d0 00 00 01 d4 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0b 02 00 00
40: 13 03 f1 44 06 af 00 00 10 82 65 03 00 00 00 00
50: 00 00 00 00 00 00 04 04 00 10 10 00 05 00 20 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 01 10 01 10 11 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 80 02 49 31 62 14 00 13 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Micro-star International Co Ltd: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 255
	Region 4: I/O ports at d800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d8 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 01 00 00
40: 1b f2 09 05 18 9c c0 00 20 5d 5d 20 ff 00 20 20
50: e6 17 17 e1 0c 00 00 00 a8 a8 a8 a8 00 00 00 00
60: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
70: 02 01 00 00 00 00 00 00 02 01 00 00 00 00 00 00
80: 00 e0 a6 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 06 00 71 05 62 14 00 13 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 09 00 00 00 00 00 00 00 00 00

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00 [UHCI])
	Subsystem: Micro-star International Co Ltd: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 4: I/O ports at dc00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 07 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 dc 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 80 00 00 00 00 00 00 00 0a 01 00 00
40: 40 12 03 00 00 00 00 00 00 0b a0 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 c2 ff 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 00

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00 [UHCI])
	Subsystem: Micro-star International Co Ltd: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 4: I/O ports at e000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 07 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 e0 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 80 00 00 00 00 00 00 00 0a 01 00 00
40: 40 12 03 00 00 00 00 00 00 0b a0 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 c2 ff 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 00

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00 [UHCI])
	Subsystem: Micro-star International Co Ltd: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at e400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 07 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 e4 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 80 00 00 00 00 00 00 00 0b 02 00 00
40: 40 12 03 00 00 00 00 00 00 0b a0 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 c2 ff 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 00

00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
(prog-if 20 [EHCI])
	Subsystem: Micro-star International Co Ltd: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 10
	Interrupt: pin C routed to IRQ 5
	Region 0: Memory at fa010000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 04 31 17 00 10 02 86 20 03 0c 10 20 80 00
10: 00 00 01 fa 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 03 00 00
40: 00 00 03 00 00 00 00 00 80 20 00 09 00 00 00 00
50: 00 5a 00 80 00 00 00 00 04 0b 66 66 53 66 66 00
60: 20 20 01 00 00 00 00 00 01 00 00 00 00 00 08 c0
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 c2 ff 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 86 00 00 00 00 00 00 00 00 00

00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3227
	Subsystem: Micro-star International Co Ltd: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 27 32 87 00 10 02 00 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00
40: 44 00 f8 00 ba ab 10 00 8c 20 00 00 44 00 08 08
50: 81 8d 09 00 00 20 22 20 43 80 00 09 00 00 00 00
60: 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00 00
70: 62 14 00 13 00 00 00 00 00 00 00 00 20 00 00 00
80: 20 84 49 00 f2 30 00 00 01 40 00 00 0a 18 00 00
90: 00 3b 6e 88 a0 c0 0f 00 00 00 5e 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 01 50 01 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 04 09 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 02 00 00 00 00 00 00 00 00 00

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233
AC97 Audio Controller (rev 60)
	Subsystem: Micro-star International Co Ltd: Unknown device 1300
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 5
	Region 0: I/O ports at ec00 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 59 30 01 00 10 02 60 00 01 04 00 00 00 00
10: 01 ec 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 c0 00 00 00 00 00 00 00 05 03 00 00
40: 01 cc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 06 00 00 00 00 00 00 00 00 00 00 00 00
d0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00
40: 01 01 03 00 02 02 01 00 01 01 01 00 01 01 01 00
50: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
60: 10 00 01 00 e4 02 00 00 00 c8 00 0f 10 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 08 a0 01 21 20 00 11 11 22 06 75 80 02 00 00 00
90: 13 56 13 04 00 00 00 00 03 00 00 00 00 00 00 00
a0: 08 c0 01 21 d0 00 11 77 22 00 75 80 02 00 00 00
b0: 52 06 53 02 00 00 00 00 00 00 00 00 00 00 00 00
c0: 08 00 01 21 20 00 11 11 22 05 75 80 02 00 00 00
d0: 56 04 51 02 00 00 ff 00 07 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 03 00 00 00 00 00 3f 00 00 00 40 00 01 00 00 00
50: 00 00 40 00 02 00 00 00 00 00 40 00 03 00 00 00
60: 00 00 40 00 04 00 00 00 00 00 40 00 05 00 00 00
70: 00 00 40 00 06 00 00 00 00 00 40 00 07 00 00 00
80: 03 00 fa 00 20 10 fa 00 03 0a 00 00 20 0b 00 00
90: 03 00 f8 00 20 ff f9 00 03 00 f0 00 20 ff f7 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 13 00 00 00 20 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 03 02 00 ff 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 00 00 00 01 10 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 ee e0 03 00 ee e0 03 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 03 00 00 00 00 00 00 00 35 3b 72 13 20 0a 10 00
90: 00 8c 01 08 09 0b 5b 06 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 55 fe b6 ba 1e 00 00 00 7f 25 00 28 d2 fa 0d b0
c0: 00 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 4d fb ac b5 6c fe fb fe 7c cc 98 90 dc ec ff 1a
e0: 6c da 9a 94 7b 7a f8 bb 7d 76 9c d1 cf f4 bb 4f
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: ff 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
50: f8 ff f7 ff ff 00 00 00 00 00 00 00 40 00 e6 90
60: 0f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 01 02 51 11 80 00 50 00 38 00 08 1b 22 00 00
80: 00 00 07 23 13 21 13 00 00 00 00 00 00 00 00 00
90: 05 00 00 00 74 00 00 00 00 e8 3f 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 3d 00 00 20 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 07 07 e2 04 00 00 00 00 25 00 00 00
e0: 00 00 00 00 20 12 69 00 1b 01 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00
40: 04 04 01 00 01 01 05 00 01 01 01 00 01 01 01 00
50: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
60: 11 00 01 00 e4 00 00 00 00 c8 00 0f 0c 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 08 a0 01 21 d0 00 11 77 22 00 75 80 02 00 00 00
90: ff 40 54 06 00 00 00 00 00 00 00 00 00 00 00 00
a0: 08 c0 01 21 20 00 11 11 22 06 75 80 02 00 00 00
b0: 13 56 13 04 00 00 00 00 03 00 00 00 00 00 00 00
c0: 08 00 01 21 d0 00 11 77 22 00 75 80 02 00 00 00
d0: 00 d0 04 07 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 03 00 00 00 00 00 3f 00 00 00 40 00 01 00 00 00
50: 00 00 40 00 02 00 00 00 00 00 40 00 03 00 00 00
60: 00 00 40 00 04 00 00 00 00 00 40 00 05 00 00 00
70: 00 00 40 00 06 00 00 00 00 00 40 00 07 00 00 00
80: 03 00 fa 00 20 10 fa 00 03 0a 00 00 20 0b 00 00
90: 03 00 f8 00 20 ff f9 00 03 00 f0 00 20 ff f7 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 13 00 00 00 20 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 03 02 00 ff 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 4a 5e 6d 83 1f 00 00 00 f8 e1 10 18 0f 60 08 02
c0: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: f8 22 c4 a7 f1 fa fd 9d fc 76 09 99 10 f3 18 52
e0: fa a5 db e3 fb fd 7a 0c ff b2 49 9c 92 d1 31 61
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: ff 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
50: 40 77 ff 2f 4f 00 00 00 00 00 00 00 00 f3 96 82
60: 0f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 01 02 51 11 80 00 50 00 38 00 08 1b 22 00 00
80: 00 00 07 23 13 21 13 00 00 00 00 00 00 00 00 00
90: 05 00 00 00 74 00 00 00 00 e8 3f 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 3f 00 00 80 ff 22 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 07 07 e2 04 00 00 00 00 00 25 00 00
e0: 00 00 00 00 20 10 6d 00 1b 01 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: nVidia Corporation: Unknown device
032b (rev a1) (prog-if 00 [VGA])
	Subsystem: nVidia Corporation: Unknown device 01ba
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 3.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
00: de 10 2b 03 07 00 b0 02 a1 00 00 03 00 20 00 00
10: 00 00 00 f8 08 00 00 f0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 de 10 ba 01
30: 00 00 00 00 60 00 00 00 00 00 00 00 0a 01 05 01
40: de 10 ba 01 02 00 30 00 1b 0e 00 1f 00 00 00 00
50: 01 00 00 00 01 00 00 00 ce d6 23 00 0f 00 00 00
60: 01 44 02 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
