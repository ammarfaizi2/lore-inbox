Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263116AbTJJSY3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 14:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbTJJSY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 14:24:29 -0400
Received: from vsmtp2.tin.it ([212.216.176.222]:54739 "EHLO vsmtp2.tin.it")
	by vger.kernel.org with ESMTP id S263116AbTJJSYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 14:24:16 -0400
Message-ID: <3F86F9D3.8040209@tin.it>
Date: Fri, 10 Oct 2003 20:26:27 +0200
From: Marcello <voloterreno@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031006
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [2.4] 8139too driver gives many errors and collisions
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I'm using 2 Ethernet card based on the chip RTL8139C made by Skintek. 
These cards work with the 8139too.o module (that I've tried to build 
with various options) , but I get on both the boards , with variuous 
Cables tried the same error:

During the connection I get very much collsions and also some error 
packages under a very low connection load .

In paricular I have an ADSL Ethernet Modem , that is plugged to one of 
these cards , and using various file sharing programs like xMule 
immediatly I get collisions , and my connection is only 256Kbit/s !!!

This is the result of a "ping -f _modem_" :
bash-2.05a# ping -f 192.168.254.254
PING 192.168.254.254 (192.168.254.254): 56 octets data
...............................................................................
--- 192.168.254.254 ping statistics ---
2664 packets transmitted, 2585 packets received, 2% packet loss
round-trip min/avg/max = 0.8/19.0/42.8 ms
bash-2.05a#

and this is the "ifconfig" output after that :
bash-2.05a# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:40:F4:55:9D:95
          inet addr:192.168.254.1  Bcast:192.168.254.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:7611 errors:0 dropped:0 overruns:0 frame:0
          TX packets:7479 errors:0 dropped:0 overruns:0 carrier:0
          collisions:4847 txqueuelen:1000
          RX bytes:765102 (747.1 Kb)  TX bytes:729649 (712.5 Kb)
          Interrupt:17 Base address:0x8f00
 
eth1      Link encap:Ethernet  HWaddr 00:40:F4:55:A1:40
          inet addr:192.168.254.2  Bcast:192.168.254.255  Mask:255.255.255.0
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:19 Base address:0xae00
 
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:2 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:100 (100.0 b)  TX bytes:100 (100.0 b)
 

As you can see collisions are very much .

I haven't this problem with the 2.4.21-gentoo_modified kernel and with 
the new 2.6.0-test7 kernel , so it seems to be a Kernel problem .

Another strange problem that seems to be Kernel indipendent is that the 
autonegotiation fails :

bash-2.05a# mii-tool -v
eth0: autonegotiation failed, link ok
  product info: vendor 00:00:00, model 0 rev 0
  basic mode:   autonegotiation enabled
  basic status: autonegotiation complete, link ok
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
eth1: no link
  product info: vendor 00:00:00, model 0 rev 0
  basic mode:   autonegotiation enabled
  basic status: no link
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
bash-2.05a#


Please, Help me to find a solution to this! :(

Thank you very much!

Marcello


(Here the dmesg) :
bash-2.05a# dmesg
Linux version 2.4.23-pre7 (root@melchior.magisystem.it) (gcc version 
3.2.3 (CRUX)) #4 Fri Oct 10 20:03:16 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000cc000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
found SMP MP-table at 000fb930
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 AMI                                       ) @ 0x000fa9c0
ACPI: RSDT (v001 AMIINT VIA_K7   0x00000010 MSFT 0x00000097) @ 0x1fff0000
ACPI: FADT (v001 AMIINT VIA_K7   0x00000011 MSFT 0x00000097) @ 0x1fff0030
ACPI: MADT (v001 AMIINT VIA_K7   0x00000009 MSFT 0x00000097) @ 0x1fff00c0
ACPI: DSDT (v001    VIA   VIA_K7 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 Pentium(tm) Pro APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] 
trigger[0x0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] 
trigger[0x3])
Using ACPI (MADT) for SMP configuration information
Kernel command line: auto BOOT_IMAGE=CRUX ro root=303 hdc=ide-scsi 
hdd=ide-scsi
ide_setup: hdc=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 2004.627 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 3997.69 BogoMIPS
Memory: 516088k/524224k available (1254k kernel code, 7748k reserved, 
466k data, 112k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: CLK_CTL MSR was 6003d22f. Reprogramming to 2003d22f
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) XP 2400+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000080
ESR value after enabling vector: 00000000
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
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   1   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
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
calibrating APIC timer ...
..... CPU clock speed is 2004.5111 MHz.
..... host bus clock speed is 334.0851 MHz.
cpu: 0, clocks: 3340851, slice: 1670425
CPU0<T0:3340848,T1:1670416,D:7,S:1670425,C:3340851>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030918
PCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=1
PCI: Using configuration type 1
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:1)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
PCI: Probing PCI hardware
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
00:00:01[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17 Mode:1 Active:1)
00:00:01[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xb9 -> IRQ 22 Mode:1 Active:1)
00:00:11[C] -> 2-22 -> IRQ 22
Pin 2-16 already programmed
Pin 2-17 already programmed
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc1 -> IRQ 18 Mode:1 Active:1)
00:00:05[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc9 -> IRQ 19 Mode:1 Active:1)
00:00:05[D] -> 2-19 -> IRQ 19
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-16 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd1 -> IRQ 21 Mode:1 Active:1)
00:00:10[A] -> 2-21 -> IRQ 21
Pin 2-21 already programmed
Pin 2-21 already programmed
Pin 2-21 already programmed
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xd9 -> IRQ 23 Mode:1 Active:1)
00:00:12[A] -> 2-23 -> IRQ 23
Pin 2-18 already programmed
PCI: No IRQ known for interrupt pin A of device 00:11.1 - using IRQ 255
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
PCI: Via IRQ fixup for 00:10.0, from 11 to 5
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
vesafb: framebuffer at 0xd8000000, mapped to 0xe080b000, size 3072k
vesafb: mode is 1024x768x16, linelength=2048, pages=0
vesafb: protected mode interface info at c000:bbc0
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:11.1
PCI: No IRQ known for interrupt pin A of device 00:11.1 - using IRQ 255
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
hda: MAXTOR 6L060J3, ATA DISK drive
hdb: QUANTUM FIREBALLP AS30.0, ATA DISK drive
blk: queue c02f9100, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c02f923c, I/O limit 4095Mb (mask 0xffffffff)
hdc: LITE-ON LTR-52246S, ATAPI CD/DVD-ROM drive
hdd: _NEC DV-5800A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 117266688 sectors (60041 MB) w/1819KiB Cache, CHS=7299/255/63, 
UDMA(133)
hdb: attached ide-disk driver.
hdb: host protected area => 1
hdb: 58633344 sectors (30020 MB) w/1902KiB Cache, CHS=3649/255/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 >
 /dev/ide/host0/bus0/target1/lun0: p1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ide0(3,3)) ...
for (ide0(3,3))
ide0(3,3):Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 112k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 1028120k swap-space (priority -1)
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ide0(3,5)) ...
for (ide0(3,5))
ide0(3,5):Using r5 hash to sort names
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ide0(3,6)) ...
for (ide0(3,6))
ide0(3,6):Using r5 hash to sort names
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ide0(3,7)) ...
for (ide0(3,7))
ide0(3,7):Using r5 hash to sort names
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,65), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 at 0xe0e78f00, 00:40:f4:55:9d:95, IRQ 17
eth0:  Identified 8139 chip type 'RTL-8139C'
eth1: RealTek RTL8139 at 0xe0e7ae00, 00:40:f4:55:a1:40, IRQ 19
eth1:  Identified 8139 chip type 'RTL-8139C'
eth0: link up, 10Mbps, half-duplex, lpa 0x0000
eth1: link down
usb.c: registered new driver hub
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
usb-uhci.c: $Revision: 1.275 $ time 20:07:17 Oct 10 2003
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xe000, IRQ 21
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
ehci_hcd 00:10.3: VIA Technologies, Inc. USB 2.0
ehci_hcd 00:10.3: irq 21, pci mem e0ea3d00
usb.c: new USB bus registered, assigned bus number 2
ehci_hcd 00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-19/2.4
hub.c: USB hub found
hub.c: 2 ports detected
mice: PS/2 mouse device common for all mice
hub.c: new USB device 00:10.0-1, assigned address 2
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb1:2.0
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
HDLC line discipline: version $Revision: 3.7 $, maxframe=4096
N_HDLC line discipline registered.
cmpci: version $Revision: 6.16 $ time 20:07:09 Oct 10 2003
cmpci: found CM8738 adapter at io 0xe400 irq 16
cmpci: chip version = 055
bash-2.05a#





