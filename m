Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUKGM0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUKGM0P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 07:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbUKGM0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 07:26:15 -0500
Received: from newbie.network.my-ct.de ([82.211.58.6]:61861 "HELO
	mail.my-ct.de") by vger.kernel.org with SMTP id S261586AbUKGMZp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 07:25:45 -0500
Message-ID: <418E14DF.7050206@my-ct.de>
Date: Sun, 07 Nov 2004 13:28:15 +0100
From: Sebastian Epple <sebbi@my-ct.de>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: ESTABLISHED connections turn status to CLOSE_WAIT
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem: ESTABLISHED connections turn status to CLOSE_WAIT


Description:
We run psyBNC software on 2.4 kernels without any problems.
On kernel 2.6.8.1 all connections psyBNC establishes turn status to 
CLOSE_WAIT (I figured out that this occurs after something does not work 
regular, e.g. some nameserver or irc server is not responsing or the 
server gets a denial of service attack.)
All connections of the process turn to CLOSE_WAIT, a SIGHUP does not 
help, just restarting the psyBNC software does help.


Keywords: TCP/IP, Sockets, Networking


ra:~# cat /proc/version
Linux version 2.6.8.1-ha-lc (root@newnew) (gcc version 2.95.4 20011002 
(Debian prerelease)) #1 Sun Oct 17 19:07:39 CEST 2004


Example program is psyBNC2.3.2-4, available at http://www.psychoid.net/


ra:~# sh ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux ra 2.6.8.1-ha-lc #1 Sun Oct 17 19:07:39 CEST 2004 i686 GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
util-linux             2.12
mount                  2.12
modutils               2.4.26
e2fsprogs              1.35
xfsprogs               2.6.20
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1


ra:~# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 7
cpu MHz         : 2412.580
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 4767.74


The kernel was built without module support for security reasons.


ra:~# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
4000-407f : 0000:00:1f.0
4080-40bf : 0000:00:1f.0
5000-501f : 0000:00:1f.3
c000-c0ff : 0000:01:05.0
   c000-c0ff : 8139too
c400-c43f : 0000:01:05.1
d000-d01f : 0000:00:1d.1
d400-d41f : 0000:00:1d.2
d800-d81f : 0000:00:1d.0
e000-e0ff : 0000:00:1f.5
e400-e43f : 0000:00:1f.5
f000-f00f : 0000:00:1f.1
   f000-f007 : ide0
   f008-f00f : ide1


ra:~# cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-3f7effff : System RAM
   00100000-002fdcdf : Kernel code
   002fdce0-003a9dff : Kernel data
3f7f0000-3f7f2fff : ACPI Non-volatile Storage
3f7f3000-3f7fffff : ACPI Tables
3f800000-3fffffff : reserved
40000000-400003ff : 0000:00:1f.1
d0000000-dfffffff : 0000:00:00.0
e0000000-e7ffffff : 0000:00:02.0
e8000000-e80000ff : 0000:01:05.0
   e8000000-e80000ff : 8139too
e8100000-e817ffff : 0000:00:02.0
e8180000-e81803ff : 0000:00:1d.7
e8181000-e81811ff : 0000:00:1f.5
e8182000-e81820ff : 0000:00:1f.5
fec00000-ffffffff : reserved


ra:~# lspci -vvv
0000:00:00.0 Host bridge: Intel Corp. 82845G/GL[Brookdale-G]/GE/PE DRAM 
Controller/Host-Hub Interface (rev 03)
         Subsystem: Giga-byte Technology GA-8PE667 Ultra
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Region 0: Memory at d0000000 (32-bit, prefetchable) [size=256M]
         Capabilities: [e4] #09 [1105]

0000:00:02.0 VGA compatible controller: Intel Corp. 
82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics Device (rev 03) 
(prog-if 00 [VGA])
         Subsystem: Giga-byte Technology: Unknown device 2562
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 12
         Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
         Region 1: Memory at e8100000 (32-bit, non-prefetchable) [size=512K]
         Capabilities: [d0] Power Management version 1
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 02) (prog-if 00 [UHCI])
         Subsystem: Giga-byte Technology: Unknown device 24c2
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 12
         Region 4: I/O ports at d800 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
         Subsystem: Giga-byte Technology: Unknown device 24c2
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin B routed to IRQ 5
         Region 4: I/O ports at d000 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 02) (prog-if 00 [UHCI])
         Subsystem: Giga-byte Technology: Unknown device 24c2
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin C routed to IRQ 12
         Region 4: I/O ports at d400 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 
2.0 EHCI Controller (rev 02) (prog-if 20 [EHCI])
         Subsystem: Giga-byte Technology: Unknown device 5006
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin D routed to IRQ 11
         Region 0: Memory at e8180000 (32-bit, non-prefetchable) [size=1K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 82) (prog-if 
00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
         I/O behind bridge: 0000c000-0000cfff
         Memory behind bridge: e8000000-e80fffff
         Prefetchable memory behind bridge: fff00000-000fffff
         BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) LPC 
Bridge (rev 02)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) 
UltraATA-100 IDE Controller (rev 02) (prog-if 8a [Master SecP PriP])
         Subsystem: Giga-byte Technology GA-8PE667 Ultra
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 12
         Region 0: I/O ports at <unassigned>
         Region 1: I/O ports at <unassigned>
         Region 2: I/O ports at <unassigned>
         Region 3: I/O ports at <unassigned>
         Region 4: I/O ports at f000 [size=16]
         Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
SMBus Controller (rev 02)
         Subsystem: Giga-byte Technology GA-8PE667 Ultra
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin B routed to IRQ 5
         Region 4: I/O ports at 5000 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 02)
         Subsystem: Giga-byte Technology GA-8PE667 Ultra
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin B routed to IRQ 5
         Region 0: I/O ports at e000 [size=256]
         Region 1: I/O ports at e400 [size=64]
         Region 2: Memory at e8181000 (32-bit, non-prefetchable) [size=512]
         Region 3: Memory at e8182000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (8000ns min, 16000ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at c000 [size=256]
         Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:05.1 Modem: Realtek Semiconductor Co., Ltd. SmartLAN56 56K Modem 
(prog-if 00 [Generic])
         Subsystem: Realtek Semiconductor Co., Ltd. SmartLAN56 56K Modem
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Interrupt: pin B routed to IRQ 9
         Region 0: I/O ports at c400 [size=64]
         Capabilities: [48] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=55mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-


Kernel was built without SCSI support.



-- 
Sebastian Epple

Epple IT - concept Together

Kesslerstr. 65-69
D-73765 Neuhausen

fon: +49 (0)7158 98115 - 3
fax: +49 (0)7158 98115 - 9

epple@my-ct.de
http://www.my-ct.de
