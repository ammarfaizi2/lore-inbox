Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265478AbRGEXFv>; Thu, 5 Jul 2001 19:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbRGEXFm>; Thu, 5 Jul 2001 19:05:42 -0400
Received: from pD9E1E4C1.dip.t-dialin.net ([217.225.228.193]:14084 "HELO
	depressed.yi.org") by vger.kernel.org with SMTP id <S265478AbRGEXFb> convert rfc822-to-8bit;
	Thu, 5 Jul 2001 19:05:31 -0400
Message-ID: <200107060104210229.0A4FA5C3@mail.dep.inf>
X-Mailer: Calypso Version 3.20.02.00 (4)
Date: Fri, 06 Jul 2001 01:04:21 +0200
From: "Christian Rubbert" <christian@rubbert.de>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Kernel Panics because of sync() and IO ressources,
  Supposed to be fixed in 2.4.5pre9 ?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good Morning!

NOTE: Please CC answers/replies to my personal email account, because i can't keep track of all the stuff on linux-kernel, as i just started a new job. Thank you very much!

Ok i'll try to stick to the bug report form :)

PROBLEM: Kernel Panics since i switched to T-DSL, using masquadering. Supposed to be fixed in 2.4.5pre9 ?

Description:
I switched to DSL about 2 weeks ago, i got 3 NICs in that box one for the private net, one for the biz net and one for the DSL modem, using pppoe (not rp-pppoe). All three are Intel EtherExpress Pro 100+, two brand new ones and an older one (different size, same driver), but it happened with a Tulip card instead of the old Intel (which serves the modem) as well. The Kernel kept crashing with Kernel Panics, usually with Process: swapper (PID = 0), but when dnetc is running, it preferrable gives dnetc as process. It seems to occur only with masquadering in use.
I'm using Kernel 2.4.6 (it happened in 2.4.4, 2.4.5 and 2.4.5ac22 as well), because i thought those fixes in pre9 would od the trick:

-pre9:
 - make sure "sync()" doesn't effectively lock up the machine by
   overloading all the IO resources
 - fix up some network memory allocations that don't wan tto wait on IO.

it crashed only two times in a little more than 24 hours, which is really good.. I was happy for every hour uptime the days before :) I hope the other informations help you to find and fix the problem, i'll be happy to provide any other information needed.

Keywords: Kernel Panics, sync(), IO ressources
(i think ;)

root@router:~# cat /proc/version
Linux version 2.4.6 (root@router) (gcc version 2.95.2 19991024 (release)) #2 SMP Wed Jul 4 19:18:12 CEST 2001

Couldn't figure out how to do the oops tracing (it's late) and i can't provide a shell script/program which reproduces the crash unfortunately, it dies unexpectandly.

Environment:
Linux router 2.4.6 #2 SMP Wed Jul 4 19:18:12 CEST 2001 i686 unknown

Gnu C                  egcs-2.91.66
Gnu make               3.79
binutils               2.9.1.0.25
util-linux             2.11d
mount                  2.11d
modutils               2.4.6
e2fsprogs              1.22
reiserfsprogs          3.x.0j
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.1.3
ldd: version 1.9.9
Procps                 2.0.6
Net-tools              1.55
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         pppoe pppox ipt_TOS ipt_state ipt_REJECT ipt_LOG ipt_limit ipt_MASQUERADE iptable_mangle iptable_nat ip_conntrack iptable_filter ip_tables hisax isdn

root@router:~# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 0
cpu MHz         : 300.688
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 599.65

root@router:~# cat /proc/modules
pppoe                   8416   1 (autoclean)
pppox                   1664   1 (autoclean) [pppoe]
ipt_TOS                 1200   5 (autoclean)
ipt_state                896   5 (autoclean)
ipt_REJECT              3232   7 (autoclean)
ipt_LOG                 3600  14 (autoclean)
ipt_limit               1344  16 (autoclean)
ipt_MASQUERADE          1680   2 (autoclean)
iptable_mangle          2016   0 (autoclean) (unused)
iptable_nat            16464   0 (autoclean) [ipt_MASQUERADE]
ip_conntrack           16496   2 (autoclean) [ipt_state ipt_MASQUERADE iptable_nat]
iptable_filter          2048   0 (autoclean) (unused)
ip_tables              11104  11 [ipt_TOS ipt_state ipt_REJECT ipt_LOG ipt_limit ipt_MASQUERADE iptable_mangle iptable_nat iptable_filter]
hisax                 137104   2
isdn                  116592   3 [hisax]

root@router:~# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0340-0340 : HiSax hscx A fifo
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0740-075f : HiSax hscx A
0b40-0b40 : HiSax hscx B fifo
0cf8-0cff : PCI conf1
0f40-0f5f : HiSax hscx B
1340-1340 : HiSax isac fifo
1740-175f : HiSax isac
1b40-1b47 : avm cfg
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
e000-e01f : Intel Corporation 82371AB PIIX4 USB
e400-e43f : Intel Corporation 82557 [Ethernet Pro 100]
  e400-e43f : eepro100
e800-e81f : Intel Corporation 82557 [Ethernet Pro 100] (#2)
  e800-e81f : eepro100
ec00-ec3f : Intel Corporation 82557 [Ethernet Pro 100] (#3)
  ec00-ec3f : eepro100
f000-f00f : Intel Corporation 82371AB PIIX4 IDE

root@router:~# cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Extension ROM
000c9000-000c9fff : Extension ROM
000f0000-000fffff : System ROM
00100000-03ffffff : System RAM
  00100000-0020c459 : Kernel code
  0020c45a-0026815f : Kernel data
d0000000-d3ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
d4000000-d5ffffff : PCI Bus #01
  d4000000-d4ffffff : nVidia Corporation Riva TnT 128 [NV04]
d6000000-d6ffffff : PCI Bus #01
  d6000000-d6ffffff : nVidia Corporation Riva TnT 128 [NV04]
d8000000-d80fffff : Intel Corporation 82557 [Ethernet Pro 100]
d8100000-d81fffff : Intel Corporation 82557 [Ethernet Pro 100] (#2)
d8200000-d82fffff : Intel Corporation 82557 [Ethernet Pro 100] (#3)
d8300000-d8300fff : Intel Corporation 82557 [Ethernet Pro 100]
  d8300000-d8300fff : eepro100
d8301000-d8301fff : Intel Corporation 82557 [Ethernet Pro 100] (#3)
  d8301000-d8301fff : eepro100
d8302000-d8302fff : Intel Corporation 82557 [Ethernet Pro 100] (#2)
  d8302000-d8302fff : eepro100
ffff0000-ffffffff : reserved

lspci -vvv:
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: d4000000-d5ffffff
	Prefetchable memory behind bridge: d6000000-d6ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin D routed to IRQ 12
	Region 4: I/O ports at e000 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:09.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at d8300000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at e400 [size=64]
	Region 2: Memory at d8000000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0b.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 05)
	Subsystem: Intel Corporation EtherExpress PRO/100+
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d8302000 (32-bit, prefetchable) [size=4K]
	Region 1: I/O ports at e800 [size=32]
	Region 2: Memory at d8100000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d8301000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at ec00 [size=64]
	Region 2: Memory at d8200000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

01:00.0 VGA compatible controller: nVidia Corporation Riva TnT 128 [NV04] (rev 04) (prog-if 00 [VGA])
	Subsystem: Elsa AG Erazor II SGRAM
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at d4000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d6000000 (32-bit, prefetchable) [size=16M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 1.0
		Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


no SCSI Stuff :)

And here is the stuff i hand-copied from the screen, i hope there are no typos in it.

virtual address 00008ba7
*pde = 00000000
Oops = 0000
CPU = 0
EIP = 0010:[<c01c96c9>]
EFLAGS: 00010202

eax: c1569940 ebx: 00008ba7 ecx: 00000000 edx: 00068ba7
esi: c1b5ce80 edi: c15697e0 ebp: 00000060 esp: c0e41dd4
ds: 0018 es: 0018 ss: 0018

Process dnetc (pid: 2152, stackpage=c0e41000)

Stack: ffffff00 c01c976b c1b5ce80 ffffff00 c1b5ce80 c01c9d53 c1b5ce80 c11fa800
       c1b5ce80 0000000e c1b5ce80 ffffffe6 c01cc667 c1b5ce80 00000020 00000004
       c1979b20 0000000e c01d0cdd c1b5ce80 00000001 00000000 c1b5ce80 c01dabf0
      
Call Trace: [<c01c976b>] [<c01c9d53>] [<c01ccdd7>] [<c01d0cdd>] [<c01dabf0>] [<c01dacb0>] [<c01d1ef8>]
            [<c01d8240>] [<c01dabd2>] [<c01dabf0>] [<c01d829a>] [<c01d1ef8>] [<c01d8fd6>] [<c01d8240>] [<c01d7290>]
                                                                      ^ f or 1 ? (that's the f in the third entry, for those not using fixed width fonts :)
            [<c01d742d>] [<c01d7290>] [<c01d1ef8>] [<c01d70d6>] [<c01d7290>] [<c01cd59e>] [<c0116b8a>] [<c01085cb>]
            [<c0106d04>]

Code: 8b 1b 8b 42 70 83 f8 01 74 0b f0 ff 4a 70 0f 94 c0 84 c0 74
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing.

Well people, i really hope you can help me with that problem, i know that i'm not the onl one, a friend of mine has the same problem, and another guy in the adsl4linux Forum.
http://www.adsl4linux.de/forum/viewthread.php3?TID=147
He even has a screenshot of his kernel panic (this one has Process: swapper ;), look quite similar to mine.
http://www.homepages.lu/globi/panic.jpg

That's it, i'm going to bed.. Have fun dudes, and don't make me switch to *BSD ;)

mfg,
Christian Rubbert

