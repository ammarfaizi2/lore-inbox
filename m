Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271333AbTGQCti (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 22:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271339AbTGQCth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 22:49:37 -0400
Received: from adsl-68-73-202-190.dsl.sfldmi.ameritech.net ([68.73.202.190]:38980
	"EHLO omnium.barsetshire") by vger.kernel.org with ESMTP
	id S271333AbTGQCsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 22:48:36 -0400
Subject: ACPI oops 2.4.21-0.13mdkenterprise
From: Jonathan Moore <writetojon@hotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058411006.3740.1.camel@omnium.barsetshire>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2-3mdk 
Date: 16 Jul 2003 23:03:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am deeply stumped! I have two systems with identical Mandrake 9.1
installations. One Intel D815EEA2L2 wake on lan works. The other Intel
SE7501WV2 wake on lan does not work. 
When I echo 5 >/proc/acpi/sleep on the 7501 I get the following kernel oops.
Is there anything I need to do 'special' when I power down? Is the echo 5 necessary?
I don't need it on the D815 motherboard for the WOL to work. I am sure the hardware works because on one occasion
I managed to get it to WOL successfully but I admit I pressed the power button a few times in desperation (or something) needless to say I cannot repeat.

I'd appreciate a suggestion, I have run out of ideas.

Jonathan

uname -ar
Linux plumstead.barsetshire 2.4.21-0.13mdkenterprise #1 SMP Fri Mar 14 14:40:17
EST 2003 i686 unknown unknown GNU/Linux


Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c011817e
*pde = 00000000
Oops: 0002
nfsd af_packet floppy e1000 ext3 jbd nls_iso8859-1 nls_cp850 vfat fat supermount usb-storage scsi_mod usb-uhci usbcore rtc  
CPU:    0
EIP:    0010:[acpi_restore_pmd+14/48]    Not tainted
EIP:    0010:[<c011817e>]    Not tainted
EFLAGS: 00010002
EIP is at acpi_restore_pmd+0xe/0x30 [kernel]
eax: 00000000   ebx: 00000001   ecx: c0369174   edx: 00000000
esi: 00000005   edi: 00000005   ebp: f6c4ff28   esp: f6c4ff28
Jul 16 19:24:57 plumstead su(pam_unix)[1455]: session closed for user root
ds: 0018   es: 0018   ss: 0018
Process bash (pid: 1459, stackpage=f6c4f000)
Stack: f6c4ff34 c01b76a2 00000001 f6c4ff50 c01b7802 00000005 00000005 00000002 
       f6c4ff5c c403a760 f6c4ff78 c01b7d1e 00000005 00000a35 00000000 00000000 
       ffffffea 00000000 f6d6e2e0 ffffffea f6c4ff90 c016e750 f6d6e2e0 080e7808 
Call Trace:
 [acpi_system_restore_state+22/81] acpi_system_restore_state+0x16/0x51 [kernel]
 [<c01b76a2>] acpi_system_restore_state+0x16/0x51 [kernel]
 [acpi_suspend+82/158] acpi_suspend+0x52/0x9e [kernel]
 [<c01b7802>] acpi_suspend+0x52/0x9e [kernel]
 [acpi_system_write_sleep+123/136] acpi_system_write_sleep+0x7b/0x88 [kernel]
 [<c01b7d1e>] acpi_system_write_sleep+0x7b/0x88 [kernel]
 [proc_file_write+64/80] proc_file_write+0x40/0x50 [kernel]
 [<c016e750>] proc_file_write+0x40/0x50 [kernel]
 [sys_write+156/336] sys_write+0x9c/0x150 [kernel]
 [<c0146a8c>] sys_write+0x9c/0x150 [kernel]
 [system_call+51/56] system_call+0x33/0x38 [kernel]
 [<c010962f>] system_call+0x33/0x38 [kernel]

Code: 89 02 0f 20 d8 0f 22 d8 a1 24 e6 3d c0 31 d2 5d e9 0d 74 02 

The ethtool reports the following for the working motherboard

Settings for eth0:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 100Mb/s
        Duplex: Full
        Port: Twisted Pair
        PHYAD: 1
        Transceiver: internal
        Auto-negotiation: on
        Supports Wake-on: puag
        Wake-on: g
        Link detected: yes

and the following for the SE7501WV2 that does not work (NIC = 82546EB)
Settings for eth0:
	Supported ports: [ TP ]
	Supported link modes:   10baseT/Half 10baseT/Full 
	                        100baseT/Half 100baseT/Full 
	                        1000baseT/Full 
	Supports auto-negotiation: Yes
	Advertised link modes:  10baseT/Half 10baseT/Full 
	                        100baseT/Half 100baseT/Full 
	                        1000baseT/Full 
	Advertised auto-negotiation: Yes
	Speed: Unknown! (65535)
	Duplex: Unknown! (255)
	Port: Twisted Pair
	PHYAD: 0
	Transceiver: internal
	Auto-negotiation: on
	Supports Wake-on: umbg
	Wake-on: umbg
	Link detected: no

Here is the output of dmesg.

ing delay loop... 4784.12 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check reporting enabled on CPU#3.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU3: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Total of 4 processors activated (19123.40 BogoMIPS).
cpu_sibling_map[0] = 1
cpu_sibling_map[1] = 0
cpu_sibling_map[2] = 3
cpu_sibling_map[3] = 2
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 8-0, 8-16, 8-17, 8-18, 8-19, 8-20, 8-21, 8-22, 8-23, 9-0, 9-1, 9-2, 9-3, 9-4, 9-5, 9-6, 9-7, 9-8, 9-9, 9-10, 9-11, 9-12, 9-13, 9-14, 9-15, 9-16, 9-17, 9-18, 9-19, 9-20, 9-21, 9-22, 9-23, 10-0, 10-1, 10-2, 10-3, 10-4, 10-5, 10-6, 10-7, 10-8, 10-9, 10-10, 10-11, 10-12, 10-13, 10-14, 10-15, 10-16, 10-17, 10-18, 10-19, 10-20, 10-21, 10-22, 10-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 16.
number of IO-APIC #8 registers: 24.
number of IO-APIC #9 registers: 24.
number of IO-APIC #10 registers: 24.
testing the IO APIC.......................

IO APIC #8......
.... register #00: 08000000
.......    : physical APIC id: 08
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
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
 09 001 01  1    1    0   0   0    1    1    71
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

IO APIC #9......
.... register #00: 09000000
.......    : physical APIC id: 09
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 09000000
.......     : arbitration: 09
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #10......
.... register #00: 0A000000
.......    : physical APIC id: 0A
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 0A000000
.......     : arbitration: 0A
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
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
..... CPU clock speed is 2392.2878 MHz.
..... host bus clock speed is 132.9048 MHz.
cpu: 0, clocks: 1329048, slice: 265809
CPU0<T0:1329040,T1:1063216,D:15,S:265809,C:1329048>
cpu: 1, clocks: 1329048, slice: 265809
cpu: 3, clocks: 1329048, slice: 265809
cpu: 2, clocks: 1329048, slice: 265809
CPU1<T0:1329040,T1:797408,D:14,S:265809,C:1329048>
CPU2<T0:1329040,T1:531584,D:29,S:265809,C:1329048>
CPU3<T0:1329040,T1:265792,D:12,S:265809,C:1329048>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0xe)
All processors have done init_idle
ACPI: Subsystem revision 20030122
PCI: PCI BIOS revision 2.10 entry at 0xfdb75, last bus=4
PCI: Using configuration type 1
    ACPI-0552: *** Warning: Type override - [DEB_] had invalid type (Integer) for Scope operator, changed to (Scope)
    ACPI-0552: *** Warning: Type override - [MLIB] had invalid type (Integer) for Scope operator, changed to (Scope)
    ACPI-0552: *** Warning: Type override - [DATA] had invalid type (String) for Scope operator, changed to (Scope)
    ACPI-0552: *** Warning: Type override - [SIO_] had invalid type (String) for Scope operator, changed to (Scope)
    ACPI-0552: *** Warning: Type override - [LEDP] had invalid type (String) for Scope operator, changed to (Scope)
    ACPI-0552: *** Warning: Type override - [GPEN] had invalid type (String) for Scope operator, changed to (Scope)
    ACPI-0552: *** Warning: Type override - [GPST] had invalid type (String) for Scope operator, changed to (Scope)
    ACPI-0552: *** Warning: Type override - [WUES] had invalid type (String) for Scope operator, changed to (Scope)
    ACPI-0552: *** Warning: Type override - [WUSE] had invalid type (String) for Scope operator, changed to (Scope)
    ACPI-0552: *** Warning: Type override - [SBID] had invalid type (String) for Scope operator, changed to (Scope)
    ACPI-0552: *** Warning: Type override - [SWCE] had invalid type (String) for Scope operator, changed to (Scope)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 8)
schedule_task(): keventd has not started
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P5.P5P6._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P5.P5P7._PRT]
PCI: Probing PCI hardware
IOAPIC[0]: Set PCI routing entry (8-16 -> 0xa9 -> IRQ 16)
00:00:1d[A] -> 8-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (8-19 -> 0xb1 -> IRQ 19)
00:00:1d[B] -> 8-19 -> IRQ 19
Pin 8-16 already programmed
IOAPIC[0]: Set PCI routing entry (8-17 -> 0xb9 -> IRQ 17)
00:00:1f[B] -> 8-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (8-18 -> 0xc1 -> IRQ 18)
00:00:1f[C] -> 8-18 -> IRQ 18
Pin 8-19 already programmed
Pin 8-17 already programmed
Pin 8-18 already programmed
Pin 8-17 already programmed
Pin 8-19 already programmed
IOAPIC[1]: Set PCI routing entry (9-0 -> 0xc9 -> IRQ 24)
00:03:08[A] -> 9-0 -> IRQ 24
IOAPIC[1]: Set PCI routing entry (9-3 -> 0xd1 -> IRQ 27)
00:03:08[B] -> 9-3 -> IRQ 27
IOAPIC[1]: Set PCI routing entry (9-1 -> 0xd9 -> IRQ 25)
00:03:08[C] -> 9-1 -> IRQ 25
IOAPIC[1]: Set PCI routing entry (9-2 -> 0xe1 -> IRQ 26)
00:03:08[D] -> 9-2 -> IRQ 26
Pin 9-3 already programmed
IOAPIC[1]: Set PCI routing entry (9-4 -> 0xe9 -> IRQ 28)
00:03:09[B] -> 9-4 -> IRQ 28
IOAPIC[1]: Set PCI routing entry (9-5 -> 0x32 -> IRQ 29)
00:03:09[C] -> 9-5 -> IRQ 29
Pin 9-0 already programmed
Pin 9-4 already programmed
Pin 9-5 already programmed
Pin 9-0 already programmed
Pin 9-3 already programmed
IOAPIC[1]: Set PCI routing entry (9-6 -> 0x3a -> IRQ 30)
00:03:07[A] -> 9-6 -> IRQ 30
IOAPIC[1]: Set PCI routing entry (9-7 -> 0x42 -> IRQ 31)
00:03:07[B] -> 9-7 -> IRQ 31
IOAPIC[2]: Set PCI routing entry (10-0 -> 0x4a -> IRQ 48)
00:04:08[A] -> 10-0 -> IRQ 48
IOAPIC[2]: Set PCI routing entry (10-3 -> 0x52 -> IRQ 51)
00:04:08[B] -> 10-3 -> IRQ 51
IOAPIC[2]: Set PCI routing entry (10-1 -> 0x5a -> IRQ 49)
00:04:08[C] -> 10-1 -> IRQ 49
IOAPIC[2]: Set PCI routing entry (10-2 -> 0x62 -> IRQ 50)
00:04:08[D] -> 10-2 -> IRQ 50
Pin 10-3 already programmed
IOAPIC[2]: Set PCI routing entry (10-4 -> 0x6a -> IRQ 52)
00:04:09[B] -> 10-4 -> IRQ 52
IOAPIC[2]: Set PCI routing entry (10-5 -> 0x72 -> IRQ 53)
00:04:09[C] -> 10-5 -> IRQ 53
Pin 10-0 already programmed
Pin 10-4 already programmed
Pin 10-5 already programmed
Pin 10-0 already programmed
Pin 10-3 already programmed
Pin 10-2 already programmed
Pin 10-1 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Detected PS/2 Mouse Port.
pty: 1024 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH3: chipset revision 2
ICH3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x03a0-0x03a7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x03a8-0x03af, BIOS settings: hdc:DMA, hdd:pio
PDC20277: IDE controller at PCI slot 01:02.0
PDC20277: chipset revision 1
PDC20277: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0x1420-0x1427, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x1428-0x142f, BIOS settings: hdg:pio, hdh:pio
hdc: MATSHITADVD-ROM SR-8177, ATAPI CD/DVD-ROM drive
hde: Maxtor 6Y200P0, ATA DISK drive
blk: queue c042d8d8, I/O limit 4095Mb (mask 0xffffffff)
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x1400-0x1407,0x140a on irq 18
hde: host protected area => 1
hde: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(133)
Partition check:
 /dev/ide/host2/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 >
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 32768 buckets, 256Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 48k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Mounted devfs on /dev
Freeing unused kernel memory: 156k freed
Real Time Clock Driver v1.10e
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 15:05:31 Mar 14 2003
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0x3020, IRQ 16
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0x3000, IRQ 19
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usbdevfs: remount parameter error
Adding Swap: 811240k swap-space (priority -1)
SCSI subsystem driver Revision: 1.00
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
MSDOS FS: IO charset iso8859-1
MSDOS FS: Using codepage 850
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide2(33,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide2(33,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Intel(R) PRO/1000 Network Driver - version 4.4.19-k2
Copyright (c) 1999-2002 Intel Corporation.
eth0: Intel(R) PRO/1000 Network Connection
eth1: Intel(R) PRO/1000 Network Connection
inserting floppy driver for 2.4.21-0.13mdkenterprise
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
-- 
Jonathan Moore <writetojon@hotmail.com>
