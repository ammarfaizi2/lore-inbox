Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268133AbRHWPA4>; Thu, 23 Aug 2001 11:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268145AbRHWPAr>; Thu, 23 Aug 2001 11:00:47 -0400
Received: from mail.skybert.no ([213.184.194.22]:54534 "EHLO romeo.skybert.no")
	by vger.kernel.org with ESMTP id <S268133AbRHWPAl>;
	Thu, 23 Aug 2001 11:00:41 -0400
Date: Thu, 23 Aug 2001 17:00:48 +0200 (CEST)
From: =?iso-8859-1?Q?Erik_Inge_Bols=F8?= <erik@tms.no>
To: <linux-kernel@vger.kernel.org>
cc: <mj@suse.cz>
Subject: [2.2 & 2.4] PCI trouble (no IRQ assigned to network card)
Message-ID: <Pine.LNX.4.30.0108231622360.20195-100000@romeo.skybert.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-AntiVirus: scanned for viruses by AMaViS 0.2.0-pre6-clm-rl-8 (http://amavis.org/)
X-AntiVirus: scanned for viruses by AMaViS 0.2.0-pre6-clm-rl-8 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary:
 No IRQ assigned to network card.

Full description:
 I recently thought to upgrade an old Digital Prioris LX 5150 server with
a Intel EtherExpress PRO/100+ network card, to speed it up a little for
backups. It is the only expansion card in this EISA/PCI-based box, Intel
82434LX chipset, 1995-era. Previously I'd used the built-in 10mbit Tulip
chip, which works fine still.
 On module load, I get the following:
"PCI: No IRQ known for interrupt pin A of device 00:07.0. Please try using
pci=biosirq."
 ...and the device fails to work.

Trying the suggested "pci=biosirq" causes an Oops too early to be logged.
I can try to capture it if there is interest.

There is no "PnP OS" or similar choice in the BIOS, and no option for
setting IRQs. All the built-in PCI peripherals work fine and have proper
IRQs.

Any suggestions for getting the card to work is welcome. I can run tests
if necessary. For the time being, I'm going back to the 10mbit card and
2.2.20pre9.

Kernel: 2.4.8ac9

Processor: Pentium 150 (family 5 model 2 stepping 12) w/f00f bug

$ ./dump_pirq
No PCI interrupt routing table was found.

No known PCI interrupt routers were found.

$ cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
02f8-02ff : serial(auto)
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cfb : PCI conf2
1000-103f : Intel Corporation 82557 [Ethernet Pro 100]
8000-80ff : Adaptec AHA-7850
8400-847f : Digital Equipment Corporation DECchip 21040 [Tulip]
  8400-847f : tulip

$ cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cc7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-001d814b : Kernel code
  001d814c-00215cbf : Kernel data
10000000-10000fff : Intel Corporation 82557 [Ethernet Pro 100]
10100000-101fffff : Intel Corporation 82557 [Ethernet Pro 100]
c0100000-c0100fff : Adaptec AHA-7850
  c0100000-c0100fff : aic7xxx
c0101000-c010107f : Digital Equipment Corporation DECchip 21040 [Tulip]
  c0101000-c010107f : tulip
fec00000-fecfffff : reserved
fee00000-feefffff : reserved
ffff7598-ffffffff : reserved

$ lspci -vvx
00:00.0 Host bridge: Intel Corporation 82434LX [Mercury/Neptune] (rev 11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
00: 86 80 a3 04 46 01 00 24 11 00 00 06 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.0 SCSI storage controller: Adaptec AHA-7850
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 1000ns max), cache line size 04
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 8000 [disabled] [size=256]
	Region 1: Memory at c0100000 (32-bit, non-prefetchable) [size=4K]
00: 04 90 78 50 16 01 80 02 00 00 00 01 04 40 00 00
10: 01 80 00 00 00 00 10 c0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 04 04

00:02.0 Non-VGA unclassified device: Intel Corporation 82375EB (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248
00: 86 80 82 04 07 00 00 02 03 00 00 00 00 f8 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.0 Ethernet controller: Digital Equipment Corporation DECchip 21040 [Tulip] (rev 24)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 8400 [size=128]
	Region 1: Memory at c0101000 (32-bit, non-prefetchable) [size=128]
00: 11 10 02 00 07 01 80 02 24 00 00 02 00 40 00 00
10: 01 84 00 00 00 10 10 c0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 01 00 00

00:04.0 IDE interface: CMD Technology Inc PCI0640 (rev 02) (prog-if 00 [])
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 14
00: 95 10 40 06 00 00 00 02 02 00 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0e 01 00 00

00:07.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 1000 [size=64]
	Region 2: Memory at 10100000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at 80000000 [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable+ DSel=0 DScale=2 PME-
00: 86 80 29 12 03 00 90 02 08 00 00 02 00 40 00 00
10: 00 00 00 10 01 10 00 00 00 00 10 10 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 0c 00
30: 00 00 00 80 dc 00 00 00 00 00 00 00 00 01 08 38

$ dmesg (a little pruned)
Linux version 2.4.8-ac9 (root@lear) (gcc version 2.95.2 19991024 (release)) #1 Thu Aug 23 10:32:11 CEST 2001
No local APIC present or hardware disabled
Kernel command line: BOOT_IMAGE=nyere ro root=801
Initializing CPU#0
Detected 150.344 MHz processor.
CPU: Before vendor init, caps: 000001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
Intel old style machine check architecture supported.
Intel old style machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 000001bf 00000000 00000000 00000000
CPU:     After generic, caps: 000001bf 00000000 00000000 00000000
CPU:             Common caps: 000001bf 00000000 00000000 00000000
CPU: Intel Pentium 75 - 200 stepping 0c
Checking 'hlt' instruction... OK.
PCI: PCI BIOS revision 2.00 entry at 0xfdabe, last bus=0
PCI: Using configuration type 2
PCI: Probing PCI hardware
SCSI subsystem driver Revision: 1.00
ahc_pci:0:1:0: Using left over BIOS settings
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec aic7850 SCSI adapter>
        aic7850: Single Channel A, SCSI Id=7, 3/255 SCBs

  Vendor: IBM       Model: DORS-32160        Rev: WABA
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: CD-ROM XM-5701TA  Rev: 3136
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: QUANTUM   Model: ATLAS IV 9 WLS    Rev: 0909
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:0:0:0: Tagged Queuing enabled.  Depth 8
scsi0:0:6:0: Tagged Queuing enabled.  Depth 8
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 6, lun 0
(scsi0:A:0): 10.000MB/s transfers (10.000MHz, offset 15)
SCSI device sda: 4226725 512-byte hdwr sectors (2164 MB)
Partition check:
 sda: sda1 sda2 sda3
(scsi0:A:6): 10.000MB/s transfers (10.000MHz, offset 15)
SCSI device sdb: 17942584 512-byte hdwr sectors (9187 MB)
 sdb: sdb1
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 5, lun 0
(scsi0:A:5): 10.000MB/s transfers (10.000MHz, offset 8)
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Enabling device 00:07.0 (0000 -> 0003)
PCI: No IRQ known for interrupt pin A of device 00:07.0. Please try using pci=biosirq.
eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:D0:B7:1D:9D:82, IRQ 0.
  Board assembly 721383-008, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).

$ sh ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux lear 2.4.8-ac9 #1 Thu Aug 23 10:32:11 CEST 2001 i586 unknown

Gnu C                  2.95.2
Gnu make               3.77
binutils               2.9.1.0.25
util-linux             2.10f
mount                  2.10f
modutils               2.4.7
e2fsprogs              1.14
PPP                    2.3.11
Linux C Library        x   1 root     root      4190668 Aug  6  1999 /lib/libc.so.6
Dynamic linker (ldd)   2.1.1
Procps                 2.0.2
Net-tools              1.52
Kbd                    0.99
Sh-utils               1.16
Modules Loaded         tulip serial

-- 
Erik I. Bolsø, Triangel Maritech Software AS
Tlf: 712 41 694		Mobil: 915 79 512


