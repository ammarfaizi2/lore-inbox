Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261867AbSJ2AQ7>; Mon, 28 Oct 2002 19:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbSJ2AQ6>; Mon, 28 Oct 2002 19:16:58 -0500
Received: from mail.lordy.de ([193.17.17.196]:43193 "HELO mail.lordy.de")
	by vger.kernel.org with SMTP id <S261867AbSJ2AQl>;
	Mon, 28 Oct 2002 19:16:41 -0500
Message-Id: <5.1.0.14.2.20021029011326.024610e0@mail.lordy.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 29 Oct 2002 01:22:56 +0100
To: linux-kernel@vger.kernel.org
From: Steve <steve@azzkikr.net>
Subject: PROBLEM: klogd crashed
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is my first "bug" report so please be understanding if it contains errors.

BUG REPORT:

1. klogd crashes on heavy write usage to ext3 filesystem

2. This problem occured when I was moving a lot of data from one system to
the other using scp. I copied about 13 GB of data when I came across this
message and my scp stalled. This is what syslog said:

Oct 28 22:04:48 cartman kernel:  printing eip:
Oct 28 22:04:48 cartman kernel: c015a707
Oct 28 22:04:48 cartman kernel: Oops: 0000
Oct 28 22:04:48 cartman kernel: CPU:    0
Oct 28 22:04:48 cartman kernel: 
EIP:    0010:[journal_commit_transaction+551/3623]    Not tainted
Oct 28 22:04:48 cartman kernel: EFLAGS: 00010283
Oct 28 22:04:48 cartman kernel: eax: 0000033d   ebx: 00000000   ecx: 
df7b3c94   edx: d2dad4c0
Oct 28 22:04:48 cartman kernel: esi: d5cc87b0   edi: c0677240   ebp: 
d5cc8720   esp: df77be8c
Oct 28 22:04:48 cartman kernel: ds: 0018   es: 0018   ss: 0018
Oct 28 22:04:48 cartman kernel: Process kjournald (pid: 106, 
stackpage=df77b000)
Oct 28 22:04:48 cartman kernel: Stack: df7b3c50 df7b3c00 df7b3c00 00000000 
00000000 c01f9ca0 d39cac40 df7b3c94
Oct 28 22:04:48 cartman kernel:        df7b3c50 00000000 00000000 00000000 
00000000 d380a630 d5cc84e0 00000823
Oct 28 22:04:48 cartman kernel:        d2dad4c0 d2dcc640 d2deb3c0 d396c7c0 
d38744c0 d2dad3c0 d3494140 d2e673c0
Oct 28 22:04:48 cartman kernel: Call 
Trace:    [ip_local_deliver_finish+0/304] [kjournald+278/432] 
[commit_timeout+0/16] [kernel_thr
ead+40/64]
Oct 28 22:04:48 cartman kernel:
Oct 28 22:04:48 cartman kernel: Code: 8b 43 18 a8 04 75 42 a8 02 74 15 ff 
43 10 8b 54 24 30 8d 44

3. klogd, ext3

4. 2.4.19

5. N/A

6. N/A

7.
PWD=/root
PS1=\h:\w\$
USER=root
MAIL=/var/mail/root
LOGNAME=root
SHLVL=1
SHELL=/bin/bash
HOME=/root
TERM=vt100
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/X11
SSH_TTY=/dev/pts/1
_=/usr/bin/env
OLDPWD=/

7.1.
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
No Modules loaded

7.2.
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1311.719

7.3.
No modules used

7.4.
cartman:~# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
02f8-02ff : serial(set)
03c0-03df : vga+
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
7000-703f : Promise Technology, Inc. 20265
   7000-7007 : ide0
   7008-700f : ide1
   7010-703f : PDC20265
7400-7403 : Promise Technology, Inc. 20265
   7402-7402 : ide1
7800-7807 : Promise Technology, Inc. 20265
   7800-7807 : ide1
8000-8003 : Promise Technology, Inc. 20265
   8002-8002 : ide0
8400-8407 : Promise Technology, Inc. 20265
   8400-8407 : ide0
8800-887f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
   8800-887f : 00:0d.0
9000-900f : Promise Technology, Inc. 20269
   9000-9007 : ide2
   9008-900f : ide3
9400-9403 : Promise Technology, Inc. 20269
   9402-9402 : ide3
9800-9807 : Promise Technology, Inc. 20269
   9800-9807 : ide3
a000-a003 : Promise Technology, Inc. 20269
   a002-a002 : ide2
a400-a407 : Promise Technology, Inc. 20269
   a400-a407 : ide2
d000-d01f : VIA Technologies, Inc. UHCI USB (#2)
d400-d41f : VIA Technologies, Inc. UHCI USB
d800-d80f : VIA Technologies, Inc. Bus Master IDE
e200-e27f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
e800-e80f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]

cartman:~# cat /proc/iomem
00000000-0009d7ff : System RAM
0009d800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c9fff : Extension ROM
000cc000-000ce7ff : Extension ROM
000d0000-000d07ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffebfff : System RAM
   00100000-0024efae : Kernel code
   0024efaf-002a79a3 : Kernel data
1ffec000-1ffeefff : ACPI Tables
1ffef000-1fffefff : reserved
1ffff000-1fffffff : ACPI Non-volatile Storage
e1800000-e181ffff : Promise Technology, Inc. 20265
e2000000-e200007f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
e2800000-e2ffffff : S3 Inc. 86c764/765 [Trio32/64/64V+]
e3000000-e3003fff : Promise Technology, Inc. 20269
e4000000-e7ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
ffff0000-ffffffff : reserved

7.5.
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
         Subsystem: Asustek Computer, Inc.: Unknown device 8042
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 8
         Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [a0] AGP version 2.0
                 Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] 
(prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000e000-0000dfff
         Memory behind bridge: e3f00000-e3efffff
         Prefetchable memory behind bridge: e4000000-e3ffffff
         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 40)
         Subsystem: Asustek Computer, Inc.: Unknown device 8042
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Region 4: I/O ports at d800 [size=16]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 
00 [UHCI])
         Subsystem: Unknown device 0925:1234
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin D routed to IRQ 9
         Region 4: I/O ports at d400 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 
00 [UHCI])
         Subsystem: Unknown device 0925:1234
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin D routed to IRQ 9
         Region 4: I/O ports at d000 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
         Subsystem: Asustek Computer, Inc.: Unknown device 8042
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin ? routed to IRQ 9
         Capabilities: [68] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown 
device 4d69 (rev 02) (prog-if 85)
         Subsystem: Promise Technology, Inc.: Unknown device 4d68
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (1000ns min, 4500ns max), cache line size 08
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at a400 [size=8]
         Region 1: I/O ports at a000 [size=4]
         Region 2: I/O ports at 9800 [size=8]
         Region 3: I/O ports at 9400 [size=4]
         Region 4: I/O ports at 9000 [size=16]
         Region 5: Memory at e3000000 (32-bit, non-prefetchable) [size=16K]
         Expansion ROM at <unassigned> [disabled] [size=16K]
         Capabilities: [60] Power Management version 1
                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] 
(prog-if 00 [VGA])
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 5
         Region 0: Memory at e2800000 (32-bit, non-prefetchable) [size=8M]
         Expansion ROM at 000c0000 [disabled] [size=64K]

00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] 
(rev 78)
         Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC 
Management NIC
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2500ns min, 2500ns max), cache line size 08
         Interrupt: pin A routed to IRQ 9
         Region 0: I/O ports at 8800 [size=128]
         Region 1: Memory at e2000000 (32-bit, non-prefetchable) [size=128]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 
(rev 02)
         Subsystem: Promise Technology, Inc.: Unknown device 4d33
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at 8400 [size=8]
         Region 1: I/O ports at 8000 [size=4]
         Region 2: I/O ports at 7800 [size=8]
         Region 3: I/O ports at 7400 [size=4]
         Region 4: I/O ports at 7000 [size=64]
         Region 5: Memory at e1800000 (32-bit, non-prefetchable) [size=128K]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [58] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

7.6.
No SCSI devices available

7.7.
N/A

Best regards,
Steve

