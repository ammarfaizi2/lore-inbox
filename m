Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283537AbRLMGug>; Thu, 13 Dec 2001 01:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283541AbRLMGu1>; Thu, 13 Dec 2001 01:50:27 -0500
Received: from mout1.freenet.de ([194.97.50.132]:6852 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S283537AbRLMGuK>;
	Thu, 13 Dec 2001 01:50:10 -0500
Message-ID: <3C184E22.A12C0941@mailnet.de>
Date: Thu, 13 Dec 2001 07:43:46 +0100
From: pil@mailnet.de
X-Mailer: Mozilla 4.79C-dsl. [en] (X11; U; Linux 2.4.16 i586)
X-Accept-Language: en, en-US, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: HFS-Bug in 2.4.16
Content-Type: multipart/mixed;
 boundary="------------BB2B175EA9B8FA9B8E3D8EF4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BB2B175EA9B8FA9B8E3D8EF4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,


You can recreate the bug if you have a kernel with modules support for
hfs-format, mount a hfs formated floppy and try to remove a file on that
floppy. You'll get a segmentation fault and an uninterruptible sleep for
the mount PID.
You cannot use or unmount the drive again. Because I've two floppy
drives I don't know if this is also the case if you have only one.

Regards

Wolfgang Pichler
--------------BB2B175EA9B8FA9B8E3D8EF4
Content-Type: text/plain; charset=us-ascii;
 name="report"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="report"





syslog

Dec 12 13:41:34 pc kernel: invalid operand: 0000
Dec 12 13:41:34 pc kernel: CPU:    0
Dec 12 13:41:34 pc kernel: EIP:    0010:[<c88abc0f>]    Not tainted
Dec 12 13:41:34 pc kernel: EFLAGS: 00010246
Dec 12 13:41:34 pc kernel: eax: 00000000   ebx: c4cf8a20   ecx: c5cb4220   edx: c022cac0
Dec 12 13:41:34 pc kernel: esi: 00000001   edi: c4431bc0   ebp: c39b9220   esp: c4625f2c
Dec 12 13:41:34 pc kernel: ds: 0018   es: 0018   ss: 0018
Dec 12 13:41:34 pc kernel: Process rm (pid: 1077, stackpage=c4625000)
Dec 12 13:41:34 pc kernel: Stack: ffffffff c2eb1420 c022cac0 c4625fa4 c5cb4220 00000000 c5cb4200 0000220d 
Dec 12 13:41:34 pc kernel:        74070200 63737063 00076e61 c8ab0000 cac0c013 ae20c022 1420c35a 2464c2eb 
Dec 12 13:41:34 pc kernel:        0000c88b c01368c7 c2eb1420 c022cac0 c022cac0 c022cac0 c3b66000 c01369b4 
Dec 12 13:41:34 pc kernel: Call Trace: [vfs_unlink+231/300] [sys_unlink+168/284] [system_call+51/64] 
Dec 12 13:41:34 pc kernel: 
Dec 12 13:41:34 pc kernel: Code: 0f 0b ff 03 8b 53 08 66 c7 42 34 00 00 a1 30 a9 24 c0 89 42 

proc/version

Linux version 2.4.16 (root@pc) (gcc version 2.95.2 19991024 (release)) #2 Thu Nov 29 11:22:10 CET 2001

Environment

proc/cpuinfo

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 451.037
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
bogomips        : 897.84

proc/modules


hfs                    73552   1 (autoclean)
vfat                    9200   0 (autoclean)
fat                    28896   0 (autoclean) [vfat]
floppy                 45808   2 (autoclean)
snd-pcm-oss            18208   0 (unused)
snd-pcm-plugin         14000   0 [snd-pcm-oss]
snd-mixer-oss           4832   0 [snd-pcm-oss]
snd-card-via686a        7152   0
snd-pcm                29216   0 [snd-pcm-oss snd-pcm-plugin snd-card-via686a]
snd-timer               8192   0 [snd-pcm]
snd-ac97-codec         24320   0 [snd-card-via686a]
snd-mixer              22896   0 [snd-mixer-oss snd-ac97-codec]
snd-mpu401-uart         2320   0 [snd-card-via686a]
snd-rawmidi             9344   0 [snd-mpu401-uart]
snd-seq-device          3824   0 [snd-rawmidi]
snd                    31568   1 [snd-pcm-oss snd-pcm-plugin snd-mixer-oss snd-card-via686a snd-pcm snd-timer snd-ac97-codec snd-mixer snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               3280   4 [snd]
ide-scsi                7472   0
loop                    7776   0 (unused)
sr_mod                 12032   0 (unused)
sg                     22528   0 (unused)
scsi_mod               78960   3 [ide-scsi sr_mod sg]


lspci -vvv



00:00.0 Host bridge: VIA Technologies, Inc. VT8501 (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32 set
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8501 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0 set
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e4000000-e7ffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 14)
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set
	Region 4: I/O ports at d000 [size=16]

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 06) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at d400 [size=32]

00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 06) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at d800 [size=32]

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 10)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 [Apollo Super AC97/Audio] (rev 12)
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 11
	Region 0: I/O ports at dc00 [size=256]
	Region 1: I/O ports at e000 [size=4]

00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RT8139 (rev 10)
	Subsystem: Allied Telesyn International: Unknown device 2503
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 min, 64 max, 32 set
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at e400 [size=256]
	Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME+
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/i7 (rev 5b) (prog-if 00 [VGA])
	Subsystem: Trident Microsystems: Unknown device 8400
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e5800000 (32-bit, non-prefetchable) [size=8M]
	Region 1: Memory at e6000000 (32-bit, non-prefetchable) [size=128K]
	Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [80] AGP version 1.0
		Status: RQ=32 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [90] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI+ D1+ D2+ PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--------------BB2B175EA9B8FA9B8E3D8EF4--


