Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261912AbSIYEqR>; Wed, 25 Sep 2002 00:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261913AbSIYEqR>; Wed, 25 Sep 2002 00:46:17 -0400
Received: from web20305.mail.yahoo.com ([216.136.226.86]:3958 "HELO
	web20305.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261912AbSIYEqM>; Wed, 25 Sep 2002 00:46:12 -0400
Message-ID: <20020925045126.13939.qmail@web20305.mail.yahoo.com>
Date: Tue, 24 Sep 2002 21:51:26 -0700 (PDT)
From: Art <pinaart@yahoo.com>
Subject: PROBLEM: building modules for 2.5.38 from source under 2.4.19 on x86 P4
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.  ] One line summary of the problem:
Updated check.c to fix `devfs_handle' undeclared error and
mtdblock_ro.c,
[2.  ] Full description of the problem/report:
Compiling under Linux 2.4.19 resulted in errors which appear to be bugs
        which I fixed:
  make[2]: Entering directory `/home/src/linux-2.5.38/fs/partitions'
    gcc -Wp,-MD,./.check.o.d -D__KERNEL__
-I/home/src/linux-2.5.38/include -Wall \
  -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing \
  -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 \
  -I/home/src/linux-2.5.38/arch/i386/mach-generic -nostdinc
-iwithprefix include \
  -DKBUILD_BASENAME=check   -c -o check.o check.c
  check.c: In function `devfs_create_cdrom':
  check.c:365: `devfs_handle' undeclared (first use in this function)
  check.c:365: (Each undeclared identifier is reported only once
  check.c:365: for each function it appears in.)
  check.c:344: warning: unused variable `symlink'
  check.c:344: warning: unused variable `dirname'
  check.c:343: warning: unused variable `devfs_flags'
  check.c:342: warning: unused variable `slave'
  check.c:342: warning: unused variable `dir'
  check.c:341: warning: unused variable `pos'
  make[2]: *** [check.o] Error 1

 FIX: Defined "devfs_handle" in a second function, devfs_create_cdrom.

   gcc -Wp,-MD,./.mtdblock_ro.o.d -D__KERNEL__
-I/home/src/linux-2.5.38/include \
   -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer \
   -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 \
   -I/home/src/linux-2.5.38/arch/i386/mach-generic -nostdinc
-iwithprefix include \
   -DMODULE -include /home/src/linux-2.5.38/include/linux/modversions.h
\
   -DKBUILD_BASENAME=mtdblock_ro   -c -o mtdblock_ro.o mtdblock_ro.c
   mtdblock_ro.c:33: parse error before `names'


 FIX: Deleted syntax error cause, "names".

   gcc -Wp,-MD,./.mtdblock_ro.o.d -D__KERNEL__
-I/home/src/linux-2.5.38/include \
   -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer \
   -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 \
   -I/home/src/linux-2.5.38/arch/i386/mach-generic -nostdinc
-iwithprefix include \
   -DMODULE -include /home/src/linux-2.5.38/include/linux/modversions.h
\
   -DKBUILD_BASENAME=mtdblock_ro   -c -o mtdblock_ro.o mtdblock_ro.c
   ...
   mtdblock_ro.c: In function `mtdblock_request':
   mtdblock_ro.c:125: warning: int format, kdev_t arg (arg 2)
   mtdblock_ro.c:143: `io_request_lock' undeclared (first use in this
function)

 FIX: Defined "io_request_lock" in mtdblock_request function.
        Elsewhere in code, there were function calls with "not enough
arguments"
        and I added the missing argument (3 expected vs 2 given).

[3.  ] Keywords (i.e., modules, networking, kernel):
Files affected: fs/partitions/check.c, fs/jffs/intrep.c,
fs/jffs2/background.c,
        drivers/mtd/mtdblock_ro.c

[4.  ] Kernel version (from /proc/version):
Linux version 2.4.19-pre10 (pinaar@pinaar) (gcc version 2.96 20000731
(Red Hat Linux 7.3 2.96-110)) #23 Tue Jul 30 22:02:36 PDT 2002

[5.  ] No Oops here.

[6.  ] Problem shows up by just doing a make: make modules

[7.  ]  Environment: It's a modules build problem.

[7.1 ] Software: sh scripts/ver_linux:
Linux pinaar 2.4.19-pre10 #23 Tue Jul 30 22:02:36 PDT 2002 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n 
modutils               2.4.14
e2fsprogs              1.27
reiserfsprogs          3.x.0j
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11

[7.2.] Processor information:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Pentium(R) 4 CPU 1.70GHz
stepping        : 2
cpu MHz         : 1703.878
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no 
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2 
wp              : yes

flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3394.76

[7.3.] Module information:
sis900                 14756   1
8139too                15072   1
mii                     1980   0 [8139too]
af_packet              13736   1 (autoclean)
serial                 45504   0 (autoclean)
vfat                   11804   4 (autoclean)
fat                    35992   0 (autoclean) [vfat]
ehci-hcd               22720   0 (unused)
usb-uhci               24260   0 (unused)
usb-ohci               20160   0 (unused)
usbcore                77248   1 [ehci-hcd usb-uhci usb-ohci]
unix                   15908  44 (autoclean)

[7.4.] Loaded driver and hardware information:
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
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
c000-c0ff : Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet
  c000-c0ff : sis900
c400-c4ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
  c400-c4ff : 8139too
c800-c81f : VIA Technologies, Inc. UHCI USB
  c800-c81f : usb-uhci
cc00-cc1f : VIA Technologies, Inc. UHCI USB (#2)
  cc00-cc1f : usb-uhci
d000-d0ff : C-Media Electronics Inc CM8738

[7.5.] PCI information:
bash-2.05a# lspci -vvv
00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device
0645 (rev
02)
        Subsystem: Soyo Computer, Inc: Unknown device a403
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort
- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at e8000000 (32-bit, non-prefetchable)
[size=32M]
        Capabilities: [c0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
(prog-if 00 [
Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort-
<MAbort- >SERR- <PERR-

        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 0

00:02.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
(prog-if
10 [OHCI])
        Subsystem: Soyo Computer, Inc: Unknown device a403
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 0: Memory at ec000000 (32-bit, non-prefetchable)
[size=4K]

00:02.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
(prog-if
10 [OHCI])
        Subsystem: Soyo Computer, Inc: Unknown device a403
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at ec003000 (32-bit, non-prefetchable)
[size=4K]

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev
d0) (pro
g-if 80 [Master])
        Subsystem: Soyo Computer, Inc: Unknown device a403
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 128
        Region 4: I/O ports at f000 [size=16]

00:03.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
10/100 Ethe
rnet (rev 90)
        Subsystem: Soyo Computer, Inc: Unknown device a403
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 (13000ns min, 2750ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at c000 [size=256]
        Region 1: Memory at ec004000 (32-bit, non-prefetchable)
[size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot
+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (
rev 02)
        Subsystem: Hauppauge computer works Inc. WinTV/GO
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ec001000 (32-bit, prefetchable) [size=4K]

00:09.1 Multimedia controller: Brooktree Corporation Bt878 Audio
Capture (rev 02
)
        Subsystem: Hauppauge computer works Inc. WinTV/GO
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ec002000 (32-bit, prefetchable) [size=4K]

00:0b.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX
DDR] (re
v b2) (prog-if 00 [VGA])
        Subsystem: VISIONTEK: Unknown device 0027
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at ea000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C (rev
 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at c400 [size=256]
        Region 1: Memory at ec005000 (32-bit, non-prefetchable)
[size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3h
ot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME- 

00:0d.0 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID): Unknown device
1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at c800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.1 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID): Unknown device
1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step

ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at cc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
(prog-if 20 [EHC
I])
        Subsystem: VIA Technologies, Inc. (Wrong ID): Unknown device
1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin C routed to IRQ 9
        Region 0: Memory at ec006000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk+ DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot
+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Multimedia audio controller: C-Media Electronics Inc CM8738
(rev 10)
        Subsystem: Soyo Computer, Inc: Unknown device a403
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at d000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 RAID bus controller: Triones Technologies, Inc. HPT366 / HPT370
(rev 05)
        Subsystem: Triones Technologies, Inc.: Unknown device 0001
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 11 
        Region 0: I/O ports at d400 [size=8]
        Region 1: I/O ports at d800 [size=4]
        Region 2: I/O ports at dc00 [size=8]
        Region 3: I/O ports at e000 [size=4]
        Region 4: I/O ports at e400 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices: none

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

[X.] Other notes, patches, fixes, workarounds:
None - see sections 6, 7 above. 
Well. Ok. My workaround was to drop it after fixing 5 bugs associated
with the
above report. I just downloaded linux-2.4.19.tar.gz and will rebuild
from this
one (even though I have 2.4.19 already, but I don't trust my source now
and I
need SCSI emulation to get the CD-RW applications running on my
system).

Thanks & Regards,

Art





__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
