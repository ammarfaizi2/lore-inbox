Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbULQO4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbULQO4c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 09:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbULQO4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 09:56:32 -0500
Received: from boa.mtg-marinetechnik.de ([62.153.155.10]:65006 "EHLO
	cascabel.mtg-marinetechnik.de") by vger.kernel.org with ESMTP
	id S261211AbULQOzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 09:55:14 -0500
Message-ID: <41C2F308.90102@mtg-marinetechnik.de>
Date: Fri, 17 Dec 2004 15:54:00 +0100
From: Richard Ems <richard.ems@mtg-marinetechnik.de>
Organization: MTG Marinetechnik GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, de, es
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       Feedback <feedback@suse.de>, edward_peng@dlink.com.tw
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Subject: PROBLEM: Network hang: "eth0: Tx timed out (f0080), is buffer
  full?"
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list!

[1.] One line summary of the problem:
Network hang: "eth0: Tx timed out (f0080), is buffer full?"


[2.] Full description of the problem/report:

We had to reboot a server twice after a network card hang.
The first time was after one day uptime.
The second time, yesterday, after 8 days uptime.
The server is a dual AMD Athlon(tm) MP 2200+ with 1 GB RAM and is 
running SuSE Linux 9.2.

There are 2 NIC's on this system, a 10/100 Mbit/s 3Com Corporation 
3c905C-TX/TX-M [Tornado] which is not being used and a D-Link System Inc 
DL2000-based Gigabit Ethernet card.
The problem seems to be the dl2k driver for this second NIC.
The last minutes previous to the network hang and system hard reset 
(local login is not possible because of nfs mounts hang) the following 
lines were logged in /var/log/messages:

Dec  8 10:36:55 urutu kernel: eth0: HostError! IntStatus 0002.
Dec  8 10:36:55 urutu kernel: klogd 1.4.1, ---------- state change 
----------
Dec  8 10:38:48 urutu kernel: nfs: server jupiter not responding, still 
trying
Dec  8 10:39:48 urutu kernel: nfs: server diablo not responding, still 
trying

Dec  8 10:40:21 urutu kernel: eth0: Tx timed out (f0080), is buffer full?
Dec  8 10:43:25 urutu kernel: NETDEV WATCHDOG: eth0: transmit timed out
Dec  8 10:43:25 urutu kernel: eth0: Tx timed out (d0080), is buffer full?
Dec  8 10:46:57 urutu kernel: NETDEV WATCHDOG: eth0: transmit timed out
Dec  8 10:46:57 urutu kernel: eth0: Tx timed out (b0080), is buffer full?

On another thread I read that doing a ifconfg eth? down and up again 
would be enough to regain connectivity again.
Also just ping flooding the card will hang it.
See http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=281819

The hardware wasn't changed the last months. The problem appeared after 
updating the 4th December from SuSE 9.0 (kernel 2.4.xx) to SuSE 9.2 
(kernel 2.6.8).

The card is configured as eth1 but the error above shows eth0! The 3Com 
card was detected as eth0 and it's down.

The dl2k driver was last updated 2002/10/03. I didn't find any 
maintainer listed in the Maintainers file.

Any idea what's happening? Should I go back to 2.4.xx? This is a 
production server with different people logged in using VNC, so testing 
changes is not so easy.


Many thanks, Richard





[3.] Keywords (i.e., modules, networking, kernel):
networking, d-link dl2k

[4.] Kernel version (from /proc/version):
Linux version 2.6.8-24.5-smp (geeko@buildhost) (gcc version 3.3.4 (pre 
3.3.5 20040809)) #1 SMP Wed Nov 17 11:10:06 UTC 2004

[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)
no oops

[6.] A small shell script or example program which triggers the
      problem (if possible)


[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux urutu 2.6.8-24.5-smp #1 SMP Wed Nov 17 11:10:06 UTC 2004 i686 
athlon i386 GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15.91.0.2
util-linux             2.12c
mount                  2.12c
module-init-tools      3.1-pre5
e2fsprogs              1.35
jfsutils               1.1.7
reiserfsprogs          3.6.18
reiser4progs           line
xfsprogs               2.6.13
PPP                    2.4.2
isdn4k-utils           3.5
nfs-utils              1.0.6
Linux C Library        x  1 root root 1359489 Oct  5 14:21 
/lib/tls/libc.so.6
Dynamic linker (ldd)   2.3.3
Linux C++ Library      5.0.7
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         nfsd exportfs autofs4 dl2k 3c59x edd joydev sg st 
sd_mod sr_mod scsi_mod ide_cd cdrom subfs amd_k7_agp agpgart hw_random 
evdevdm_mod usbcore ext3 jbd


[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) MP 2200+
stepping        : 1
cpu MHz         : 1800.416
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse pni syscall mp mmxext 3dnowext 3dnow
bogomips        : 3555.32

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) Processor
stepping        : 1
cpu MHz         : 1800.416
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse pni syscall mp mmxext 3dnowext 3dnow
bogomips        : 3596.28


[7.3.] Module information (from /proc/modules):
nfsd 117960 9 - Live 0xf919a000
exportfs 10368 1 nfsd, Live 0xf90fc000
autofs4 23940 1 - Live 0xf9165000
dl2k 27044 0 - Live 0xf915d000
3c59x 43432 0 - Live 0xf916c000
edd 14620 0 - Live 0xf90e2000
joydev 13760 0 - Live 0xf90f2000
sg 42528 0 - Live 0xf9132000
st 43164 0 - Live 0xf9126000
sd_mod 22144 0 - Live 0xf911f000
sr_mod 21156 0 - Live 0xf9118000
scsi_mod 121412 4 sg,st,sd_mod,sr_mod, Live 0xf913e000
ide_cd 44448 0 - Live 0xf910c000
cdrom 42652 2 sr_mod,ide_cd, Live 0xf9100000
subfs 12672 2 - Live 0xf90e7000
amd_k7_agp 11788 1 - Live 0xf8865000
agpgart 37804 1 amd_k7_agp, Live 0xf8873000
hw_random 9620 0 - Live 0xf883b000
evdev 13184 0 - Live 0xf8836000
dm_mod 63104 6 - Live 0xf8854000
usbcore 120164 1 - Live 0xf90a5000
ext3 128744 7 - Live 0xf9002000
jbd 76964 1 ext3, Live 0xf8840000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
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
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-10ff : 0000:00:08.0
   1000-10ff : dl2k
1410-1413 : 0000:00:00.0
2000-2fff : PCI Bus #01
   2000-20ff : 0000:01:05.0
3000-3fff : PCI Bus #02
   3000-307f : 0000:02:08.0
     3000-307f : 0000:02:08.0
8000-8003 : PM1a_EVT_BLK
8004-8005 : PM1a_CNT_BLK
8008-800b : PM_TMR
8020-8023 : GPE0_BLK
f000-f00f : 0000:00:07.1
   f000-f007 : ide0
   f008-f00f : ide1

# cat /proc/iomem
00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c87ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-3feeffff : System RAM
   00100000-0034888d : Kernel code
   0034888e-00416eff : Kernel data
3fef0000-3fefefff : ACPI Tables
3feff000-3fefffff : ACPI Non-volatile Storage
3ff00000-3fffffff : System RAM
f4000000-f40001ff : 0000:00:08.0
   f4000000-f40001ff : dl2k
f4100000-f5ffffff : PCI Bus #01
   f4100000-f4100fff : 0000:01:05.0
   f5000000-f5ffffff : 0000:01:05.0
     f5000000-f57effff : vesafb
f6000000-f60fffff : PCI Bus #02
   f6001000-f600107f : 0000:02:08.0
f6300000-f6300fff : 0000:00:00.0
f8000000-fbffffff : 0000:00:00.0
fec00000-fec07fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
0000:00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP 
[IGD4-2P] System Controller (rev 11)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 64
         Region 0: Memory at f8000000 (32-bit, prefetchable)
         Region 1: Memory at f6300000 (32-bit, prefetchable) [size=4K]
         Region 2: I/O ports at 1410 [disabled] [size=4]
         Capabilities: [a0] AGP version 2.0
                 Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                 Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- 
FW- Rate=x4

0000:00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP 
[IGD4-2P] AGP Bridge (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 99
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
         I/O behind bridge: 00002000-00002fff
         Memory behind bridge: f4100000-f5ffffff
         Prefetchable memory behind bridge: fff00000-000fffff
         Expansion ROM at 00002000 [disabled] [size=4K]
         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA 
(rev 04)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] 
IDE (rev 04) (prog-if 8a [Master SecP PriP])
         Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Region 4: I/O ports at f000 [size=16]

0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI 
(rev 03)
         Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:08.0 Ethernet controller: D-Link System Inc DL2000-based Gigabit 
Ethernet (rev 0c)
         Subsystem: D-Link System Inc DL2000-based Gigabit Ethernet
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (20000ns min, 2500ns max), cache line size 10
         Interrupt: pin A routed to IRQ 169
         Region 0: I/O ports at 1000
         Region 1: Memory at f4000000 (32-bit, non-prefetchable) [size=512]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI 
(rev 04) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=168
         I/O behind bridge: 00003000-00003fff
         Memory behind bridge: f6000000-f60fffff
         Prefetchable memory behind bridge: fff00000-000fffff
         Expansion ROM at 00003000 [disabled] [size=4K]
         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:01:05.0 VGA compatible controller: ATI Technologies Inc Rage XL AGP 
2X (rev 27) (prog-if 00 [VGA])
         Subsystem: ATI Technologies Inc Xpert 98 RXL AGP 2X
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 66 (2000ns min), cache line size 10
         Interrupt: pin A routed to IRQ 177
         Region 0: Memory at f5000000 (32-bit, non-prefetchable)
         Region 1: I/O ports at 2000 [size=256]
         Region 2: Memory at f4100000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [50] AGP version 1.0
                 Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- 
FW- Rate=<none>
         Capabilities: [5c] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M 
[Tornado] (rev 78)
         Subsystem: Tyan Computer Tiger MPX S2466 (3C920 Integrated Fast 
Ethernet Controller)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 80 (2500ns min, 2500ns max), cache line size 10
         Interrupt: pin A routed to IRQ 185
         Region 0: I/O ports at 3000
         Region 1: Memory at f6001000 (32-bit, non-prefetchable) [size=128]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)
(no scsi chip/card)

# cat /proc/scsi/scsi
Attached devices:

[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):

[X.] Other notes, patches, fixes, workarounds:


-- 
Richard Ems

MTG Marinetechnik GmbH
Wandsbeker Königstr. 62
22041 Hamburg
Telefon: +49 40 65803 312
TeleFax: +49 40 65803 392
mail: richard.ems@mtg-marinetechnik.de

