Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268929AbUHUJMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268929AbUHUJMZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 05:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268932AbUHUJLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 05:11:54 -0400
Received: from mazurek.man.lodz.pl ([212.51.192.15]:8322 "EHLO
	mazurek.man.lodz.pl") by vger.kernel.org with ESMTP id S268928AbUHUJJU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 05:09:20 -0400
Date: Sat, 21 Aug 2004 11:09:07 +0200 (CEST)
From: Piotr Goczal <bilbo@mazurek.man.lodz.pl>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Promise Fast Track SX6000 i2o driver.
Message-ID: <Pine.LNX.4.58.0408211012500.2571@mazurek.man.lodz.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-mazurek.man.lodz.pl-MailScanner-Information: Please contact bilbo@man.lodz.pl
X-mazurek.man.lodz.pl-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is the report:

1. Short description: Promise Fast Track SX6000 i2o driver problem.

2. Full description:

I've found problem with Fast Track SX6000 and linux ver 2.4.22 and 2.6.7 
i2o drivers. With drivers from vendor web site everything works fine (but 
there aren't i2o drivers).
There is a few version of firmware for this controler.

With old version of SX6000 firmware (Bios version 1.1.0 (Build 15), 
Firmware 77RM) driver's found controler but it's hanging durring 
initialisation.

With new version of firmware (Bios version 1.20.0.27) driver doesn't 
recognise hardware at all. The problem is: Promise's changed PCI_CLASS 
identifier from 0x0e00 (I2O controler) to 0x0104 (RAID bus controller). 
I've tried simply change PCI_CLASS number in source and recompile it but 
it doesn't work good (driver recognised hardware but hung whole machine!).

Hardware is working fine because I've instaled win2k :-( on this machine 
and everthing seems to be working.

3. Keywords: Fast Track SX6000, i2o module, kernel version 2.6.7

4. Kernel version

[root@server SX6000]# cat /proc/version
Linux version 2.6.7-1.494.2.2 (bhcompile@tweety.build.redhat.com) (gcc 
version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 Tue Aug 3 09:39:58 EDT 2004

5. Opss: no opps

6. Example:

Old firmware:

[root@server SX6000]# modprobe -v i2o_block
insmod
/lib/modules/2.6.7-1.494.2.2/kernel/drivers/message/i2o/i2o_core.ko
i2o/iop0: Reset rejected, trying to clear
insmod
/lib/modules/2.6.7-1.494.2.2/kernel/drivers/message/i2o/i2o_block.ko

cat /var/log/messages

Aug 20 23:17:25 server kernel: I2O Core - (C) Copyright 1999 Red Hat
Software
Aug 20 23:17:25 server kernel: I2O: Event thread created as pid 2730
Aug 20 23:17:25 server kernel: i2o: Checking for PCI I2O controllers...
Aug 20 23:17:25 server kernel: PCI: Found IRQ 10 for device 0000:00:11.1
Aug 20 23:17:25 server kernel: PCI: Sharing IRQ 10 with 0000:00:07.2
Aug 20 23:17:25 server kernel: i2o: I2O controller on bus 0 at 137.
Aug 20 23:17:25 server kernel: I2O: Promise workarounds activated.
Aug 20 23:17:25 server kernel: i2o: PCI I2O controller at ED000000
size=4194304
Aug 20 23:17:25 server kernel: I2O: MTRR workaround for Intel i960
processor
Aug 20 23:17:25 server kernel: i2o/iop0: Installed at IRQ10
Aug 20 23:17:25 server kernel: i2o: 1 I2O controller found and
installed.
Aug 20 23:17:25 server kernel: Activating I2O controllers...
Aug 20 23:17:25 server kernel: This may take a few minutes if there are
many devices
Aug 20 23:17:27 server kernel: i2o/iop0: Reset rejected, trying to clear
Aug 20 23:17:32 server kernel: i2o/iop0: LCT has 4 entries.
Aug 20 23:17:32 server kernel: I2O Block Storage OSM v0.9
Aug 20 23:17:32 server kernel:    (c) Copyright 1999-2001 Red Hat
Software.
Aug 20 23:17:32 server kernel: i2o_block: registered device at major 80
Aug 20 23:17:32 server kernel: i2o_block: Checking for Boot device...
Aug 20 23:17:32 server kernel: i2o_block: Checking for I2O Block
devices...
Aug 20 23:17:32 server kernel: i2o_block: New device detected
Aug 20 23:17:32 server kernel:    Controller 0 Tid 11
Aug 20 23:17:34 server kernel: i2ob: Installing tid 11 device at unit 0
Aug 20 23:17:34 server kernel: i2o/hda: Max segments 0, queue depth 8,
byte limit 1024.
Aug 20 23:17:34 server kernel: i2o/hda: Disk Storage: 349044MB, 512 byte
sectors.
Aug 20 23:17:34 server kernel: i2o/hda: Maximum sectors/read set to 2.
Aug 20 23:17:40 server kernel:  i2o/hda:<4>i2o/iop0: Unsolicited message
reply sent to core!Message dumped to syslog
Aug 20 23:17:40 server kernel: i2o/iop0: Unsolicited message reply sent
to core!Message dumped to syslog
Aug 20 23:17:40 server kernel: I2O: Spurious reply to handler 3

New firmware:

[root@server linux]# modprobe -v i2o_block
insmod /lib/modules/2.6.7-1.494.2.2/kernel/drivers/message/i2o/i2o_core.ko
insmod 
/lib/modules/2.6.7-1.494.2.2/kernel/drivers/message/i2o/i2o_block.ko

dmesg

I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 2664
i2o: Checking for PCI I2O controllers...
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: registered device at major 80
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...

7. Enviroment

7.1 Software

[root@server SX6000]# /usr/src/linux/scripts/ver_linux |more
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux server 2.6.7-1.494.2.2 #1 Tue Aug 3 09:39:58 EDT 2004 i686 i686 i386 
GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12
mount                  2.12
module-init-tools      2.4.26
e2fsprogs              1.35
pcmcia-cs              3.2.7
quota-tools            3.10.
PPP                    2.4.2
isdn4k-utils           3.3
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.2.0
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         i2o_block i2o_core parport_pc lp parport autofs4 
sunrpc 3c59x microcode dm_mod usblp uhci_hcd radeon ipv6 ext3 jbd aic7xxx 
sd_mod scsi_mod

7.2 Processor information
[root@server root]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 802.053
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 mtrr pge mca cmov
pat pse36 mmx fxsr sse
bogomips        : 1585.15

7.3 Module information (from /proc/modules):

[root@server root]# cat /proc/modules
i2o_block 16225 2 - Loading 0x12924000
i2o_core 42289 1 i2o_block, Live 0x1296d000
radeon 113669 2 - Live 0x1298f000
ipv6 216325 10 - Live 0x129ae000
parport_pc 21249 1 - Live 0x1291d000
lp 9133 0 - Live 0x12841000
parport 35977 2 parport_pc,lp, Live 0x1292a000
autofs4 20677 0 - Live 0x128be000
sunrpc 141861 1 - Live 0x12949000
3c59x 33385 0 - Live 0x12913000
microcode 5601 0 - Live 0x12833000
dm_mod 47317 0 - Live 0x128c5000
usblp 10817 0 - Live 0x1282f000
uhci_hcd 28505 0 - Live 0x12839000
ext3 96937 3 - Live 0x12873000
jbd 66521 1 ext3, Live 0x12861000
aic7xxx 146841 0 - Live 0x12890000
sd_mod 17473 0 - Live 0x12829000
scsi_mod 105361 2 aic7xxx,sd_mod, Live 0x12846000

7.4 Loaded driver and hardware information

Old firmware:

[root@server root]# cat /proc/ioports

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
4000-403f : 0000:00:07.3
5000-501f : 0000:00:07.3
9000-9fff : PCI Bus #01
  9000-90ff : 0000:01:00.0
a000-afff : PCI Bus #02
  a000-a003 : 0000:02:01.0
  a004-a007 : 0000:02:00.0
  a008-a00f : 0000:02:00.0
  a010-a017 : 0000:02:00.0
  a018-a01b : 0000:02:00.0
  a01c-a01f : 0000:02:01.0
  a020-a02f : 0000:02:00.0
  a030-a037 : 0000:02:01.0
  a038-a03f : 0000:02:01.0
  a040-a047 : 0000:02:02.0
  a048-a04b : 0000:02:02.0
  a050-a05f : 0000:02:02.0
  a400-a40f : 0000:02:01.0
  a800-a807 : 0000:02:02.0
  ac00-ac03 : 0000:02:02.0
b000-b007 : 0000:00:0c.0
  b000-b007 : ide2
b400-b403 : 0000:00:0c.0
  b402-b402 : ide2
b800-b807 : 0000:00:0c.0
bc00-bc03 : 0000:00:0c.0
c000-c03f : 0000:00:0c.0
  c000-c007 : ide2
  c008-c00f : ide3
  c010-c03f : PDC20262
c400-c47f : 0000:00:0e.0
  c400-c47f : 0000:00:0e.0
c800-c81f : 0000:00:07.2
  c800-c81f : uhci_hcd
f000-f00f : 0000:00:07.1
  f000-f007 : ide0
  f008-f00f : ide1

[root@server root]# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cafff : Video ROM
000cc000-000cd7ff : Adapter ROM
000ce000-000d1fff : Adapter ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-002f7fff : Kernel code
  002f8000-0039abff : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
e0000000-e3ffffff : 0000:00:00.0
e4000000-e7ffffff : PCI Bus #01
  e4000000-e7ffffff : 0000:01:00.0
e8000000-e9ffffff : PCI Bus #01
  e9000000-e907ffff : 0000:01:00.0
ed000000-ed3fffff : 0000:00:11.1
ed400000-ed41ffff : 0000:00:0c.0
ed420000-ed42007f : 0000:00:0e.0
ffff0000-ffffffff : reserved

New firmare:

[root@server SX6000]# cat /proc/ioports |more
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
4000-403f : 0000:00:07.3
5000-501f : 0000:00:07.3
9000-9fff : PCI Bus #01
  9000-90ff : 0000:01:00.0
a000-afff : PCI Bus #02
b000-b007 : 0000:00:0c.0
  b000-b007 : ide2
b400-b403 : 0000:00:0c.0
  b402-b402 : ide2
b800-b807 : 0000:00:0c.0
bc00-bc03 : 0000:00:0c.0
c000-c03f : 0000:00:0c.0
  c000-c007 : ide2
  c008-c00f : ide3
  c010-c03f : PDC20262
c400-c47f : 0000:00:0e.0
  c400-c47f : 0000:00:0e.0
c800-c81f : 0000:00:07.2
  c800-c81f : uhci_hcd
f000-f00f : 0000:00:07.1
  f000-f007 : ide0
  f008-f00f : ide1

[root@server SX6000]# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cafff : Video ROM
000cc000-000cd7ff : Adapter ROM
000ce000-000d1fff : Adapter ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-002f7fff : Kernel code
  002f8000-0039abff : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
e0000000-e3ffffff : 0000:00:00.0
e4000000-e7ffffff : PCI Bus #01
  e4000000-e7ffffff : 0000:01:00.0
e8000000-ebffffff : 0000:00:14.1
ec000000-edffffff : PCI Bus #01
  ed000000-ed07ffff : 0000:01:00.0
f1000000-f101ffff : 0000:00:0c.0
f1020000-f102007f : 0000:00:0e.0
ffff0000-ffffffff : reserved

7.5 PCI information

Old firmware: 

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge 
(rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e0000000 (32-bit, prefetchable)
        Capabilities: [a0] AGP version 1.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- 
Rate=x1

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge 
(rev 03)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: e8000000-e9ffffff
        Prefetchable memory behind bridge: e4000000-e7ffffff
        Expansion ROM at 00009000 [disabled] [size=4K]
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) 
(prog-if 80
[Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at c800 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:0c.0 Unknown mass storage controller: Promise Technology, Inc. 20262 
(rev 01)        Subsystem: Promise Technology, Inc. Ultra66
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at b000 [size=ea000000]
        Region 1: I/O ports at b400 [size=4]
        Region 2: I/O ports at b800 [size=8]
        Region 3: I/O ports at bc00 [size=4]
        Region 4: I/O ports at c000 [size=64]
        Region 5: Memory at ed400000 (32-bit, non-prefetchable) 
[size=128K]
        Expansion ROM at 00010000 [disabled]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] 
(rev 24)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2500ns min, 2500ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at c400 [size=eb000000]
        Region 1: Memory at ed420000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 PCI bridge: Intel Corp. 80960RM [i960RM Bridge] (rev 02) (prog-if 
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size 02
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        Expansion ROM at 0000a000 [disabled] [size=4K]
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:11.1 I2O: Intel Corp. 80960RM [i960RM Microprocessor] (rev 02) (prog-if 
01)
        Subsystem: Promise Technology, Inc. SuperTrak SX6000 I2O CPU
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at ed000000 (32-bit, prefetchable) 
[size=ec000000]
        Expansion ROM at 00010000 [disabled]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R100 QD 
[Radeon 7200] (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Radeon 7000/Radeon
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), Cache Line Size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e4000000 (32-bit, prefetchable)
        Region 1: I/O ports at 9000 [size=256]
        Region 2: Memory at e9000000 (32-bit, non-prefetchable) 
[size=512K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- 
Rate=x1
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev 
01) (prog-if 85)
        Subsystem: Promise Technology, Inc. SuperTrak SX6000 IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 128 (1000ns min, 4500ns max), Cache Line Size 01
        Interrupt: pin A routed to IRQ 14
        Region 0: I/O ports at a008
        Region 1: I/O ports at a004 [size=4]
        Region 2: I/O ports at a010 [size=8]
        Region 3: I/O ports at a018 [size=4]
        Region 4: I/O ports at a020 [size=16]
        Region 5: Memory at <ignored> (32-bit, non-prefetchable)
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:01.0 RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev 
01) (prog-if 85)
        Subsystem: Promise Technology, Inc. SuperTrak SX6000 IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 128 (1000ns min, 4500ns max), Cache Line Size 01
        Interrupt: pin A routed to IRQ 14
        Region 0: I/O ports at a030
        Region 1: I/O ports at a01c [size=4]
        Region 2: I/O ports at a038 [size=8]
        Region 3: I/O ports at a000 [size=4]
        Region 4: I/O ports at a400 [size=16]
        Region 5: Memory at <ignored> (32-bit, non-prefetchable)
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:02.0 RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev 
01) (prog-if 85)
        Subsystem: Promise Technology, Inc. SuperTrak SX6000 IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 128 (1000ns min, 4500ns max), Cache Line Size 01
        Interrupt: pin A routed to IRQ 14
        Region 0: I/O ports at a800
        Region 1: I/O ports at ac00 [size=4]
        Region 2: I/O ports at a040 [size=8]
        Region 3: I/O ports at a048 [size=4]
        Region 4: I/O ports at a050 [size=16]
        Region 5: Memory at <ignored> (32-bit, non-prefetchable)
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

New firmware:

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge 
(rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e0000000 (32-bit, prefetchable)
        Capabilities: [a0] AGP version 1.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- 
Rate=x1
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge 
(rev 03)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: ec000000-edffffff
        Prefetchable memory behind bridge: e4000000-e7ffffff
        Expansion ROM at 00009000 [disabled] [size=4K]
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) 
(prog-if 80
[Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at c800 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:0c.0 Unknown mass storage controller: Promise Technology, Inc. 20262 
(rev 01)        Subsystem: Promise Technology, Inc. Ultra66
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 3
        Region 0: I/O ports at b000 [size=ef000000]
        Region 1: I/O ports at b400 [size=4]
        Region 2: I/O ports at b800 [size=8]
        Region 3: I/O ports at bc00 [size=4]
        Region 4: I/O ports at c000 [size=64]
        Region 5: Memory at f1000000 (32-bit, non-prefetchable) 
[size=128K]
        Expansion ROM at 00010000 [disabled]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] 
(rev 24)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2500ns min, 2500ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at c400 [size=ee000000]
        Region 1: Memory at f1020000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:14.0 PCI bridge: Intel Corp. 80960RM [i960RM Bridge] (rev 02) (prog-if 
00 [Normal decode])
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size 02
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        Expansion ROM at 0000a000 [disabled] [size=4K]
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:14.1 RAID bus controller: Intel Corp. 80960RM [i960RM Microprocessor] 
(rev 02) (prog-if 85)
        Subsystem: Promise Technology, Inc. SuperTrak SX6000 I2O CPU
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e8000000 (32-bit, prefetchable) 
[size=f0000000]
        Expansion ROM at 00010000 [disabled]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R100 QD 
[Radeon 7200] (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Radeon 7000/Radeon
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), Cache Line Size 08
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at e4000000 (32-bit, prefetchable)
        Region 1: I/O ports at 9000 [size=256]
        Region 2: Memory at ed000000 (32-bit, non-prefetchable) 
[size=512K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- 
Rate=x1
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

7.6 SCSI information

[root@server root]# cat /proc/scsi/scsi
Attached devices:

7.7 Other information

With old firmware durring booting kernel I've:

PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0
PCI: Cannot allocate resource region 0 of device 0000:02:00.0
PCI: Cannot allocate resource region 1 of device 0000:02:00.0
PCI: Cannot allocate resource region 2 of device 0000:02:00.0
PCI: Cannot allocate resource region 3 of device 0000:02:00.0
PCI: Cannot allocate resource region 4 of device 0000:02:00.0
PCI: Cannot allocate resource region 5 of device 0000:02:00.0
PCI: Cannot allocate resource region 0 of device 0000:02:01.0
PCI: Cannot allocate resource region 1 of device 0000:02:01.0
PCI: Cannot allocate resource region 2 of device 0000:02:01.0
PCI: Cannot allocate resource region 5 of device 0000:02:01.0
PCI: Cannot allocate resource region 2 of device 0000:02:02.0
PCI: Cannot allocate resource region 3 of device 0000:02:02.0
PCI: Cannot allocate resource region 4 of device 0000:02:02.0
PCI: Cannot allocate resource region 5 of device 0000:02:02.0
PCI: Failed to allocate mem resource #5:4000@0 for 0000:02:00.0
PCI: Failed to allocate mem resource #5:4000@0 for 0000:02:01.0
PCI: Failed to allocate mem resource #5:4000@0 for 0000:02:02.0
TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)

With new firmware there are not these messages.

8. Other notes

I can offer a root terminal access (ssh) to this machine if it could be 
usefull. There are no production services on this machine (yet until I 
will have SX6000 working) so it can be rebooted, oppsed, etc anytime.

Best regards

Piotr Goczal
