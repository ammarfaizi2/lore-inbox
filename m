Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131460AbRDCMxm>; Tue, 3 Apr 2001 08:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131461AbRDCMxd>; Tue, 3 Apr 2001 08:53:33 -0400
Received: from mail.fh-wedel.de ([195.37.86.23]:47628 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id <S131460AbRDCMxU>;
	Tue, 3 Apr 2001 08:53:20 -0400
Date: Tue, 3 Apr 2001 14:52:19 +0200
From: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: Bugreport: Kernel 2.4.x crash
Message-ID: <20010403145219.A15009@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Kernel crash w/out error message or logfile entry

2. A Fileserver with an ABIT Hotrod 66 (htp366) controller will crash within
5-60 minutes after boot with a 2.4.x kernel. 2.2.x works fine. No other
exotic hardware. Another possibility might be Reiserfs, which I use for all
partitions except /.
I have no experience with kernel debugging, but so far, I have found no log
entry giving me a hint and the screen is blank after the crash. There might
have been some output before, but the machine is in the basement and too
important for excessive testing.
I have tried 2.4.2 and 2.4.3 once each.

3. ide, hpt366

4. 2.4.2, 2.4.3

5. -

6. -

7. All this information is taken from the running 2.2.18 Kernel.

7.1. sh /usr/src/linux/scripts/ver_linux
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux belfast 2.2.18 #1 Fri Feb 23 14:47:14 CET 2001 i586 unknown
Kernel modules         2.4.2
Gnu C                  2.95.3
Gnu Make               3.79.1
Binutils               2.11.90.0.1
Linux C Library        2.2.2
Dynamic linker         ldd (GNU libc) 2.2.2
Procps                 2.0.7
Mount                  2.11b
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         sb uart401 sound soundcore

7.2. cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 3
cpu MHz         : 200.459
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 399.76

7.3 cat /var/log/ksymoops/20010401164317.modules (2.4.3)
sb                      2128   0 (unused)
sb_lib                 33936   0 [sb]
uart401                 6352   0 [sb_lib]
sound                  56400   0 [sb_lib uart401]
soundcore               3792   5 [sb_lib sound]
raid1                  12784   0 (unused)
raid0                   3520   0 (unused)
md                     41056   0 [raid1 raid0]

7.4. cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0220-022f : soundblaster
02f8-02ff : serial(set)
0330-0333 : MPU-401 UART
03c0-03df : vga+
03e8-03ef : serial(auto)
03f6-03f6 : ide0
03f8-03ff : serial(set)
6100-6107 : ide2
6202-6202 : ide2
6400-6407 : ide3
6502-6502 : ide3
6700-677f : eth0
f000-f007 : ide0
f008-f00f : ide1

7.5 lspci -vvv
00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev
03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32

00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II]
(rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton
II] (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at f000

00:08.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366
(rev 01)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 6100
        Region 1: I/O ports at 6200
        Region 4: I/O ports at 6300

00:08.1 Unknown mass storage controller: Triones Technologies, Inc. HPT366
(rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 6400
        Region 1: I/O ports at 6500
        Region 4: I/O ports at 6600

00:0a.0 VGA compatible controller: S3 Inc. Trio 64V2/DX or /GX (rev 16)
(prog-if 00 [VGA])
        Subsystem: Elsa AG: Unknown device 0935
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e0000000 (32-bit, non-prefetchable)

00:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink]
(rev 74)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC
Management NIC
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at 6700
        Region 1: Memory at e4000000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable+ DSel=0 DScale=2 PME-
7.6. No SCSI

7.7. -

-- 
When your language is nowhere near Turing-complete, 
syntactic sugar can be your friend.
