Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271858AbRICX1G>; Mon, 3 Sep 2001 19:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271859AbRICX04>; Mon, 3 Sep 2001 19:26:56 -0400
Received: from pyro.net ([207.7.10.2]:4900 "HELO kiwi.pyro.net")
	by vger.kernel.org with SMTP id <S271858AbRICX0r>;
	Mon, 3 Sep 2001 19:26:47 -0400
Date: Mon, 3 Sep 2001 18:45:00 -0500 (CDT)
From: John Pierce <hawkfan@pyrotechnics.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.9 PCI routing Oops
Message-ID: <Pine.LNX.4.00.10109031737160.27914-100000@kiwi.pyro.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to get a TI pci cardbus bridge working on a TXPro/TX-Two based
board.

With the normal PCI configuration methods no IRQ's ever get routed to the
board afaict.  Using pci=biosirq oops's as soon as it tries to assign an
irq to a device.

I'm using 2.4.9 patched for lvm-1.0.1-rc1 and ext3-2.4-0.9.6-249.  The
same occurs on vanilla 2.4.9

I'm using the pcmcia modules from pcmcia-cs-3.1.28 and linux-wlan-ng-0.1.9
because the kernel modules don't provide the features I need for my
application.  The kernel yenta_socket doesn't load because it
cant get the irq's routed..  The linux-wlan and pcmcia-cs drivers do get
loaded but don't actually get the irq's routed.

The relevant config:
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set

Output of lspci -vvx:
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1531 [Aladdin IV] (rev
b3)
        Subsystem: Acer Laboratories Inc. [ALi] M1531 [Aladdin IV]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
00: b9 10 31 15 06 00 00 24 b3 00 00 06 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 31 15
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge
[Aladdin IV] (rev b4)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 0
00: b9 10 33 15 0f 00 00 32 b4 00 01 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 05)        Subsystem: Intel Corporation EtherExpress PRO/100+
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ff5ff000 (32-bit, prefetchable) [size=4K]
        Region 1: I/O ports at ef40 [size=32]
        Region 2: Memory at ffa00000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at ff900000 [disabled] [size=1M]
        Capabilities: <available only to root>
00: 86 80 29 12 17 01 90 02 05 00 00 02 08 40 00 00
10: 08 f0 5f ff 41 ef 00 00 00 00 a0 ff 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 09 00
30: 00 00 90 ff dc 00 00 00 00 00 00 00 0b 01 08 38

00:05.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
Controller (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001
00: 4c 10 50 ac 07 00 10 02 01 00 07 06 08 a8 02 00
10: 00 00 00 10 a0 00 00 02 00 01 04 b0 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 c0 07
40: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 20)
(prog-if fa)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at ffa0 [size=16]
00: b9 10 29 52 05 00 80 02 20 fa 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 02 04

/proc/interrupts:
           CPU0       
  0:     159442          XT-PIC  timer
  2:          0          XT-PIC  cascade
  4:       1534          XT-PIC  serial
  5:          0          XT-PIC  prism2_cs
  8:          1          XT-PIC  rtc
 11:       1304          XT-PIC  eth0
 14:       2043          XT-PIC  ide0
NMI:          0 
ERR:          0

Note the 0 count on prism2_cs.  It's across the bridge.

Boot log w/o pci=biosirq:
Linux version 2.4.9 (john@penguin.AfterThought.int) (gcc version
egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Mon Sep 3 03:35:42
CDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000002000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
On node 0 totalpages: 8192
zone(0): 4096 pages.
zone(1): 4096 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/blackhawk_sys/root console=ttyS0 single
Initializing CPU#0
Detected 199.964 MHz processor.
Calibrating delay loop... 398.95 BogoMIPS
Memory: 29248k/32768k available (832k kernel code, 3132k reserved, 321k
data, 188k init, 0k highmem)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: AMD-K6tm w/ multimedia extensions stepping 02
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfdb11, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
Journalled Block Device driver loaded
devfs: v0.107 (20010709) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 64 slots per queue, batch=8
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 58
PCI: No IRQ known for interrupt pin A of device 00:0b.0. Please try using
pci=biosirq.
ALI15X3: chipset revision 32
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
hda: WDC AC36400L, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 12594960 sectors (6449 MB) w/256KiB Cache, CHS=13328/15/63, (U)DMA
Partition check:
 /dev/ide/host0/bus0/target0/lun0: [PTBL] [784/255/63] p1 p3 p4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET4: Frame Diverter 0.46
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:90:27:1C:7F:00, IRQ
11.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 689661-004, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
Linux IP multicast router 0.06 plus PIM-SM

[rest of boot works fine]

bootlog with pci=biosirq:
Linux version 2.4.9 (john@penguin.AfterThought.int) (gcc version
egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Mon Sep 3 03:35:42
CDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000002000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
On node 0 totalpages: 8192
zone(0): 4096 pages.
zone(1): 4096 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/blackhawk_sys/root console=ttyS0
pci=biosirq single
Initializing CPU#0
Detected 199.965 MHz processor.
Calibrating delay loop... 398.95 BogoMIPS
Memory: 29248k/32768k available (832k kernel code, 3132k reserved, 321k
data, 188k init, 0k highmem)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: AMD-K6tm w/ multimedia extensions stepping 02
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfdb11, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using BIOS Interrupt Routing Table
PCI: Using BIOS for IRQ routing
PCI: Hardcoded IRQ 14 for device 00:0b.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
Journalled Block Device driver loaded
devfs: v0.107 (20010709) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 64 slots per queue, batch=8
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 58
PCI: Hardcoded IRQ 14 for device 00:0b.0
ALI15X3: chipset revision 32
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
hda: WDC AC36400L, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 12594960 sectors (6449 MB) w/256KiB Cache, CHS=13328/15/63, (U)DMA
Partition check:
 /dev/ide/host0/bus0/target0/lun0: [PTBL] [784/255/63] p1 p3 p4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET4: Frame Diverter 0.46
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
Unable to handle kernel paging request at virtual address 0000dde4
 printing eip:
c00fde03                                                  
*pde = 00000000                                           
Oops: 0000                                                
CPU:    0                                                 
EIP:    0010:[<c00fde03>]
EFLAGS: 00010296
eax: 00000008   ebx: 0000dde4   ecx: 00000b0a   edx: c1090bc8
esi: c02140cc   edi: 0000000b   ebp: 00000000   esp: c1ff1e86
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c1ff1000)
Stack: 000b0bc8 40cc0000 0000c021 1ea80000 0020c1ff def80000 0b0ac109
0bc80000 
       deba0000 000bc00f 40cc0000 0000c021 1ecc0000 0020c1ff a8010000
0b0ac109 
       b10b0000 dd410000 b10fc00f 0b0aa800 c00fdba2 ccbc0206 0010c010
000b0000 
Call Trace: <1>Unable to handle kernel paging request at virtual address
c2000000
 printing eip:
c0107050
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0107050>]
EFLAGS: 00010002
eax: 0000000c   ebx: 00000000   ecx: 00000000   edx: c1fffffe
esi: 00000001   edi: 00000018   ebp: 00000001   esp: c1ff1d3e
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c1ff1000)

[ endless stream of oopses snipped ]

c00fde03 is not in my System.map, c0107050 is inside show_trace.

I've narrowed down the problem to an lcall inside pcibios_set_irq_routing,
it goes into the call and oopses from there.

__asm__("lcall (%%esi); cld\n\t"
    "jc 1f\n\t"
    "1:"
    : "=a" (ret)
    : "0" (PCIBIOS_SET_PCI_HW_INT),
      "b" ((dev->bus->number << 8) | dev->devfn),
      "c" ((irq << 8)) | (pin + 10)),
      "S" (&pci_indirect));

Some poking around shows that %esi remains unch, %eax and %ebx are
clobbered and %ecx is untouched.  It does appear that the inputs are
correct for the call.  I can't confirm that the call address c02140cc, or
the device function 0x20 is correct however.

The card is attempting to take irq 11, if I swap things around to get it
to take 10, %ebx goes to dde3.

The board is an Amptron PM-9600 which uses a TX-Two labeled chipset,
really its the same as a TXPro/ALi 1531, infact you can use many TXPro
bios's with it.  The bios date is 5/13/99 S, it's the last bios update for
this board.  A PC Chips m565 (402s) bios also works but has the same
results.

No bios settings have an effect.

I'll be glad to poke around some more or test changes.

Do I have any hope of getting irq routing over this bridge working on this
board?

Thanks,
John..

-- 
John Pierce              | Finger for PGP/GnuPG keys or see:
hawkfan@pyrotechnics.com | http://www.pyrotechnics.com/~hawkfan/
RSA: 5F FC 0A 2D D6 FD B9 3E  57 34 E5 96 AB FC 9D 13
DH:  0BE5 672B F30F 095E 9BDD  0447 1613 DACA 60F6 4A64


