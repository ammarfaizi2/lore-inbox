Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbTLUPQM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 10:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263447AbTLUPQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 10:16:12 -0500
Received: from mail.epost.de ([193.28.100.167]:42483 "EHLO mail.epost.de")
	by vger.kernel.org with ESMTP id S263102AbTLUPPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 10:15:18 -0500
Subject: PROBLEM: 2.4.23 freezes on "ifdown -a" witk sk98lin network driver
From: Daniel Sobe <daniel.sobe@epost.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1071999571.1067.20.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 21 Dec 2003 16:16:24 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo!

I'm running 2.4.23 and have the problem that the computer freezes hard
(no sysrq keys working) on shutdown when the system was up for at least
1 hour with the following message:

ETH0: ERROR
Class: Hardware failure
Nr: 0xd9
MSG: Fatal: SkGeStopPort() does not terminate (Tx)

(I wrote this up from the screen, maxbe I mixed some upper/lower-case).

It happens when the script "/etc/init.d/networking stop" is called, the
command that most likely triggers this is "ifdown -a".

I had the same problems with 2.4.22, maybe the error message was
different.

The kernel is patched with the "backstreet ruby" patch and the "packet
cd writing" patch. It is tainted due to the drivers for the Logitech
Webcam and the Smartlink USB modem, none of them seem to be a cause for
the problem. I have enabled ACPI and the IO-APIC.

I'd appreciate any help on this. Thank You.

Please "cc" me on any discussion because I'm not subscribed to the list.

Daniel

---------------------------------------

cat /proc/version 
Linux version 2.4.23-backstreet-ruby (root@localhost) (gcc version
2.95.4 20011002 (Debian prerelease)) #3 Sam Dez 13 12:06:21 MET 2003

------------------------------------

sh scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux localhost 2.4.23-backstreet-ruby #3 Sam Dez 13 12:06:21 MET 2003
i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
reiserfsprogs          3.x.1b
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         snd-pcm-oss snd-via82xx snd-mpu401-uart
ppp_deflate zlib_inflate zlib_deflate bsd_comp ppp_async ppp_generic
slhc snd-mixer-oss snd-ens1371 snd-ac97-codec sr_mod pktcdvd cdrom
sd_mod parport_pc lp parport pwcx-i386 pwc tuner tvaudio msp3400
snd-usb-audio snd-pcm snd-page-alloc bttv snd-timer videodev snd-rawmidi
i2c-algo-bit snd-seq-device i2c-core snd soundcore slusb sk98lin
ehci-hcd usb-uhci hid usbcore analog gameport joydev ide-scsi scsi_mod

-----------------------------------------------

cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(TM) XP 2500+
stepping        : 0
cpu MHz         : 1833.180
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3656.90

--------------------------------------------------------

cat /proc/modules 
snd-pcm-oss            36964   0 (autoclean)
snd-via82xx            12000   0 (autoclean)
snd-mpu401-uart         3024   0 (autoclean) [snd-via82xx]
ppp_deflate             3008   0 (autoclean)
zlib_inflate           18592   0 (autoclean) [ppp_deflate]
zlib_deflate           18016   0 (autoclean) [ppp_deflate]
bsd_comp                4064   0 (autoclean)
ppp_async               6624   0 (autoclean)
ppp_generic            16108   0 (autoclean) [ppp_deflate bsd_comp
ppp_async]
slhc                    4720   0 (autoclean) [ppp_generic]
snd-mixer-oss          11552   1 (autoclean) [snd-pcm-oss]
snd-ens1371            10976   1 (autoclean)
snd-ac97-codec         40920   0 (autoclean) [snd-via82xx snd-ens1371]
sr_mod                 13560   0 (autoclean)
pktcdvd                18420   1 (autoclean)
cdrom                  29056   0 (autoclean) [sr_mod pktcdvd]
sd_mod                 10332   0 (autoclean) (unused)
parport_pc             25288   1 (autoclean)
lp                      6560   0 (autoclean)
parport                25024   1 (autoclean) [parport_pc lp]
pwcx-i386              87104   0
pwc                    44672   0 [pwcx-i386]
tuner                   9508   1 (autoclean)
tvaudio                12640   0 (autoclean) (unused)
msp3400                15664   1 (autoclean)
snd-usb-audio          39680   0
snd-pcm                57984   0 [snd-pcm-oss snd-via82xx snd-ens1371
snd-usb-audio]
snd-page-alloc          5700   0 [snd-via82xx snd-pcm]
bttv                   96800   0
snd-timer              14528   0 [snd-pcm]
videodev                5856   4 [pwc bttv]
snd-rawmidi            13120   0 [snd-mpu401-uart snd-ens1371
snd-usb-audio]
i2c-algo-bit            7180   1 [bttv]
snd-seq-device          4004   0 [snd-rawmidi]
i2c-core               12992   0 [tuner tvaudio msp3400 bttv
i2c-algo-bit]
snd                    31008   0 [snd-pcm-oss snd-via82xx
snd-mpu401-uart snd-mixer-oss snd-ens1371 snd-ac97-codec snd-usb-audio
snd-pcm snd-timer snd-rawmidi snd-seq-device]
soundcore               3620   0 [bttv snd]
slusb                  13072   2
sk98lin               135456   1 (autoclean)
ehci-hcd               15776   0 (unused)
usb-uhci               21796   0 (unused)
hid                    14560   0 (unused)
usbcore                36704   0 [pwc snd-usb-audio slusb ehci-hcd
usb-uhci hid]
analog                  7360   0 (unused)
gameport                1632   0 [snd-via82xx snd-ens1371 analog]
joydev                  7552   0 (unused)
ide-scsi                9088   2
scsi_mod               83256   3 [sr_mod sd_mod ide-scsi]

--------------------------------------------

cat /proc/ioports 
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
0200-0207 : ens137x: gameport
02f8-02ff : serial(set)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0778-077a : parport0
0cf8-0cff : PCI conf1
8000-80ff : 3Dfx Interactive, Inc. Voodoo 3
8400-841f : VIA Technologies, Inc. USB (#4)
  8400-841f : usb-uhci
8800-881f : VIA Technologies, Inc. USB (#3)
  8800-881f : usb-uhci
9000-901f : VIA Technologies, Inc. USB (#2)
  9000-901f : usb-uhci
9400-941f : VIA Technologies, Inc. USB
  9400-941f : usb-uhci
9800-980f : VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C
PIPC Bus Mast
 IDE
  9800-9807 : ide0
  9808-980f : ide1
a000-a0ff : PCI device 1106:3149 (VIA Technologies, Inc.)
a400-a40f : PCI device 1106:3149 (VIA Technologies, Inc.)
a800-a803 : PCI device 1106:3149 (VIA Technologies, Inc.)
b000-b007 : PCI device 1106:3149 (VIA Technologies, Inc.)
b400-b403 : PCI device 1106:3149 (VIA Technologies, Inc.)
b800-b807 : PCI device 1106:3149 (VIA Technologies, Inc.)
d000-d03f : Ensoniq 5880 AudioPCI
  d000-d03f : Ensoniq AudioPCI
d400-d4ff : LSI Logic / Symbios Logic 53c810
d800-d8ff : 3Com Corporation Gigabit Ethernet Adapter
  d800-d8ff : SysKonnect SK-98xx
e000-e0ff : VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller
  e000-e0ff : VIA8233


----------------------------------------------------

cat /proc/iomem 
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1fffbfff : System RAM
  00100000-002568ce : Kernel code
  002568cf-002e7f97 : Kernel data
1fffc000-1fffefff : ACPI Tables
1ffff000-1fffffff : ACPI Non-volatile Storage
de000000-dfffffff : 3Dfx Interactive, Inc. Voodoo 3
e0800000-e08000ff : VIA Technologies, Inc. USB 2.0
  e0800000-e08000ff : ehci_hcd
e1000000-e10000ff : LSI Logic / Symbios Logic 53c810
e1800000-e1803fff : 3Com Corporation Gigabit Ethernet Adapter
  e1800000-e1803fff : SysKonnect SK-98xx
e2000000-e3efffff : PCI Bus #01
  e2000000-e2ffffff : nVidia Corporation NV11 [GeForce2 MX/MX 400]
e4000000-e5ffffff : 3Dfx Interactive, Inc. Voodoo 3
e6800000-e6800fff : Brooktree Corporation Bt878 Audio Capture
e7000000-e7000fff : Brooktree Corporation Bt878 Video Capture
  e7000000-e7000fff : bttv
e7f00000-efffffff : PCI Bus #01
  e8000000-efffffff : nVidia Corporation NV11 [GeForce2 MX/MX 400]
f0000000-f7ffffff : VIA Technologies, Inc. VT8377 [KT400 AGP] Host
Bridge
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved


-----------------------------------------------------------

lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3189 (rev
80)
        Subsystem: Asustek Computer, Inc.: Unknown device 807f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [80] AGP version 3.5
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b198 (prog-if
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: e2000000-e3efffff
        Prefetchable memory behind bridge: e7f00000-efffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: 3Com Corporation: Unknown device 1700 (rev
12)
        Subsystem: Asustek Computer, Inc.: Unknown device 80eb
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (5750ns min, 7750ns max), cache line size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at e1800000 (32-bit, non-prefetchable)
[size=16K]
        Region 1: I/O ports at d800 [size=256]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data

00:0b.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly
NCR) 53c810 (rev 23)
        Subsystem: LSI Logic / Symbios Logic (formerly NCR) 8100S
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 16000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at d400 [size=256]
        Region 1: Memory at e1000000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at d000 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Multimedia video controller: Brooktree Corporation Bt878 (rev
02)
        Subsystem: Hauppauge computer works Inc. WinTV/GO
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at e7000000 (32-bit, prefetchable) [size=4K]

00:0e.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
        Subsystem: Hauppauge computer works Inc. WinTV/GO
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at e6800000 (32-bit, prefetchable) [size=4K]

00:0f.0 RAID bus controller: VIA Technologies, Inc.: Unknown device 3149
(rev 80)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 20
        Region 0: I/O ports at b800 [size=8]
        Region 1: I/O ports at b400 [size=4]
        Region 2: I/O ports at b000 [size=8]
        Region 3: I/O ports at a800 [size=4]
        Region 4: I/O ports at a400 [size=16]
        Region 5: I/O ports at a000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 20
        Region 4: I/O ports at 9800 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. UHCI USB (rev 81)
(prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 21
        Region 4: I/O ports at 9400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. UHCI USB (rev 81)
(prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 21
        Region 4: I/O ports at 9000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 81)
(prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin B routed to IRQ 21
        Region 4: I/O ports at 8800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 81)
(prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin B routed to IRQ 21
        Region 4: I/O ports at 8400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.4 USB Controller: VIA Technologies, Inc.: Unknown device 3104 (rev
86) (prog-if 20)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 10
        Interrupt: pin C routed to IRQ 21
        Region 0: Memory at e0800000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3227
        Subsystem: Asustek Computer, Inc.: Unknown device 80ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 60)
        Subsystem: Asustek Computer, Inc.: Unknown device 80b0
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 22
        Region 0: I/O ports at e000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:13.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev
01) (prog-if 00 [VGA])
        Subsystem: 3Dfx Interactive, Inc. Voodoo3
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at de000000 (32-bit, non-prefetchable)
[disabled] [size=32M]
        Region 1: Memory at e4000000 (32-bit, prefetchable) [disabled]
[size=32M]
        Region 2: I/O ports at 8000 [disabled] [size=256]
        Expansion ROM at e3ff0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX)
(rev a1) (prog-if 00 [VGA])
        Subsystem: LeadTek Research Inc.: Unknown device 2830
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at e2000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at e7ff0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>



