Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266247AbUALV6W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 16:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266251AbUALV6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 16:58:21 -0500
Received: from 208.Red-217-126-142.pooles.rima-tde.net ([217.126.142.208]:27776
	"EHLO devmaster.w3ping.net") by vger.kernel.org with ESMTP
	id S266247AbUALV51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 16:57:27 -0500
Message-ID: <400318AD.4000003@terra.es>
Date: Mon, 12 Jan 2004 22:59:09 +0100
From: =?ISO-8859-1?Q?Antonio_Fiol_Bonn=EDn?= <fiol.bonnin@terra.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: es-es, es, fr-fr, fr, en-gb, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Complete system freeze - audio related
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms050205020403010400060801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050205020403010400060801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I will format this as a bug report, although I am not sure whether it is 
a bug or not.

The problem: closing /dev/dsp seems to freeze my complete system.

Full description:
My system was freezing at some point during shutdown.
Then I discovered it was triggered by killing esd (the sound daemon).
That means if I "killall esd", system freezes.
I then tried "echo hello > /dev/dsp" without esd being started. I hit 
Ctrl-C several times. Then the system froze.

Kernel version:  Linux version 2.6.0-test11 (root@devmaster) (gcc 
version 3.3.3 20031229 (prerelease) (Debian)) #2 SMP Sun Jan 4 17:53:09 
CET 2004
Sound card: Intel Corp. 82801BA/BAM AC'97 Audio using i810_audio module 
(see system info below for full details)

No oops: Just system frozen.

How to reproduce:
echo hello > /dev/dsp, then kill it.
This will probably not kill your system, but it kills mine reproducibly.

I was too lazy to verify if there have been any changes since 2.6.1, but 
there is apparently nothing related to i810_audio between 2.6.0-test11 
and 2.6.1.

Any hints? I hope my message is useful.

I am available for anything you may wish me to try. Some more freezes 
will not hurt!

Yours sincerely, Antonio Fiol

P.S. Please CC: me, as I am not subscribed.



System info below. Nothing else.

devmaster:~# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Pentium(R) 4 CPU 1.50GHz
stepping        : 2
cpu MHz         : 1507.729
cache size      : 256 KB
physical id     : 0
siblings        : 1
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
bogomips        : 2965.50
 
devmaster:~# lsmod
Module                  Size  Used by
ipv6                  271552  13
usblp                  13824  0
ipt_MASQUERADE          4736  1
iptable_nat            23204  2 ipt_MASQUERADE
ipt_state               2432  4
ip_conntrack           33580  3 ipt_MASQUERADE,iptable_nat,ipt_state
iptable_filter          3328  1
ip_tables              18944  4 
ipt_MASQUERADE,iptable_nat,ipt_state,iptable_filter
uhci_hcd               35084  0
usbcore               120412  4 usblp,uhci_hcd
evdev                  10112  0
w83781d                34688  0
i2c_sensor              3584  1 w83781d
i2c_isa                 2560  0
i2c_core               25736  3 w83781d,i2c_sensor,i2c_isa
button                  6680  0
8250_pci               17408  0
8250                   23040  3 8250_pci
serial_core            24576  1 8250
rtc                    14408  0
i810_audio             35092  1
ac97_codec             19212  1 i810_audio
soundcore              10176  2 i810_audio
sd_mod                 14496  0
sr_mod                 16164  0
sg                     33560  0
ide_scsi               15748  0
scsi_mod               79652  4 sd_mod,sr_mod,sg,ide_scsi
8139too                24448  0
ne2k_pci                9696  0
8390                   12032  1 ne2k_pci
crc32                   4992  2 8139too,8390
devmaster:~# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0290-0297 : w83781d
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0500-050f : 0000:00:1f.3
0cf8-0cff : PCI conf1
c000-c0ff : 0000:02:01.0
  c000-c0ff : 8139too
c400-c41f : 0000:02:02.0
  c400-c41f : ne2k-pci
d000-d01f : 0000:00:1f.2
  d000-d01f : uhci_hcd
d800-d81f : 0000:00:1f.4
  d800-d81f : uhci_hcd
dc00-dcff : 0000:00:1f.5
  dc00-dcff : Intel ICH2
e000-e03f : 0000:00:1f.5
  e000-e03f : Intel ICH2
f000-f00f : 0000:00:1f.1
  f000-f007 : ide0
  f008-f00f : ide1
devmaster:~# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-002f9030 : Kernel code
  002f9031-003cc47f : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
e0000000-e3ffffff : 0000:00:00.0
e4000000-e5ffffff : PCI Bus #01
  e4000000-e5ffffff : 0000:01:00.0
e6000000-e7ffffff : PCI Bus #01
  e6000000-e6ffffff : 0000:01:00.0
e9000000-e90000ff : 0000:02:01.0
  e9000000-e90000ff : 8139too
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffb00000-ffffffff : reserved
devmaster:~# lspci -vvv
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host 
Bridge (rev 03)
        Subsystem: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [0104]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>
 
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge 
(rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e6000000-e7ffffff
        Prefetchable memory behind bridge: e4000000-e5ffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-
 
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 12) 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: e8000000-e9ffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
 
00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 12)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
 
00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 12) (prog-if 80 
[Master])
        Subsystem: Intel Corp.: Unknown device 2442
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at f000 [size=16]
 
00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 12) 
(prog-if 00 [UHCI])
        Subsystem: Intel Corp. 82801BA/BAM USB (Hub #1)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at d000 [size=32]
 
00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 12)
        Subsystem: Intel Corp.: Unknown device 2442
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 9
        Region 4: I/O ports at 0500 [size=16]
 
00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 12) 
(prog-if 00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 2442
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 11
        Region 4: I/O ports at d800 [size=32]
 
00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio 
(rev 12)
        Subsystem: Avance Logic Inc.: Unknown device 32dd
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 9
        Region 0: I/O ports at dc00 [size=256]
        Region 1: I/O ports at e000 [size=64]
 
01:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT2 
Model 64/Model 64 Pro] (rev 15) (prog-if 00 [VGA])
        Subsystem: Micro-Star International Co., Ltd. MSI-8808
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e6000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e4000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>
 
02:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at c000 [size=256]
        Region 1: Memory at e9000000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
02:02.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at c400 [size=32]
 





--------------ms050205020403010400060801
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
--------------ms050205020403010400060801--

