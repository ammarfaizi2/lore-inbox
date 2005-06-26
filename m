Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVFZP05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVFZP05 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 11:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVFZP05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 11:26:57 -0400
Received: from cf-007-10.coolhousing.cz ([81.95.106.150]:20192 "EHLO
	sirius.flyweb.cz") by vger.kernel.org with ESMTP id S261326AbVFZPYt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 11:24:49 -0400
Message-ID: <42BEC912.4080804@flyweb.cz>
Date: Sun, 26 Jun 2005 17:26:10 +0200
From: =?ISO-8859-2?Q?Ji=F8=ED_Fogl?= <jiri.fogl@flyweb.cz>
Organization: JabloNET, v.o.s.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM-UPDATED: ehci-hcd storage device resets during I/O with kernels
 2.6.12.1 (vanilla)
Content-Type: multipart/mixed;
 boundary="------------020604050603020305070102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020604050603020305070102
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit

I didn't include listings of relevant lines from syslog in my recent 
post, I'm sorry for this - the listing is attached to the end of this 
report.
It contains a line sda: unknown partition table, but there is no problem 
with it - when I connect a device to USB 1.1 port or unload ehci-hcd 
module, everything works.

Jiri Fogl <eregon@eregon.info>
http://www.eregon.info




-------- Pùvodní zpráva --------
Pøedmìt: 	PROBLEM: ehci-hcd storage device resets during I/O with 
kernels 2.6.12.1 (vanilla)
Datum: 	Sun, 26 Jun 2005 16:47:06 +0200
Od: 	Jiøí Fogl <jiri.fogl@flyweb.cz>
Spoleènost: 	JabloNET, v.o.s.
Komu: 	linux-kernel@vger.kernel.org



PROBLEM:
========
ehci-hcd storage device resets during I/O with 2.6.12.1 (vanilla)



DESCRIPTION:
============
I encountered problems with memory devices (flashdisks, memory-card 
readers) connected to USB 2.0 PCI card. After connecting the device to 
the USB port it is found by system properly and assigned to /dev/sd? 
files. I can mount them and read from/write to them, but after a while 
the device is reset and reading/writing stops and error message appears 
(Can't read file xxx). Duration of this while differs for every attempt.
After trying hardware (removing other PCI cards, moving USB PCI card to 
other PCI slots, disabling motherboard's built-in USB) and software 
(mostly experiments with loading and unloading relating modules) changes 
I found the problem is in ehci-hcd module. After unloading it the memory 
device works without reset, but only like USB 1.1 device.

Changelog of kernel 2.6.12 says there is a patch for EHCI ([PATCH] spin 
longer for ehci port reset completion by David Brownell), so I compiled 
and used it (exactly i used 2.6.12.1 from kernel.org):
Device is properly recognized after connecting to the USB port; I mount 
it and start reading data from it. After a random-long while the 
transfer stops, but after next while it runs again. In result the 
reading is much slower than with UHCI. After few measuring attempts the 
copying of about 120 MB from the device the process hanged up - there 
are messages about resetting the device, but copying process didn't end 
by error (I used drag and drop copying with KDE's Konqueror and the 
progress is 82% last two hours).

Beside this I also use CDMA modem (Gtran GPC-6420 - this model is AFAIK 
specific for Czech republic) connected to USB (uses cdc-acm module) and 
there are no issues with it, no matter if it is connected to 2.0 PCI 
card or to integrated 1.1 USB port or disconnected at all.



KEYWORDS:
=========
USB, ehci-hcd, memory device



KERNEL VERSION:
===============
Linux version 2.6.12.1 (root@masterlord) (gcc version 3.4.1 
(Mandrakelinux 10.1 3.4.1-4mdk)) #1 Sun Jun 26 02:00:03 CEST 2005



HARDWARE DETAILS:
=================
Processor: AMD Athlon XP 1600+
Mainboard: ECS K7VTA3 (VIA KT333 &8233A chipset) with integrated USB 1.1 
controller
USB 2.0 additional card: Edimax EU-CV4N (documentation claims no need of 
drivers with kernel 2.5.2+; details about this card at 
http://www.edimax.nl/html/english/products/EU-CV4N.htm)
HDD and CD-burner are IDE, there are no SCSI devices in this computer.
Inno3D Tornado VGA (nVIDIA GeForce 4 - MX 440, 64 MB, TV-out)
There is also Microcom SP2612R Gbit LAN Card, but there was no 
difference if it was or wasn't installed.
HW info provided by system attached below in LISTINGS section.



SOFTWARE DETAILS:
=================
OS: Mandrake 10.1 official (download version) - test performed with 
distribution's kernel 2.6.8-6mdk and new kernel 2.6.12.1 from kernel.org.
Details about environment below in LISTINGS section.



LISTINGS:
=========

ver_linux:
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux masterlord 2.6.12.1 #1 Sun Jun 26 02:00:03 CEST 2005 i686 AMD 
Athlon(tm) XP 1600+ unknown GNU/Linux
 
Gnu C                  3.4.1
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12a
mount                  2.12a
module-init-tools      3.0
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.2.3
Net-tools              1.60
Kbd                    [pøepínaè...]
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   030
Modules Loaded         nls_iso8859_1 nls_cp437 vfat fat sd_mod 
usb_storage scsi_mod bsd_comp ppp_async crc_ccitt ppp_generic slhc 
parport_pc parport nfsd exportfs lockd sunrpc md5 ipv6 snd_pcm_oss 
snd_mixer_oss snd_via82xx snd_ac97_codec snd_pcm snd_timer 
snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 
af_packet floppy ipt_MASQUERADE iptable_nat ip_conntrack ipt_LOG 
iptable_filter ip_tables cdc_acm r8169 ide_cd cdrom loop ext3 jbd 
via_agp agpgart ehci_hcd uhci_hcd usbcore evdev


/proc/cpuinfo:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) XP 1600+
stepping        : 2
cpu MHz         : 1400.618
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 2768.89


/proc/modules:
nls_iso8859_1 3840 1 - Live 0xd886e000
nls_cp437 5440 1 - Live 0xd8ca8000
vfat 10816 1 - Live 0xd8b39000
fat 46300 1 vfat, Live 0xd8cb0000
sd_mod 14736 1 - Live 0xd8cab000
usb_storage 71552 1 - Live 0xd8cbd000
scsi_mod 122632 2 sd_mod,usb_storage, Live 0xd8d0c000
bsd_comp 5248 0 - Live 0xd8ca2000
ppp_async 9024 1 - Live 0xd8c5f000
crc_ccitt 1728 1 ppp_async, Live 0xd8afe000
ppp_generic 21972 6 bsd_comp,ppp_async, Live 0xd8c38000
slhc 6080 1 ppp_generic, Live 0xd8c35000
parport_pc 32132 0 - Live 0xd8c20000
parport 32840 1 parport_pc, Live 0xd8c2b000
nfsd 211968 8 - Live 0xd8cd7000
exportfs 5312 1 nfsd, Live 0xd8c1d000
lockd 60648 2 nfsd, Live 0xd8c00000
sunrpc 126148 2 nfsd,lockd, Live 0xd8c3f000
md5 3776 1 - Live 0xd8af7000
ipv6 243648 13 - Live 0xd8c65000
snd_pcm_oss 48672 0 - Live 0xd8c10000
snd_mixer_oss 17088 2 snd_pcm_oss, Live 0xd8bfa000
snd_via82xx 23200 4 - Live 0xd8b96000
snd_ac97_codec 78648 1 snd_via82xx, Live 0xd8bd4000
snd_pcm 84040 5 snd_pcm_oss,snd_via82xx,snd_ac97_codec, Live 0xd8bbe000
snd_timer 22020 1 snd_pcm, Live 0xd8b9e000
snd_page_alloc 7428 2 snd_via82xx,snd_pcm, Live 0xd8b6c000
snd_mpu401_uart 6336 1 snd_via82xx, Live 0xd8b69000
snd_rawmidi 21280 1 snd_mpu401_uart, Live 0xd8b71000
snd_seq_device 6860 1 snd_rawmidi, Live 0xd8b66000
snd 46308 13 
snd_pcm_oss,snd_mixer_oss,snd_via82xx,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, 
Live 0xd8b89000
soundcore 7648 2 snd, Live 0xd8b3d000
af_packet 17224 0 - Live 0xd8b40000
floppy 53716 0 - Live 0xd8b7a000
ipt_MASQUERADE 2560 1 - Live 0xd8af9000
iptable_nat 19612 2 ipt_MASQUERADE, Live 0xd8b28000
ip_conntrack 38456 2 ipt_MASQUERADE,iptable_nat, Live 0xd8b2e000
ipt_LOG 6400 2 - Live 0xd8afb000
iptable_filter 2176 1 - Live 0xd8869000
ip_tables 20352 4 ipt_MASQUERADE,iptable_nat,ipt_LOG,iptable_filter, 
Live 0xd887a000
cdc_acm 10016 2 - Live 0xd880d000
r8169 22092 0 - Live 0xd8af0000
ide_cd 36804 0 - Live 0xd8870000
cdrom 36704 1 ide_cd, Live 0xd8851000
loop 13960 0 - Live 0xd8819000
ext3 123720 3 - Live 0xd8b46000
jbd 54872 1 ext3, Live 0xd8ae1000
via_agp 7680 1 - Live 0xd8816000
agpgart 29192 1 via_agp, Live 0xd885b000
ehci_hcd 29512 0 - Live 0xd8827000
uhci_hcd 29328 0 - Live 0xd881e000
usbcore 110140 5 usb_storage,cdc_acm,ehci_hcd,uhci_hcd, Live 0xd8835000
evdev 7424 0 - Live 0xd8811000


/proc/ioports:
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
d000-d0ff : 0000:00:09.0
  d000-d0ff : r8169
d400-d41f : 0000:00:0b.0
  d400-d41f : uhci_hcd
d800-d81f : 0000:00:0b.1
  d800-d81f : uhci_hcd
dc00-dc0f : 0000:00:11.1
  dc00-dc07 : ide0
  dc08-dc0f : ide1
e000-e01f : 0000:00:11.2
  e000-e01f : uhci_hcd
e400-e41f : 0000:00:11.3
  e400-e41f : uhci_hcd
e800-e8ff : 0000:00:11.5
  e800-e8ff : VIA8233A


/proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cfbff : Video ROM
000f0000-000fffff : System ROM
00100000-17feffff : System RAM
  00100000-002c9a88 : Kernel code
  002c9a89-0034a33f : Kernel data
17ff0000-17ff2fff : ACPI Non-volatile Storage
17ff3000-17ffffff : ACPI Tables
d0000000-d7ffffff : 0000:00:00.0
d8000000-e7ffffff : PCI Bus #01
  d8000000-dfffffff : 0000:01:00.0
    d8000000-dbffffff : vesafb
  e0000000-e007ffff : 0000:01:00.0
e8000000-e9ffffff : PCI Bus #01
  e8000000-e8ffffff : 0000:01:00.0
eb000000-eb0000ff : 0000:00:09.0
  eb000000-eb0000ff : r8169
eb001000-eb0010ff : 0000:00:0b.2
  eb001000-eb0010ff : ehci_hcd
ffff0000-ffffffff : reserved


lspci -vvv:
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
        Subsystem: Elitegroup Computer Systems: Unknown device 0996
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo 
KT266/A/333 AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e8000000-e9ffffff
        Prefetchable memory behind bridge: d8000000-e7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 
Gigabit Ethernet (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d000 [size=256]
        Region 1: Memory at eb000000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 61) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 61) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 63) (prog-if 
20 [EHCI])
        Subsystem: VIA Technologies, Inc. USB 2.0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 10
        Interrupt: pin C routed to IRQ 5
        Region 0: Memory at eb001000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
        Subsystem: Elitegroup Computer Systems: Unknown device 0996
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. 
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at dc00 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 23) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at e000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 23) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at e400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 40)
        Subsystem: Elitegroup Computer Systems: Unknown device 0996
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 11
        Region 0: I/O ports at e800 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX 
440] (rev a3) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Region 2: Memory at e0000000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>


/proc/scsi/scsi:
Attached devices:



/proc/config.gz in attachment of this email.



Relevant parts of syslog:
Jun 26 12:36:16 masterlord kernel: usb 5-1: new high speed USB device using ehci_hcd and address 2
Jun 26 12:36:16 masterlord kernel: hub 5-1:1.0: USB hub found
Jun 26 12:36:16 masterlord kernel: hub 5-1:1.0: 1 port detected
Jun 26 12:36:17 masterlord kernel: usb 5-1.1: new high speed USB device using ehci_hcd and address 3
Jun 26 12:36:18 masterlord kernel: SCSI subsystem initialized
Jun 26 12:36:18 masterlord kernel: Initializing USB Mass Storage driver...
Jun 26 12:36:18 masterlord kernel: scsi0 : SCSI emulation for USB Mass Storage devices
Jun 26 12:36:18 masterlord kernel: usbcore: registered new driver usb-storage
Jun 26 12:36:18 masterlord kernel: USB Mass Storage support registered.
Jun 26 12:36:18 masterlord kernel: usb-storage: device found at 3
Jun 26 12:36:18 masterlord kernel: usb-storage: waiting for device to settle before scanning
Jun 26 12:36:23 masterlord kernel:   Vendor: USB 2.0   Model: Flash Disk        Rev: PROL
Jun 26 12:36:23 masterlord kernel:   Type:   Direct-Access                      ANSI SCSI revision: 00
Jun 26 12:36:23 masterlord kernel: usb-storage: device scan complete
Jun 26 12:36:23 masterlord scsi.agent[7667]: disk at /devices/pci0000:00/0000:00:0b.2/usb5/5-1/5-1.1/5-1.1:1.0/host0/target0:0:0/0:0:0:0
Jun 26 12:36:23 masterlord kernel: SCSI device sda: 256000 512-byte hdwr sectors (131 MB)
Jun 26 12:36:23 masterlord kernel: sda: Write Protect is off
Jun 26 12:36:23 masterlord kernel: sda: Mode Sense: 00 06 00 00
Jun 26 12:36:23 masterlord kernel: sda: assuming drive cache: write through
Jun 26 12:36:23 masterlord kernel: SCSI device sda: 256000 512-byte hdwr sectors (131 MB)
Jun 26 12:36:23 masterlord kernel: sda: Write Protect is off
Jun 26 12:36:23 masterlord kernel: sda: Mode Sense: 00 06 00 00
Jun 26 12:36:23 masterlord kernel: sda: assuming drive cache: write through
Jun 26 12:36:23 masterlord kernel:  sda: unknown partition table
Jun 26 12:36:23 masterlord kernel: Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0

>>> At this point I'm able to read/write to device. Transfer sometimes freezes for a while, bu then continues again.<<<

>>> From here it stopped for real: <<<
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206521
Jun 26 13:08:45 masterlord kernel: Buffer I/O error on device sda, logical block 206521
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206522
Jun 26 13:08:45 masterlord kernel: Buffer I/O error on device sda, logical block 206522
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206523
Jun 26 13:08:45 masterlord kernel: Buffer I/O error on device sda, logical block 206523
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206524
Jun 26 13:08:45 masterlord kernel: Buffer I/O error on device sda, logical block 206524
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206525
Jun 26 13:08:45 masterlord kernel: Buffer I/O error on device sda, logical block 206525
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206526
Jun 26 13:08:45 masterlord kernel: Buffer I/O error on device sda, logical block 206526
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206527
Jun 26 13:08:45 masterlord kernel: Buffer I/O error on device sda, logical block 206527
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206528
Jun 26 13:08:45 masterlord kernel: Buffer I/O error on device sda, logical block 206528
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206529
Jun 26 13:08:45 masterlord kernel: Buffer I/O error on device sda, logical block 206529
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206530
Jun 26 13:08:45 masterlord kernel: Buffer I/O error on device sda, logical block 206530
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206531
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206532
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206533
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206534
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206535
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206536
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206537
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206538
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206539
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206540
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206541
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206542
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206543
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206544
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206545
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206546
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206547
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206548
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206549
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206550
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206551
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206552
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206553
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206554
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206555
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206556
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206557
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206558
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206559
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206560
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206561
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206562
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206563
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206564
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206565
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206566
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206567
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206568
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206569
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206570
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206571
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206572
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206573
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206574
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206575
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206576
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206577
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206578
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206579
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206580
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206581
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206582
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206583
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206584
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206585
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206586
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206587
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206588
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206589
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206590
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206591
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206592
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206593
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206594
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206595
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206596
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206597
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206598
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206599
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206600
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206601
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206602
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206603
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206604
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206605
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206606
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206607
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206608
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206609
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206610
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206611
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206612
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206613
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206614
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206615
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206616
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206617
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206618
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206619
Jun 26 13:08:45 masterlord kernel: usb 5-1: USB disconnect, address 2
Jun 26 13:08:45 masterlord kernel: usb 5-1.1: USB disconnect, address 3
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206620
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206621
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206622
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206623
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206624
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206625
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206626
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206627
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206628
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206629
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206630
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206631
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206632
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206633
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206634
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206635
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206636
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206637
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206638
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206639
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206640
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206641
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206642
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206643
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206644
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206645
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206646
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206647
Jun 26 13:08:45 masterlord kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jun 26 13:08:45 masterlord kernel: end_request: I/O error, dev sda, sector 206648
Jun 26 13:08:45 masterlord kernel: usb 5-1: new high speed USB device using ehci_hcd and address 4
Jun 26 13:08:45 masterlord kernel: usb 5-1: device descriptor read/64, error -71
Jun 26 13:08:45 masterlord kernel: usb 5-1: device descriptor read/64, error -71
Jun 26 13:08:46 masterlord kernel: usb 5-1: new high speed USB device using ehci_hcd and address 5
Jun 26 13:08:46 masterlord kernel: usb 5-1: device descriptor read/64, error -71
Jun 26 13:08:46 masterlord kernel: usb 5-1: device descriptor read/64, error -71
Jun 26 13:08:46 masterlord kernel: usb 5-1: new high speed USB device using ehci_hcd and address 6
Jun 26 13:08:46 masterlord kernel: usb 5-1: device not accepting address 6, error -71
Jun 26 13:08:46 masterlord kernel: usb 5-1: new high speed USB device using ehci_hcd and address 7
Jun 26 13:08:47 masterlord kernel: usb 5-1: device not accepting address 7, error -71





Jiri Fogl <eregon@eregon.info>
http://www.eregon.info




--------------020604050603020305070102
Content-Type: application/x-gzip;
 name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.gz"

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
ZWCdgietFPwHqARQBvWxAAA=
--------------020604050603020305070102--
