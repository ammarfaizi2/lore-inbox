Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287518AbRLaNuj>; Mon, 31 Dec 2001 08:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287519AbRLaNua>; Mon, 31 Dec 2001 08:50:30 -0500
Received: from mout0.freenet.de ([194.97.50.131]:30598 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S287518AbRLaNuY>;
	Mon, 31 Dec 2001 08:50:24 -0500
Message-ID: <3C306CB6.867B071@mailnet.de>
Date: Mon, 31 Dec 2001 14:48:38 +0100
From: pil@mailnet.de
X-Mailer: Mozilla 4.79C-pil. [en] (X11; U; Linux 2.4.17 i586)
X-Accept-Language: en, en-US, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: HFS-Bug in 2.4.17
Content-Type: multipart/mixed;
 boundary="------------0A483BF81CC122B9EA34C439"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0A483BF81CC122B9EA34C439
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

Here is the next one:
You can recreate the bug if you have a kernel with modules support for
hfs-format, mount a hfs formated floppy and try to move a directory into
another directory on that floppy. You'll get a segmentation fault and an
uninterruptible sleep for the mount PID.
You cannot use or unmount the drive again.

Regards

Wolfgang Pichler
--------------0A483BF81CC122B9EA34C439
Content-Type: text/plain; charset=us-ascii;
 name="report"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="report"




syslog
Dec 31 11:33:12 pc kernel: invalid operand: 0000
Dec 31 11:33:12 pc kernel: CPU:    0
Dec 31 11:33:12 pc kernel: EIP:    0010:[<c88abfb4>]    Not tainted
Dec 31 11:33:12 pc kernel: EFLAGS: 00010246
Dec 31 11:33:12 pc kernel: eax: 00000000   ebx: c18b6f40   ecx: c42faa00   edx: 00000001
Dec 31 11:33:12 pc kernel: esi: 00000002   edi: c42fa820   ebp: c42faa20   esp: c19c9ec4
Dec 31 11:33:12 pc kernel: ds: 0018   es: 0018   ss: 0018
Dec 31 11:33:12 pc kernel: Process mv (pid: 943, stackpage=c19c9000)
Dec 31 11:33:12 pc kernel: Stack: c18b5c5c ffffffea c2129a9c 00000000 00000001 00000000 c4
2faa00 c42fa200 
Dec 31 11:33:12 pc kernel:        00000000 00005b0e 73081300 67657661 9e656d61 9ee8c19c 9a
20c19c a800c212 
Dec 31 11:33:12 pc kernel:        a859c42f e780c88a c013c6b0 c0137074 c2129a20 c18b6940 c1
8b5be0 c19c45e0 
Dec 31 11:33:12 pc kernel: Call Trace: [d_instantiate+16/48] [vfs_rename_dir+1004/1204] [v
fs_rename+46/136] [sys_rename+402/544] [system_call+51/64] 
Dec 31 11:33:12 pc kernel: 
Dec 31 11:33:12 pc kernel: Code: 0f 0b ff 03 8b 53 08 66 c7 42 34 00 00 a1 30 a9 24 c0 89 
42

cat /proc/version
Linux version 2.4.17 (root@pc) (gcc version 2.95.2 19991024 (release)) #1 Wed Dec 26 10:42:01 CET 2001

cat /proc/modules
hfs                    73552   0 (autoclean)
vfat                    9200   0 (autoclean)
fat                    28928   0 (autoclean) [vfat]
floppy                 45712   0 (autoclean)
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
loop                    7808   0 (unused)
sr_mod                 12032   0 (unused)
sg                     23520   0 (unused)
scsi_mod               79072   3 [ide-scsi sr_mod sg]



su1 lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8501 (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
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
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

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



cat /proc/cpuinfo
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





--------------0A483BF81CC122B9EA34C439--


