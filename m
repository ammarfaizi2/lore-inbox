Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSHRP53>; Sun, 18 Aug 2002 11:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSHRP53>; Sun, 18 Aug 2002 11:57:29 -0400
Received: from twister.ispgateway.de ([62.67.200.3]:29707 "HELO
	twister.ispgateway.de") by vger.kernel.org with SMTP
	id <S315278AbSHRP5V>; Sun, 18 Aug 2002 11:57:21 -0400
Date: Sun, 18 Aug 2002 18:01:26 +0200
From: Steffen Moser <lists@steffen-moser.de>
To: linux-kernel@vger.kernel.org
Subject: Complete system freeze with "linux-2.4.19-ac4"
Message-ID: <20020818160126.GA1696@steffen-moser.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

enclosed you'll find a bug report. I would be very interested 
whether someone is able to reproduce the crash.

Regards,
Steffen

[1.] One line summary of the problem:
 
Complete freeze of system after trying to read:
 
  "/proc/ide/ide1/hdd/identify"

if "ide-cd" ("/dev/hdd" is my IDE CD-ROM) is not loaded.


[2.] Full description of the problem/report:

Yesterday I had a complete lockup of my workstation machine after 
doing a: 

  "cat /proc/ide/ide1/hdd/identify"

accidentally. "/dev/hdd" is my IDE CD-ROM drive. The problem only 
occurs when kernel module "ide-cd" is _not_inserted_.

I can reprduce the crash very easily and regularly by trying to read 
from "/proc/ide/ide1/hdd/identify" whenever the "ide-cd"-module is not 
loaded.

I don't get any kernel OOPS or PANIC message neither on the console 
screen nor within my log files... The system just stops totally,
CAPS lock and SCROLL lock start blinking. SYSRQ-magic-keys don't
function either... 

Some information about my machine:

 | steffen@pc01:~> cat /proc/ide/via
 | ----------VIA BusMastering IDE Configuration----------------
 | Driver Version:                     3.34
 | South Bridge:                       VIA vt82c686a
 | Revision:                           ISA 0x22 IDE 0x10
 | Highest DMA rate:                   UDMA66
 | BM-DMA base:                        0xd000
 | PCI clock:                          33.3MHz
 | Master Read  Cycle IRDY:            0ws
 | Master Write Cycle IRDY:            0ws
 | BM IDE Status Register Read Retry:  yes
 | Max DRDY Pulse Width:               No limit
 | -----------------------Primary IDE-------Secondary IDE------
 | Read DMA FIFO flush:          yes                 yes
 | End Sector FIFO flush:         no                  no
 | Prefetch Buffer:              yes                  no
 | Post Write Buffer:            yes                  no
 | Enabled:                      yes                 yes
 | Simplex only:                  no                  no
 | Cable Type:                   80w                 80w
 | -------------------drive0----drive1----drive2----drive3-----
 | Transfer Mode:       UDMA       PIO      UDMA      UDMA
 | Address Setup:       30ns     120ns      30ns      30ns
 | Cmd Active:          90ns      90ns      90ns      90ns
 | Cmd Recovery:        30ns      30ns      30ns      30ns
 | Data Active:         90ns     330ns      90ns      90ns
 | Data Recovery:       30ns     270ns      30ns      30ns
 | Cycle Time:          30ns     600ns      30ns      60ns
 | Transfer Rate:   66.6MB/s   3.3MB/s  66.6MB/s  33.3MB/s

 | steffen@pc01:~> cat /proc/ide/drivers
 | ide-cdrom version 4.59
 | ide-disk version 1.16


I tried to reproduce the crash on another machine running the same
kernel ("linux-2.4.19-ac4"). This machine has got also a VIA chip-
set and shows exactly the same symptom (= crash):

 | gateway:~ # cat /proc/ide/via
 | ----------VIA BusMastering IDE Configuration----------------
 | Driver Version:                     3.34
 | South Bridge:                       VIA vt82c686b
 | Revision:                           ISA 0x40 IDE 0x6
 | Highest DMA rate:                   UDMA100
 | BM-DMA base:                        0xe000
 | PCI clock:                          33.3MHz
 | Master Read  Cycle IRDY:            0ws
 | Master Write Cycle IRDY:            0ws
 | BM IDE Status Register Read Retry:  yes
 | Max DRDY Pulse Width:               No limit
 | -----------------------Primary IDE-------Secondary IDE------
 | Read DMA FIFO flush:          yes                 yes
 | End Sector FIFO flush:         no                  no
 | Prefetch Buffer:               no                  no
 | Post Write Buffer:             no                  no
 | Enabled:                      yes                 yes
 | Simplex only:                  no                  no
 | Cable Type:                   80w                 80w
 | -------------------drive0----drive1----drive2----drive3-----
 | Transfer Mode:       UDMA       PIO      UDMA       PIO
 | Address Setup:       30ns     120ns      30ns      30ns
 | Cmd Active:          90ns      90ns      90ns      90ns
 | Cmd Recovery:        30ns      30ns      30ns      30ns
 | Data Active:         90ns     330ns      90ns      90ns
 | Data Recovery:       30ns     270ns      30ns      30ns
 | Cycle Time:          20ns     600ns      20ns     120ns
 | Transfer Rate:   99.9MB/s   3.3MB/s  99.9MB/s  16.6MB/s
  
 | gateway:~ # cat /proc/ide/drivers
 | ide-cdrom version 4.59
 | ide-disk version 1.16

  
[3.] Keywords (i.e., modules, networking, kernel): 

IDE subsystem, VIA chipset, modules (ide-cd.o)


[4.] Kernel version (from /proc/version):

Machine 1 ("pc01"): 

  Linux version 2.4.19-ac4 (root@pc01) (gcc version 2.95.3 20010315 (SuSE)) #52 Fri Aug 9 18:40:47 CEST 2002

Machine 2 ("gateway"): 

  Linux version 2.4.19-ac4 (root@gateway) (gcc version 2.95.3 20010315 (SuSE)) #10 Sun Aug 18 15:14:15 CEST 2002 


[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt):

I'm sorry, I don't get any oops message. :-(


[6.] A small shell script or example program which triggers the
     problem (if possible):

Just do a "rmmod ide-cd" (if it's inserted) and try to read from
"/proc/ide/ide1/hdd" (or whatever the file for your IDE CD-ROM drive 
is).


[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

 | pc01:/usr/src # ./linux-2.4.19-ac4/scripts/ver_linux
 | If some fields are empty or look unusual you may have an old version.
 | Compare to the current minimal requirements in Documentation/Changes.
 | 
 | Linux pc01 2.4.19-ac4 #52 Fri Aug 9 18:40:47 CEST 2002 i686 unknown
 | 
 | Gnu C                  2.95.3
 | Gnu make               3.79.1
 | util-linux             2.11n
 | mount                  2.11n
 | modutils               2.4.12
 | e2fsprogs              1.26
 | PPP                    2.4.1
 | isdn4k-utils           3.1pre4
 | Linux C Library        x    1 root     root      1394238 Jul 12 17:29 /lib/libc.so.6
 | Dynamic linker (ldd)   2.2.5
 | Procps                 2.0.7
 | Net-tools              1.60
 | Kbd                    1.06
 | Sh-utils               2.0
 | Modules Loaded         snd-pcm-oss snd-mixer-oss snd-seq-midi
 |                        snd-seq-midi-event snd-seq snd-ens1371 snd-pcm snd-timer snd-rawmidi
 |                        snd-seq-device snd-ac97-codec snd soundcore ipv6 mousedev hid input
 |                        usb-uhci usbcore eepro100 hisax isdn slhc reiserfs ext3 jbd

 | gateway:~ # /usr/src/linux-2.4.19-ac4/scripts/ver_linux
 | If some fields are empty or look unusual you may have an old version.
 | Compare to the current minimal requirements in Documentation/Changes.
 | 
 | Linux gateway 2.4.19-ac4 #10 Sun Aug 18 15:14:15 CEST 2002 i686 unknown
 | 
 | Gnu C                  2.95.3
 | Gnu make               3.79.1
 | util-linux             2.11n
 | mount                  2.11n
 | modutils               2.4.12
 | e2fsprogs              1.26
 | Linux C Library        x    1 root     root      1394238 Mar 23 19:34 /lib/libc.so.6
 | Dynamic linker (ldd)   2.2.5
 | Procps                 2.0.7
 | Net-tools              1.60
 | Kbd                    1.06
 | Sh-utils               2.0
 | Modules Loaded         cdrom ipv6 3c59x


[7.2.] Processor information (from /proc/cpuinfo):

 | pc01:/usr/src # cat /proc/cpuinfo
 | processor       : 0
 | vendor_id       : AuthenticAMD
 | cpu family      : 6
 | model           : 4
 | model name      : AMD Athlon(tm) processor
 | stepping        : 4
 | cpu MHz         : 1302.953
 | cache size      : 256 KB
 | fdiv_bug        : no
 | hlt_bug         : no
 | f00f_bug        : no
 | coma_bug        : no
 | fpu             : yes
 | fpu_exception   : yes
 | cpuid level     : 1
 | wp              : yes
 | flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
 |                   cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
 | bogomips        : 2595.22

 | gateway:~ # cat /proc/cpuinfo
 | processor       : 0
 | vendor_id       : AuthenticAMD
 | cpu family      : 6
 | model           : 3
 | model name      : AMD Duron(tm) Processor
 | stepping        : 1
 | cpu MHz         : 800.062
 | cache size      : 64 KB
 | fdiv_bug        : no
 | hlt_bug         : no
 | f00f_bug        : no
 | coma_bug        : no
 | fpu             : yes
 | fpu_exception   : yes
 | cpuid level     : 1
 | wp              : yes
 | flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
 |                   cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
 | bogomips        : 1595.80


[7.3.] Module information (from /proc/modules):

 | pc01:/usr/src # cat /proc/modules
 | snd-pcm-oss            36128   1 (autoclean)
 | snd-mixer-oss           9120   1 (autoclean)
 | snd-seq-midi            3264   0 (unused)
 | snd-seq-midi-event      2760   0 [snd-seq-midi]
 | snd-seq                37036   0 [snd-seq-midi snd-seq-midi-event]
 | snd-ens1371             9828   2
 | snd-pcm                47872   0 [snd-pcm-oss snd-ens1371]
 | snd-timer              10240   0 [snd-seq snd-pcm]
 | snd-rawmidi            12192   0 [snd-seq-midi snd-ens1371]
 | snd-seq-device          4076   0 [snd-seq-midi snd-seq snd-rawmidi]
 | snd-ac97-codec         22692   0 [snd-ens1371]
 | snd                    24648   0 [snd-pcm-oss snd-mixer-oss snd-seq-midi
 |                                  snd-seq-midi-event snd-seq snd-ens1371 snd-pcm snd-timer snd-rawmidi
 |                                  snd-seq-device snd-ac97-codec]
 | soundcore               3332   6 [snd]
 | ipv6                  127392  -1 (autoclean)
 | mousedev                3872   1
 | hid                    19392   0 (unused)
 | input                   3168   0 [mousedev hid]
 | usb-uhci               21508   0 (unused)
 | usbcore                55552   1 [hid usb-uhci]
 | eepro100               17584   1
 | hisax                 137152   1
 | isdn                  108576   2 [hisax]
 | slhc                    4624   0 [isdn]
 | reiserfs              159008   1 (autoclean)
 | ext3                   57600   5 (autoclean)
 | jbd                    34800   5 (autoclean) [ext3]

 | gateway:~ # cat /proc/modules
 | cdrom                  28736   0
 | ipv6                  127456  -1 (autoclean)
 | 3c59x                  25128   1


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

 | pc01:/usr/src # cat /proc/ioports
 | 0000-001f : dma1
 | 0020-003f : pic1
 | 0040-005f : timer
 | 0060-006f : keyboard
 | 0070-007f : rtc
 | 0080-008f : dma page reg
 | 00a0-00bf : pic2
 | 00c0-00df : dma2
 | 00f0-00ff : fpu
 | 0170-0177 : ide1
 | 01f0-01f7 : ide0
 | 0376-0376 : ide1
 | 03c0-03df : vesafb
 | 03f6-03f6 : ide0
 | 0cf8-0cff : PCI conf1
 | 4000-40ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
 | 5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
 | 6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
 | c000-cfff : PCI Bus #01
 |   c000-c0ff : ATI Technologies Inc Rage 128 RF/SG AGP
 | d000-d00f : VIA Technologies, Inc. Bus Master IDE
 |   d000-d007 : ide0
 |   d008-d00f : ide1
 | d400-d41f : VIA Technologies, Inc. UHCI USB
 |   d400-d41f : usb-uhci
 | dc00-dc3f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
 |   dc00-dc3f : eepro100
 | e000-e01f : AVM Audiovisuelles MKTG & Computer System GmbH A1 ISDN [Fritz]
 |   e000-e01f : avm PCI
 | e400-e4ff : Adaptec AHA-2940UW Pro / AIC-788x
 | e800-e83f : Ensoniq 5880 AudioPCI
 |   e800-e83f : Ensoniq AudioPCI

 | pc01:/usr/src # cat /proc/iomem
 | 00000000-0009ffff : System RAM
 | 000a0000-000bffff : Video RAM area
 | 000c0000-000c7fff : Video ROM
 | 000c8000-000c8fff : Extension ROM
 | 000c9000-000c97ff : Extension ROM
 | 000f0000-000fffff : System ROM
 | 00100000-1ffeffff : System RAM
 |   00100000-001e4f4f : Kernel code
 |   001e4f50-00247c9f : Kernel data
 | 1fff0000-1fff2fff : ACPI Non-volatile Storage
 | 1fff3000-1fffffff : ACPI Tables
 | d0000000-d7ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
 | d8000000-dbffffff : PCI Bus #01
 |   d8000000-dbffffff : ATI Technologies Inc Rage 128 RF/SG AGP
 |     d8000000-d9ffffff : vesafb
 | dc000000-ddffffff : PCI Bus #01
 |   dd000000-dd003fff : ATI Technologies Inc Rage 128 RF/SG AGP
 | df000000-df0fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
 | df100000-df100fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
 |   df100000-df100fff : eepro100
 | df101000-df10101f : AVM Audiovisuelles MKTG & Computer System GmbH A1 ISDN [Fritz]
 | df102000-df102fff : Adaptec AHA-2940UW Pro / AIC-788x
 | ffff0000-ffffffff : reserved

 | gateway:~ # cat /proc/ioports
 | 0000-001f : dma1
 | 0020-003f : pic1
 | 0040-005f : timer
 | 0060-006f : keyboard
 | 0080-008f : dma page reg
 | 00a0-00bf : pic2
 | 00c0-00df : dma2
 | 00f0-00ff : fpu
 | 0170-0177 : ide1
 | 01f0-01f7 : ide0
 | 0376-0376 : ide1
 | 03c0-03df : vga+
 | 03f6-03f6 : ide0
 | 0cf8-0cff : PCI conf1
 | 5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
 | 6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
 | e000-e00f : VIA Technologies, Inc. Bus Master IDE
 |   e000-e007 : ide0
 |   e008-e00f : ide1
 | e400-e41f : VIA Technologies, Inc. UHCI USB
 | e800-e81f : VIA Technologies, Inc. UHCI USB (#2)
 | ec00-ec7f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
 |   ec00-ec7f : 00:12.0

 | gateway:~ # cat /proc/iomem
 | 00000000-0009ffff : System RAM
 | 000a0000-000bffff : Video RAM area
 | 000c0000-000c7fff : Video ROM
 | 000f0000-000fffff : System ROM
 | 00100000-1ffeffff : System RAM
 |   00100000-0022aceb : Kernel code
 |   0022acec-0029b41f : Kernel data
 | 1fff0000-1fff2fff : ACPI Non-volatile Storage
 | 1fff3000-1fffffff : ACPI Tables
 | d0000000-d3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
 | d4000000-d5ffffff : PCI Bus #01
 |   d4000000-d5ffffff : nVidia Corporation Vanta [NV6]
 | d6000000-d7ffffff : PCI Bus #01
 |   d6000000-d6ffffff : nVidia Corporation Vanta [NV6]
 | d9000000-d900007f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
 | ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

 | pc01:~ # lspci -vvv
 |  00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
 |      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 |      Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
 |      Latency: 8
 |      Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
 |      Capabilities: [a0] AGP version 2.0
 |              Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
 |              Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
 |      Capabilities: [c0] Power Management version 2
 |              Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 |              Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 |
 |  00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
 |      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 |      Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
 |      Latency: 0
 |      Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
 |      I/O behind bridge: 0000c000-0000cfff
 |      Memory behind bridge: dc000000-ddffffff
 |      Prefetchable memory behind bridge: d8000000-dbffffff
 |      BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
 |      Capabilities: [80] Power Management version 2
 |              Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 |              Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 |
 |  00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
 |      Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
 |      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
 |      Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 |      Latency: 0
 |
 |  00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
 |      Subsystem: VIA Technologies, Inc. Bus Master IDE
 |      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 |      Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 |      Latency: 32
 |      Region 4: I/O ports at d000 [size=16]
 |      Capabilities: [c0] Power Management version 2
 |              Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 |              Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 |
 |  00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
 |      Subsystem: Unknown device 0925:1234
 |      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 |      Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 |      Latency: 32, cache line size 08
 |      Interrupt: pin D routed to IRQ 11
 |      Region 4: I/O ports at d400 [size=32]
 |      Capabilities: [80] Power Management version 2
 |              Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 |              Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 |
 |  00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
 |      Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
 |      Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 |      Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 |      Interrupt: pin ? routed to IRQ 9
 |      Capabilities: [68] Power Management version 2
 |              Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 |              Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 |
 |  00:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
 |      Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
 |      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 |      Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 |      Latency: 32 (2000ns min, 14000ns max), cache line size 08
 |      Interrupt: pin A routed to IRQ 10
 |      Region 0: Memory at df100000 (32-bit, non-prefetchable) [size=4K]
 |      Region 1: I/O ports at dc00 [size=64]
 |      Region 2: Memory at df000000 (32-bit, non-prefetchable) [size=1M]
 |      Expansion ROM at <unassigned> [disabled] [size=1M]
 |      Capabilities: [dc] Power Management version 2
 |              Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 |              Status: D0 PME-Enable- DSel=0 DScale=2 PME-
 |
 |  00:0a.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH A1 ISDN [Fritz] (rev 02)
 |      Subsystem: AVM Audiovisuelles MKTG & Computer System GmbH FRITZ!Card ISDN Controller
 |      Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 |      Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 |      Interrupt: pin A routed to IRQ 12
 |      Region 0: Memory at df101000 (32-bit, non-prefetchable) [size=32]
 |      Region 1: I/O ports at e000 [size=32]
 |
 |  00:0b.0 SCSI storage controller: Adaptec AHA-2940UW Pro / AIC-788x (rev 01)
 |      Subsystem: Adaptec 2940UW Pro Ultra-Wide SCSI Controller
 |      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 |      Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 |      Latency: 32 (2000ns min, 2000ns max), cache line size 08
 |      Interrupt: pin A routed to IRQ 11
 |      Region 0: I/O ports at e400 [size=256]
 |      Region 1: Memory at df102000 (32-bit, non-prefetchable) [size=4K]
 |      Expansion ROM at <unassigned> [disabled] [size=64K]
 |      Capabilities: [dc] Power Management version 1
 |              Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 |              Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 |
 |  00:0d.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
 |      Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
 |      Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 |      Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
 |      Latency: 32 (3000ns min, 32000ns max)
 |      Interrupt: pin A routed to IRQ 11
 |      Region 0: I/O ports at e800 [size=64]
 |      Capabilities: [dc] Power Management version 1
 |              Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 |              Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 |
 |  01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF/SG AGP (prog-if 00 [VGA])
 |      Subsystem: ATI Technologies Inc Magnum/Xpert128/X99/Xpert2000
 |      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
 |      Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 |      Latency: 32 (2000ns min), cache line size 08
 |      Interrupt: pin A routed to IRQ 5
 |      Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
 |      Region 1: I/O ports at c000 [size=256]
 |      Region 2: Memory at dd000000 (32-bit, non-prefetchable) [size=16K]
 |      Expansion ROM at <unassigned> [disabled] [size=128K]
 |      Capabilities: [50] AGP version 2.0
 |              Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
 |              Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
 |      Capabilities: [5c] Power Management version 1
 |              Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 |              Status: D0 PME-Enable- DSel=0 DScale=0 PME-

 | gateway:~ # lspci -vvv
 |  00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
 |      Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 |      Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
 |      Latency: 0
 |      Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
 |      Capabilities: [a0] AGP version 2.0
 |              Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
 |              Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
 |      Capabilities: [c0] Power Management version 2
 |              Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 |              Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 |
 |  00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
 |      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 |      Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
 |      Latency: 0
 |      Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
 |      I/O behind bridge: 0000f000-00000fff
 |      Memory behind bridge: d6000000-d7ffffff
 |      Prefetchable memory behind bridge: d4000000-d5ffffff
 |      BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
 |      Capabilities: [80] Power Management version 2
 |              Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 |              Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 |
 |  00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
 |      Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
 |      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
 |      Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 |      Latency: 0
 |      Capabilities: [c0] Power Management version 2
 |              Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 |              Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 |
 |  00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
 |      Subsystem: VIA Technologies, Inc. Bus Master IDE
 |      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 |      Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 |      Latency: 32
 |      Region 4: I/O ports at e000 [size=16]
 |      Capabilities: [c0] Power Management version 2
 |              Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 |              Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 |
 |  00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
 |      Subsystem: Unknown device 0925:1234
 |      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 |      Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 |      Latency: 32, cache line size 08
 |      Interrupt: pin D routed to IRQ 12
 |      Region 4: I/O ports at e400 [size=32]
 |      Capabilities: [80] Power Management version 2
 |              Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 |              Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 |
 |  00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
 |      Subsystem: Unknown device 0925:1234
 |      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 |      Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 |      Latency: 32, cache line size 08
 |      Interrupt: pin D routed to IRQ 12
 |      Region 4: I/O ports at e800 [size=32]
 |      Capabilities: [80] Power Management version 2
 |              Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 |              Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 |
 |  00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
 |      Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] 
 |      Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 |      Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 |      Interrupt: pin ? routed to IRQ 5
 |      Capabilities: [68] Power Management version 2
 |              Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 |              Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 |
 |  00:12.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
 |      Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
 |      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 |      Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 |      Latency: 32 (2500ns min, 2500ns max), cache line size 08
 |      Interrupt: pin A routed to IRQ 11
 |      Region 0: I/O ports at ec00 [size=128]
 |      Region 1: Memory at d9000000 (32-bit, non-prefetchable) [size=128]
 |      Expansion ROM at <unassigned> [disabled] [size=128K]
 |      Capabilities: [dc] Power Management version 2
 |              Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 |              Status: D0 PME-Enable+ DSel=0 DScale=2 PME-
 |
 |  01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15) (prog-if 00 [VGA])
 |      Subsystem: Elsa AG: Unknown device 0c3a
 |      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 |      Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 |      Latency: 32 (1250ns min, 250ns max)
 |      Interrupt: pin A routed to IRQ 10
 |      Region 0: Memory at d6000000 (32-bit, non-prefetchable) [size=16M]
 |      Region 1: Memory at d4000000 (32-bit, prefetchable) [size=32M]
 |      Expansion ROM at <unassigned> [disabled] [size=64K]
 |      Capabilities: [60] Power Management version 1
 |              Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 |              Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 |      Capabilities: [44] AGP version 2.0
 |              Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
 |              Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


[7.6.] SCSI information (from /proc/scsi/scsi)

SCSI subsystem was not active (on "pc01"). 

If I load the modules, I get:

 | pc01:~ # cat /proc/scsi/scsi
 | Attached devices:
 | Host: scsi0 Channel: 00 Id: 03 Lun: 00
 |   Vendor: YAMAHA   Model: CRW8424S         Rev: 1.0j
 |   Type:   CD-ROM                           ANSI SCSI revision: 02
 | Host: scsi0 Channel: 00 Id: 06 Lun: 00
 |   Vendor: HP       Model: HP35470A         Rev: T603
 |   Type:   Sequential-Access                ANSI SCSI revision: 02

On "gateway" there is no SCSI hardware present.
