Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264340AbRFNBCI>; Wed, 13 Jun 2001 21:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264339AbRFNBB6>; Wed, 13 Jun 2001 21:01:58 -0400
Received: from nic.scruz.net ([165.227.1.2]:53265 "EHLO scruz.net")
	by vger.kernel.org with ESMTP id <S264340AbRFNBB4> convert rfc822-to-8bit;
	Wed, 13 Jun 2001 21:01:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Matthew Cline <matt@nightrealms.com>
Organization: Night Realms
To: linux-kernel@vger.kernel.org
Subject: BUG: Mingetty gets tainted-memory bug in cahced_lookup() durring tty open
Date: Wed, 13 Jun 2001 17:57:00 -0700
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01061317570100.01083@kyoko>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] Intermittent tainted-mem error in mingetty in cached_lookup() in
tty open code

[2.] During bootup, mingetty got a tainted memory bug in
cached_lookup() while doing some tty opening stuff; this has only happened
once, and I don't know how to reproduce.

[3.] tty

[4.] Linux version 2.4.5-ac9 (root@kyoko) (gcc version 2.96 20000731 (Red Hat 
Linux 7.1 2.96-81)) #2 Tue Jun 12 22:05:32 PDT 2001

[5.]

kernel BUG at slab.c:1244!
invalid operand: 0000
CPU:    0
EIP:    0010:[kmalloc+324/496]
EFLAGS: 00010086

eax: 0000001b   ebx: c1447768   ecx: 00000001   edx: 00001810
esi: cea5a000   edi: cea5a9aa   ebp: 00012800   esp: cebffe24
ds: 0018   es: 0018   ss: 0018

Process mingetty (pid: 903, stackpage=cebff000)

Stack: c02233ef 000004dc cea5a000 00001000 cea5a9aa 00000246 cfeecd88 c01393f0
       cfb72e04 cebffe80 c02cfdc0 00000405 00000004 00000000 c017bf0d 00000c3c
       00000007 00000004 c017cb85 00000004 00000004 00000000 00000000 cfeecd87

Call Trace: [cached_lookup+16/80] [alloc_tty_struct+13/48]
            [init_dev+133/1008] [vfs_follow_link+225/336] [tty_open+331/896]
   [path_walk+1778/2048] [do_page_fault+0/1168] [do_page_fault+378/1168]
   [devfs_open+198/416] [dentry_open+195/320] [filp_open+77/96]
   [getname+91/160] [sys_open+54/176] [system_call+51/56]

Code: 0f 0b 58 8b 6b 10 5a 81 e5 00 04 00 00 74 4d b8 a5 c2 0f 17

Jun 13 18:29:49 kyoko kernel: Linux version 2.4.5-ac9 (root@kyoko) (gcc 
version 2.96 20000731 (Red Hat Linux 7.1 2.96-81)) #2 Tue Jun 12 22:05:32 PDT 
2001

[6.]

[7.]

Using devfs
mingetty version 0.9.4-10

[7.1]

# sh scripts/ver_linux

Linux kyoko 2.4.5-ac9 #2 Tue Jun 12 22:05:32 PDT 2001 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.11e
mount                  2.9w
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0b
pcmcia-cs              3.0.14
PPP                    2.3.7
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Linux C++ Library      2..
Procps                 2.0.7
Net-tools              1.60
Console-tools          1999.03.02
Sh-utils               2.0
Modules Loaded         ipt_REJECT ipt_state ipt_LOG ipt_unclean 
iptable_mangle iptable_filter ip_nat_ftp ip_conntrack_ftp iptable_nat tulip 
es1371 soundcore ac97_codec vfat fat sr_mod cdrom

[7.2]

# cat /proc/cpuinfo 

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 498.888
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 mmx fxsr
bogomips        : 996.14

[7.3]

# cat /proc/modules 

ipt_REJECT              3104   3 (autoclean)
ipt_state                848   2 (autoclean)
ipt_LOG                 3568  14 (autoclean)
ipt_unclean             6912   2 (autoclean)
iptable_mangle          1968   0 (autoclean) (unused)
iptable_filter          1968   0 (autoclean) (unused)
ip_nat_ftp              3712   0 (unused)
ip_conntrack_ftp        3968   0 [ip_nat_ftp]
iptable_nat            20512   1 [ip_nat_ftp]
tulip                  38816   1 (autoclean)
es1371                 26800   0
soundcore               4080   4 [es1371]
ac97_codec              8672   0 [es1371]
vfat                    9232   0 (unused)
fat                    31264   0 [vfat]
sr_mod                 12656   0 (autoclean) (unused)
cdrom                  28256   0 (autoclean) [sr_mod]

[7.4]

# cat /proc/ioports 

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0400-043f : Intel Corporation 82371AB PIIX4 ACPI
0440-045f : Intel Corporation 82371AB PIIX4 ACPI
0cf8-0cff : PCI conf1
d000-dfff : PCI Bus #01
  d800-d8ff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
e800-e8ff : Lite-On Communications Inc LNE100TX
  e800-e8ff : tulip
ef00-ef3f : Ensoniq ES1371 [AudioPCI-97]
  ef00-ef3f : es1371
ef80-ef9f : Intel Corporation 82371AB PIIX4 USB
ffa0-ffaf : Intel Corporation 82371AB PIIX4 IDE
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

# cat /proc/iomem 

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffdffff : System RAM
  00100000-0021b055 : Kernel code
  0021b056-0027217f : Kernel data
0ffe0000-0fff7fff : ACPI Tables
0fff8000-0fffffff : ACPI Non-volatile Storage
f4800000-f48fffff : PCI Bus #01
f8000000-fbffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
fca00000-feafffff : PCI Bus #01
  fd000000-fdffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
  feaff000-feafffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
febffc00-febffcff : Lite-On Communications Inc LNE100TX
  febffc00-febffcff : tulip
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

[7.5]

# lspci -vvv

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 
03)
        Subsystem: Intel Corporation: Unknown device 7190
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64 set
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=x1

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 
03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fca00000-feafffff
        Prefetchable memory behind bridge: f4800000-f48fffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 
80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Region 4: I/O ports at ffa0 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 
00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at ef80 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:0c.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 04)
        Subsystem: Intel Corporation: Unknown device 4249
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 12 min, 128 max, 64 set
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at ef00 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr+ DSI+ D1- D2+ PME+
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
        Subsystem: Netgear FA310TX
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at febffc00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at feb80000 [disabled] [size=256K]

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/2X 
(rev 5c) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0084
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at d800 [size=256]
        Region 2: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at feac0000 [disabled] [size=128K]
        Capabilities: [50] AGP version 1.0
                Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[7.6]

# cat /proc/scsi/scsi 

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W8432T Rev: 1.07
  Type:   CD-ROM                           ANSI SCSI revision: 02
