Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317114AbSHGNGe>; Wed, 7 Aug 2002 09:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317302AbSHGNGd>; Wed, 7 Aug 2002 09:06:33 -0400
Received: from [213.97.216.166] ([213.97.216.166]:8832 "EHLO
	lordvaider.evoto.org") by vger.kernel.org with ESMTP
	id <S317114AbSHGNGa>; Wed, 7 Aug 2002 09:06:30 -0400
Content-Type: text/plain;
  charset="iso-8859-15"
From: Sergio Avila <sergio@evoto.org>
Organization: EVoto Team
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel BUG at page_alloc.c:117!
Date: Wed, 7 Aug 2002 15:09:08 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208071509.30398.sergio@evoto.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

        kernel BUG at page_alloc.c:117!


[2.] Full description of the problem/report:

        cat /var/log/messages
        ...
        Aug  7 04:17:25 lordvaider kernel: NVRM: AGPGART: freed 16 
pages
        Aug  7 04:17:25 lordvaider kernel: NVRM: AGPGART: backend 
released
        Aug  7 04:17:26 lordvaider kernel: NVRM: AGPGART: Intel 
440BX chipset
        Aug  7 04:17:26 lordvaider kernel: NVRM: AGPGART: aperture: 
256M @ 0xe0000000
        Aug  7 04:17:26 lordvaider kernel: NVRM: AGPGART: aperture 
mapped from 0xe0000000 to 0xd5add000
        Aug  7 04:17:26 lordvaider kernel: NVRM: AGPGART: mode 2x
        Aug  7 04:17:26 lordvaider kernel: NVRM: AGPGART: allocated 
16 pages
        Aug  7 04:19:46 lordvaider ntpd[825]: synchronisation lost
        Aug  7 04:37:57 lordvaider ntpd[825]: time reset 2.821400 s
        Aug  7 04:37:57 lordvaider ntpd[825]: synchronisation lost
        Aug  7 06:02:30 lordvaider kernel: ------------[ cut here 
]------------
        Aug  7 06:02:30 lordvaider kernel: kernel BUG at 
page_alloc.c:117!
        Aug  7 06:02:30 lordvaider kernel: invalid operand: 0000
        Aug  7 06:02:30 lordvaider kernel: tuner bttv i2c-algo-bit 
i2c-core videodev sr_mod es1371 ac97_codec gameport so
        Aug  7 06:02:30 lordvaider kernel: CPU:    0
        Aug  7 06:02:30 lordvaider kernel: EIP:    0010:[<c0131107>]    
Tainted: P
        Aug  7 06:02:30 lordvaider kernel: EFLAGS: 00010296
        Aug  7 06:02:30 lordvaider kernel:
        Aug  7 06:02:30 lordvaider kernel: EIP is at __free_pages_ok 
[kernel] 0x57 (2.4.18-5)
        Aug  7 06:02:30 lordvaider kernel: eax: 00000020   ebx: 
c12fa968   ecx: 00000001   edx: 00002cf6
        Aug  7 06:02:30 lordvaider kernel: esi: 00000000   edi: 
00000010   ebp: 00000000   esp: d3fc7f5c
        Aug  7 06:02:30 lordvaider kernel: ds: 0018   es: 0018   ss: 
0018
        Aug  7 06:02:30 lordvaider kernel: Process kswapd (pid: 5, 
stackpage=d3fc7000)
        Aug  7 06:02:30 lordvaider kernel: Stack: c02251dc 00000075 
d39af8a0 c12fa968 c013c833 d3e8e200 c12a4748 00000030
        Aug  7 06:02:30 lordvaider kernel:        c013a9ca c12fa968 
c12fa984 00000010 d39af8a0 c012e994 c12fa968 00000030
        Aug  7 06:02:30 lordvaider kernel:        c12fa968 c12fa984 
00000010 c02c7304 c0130126 c02c732c 00000000 00001246
        Aug  7 06:02:30 lordvaider kernel: Call Trace: [<c013c833>] 
try_to_free_buffers [kernel] 0xa3
        Aug  7 06:02:30 lordvaider kernel: [<c013a9ca>] 
try_to_release_page [kernel] 0x3a
        Aug  7 06:02:30 lordvaider kernel: [<c012e994>] drop_page 
[kernel] 0x34
        Aug  7 06:02:30 lordvaider kernel: [<c0130126>] 
refill_inactive_zone [kernel] 0x276
        Aug  7 06:02:30 lordvaider kernel: [<c0130ab0>] kswapd 
[kernel] 0x280
        Aug  7 06:02:30 lordvaider kernel: [<c0105000>] stext 
[kernel] 0x0
        Aug  7 06:02:30 lordvaider kernel: [<c0107136>] 
kernel_thread [kernel] 0x26
        Aug  7 06:02:30 lordvaider kernel: [<c0130830>] kswapd 
[kernel] 0x0
        Aug  7 06:02:30 lordvaider kernel:
        Aug  7 06:02:30 lordvaider kernel:
        Aug  7 06:02:30 lordvaider kernel: Code: 0f 0b 5d 58 8b 3d 
d0 54 33 c0 89 d8 29 f8 69 c0 b7 6d db b6
        Aug  7 14:07:14 lordvaider syslogd 1.4.1: restart.
        ago  7 14:07:15 lordvaider syslog: Iniciación de syslogd 
succeeded
        Aug  7 14:07:15 lordvaider kernel: klogd 1.4.1, log source = 
/proc/kmsg started.
        Aug  7 14:07:15 lordvaider kernel: Linux version 2.4.18-5 
(bhcompile@daffy.perf.redhat.com) (gcc version 2.96 20
        000731 (Red Hat Linux 7.3 2.96-110)) #1 Mon Jun 10 15:31:48 
EDT 2002
        ...


[3.] Keywords (i.e., modules, networking, kernel):
[4.] Kernel version (from /proc/version):

        Linux version 2.4.18-5 (bhcompile@daffy.perf.redhat.com) 
(gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 Mon Jun 
10 15:31:48 EDT 2002


[5.] Output of Oops.. message (if applicable) with symbolic 
information
     resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

        [root@lordvaider linux-2.4.18-5]# sh scripts/ver_linux
        If some fields are empty or look unusual you may have an old 
version.
        Compare to the current minimal requirements in 
Documentation/Changes.

        Linux lordvaider.evoto.org 2.4.18-5 #1 Mon Jun 10 15:31:48 
EDT 2002 i686 unknown

        Gnu C                  2.96
        Gnu make               3.79.1
        util-linux             2.11n
        mount                  2.11n
        modutils               2.4.14
        e2fsprogs              1.27
        reiserfsprogs          3.x.0j
        Linux C Library        2.2.5
        Dynamic linker (ldd)   2.2.5
        Procps                 2.0.7
        Net-tools              1.60
        Console-tools          0.3.3
        Sh-utils               2.0.11
        Modules Loaded         sr_mod es1371 ac97_codec gameport 
soundcore agpgart NVdriver binfmt_misc autofs eepro100 3c59x 
iptable_nat ip_conntrack iptable_mangle iptable_filter ip_tables 
ide-scsi scsi_mod ide-cd cdrom mousedev hid input usb-uhci usbcore 
ext3 jbd

[7.2.] Processor information (from /proc/cpuinfo):

        [root@lordvaider linux-2.4.18-5]# cat /proc/cpuinfo
        processor       : 0
        vendor_id       : GenuineIntel
        cpu family      : 6
        model           : 5
        model name      : Pentium II (Deschutes)
        stepping        : 2
        cpu MHz         : 350.802
        cache size      : 512 KB
        fdiv_bug        : no
        hlt_bug         : no
        f00f_bug        : no
        coma_bug        : no
        fpu             : yes
        fpu_exception   : yes
        cpuid level     : 2
        wp              : yes
        flags           : fpu vme de pse tsc msr pae mce cx8 sep 
mtrr pge mca cmov pat pse36 mmx fxsr
        bogomips        : 699.59


[7.3.] Module information (from /proc/modules):

        [root@lordvaider linux-2.4.18-5]# cat /proc/modules
        sr_mod                 16920   2 (autoclean)
        es1371                 29024   1 (autoclean)
        ac97_codec             12320   0 (autoclean) [es1371]
        gameport                3488   0 (autoclean) [es1371]
        soundcore               6500   4 (autoclean) [es1371]
        agpgart                39680   3 (autoclean)
        NVdriver             1022272  10 (autoclean)
        binfmt_misc             7460   1
        autofs                 11972   0 (autoclean) (unused)
        eepro100               20336   1
        3c59x                  28680   1
        iptable_nat            21460   1 (autoclean)
        ip_conntrack           21836   1 (autoclean) [iptable_nat]
        iptable_mangle          3136   0 (autoclean) (unused)
        iptable_filter          2752   1 (autoclean)
        ip_tables              13792   5 [iptable_nat iptable_mangle 
iptable_filter]
        ide-scsi                9664   1
        scsi_mod              109424   2 [sr_mod ide-scsi]
        ide-cd                 30272   0
        cdrom                  32032   0 [sr_mod ide-cd]
        mousedev                5120   1
        hid                    20832   0 (unused)
        input                   5792   0 [mousedev hid]
        usb-uhci               24484   0 (unused)
        usbcore                71904   1 [hid usb-uhci]
        ext3                   67328   3
        jbd                    49496   3 [ext3]


[7.4.] Loaded driver and hardware information (/proc/ioports, 
/proc/iomem)
[7.5.] PCI information ('lspci -vvv' as root)

        00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX 
Host bridge (rev 02)
            Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
            Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
>TAbort- <TAbort- <MAbort+ >SERR- <PERR-
            Latency: 32
            Region 0: Memory at e0000000 (32-bit, prefetchable) 
[size=256M]
            Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x2

        00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX 
AGP bridge (rev 02) (prog-if 00 [Normal decode])
            Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR+ FastB2B-
            Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 64
            Bus: primary=00, secondary=01, subordinate=01, 
sec-latency=32
            I/O behind bridge: 0000f000-00000fff
            Memory behind bridge: f0000000-f1ffffff
            Prefetchable memory behind bridge: f2000000-f2ffffff
            BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- 
FastB2B+

        00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 
02)
            Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
            Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 0

        00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE 
(rev 01) (prog-if 80 [Master])
            Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
            Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 32
            Region 4: I/O ports at f000 [size=16]

        00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB 
(rev 01) (prog-if 00 [UHCI])
            Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
            Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 32
            Interrupt: pin D routed to IRQ 11
            Region 4: I/O ports at 9000 [size=32]

        00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 
02)
            Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
            Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Interrupt: pin ? routed to IRQ 9

        00:09.0 Ethernet controller: 3Com Corporation 3c900B-TPO 
[Etherlink XL TPO] (rev 04)
            Subsystem: 3Com Corporation 3C900B-TPO Etherlink XL TPO 
10Mb
            Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
            Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 32 (2500ns min, 12000ns max), cache line size 
08
            Interrupt: pin A routed to IRQ 11
            Region 0: I/O ports at 9400 [size=128]
            Region 1: Memory at f5100000 (32-bit, non-prefetchable) 
[size=128]
            Expansion ROM at f3000000 [disabled] [size=128K]
            Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

        00:0a.0 Multimedia audio controller: Ensoniq ES1371 
[AudioPCI-97] (rev 08)
            Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, 
AudioPCI128
            Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
            Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow 
>TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
            Latency: 32 (3000ns min, 32000ns max)
            Interrupt: pin A routed to IRQ 10
            Region 0: I/O ports at 9800 [size=64]
            Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

        00:0c.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet 
Pro 100] (rev 08)
            Subsystem: Intel Corp. EtherExpress PRO/100+ Management 
Adapter
            Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
            Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 32 (2000ns min, 14000ns max), cache line size 
08
            Interrupt: pin A routed to IRQ 12
            Region 0: Memory at f5101000 (32-bit, non-prefetchable) 
[size=4K]
            Region 1: I/O ports at 9c00 [size=64]
            Region 2: Memory at f5000000 (32-bit, non-prefetchable) 
[size=1M]
            Expansion ROM at f4000000 [disabled] [size=1M]
            Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

        00:0d.0 Multimedia video controller: Brooktree Corporation 
Bt848 Video Capture (rev 12)
            Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
            Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 32 (4000ns min, 10000ns max)
            Interrupt: pin A routed to IRQ 11
            Region 0: Memory at f5102000 (32-bit, prefetchable) 
[size=4K]

        01:00.0 VGA compatible controller: nVidia Corporation NV4 
[Riva TnT] (rev 04) (prog-if 00 [VGA])
            Subsystem: STB Systems Inc: Unknown device 273e
            Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
            Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 248 (1250ns min, 250ns max)
            Interrupt: pin A routed to IRQ 12
            Region 0: Memory at f0000000 (32-bit, non-prefetchable) 
[size=16M]
            Region 1: Memory at f2000000 (32-bit, prefetchable) 
[size=16M]
            Expansion ROM at <unassigned> [disabled] [size=64K]
            Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
            Capabilities: [44] AGP version 1.0
                Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=15 SBA- AGP+ 64bit- FW- Rate=x2


[7.6.] SCSI information (from /proc/scsi/scsi)

        [root@lordvaider linux-2.4.18-5]# cat /proc/scsi/scsi
        Attached devices:
        Host: scsi0 Channel: 00 Id: 00 Lun: 00
        Vendor: COMPAQ   Model: DVD-ROM GD-2500  Rev: 0011
        Type:   CD-ROM                           ANSI SCSI revision: 
02
        Host: scsi0 Channel: 00 Id: 01 Lun: 00
        Vendor: HP       Model: CD-Writer+ 8100  Rev: 1.0g
        Type:   CD-ROM                           ANSI SCSI revision: 
02


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:


-- 
Sergio Avila Jiménez <sergio@evoto.org>
EVoto Team - http://evoto.org
--
