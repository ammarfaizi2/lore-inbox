Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262355AbSI2ATO>; Sat, 28 Sep 2002 20:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262357AbSI2ATO>; Sat, 28 Sep 2002 20:19:14 -0400
Received: from h123n2fls32o986.telia.com ([213.67.49.123]:63961 "EHLO
	whatever.mjaha.org") by vger.kernel.org with ESMTP
	id <S262355AbSI2ATK>; Sat, 28 Sep 2002 20:19:10 -0400
Date: Sun, 29 Sep 2002 02:23:47 +0200 (CEST)
From: Erik Ljungstroem <erik.ljungstrom@metalab.unc.edu>
X-X-Sender: trashman@whatever.mjaha.org
To: linux-kernel@vger.kernel.org
Subject: Kernel BUG  at page_alloc.c:91!
Message-ID: <Pine.LNX.4.44.0209290203320.25035-100000@whatever.mjaha.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The following bug just appeared out of the blue.

I will try and stick to the bug-reporting procedure from
http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html

I had just played a game which gave the following message in dmesg:
Out of Memory: Killed process 24115 (fakk2).
My harddrive just started working very intence, and I was thrown out to
gnome within a second or two.
Minutes later another process (xchat) just crashed, this time dmesg didn't
say anything about out of memory, but gave me this:

 kernel BUG at page_alloc.c:91!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012b86d>]    Tainted: P
EFLAGS: 00210282
eax: c1116d94   ebx: c10afc80   ecx: 00000000   edx: c02dd920
esi: c10afc80   edi: 00000000   ebp: c02dda30   esp: c05ffdfc
ds: 0018   es: 0018   ss: 0018
Process bash (pid: 25054, stackpage=c05ff000)
Stack: 00200282 00000003 c936c210 c936c210 c936c210 c10afc80 c0134f15
00000000
       c10afc80 c02dd920 c10afc80 0000137f c02dda30 c012ae94 c05fe000
000001f3
       000001d2 00000020 0000001e 000001d2 00000020 00000006 c012b036
00000006
Call Trace:    [<c0134f15>] [<c012ae94>] [<c012b036>] [<c012b094>]
[<c012be13>]
  [<c012c06c>] [<c0122a27>] [<c01232a8>] [<c0112934>] [<c01153a7>]
[<c010715a>]
  [<c011402b>] [<c0114f4a>] [<c011e1a5>] [<c01127f4>] [<c0108a28>]

Code: 0f 0b 5b 00 f6 8b 29 c0 89 d8 2b 05 10 02 34 c0 c1 f8 02 8d

and a few seconds after that, I was trying to launch an Eterm, and got:

 kernel BUG at page_alloc.c:91!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012b86d>]    Tainted: P
EFLAGS: 00210282
eax: c11cc95c   ebx: c10ef62c   ecx: 00000000   edx: c02dd920
esi: c10ef62c   edi: 00000000   ebp: c02dda30   esp: cb1e5c14
ds: 0018   es: 0018   ss: 0018
Process Eterm (pid: 25359, stackpage=cb1e5000)
Stack: 00200282 00000003 c8c6e430 c8c6e430 c8c6e430 c10ef62c c0134f15
00000000
       c10ef62c c02dd920 c10ef62c 00001380 c02dda30 c012ae94 cb1e4000
000001f3
       000001d2 00000020 0000001e 000001d2 00000020 00000006 c012b036
00000006
Call Trace:    [<c0134f15>] [<c012ae94>] [<c012b036>] [<c012b094>]
[<c012be13>]
  [<c012c06c>] [<c0122f38>] [<c0123251>] [<c0112934>] [<c02419eb>]
[<c0241b19>]
  [<cc82490d>] [<c012bfd5>] [<c01127f4>] [<c0108a28>] [<c0285702>]
[<c0243120>]
  [<c027a0d3>] [<c023ec67>] [<c023eef5>] [<c023ef2e>] [<c01317e4>]
[<c012a431>]
  [<c010d2b6>] [<c0131947>] [<c0108937>]

Code: 0f 0b 5b 00 f6 8b 29 c0 89 d8 2b 05 10 02 34 c0 c1 f8 02 8d

Some info on my system:

erik@mother:~$ cat /etc/slackware-version
Slackware 9.0-beta

erik@mother:/usr/src/linux$ sh scripts/ver_linux
[--snip--]

Linux whatever 2.4.19 #1 Sun Aug 18 13:24:13 PDT 2002 i686 unknown

Gnu C                  gcc (GCC) 3.2 Copyright (C) 2002 Free Software
Foundation, Inc. This is free software; see the source for copying
conditions. There is NO warranty; not even for MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE.
Gnu make               3.79.1
util-linux             2.11u
mount                  2.11u
modutils               2.4.19
e2fsprogs              1.27
pcmcia-cs              3.2.1
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Linux C++ Library      5.0.0
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         cs4232 ad1848 uart401 sound soundcore agpgart
ipt_REJECT iptable_filter ip_tables mousedev hid usbmouse input uhci
usbcore pcmcia_core NVdriver ide-scsi 3c509 isa-pnp

erik@mother:~$ cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  196177920 186957824  9220096        0  9629696 99434496
Swap: 111439872 11923456 99516416
MemTotal:       191580 kB
MemFree:          9004 kB
MemShared:           0 kB
Buffers:          9404 kB
Cached:          95000 kB
SwapCached:       2104 kB
Active:          51140 kB
Inactive:       115920 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       191580 kB
LowFree:          9004 kB
SwapTotal:      108828 kB
SwapFree:        97184 kB

erik@mother:~$ cat /proc/modules
cs4232                  3652   1
ad1848                 21484   0 [cs4232]
uart401                 6340   0 [cs4232]
sound                  52980   1 [cs4232 ad1848 uart401]
soundcore               3300   4 (autoclean) [sound]
agpgart                29984   3 (autoclean)
ipt_REJECT              2616   6 (autoclean)
iptable_filter          1612   1 (autoclean)
ip_tables              10840   2 [ipt_REJECT iptable_filter]
mousedev                3924   1
hid                    17380   0 (unused)
usbmouse                1908   0 (unused)
input                   3136   0 [mousedev hid usbmouse]
uhci                   23408   0 (unused)
usbcore                55136   1 [hid usbmouse uhci]
pcmcia_core            35680   0
NVdriver              988800  10
ide-scsi                7568   1
3c509                   9332   1
isa-pnp                27876   0 [cs4232 ad1848 3c509]

erik@mother:~$ cat /proc/ioports
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
0213-0213 : isapnp read
0300-030f : 3c509
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0534-0537 : Crystal audio controller
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
1000-100f : Intel Corp. 82371AB/EB/MB PIIX4 IDE
  1000-1007 : ide0
  1008-100f : ide1
1020-103f : Intel Corp. 82371AB/EB/MB PIIX4 USB
  1020-103f : usb-uhci
7000-701f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
8000-803f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI

erik@mother:~$ cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-0bfeffff : System RAM
  00100000-0028a6ea : Kernel code
  0028a6eb-00318f9f : Kernel data
0bff0000-0bfffbff : ACPI Tables
0bfffc00-0bffffff : ACPI Non-volatile Storage
f4000000-f4ffffff : PCI Bus #01
  f4000000-f4ffffff : nVidia Corporation Riva TnT2 Ultra [NV5]
f8000000-fbffffff : Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
fc000000-fdffffff : PCI Bus #01
  fc000000-fdffffff : nVidia Corporation Riva TnT2 Ultra [NV5]
fffe7000-ffffffff : reserved

[root@mother ~] lspci -vvv
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
(rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x2

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: f4000000-f4ffffff
        Prefetchable memory behind bridge: fc000000-fdffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at 1000 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at 1020 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

01:00.0 VGA compatible controller: nVidia Corporation NV5 [Riva TnT2
Ultra] (rev 11) (prog-if 00 [VGA])
        Subsystem: Creative Labs 3D Blaster RIVA TNT2 Ultra
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at fc000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=x2

No patches, fixes or own modifications of the kernel code. Just a plain
and simple 2.4.19 kernel. Has worked flawlessly up until now.


Best regards
--

"Slackware, from time to time causes RTFM"

Erik Ljungstroem
(erik dot ljungstrom at sunsite dot unc dot edu)


