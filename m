Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318352AbSHEJ1n>; Mon, 5 Aug 2002 05:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318353AbSHEJ1n>; Mon, 5 Aug 2002 05:27:43 -0400
Received: from mout1.freenet.de ([194.97.50.132]:61073 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S318352AbSHEJ1k>;
	Mon, 5 Aug 2002 05:27:40 -0400
Message-ID: <3D4E435B.1EE20956@mailnet.de>
Date: Mon, 05 Aug 2002 11:20:27 +0200
From: pil@mailnet.de
X-Mailer: Mozilla 4.79C-pil. [en] (X11; U; Linux 2.4.19 i586)
X-Accept-Language: en, en-US, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: HFS-Bug in 2.4.19
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is my 4th report since about 2.4.8:

You can reproduce the bug in a few steps if you have a kernel with
modules support for hfs.

1. Take a well formated hfs-floppy and mount the floppy

2. cd to the floppy and make a directory b 

3. rm -r b

4. You'll get the following error message:
rm: cannot remove directory `b/.finderinfo': Operation not permitted
rm: cannot remove directory `b/.resource': Operation not permitted

5.You'll get a segmentation fault and an uninterruptible sleep for the
mount PID. You cannot use or unmount the drive again.

Regards

Wolfgang Pichler


syslog
Aug  5 11:07:51 pc kernel: kernel BUG in header file at line 247
Aug  5 11:07:51 pc kernel: kernel BUG at panic.c:141!
Aug  5 11:07:51 pc kernel: invalid operand: 0000
Aug  5 11:07:51 pc kernel: CPU:    0
Aug  5 11:07:51 pc kernel: EIP:    0010:[__out_of_line_bug+15/36]    Not
tainted
Aug  5 11:07:51 pc kernel: EFLAGS: 00010282
Aug  5 11:07:51 pc kernel: eax: 00000026   ebx: c7526b40   ecx:
c387a000   edx: c64bddc0
Aug  5 11:07:51 pc kernel: esi: 00000001   edi: c5667e00   ebp:
c75265c0   esp: c387bf10
Aug  5 11:07:51 pc kernel: ds: 0018   es: 0018   ss: 0018
Aug  5 11:07:51 pc kernel: Process rm (pid: 425, stackpage=c387b000)
Aug  5 11:07:51 pc kernel: Stack: c01e2660 000000f7 c8883e1f 000000f7
c39f585c c3bdf2dc c75265c0 c3bdf260 
Aug  5 11:07:51 pc kernel:        c5667e20 c3b40420 00000000 c39f57e0
c3b40400 0000bf07 63010200 00017265 
Aug  5 11:07:51 pc kernel:        c6fa0000 0000c015 0000c410 a0000000
bf8cc676 65c0c387 0000c752 c013ab1e 
Aug  5 11:07:51 pc kernel: Call Trace:   
[snd-mixer-oss:__insmod_snd-mixer-oss_O/lib/modules/2.4.19/misc/snd-mixer-+-53729/96]
[vfs_rmdir+326/428] [sys_rmdir+187/252] [system_call+51/64]
Aug  5 11:07:51 pc kernel: 
Aug  5 11:07:51 pc kernel: Code: 0f 0b 8d 00 86 26 1e c0 eb fe 8d 74 26
00 8d bc 27 00 00 00


cat /proc/version
Linux version 2.4.19 (root@pc) (gcc version 2.95.4 (Debian prerelease))
#2 Son Aug 4 19:08:41 CEST 2002


cat /proc/modules
floppy                 45792   2 (autoclean)
snd-mixer-oss           4672   0 (autoclean)
hfs                    73600   1
ide-floppy             11712   0
ide-scsi                7584   0
scsi_mod               80824   1 [ide-scsi]
snd-seq-midi            3008   0 (autoclean) (unused)
snd-card-via686a        6688   0 (autoclean)
snd-ac97-codec         23200   0 (autoclean) [snd-card-via686a]
snd-mixer              22824   0 (autoclean) [snd-mixer-oss
snd-ac97-codec]
snd-pcm                29184   0 (autoclean) [snd-card-via686a]
snd-mpu401-uart         2256   0 (autoclean) [snd-card-via686a]
snd-rawmidi             9632   0 (autoclean) [snd-seq-midi
snd-mpu401-uart]
snd-seq-oss            23040   0 (unused)
snd-seq-midi-event      2880   0 [snd-seq-midi snd-seq-oss]
snd-seq                37584   0 [snd-seq-midi snd-seq-oss
snd-seq-midi-event]
snd-timer               8000   0 [snd-pcm snd-seq]
snd-seq-device          3740   0 [snd-seq-midi snd-rawmidi snd-seq-oss
snd-seq]
snd                    31136   1 [snd-mixer-oss snd-seq-midi
snd-card-via686a snd-ac97-codec snd-mixer snd-pcm snd-mpu401-uart
snd-rawmidi snd-seq-oss snd-seq-midi-event snd-seq snd-timer
snd-seq-device]
soundcore               3492   5 [snd]
vfat                    9276   0 (unused)
fat                    29336   0 [vfat]



su1 lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8501 [Apollo MVP4] (rev
02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8501 [Apollo MVP4 AGP]
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e4000000-e7ffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 14)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0


00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d000 [size=16]

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 06)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at d400 [size=32]

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 10)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 12)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 11
        Region 0: I/O ports at dc00 [size=256]
        Region 1: I/O ports at e000 [size=4]

00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
        Subsystem: Allied Telesyn International: Unknown device 2503
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at e400 [size=256]
        Region 1: Memory at e8000000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/i7
(rev 5b) (prog-if 00 [VGA])
        Subsystem: Trident Microsystems CyberBlade i7 AGP
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e5800000 (32-bit, non-prefetchable)
[size=8M]
        Region 1: Memory at e6000000 (32-bit, non-prefetchable)
[size=128K]
        Region 2: Memory at e5000000 (32-bit, non-prefetchable)
[size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [80] AGP version 1.0
                Status: RQ=32 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [90] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 451.042
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow
k6_mtrr
bogomips        : 897.84

