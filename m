Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280892AbRKOPQP>; Thu, 15 Nov 2001 10:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280897AbRKOPQI>; Thu, 15 Nov 2001 10:16:08 -0500
Received: from mout1.freenet.de ([194.97.50.132]:42189 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S280892AbRKOPPv>;
	Thu, 15 Nov 2001 10:15:51 -0500
Message-ID: <3BF3DB8A.CD1BBCE6@mailnet.de>
Date: Thu, 15 Nov 2001 16:13:14 +0100
From: pil@mailnet.de
X-Mailer: Mozilla 4.78C-pil. [en] (X11; U; Linux 2.4.10 i586)
X-Accept-Language: en, en-US, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: HFS-Bug in Kernel 2.4.12 and above
Content-Type: multipart/mixed;
 boundary="------------41D5228F8595820B0AEFED3B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------41D5228F8595820B0AEFED3B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

Kernel 2.4.12 is no more able to handle two floppy drives with hfs
formated floppies.

You can recreate the failure if you have two floppy drives, use Kernel
2.4.12 (and above) with loadable module support for hfs- and
vfat-floppies and try to mount the first one with a hfs formated floppy
inside. If you unmount the floppy drive again you will get a
segmentation fault and an uninterruptible sleep for the mount PID. You
cannot mount this drive again.

For all other see attached file 'report'.

Regards

Wolfgang Pichler
--------------41D5228F8595820B0AEFED3B
Content-Type: text/plain; charset=us-ascii;
 name="report"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="report"

ARM MFM AND FLOPPY DRIVERS
P:      Dave Gilbert
M:      linux@treblig.org
S:      Maintained



Kernel 2.4.12 is no more able to handle two floppy drives with hfs formated floppies.


You can recreate the failure if you have two floppy drives, use Kernel 2.4.12 with loadable module support for hfs- and vfat-floppies and try to mount the first one with a hfs formated floppy inside. If you unmount the floppy drive again you will get a segmentation fault and an uninterruptible sleep for the mount PID. You cannot mount this drive again.

The syslog message for the mount command is quiet normal:

Nov 15 13:23:43 pc kernel: VFS: Disk change detected on device fd(2,0)
Nov 15 13:23:46 pc kernel: FAT: bogus logical sector size 63222
Nov 15 13:23:46 pc kernel: VFS: Can't find a valid FAT filesystem on dev 02:00.

The syslog message for the umount-command is:

Nov 15 13:24:10 pc kernel: invalid operand: 0000
Nov 15 13:24:10 pc kernel: CPU:    0
Nov 15 13:24:10 pc kernel: EIP:    0010:[invalidate_bdev+145/292]    Not tainted
Nov 15 13:24:10 pc kernel: EFLAGS: 00013246
Nov 15 13:24:10 pc kernel: eax: 00000000   ebx: c548ff00   ecx: c777d23c   edx: 00000200
Nov 15 13:24:10 pc kernel: esi: 00000001   edi: c7317720   ebp: 00000000   esp: c57bff00
Nov 15 13:24:10 pc kernel: ds: 0018   es: 0018   ss: 0018
Nov 15 13:24:10 pc kernel: Process umount (pid: 246, stackpage=c57bf000)
Nov 15 13:24:10 pc kernel: Stack: c777d220 c565c9c0 00000000 c63e8a44 02000000 00000000 00000000 c01311ed 
Nov 15 13:24:10 pc kernel:        c777d220 00000001 c777d220 c0131cd2 c777d220 c63e8a00 c777d220 c8890200 
Nov 15 13:24:10 pc kernel:        c0130ed0 c777d220 00000002 c11e5420 c63e8a00 c57bff98 08054398 c88980a0 
Nov 15 13:24:10 pc kernel: Call Trace: [kill_bdev+13/40] [blkdev_put+86/152] [<c8890200>] [kill_super+256/320]
 [<c88980a0>] 
Nov 15 13:24:10 pc kernel:    [__mntput+30/36] [path_release+39/44] [sys_umount+167/180] [sys_munmap+53/84] [s
ys_oldumount+12/16] [system_call+51/64] 
Nov 15 13:24:10 pc kernel: 
Nov 15 13:24:10 pc kernel: Code: 0f 0b a9 02 00 00 00 74 0d 68 a0 4f 1e c0 e8 20 5e fe ff 83 

Environment

cat /proc/version

Linux version 2.4.12 (root@pc) (gcc version 2.95.2 19991024 (release)) #1 Thu Nov 15 08:44:36 CET 2001


cat /proc/cpuinfo

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 451.024
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


cat /proc/modules

hfs                    73536   0 (autoclean)
nls_cp437               4352   0 (autoclean)
vfat                    8368   0 (autoclean)
fat                    28960   0 (autoclean) [vfat]
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
loop                    7744   0 (unused)
sr_mod                 11760   0 (unused)
sg                     22496   0 (unused)
scsi_mod               78064   3 [ide-scsi sr_mod sg]

lspci -vvv 


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


--------------41D5228F8595820B0AEFED3B--


