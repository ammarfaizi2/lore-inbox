Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129665AbQKERhI>; Sun, 5 Nov 2000 12:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129121AbQKERg5>; Sun, 5 Nov 2000 12:36:57 -0500
Received: from zeus.kernel.org ([209.10.41.242]:32013 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129692AbQKERgk>;
	Sun, 5 Nov 2000 12:36:40 -0500
Date: Sun, 5 Nov 2000 18:33:08 +0100 (CET)
From: Manuel Teira <mteira@bbvnet.com>
To: linux-kernel@vger.kernel.org
Subject: AGP memory corruption for ALI M1541 chipset
Message-ID: <Pine.LNX.4.21.0011051809440.1154-200000@localhost>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1848710380-973445588=:1154"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1848710380-973445588=:1154
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello.

1.- testgart and the glx module with AGP enabled show memory corruption
errors.

2.- The AGP gart module loads under my laptop (K6-2 450Mhz, ALI M1541
chipset, 64Mb RAM). Syslog is showing the following data:
Nov  3 19:31:20 localhost kernel: Linux agpgart interface v0.99 (c) Jeff
Hartmann
Nov  3 19:31:20 localhost kernel: agpgart: Maximum main memory to use for
agp memory: 27M
Nov  3 19:31:20 localhost kernel: agpgart: Detected Ali M1541 chipset
Nov  3 19:31:20 localhost kernel: agpgart: AGP aperture is 64M @ 0xe0000000

Then, the glx module using AGP modes mach64_dma=3 or mach64_dma=4 shows
corrupted textures, and even crashes the machine.

Trying to isolate the problem, I test the program testgart (included with
this mail), and it says:
version: 0.99
bridge id: 0x154110b9
agp_mode: 0x1c000203
aper_base: 0xe0000000
aper_size: 64
pg_total: 6912
pg_system: 6912
pg_used: 0
entry.key : 0
entry.key : 1
Allocated 8 megs of GART memory
MemoryBenchmark: 81 mb/s
MemoryBenchmark: 82 mb/s
MemoryBenchmark: 82 mb/s
Average speed: 81 mb/s
Testing data integrity (1st pass): failed on first pass!
Testing data integrity (2nd pass): failed on second pass!

At the same time, the syslog is dumping lines with this shape:
Nov  5 18:19:50 localhost kernel: memory : c3998d60
Nov  5 18:19:50 localhost kernel: memory : c0e8fba0

The testgart doesn't fail all the time. But the kernel-memory lines shows
in the syslog anyway.

With the glx module, I've also seen this line into the syslog:

Nov  3 19:31:20 localhost kernel: apm: get_event: Interface not connected

And then, the machine is not able to power down on halt. It says "Power
down" and nothing more.

cat /proc/version
Linux version 2.4.0-test10 (root@panoramix) (gcc version 2.95.2 20000220
(Debian GNU/Linux)) #2 Fri Nov 3 19:52:53 CET 2000

No Oops.

The testgart that I've used is attatched in this mail.

The output of the ver_linux script is:
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux panoramix 2.4.0-test10 #2 Fri Nov 3 19:52:53 CET 2000 i586 unknown
Kernel modules         2.3.19
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.10.91
Linux C Library        2.1.96
Dynamic linker         ldd (GNU libc) 2.1.96
Procps                 2.0.6
Mount                  2.10o
Net-tools              2.05
Kbd                    0.99
Sh-utils               2.0i
Modules Loaded         loop agpgart ppp_deflate bsd_comp ppp_async maestro soundcore ppp_generic serial_cs pcnet_cs 8390 ipt_MASQUERADE iptable_nat ip_conntrack ip_tables ds i82365 pcmcia_core nls_iso8859-1 nls_cp437 vfat fat

The /proc/cpuinfo dumps:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 451.000040
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mmx 3dnow
bogomips        : 901.12

The /proc/modules dumps:
loop                    7392   0 (autoclean)
agpgart                12752   0 (autoclean)
ppp_deflate            39168   0 (autoclean)
bsd_comp                4160   0 (autoclean)
ppp_async               6224   1 (autoclean)
maestro                25360   1 (autoclean)
soundcore               3664   2 (autoclean) [maestro]
ppp_generic            12704   3 (autoclean) [ppp_deflate bsd_comp
ppp_async]
serial_cs               5616   0 (unused)
pcnet_cs               11200   1
8390                    6112   0 [pcnet_cs]
ipt_MASQUERADE          1296   1 (autoclean)
iptable_nat            12224   0 [ipt_MASQUERADE]
ip_conntrack           12384   1 [ipt_MASQUERADE iptable_nat]
ip_tables               9888   4 [ipt_MASQUERADE iptable_nat]
ds                      6608   2 [serial_cs pcnet_cs]
i82365                 23216   2
pcmcia_core            43392   0 [serial_cs pcnet_cs ds i82365]
nls_iso8859-1           2848   1 (autoclean)
nls_cp437               4352   1 (autoclean)
vfat                   10320   1
fat                    30080   0 [vfat]

The /proc/ioports dumps:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-017f : Acer Laboratories Inc. [ALi] M5229 IDE
  0170-0177 : ide1
01f0-01ff : Acer Laboratories Inc. [ALi] M5229 IDE
  01f0-01f7 : ide0
02f8-02ff : serial(set)
0300-031f : pcnet_cs
0376-0376 : Acer Laboratories Inc. [ALi] M5229 IDE
  0376-0376 : ide1
03c0-03df : vga+
03e8-03ef : serial(set)
03f6-03f6 : Acer Laboratories Inc. [ALi] M5229 IDE
  03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
1c20-1c3f : Acer Laboratories Inc. [ALi] M7101 PMU
e000-efff : PCI Bus #01
  e800-e8ff : ATI Technologies Inc 3D Rage LT Pro AGP-133
f800-f8ff : ESS Technology ES1978 Maestro 2E
  f800-f8ff : ESS Maestro 2E
fcf0-fcff : Acer Laboratories Inc. [ALi] M5229 IDE
  fcf0-fcf7 : ide0
  fcf8-fcff : ide1

The /proc/iomem dumps:
loop                    7392   0 (autoclean)
agpgart                12752   0 (autoclean)
ppp_deflate            39168   0 (autoclean)
bsd_comp                4160   0 (autoclean)
ppp_async               6224   1 (autoclean)
maestro                25360   1 (autoclean)
soundcore               3664   2 (autoclean) [maestro]
ppp_generic            12704   3 (autoclean) [ppp_deflate bsd_comp
ppp_async]
serial_cs               5616   0 (unused)
pcnet_cs               11200   1
8390                    6112   0 [pcnet_cs]
ipt_MASQUERADE          1296   1 (autoclean)
iptable_nat            12224   0 [ipt_MASQUERADE]
ip_conntrack           12384   1 [ipt_MASQUERADE iptable_nat]
ip_tables               9888   4 [ipt_MASQUERADE iptable_nat]
ds                      6608   2 [serial_cs pcnet_cs]
i82365                 23216   2
pcmcia_core            43392   0 [serial_cs pcnet_cs ds i82365]
nls_iso8859-1           2848   1 (autoclean)
nls_cp437               4352   1 (autoclean)
vfat                   10320   1
fat                    30080   0 [vfat]

The lspci -vvv dumps:
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
	Subsystem: Acer Laboratories Inc. [ALi] ALI M1541 Aladdin V/V+ AGP System Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [b0] AGP version 1.0
		Status: RQ=28 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=28 SBA+ AGP+ 64bit- FW- Rate=x2
	Capabilities: [e0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=99
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fd000000-fecfffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:03.0 CardBus bridge: Texas Instruments PCI1251B
	Subsystem: Acer Laboratories Inc. [ALi]: Unknown device ac1f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 00000000-00000000 (prefetchable)
	Memory window 1: 00000000-00000000 (prefetchable)
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:03.1 CardBus bridge: Texas Instruments PCI1251B
	Subsystem: Acer Laboratories Inc. [ALi]: Unknown device ac1f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 00000000-00000000 (prefetchable)
	Memory window 1: 00000000-00000000 (prefetchable)
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev 0a)
	Subsystem: Acer Laboratories Inc. [ALi] ALI M1533 Aladdin IV ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 0

00:09.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev 10)
	Subsystem: CLEVO/KAPOK Computer: Unknown device 0982
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at f800 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 20) (prog-if fa)
	Subsystem: Acer Laboratories Inc. [ALi] M5229 IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at 01f0 [size=16]
	Region 1: I/O ports at 03f4
	Region 2: I/O ports at 0170 [size=16]
	Region 3: I/O ports at 0374
	Region 4: I/O ports at fcf0 [size=16]

00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU (rev 09)
	Subsystem: Acer Laboratories Inc. [ALi]: Unknown device 1533
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:13.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
	Subsystem: Acer Laboratories Inc. [ALi] M5237 USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fedff000 (32-bit, non-prefetchable) [size=4K]

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage LT Pro AGP-133 (rev dc) (prog-if 00 [VGA])
	Subsystem: CLEVO/KAPOK Computer: Unknown device 0982
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at e800 [size=256]
	Region 2: Memory at fecff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=28 SBA+ AGP+ 64bit- FW- Rate=x2
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


Best regards.

--
Manuel Teira

--8323328-1848710380-973445588=:1154
Content-Type: TEXT/x-csrc; name="testgart.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0011051833080.1154@localhost>
Content-Description: The testgart utility
Content-Disposition: attachment; filename="testgart.c"

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8dW5pc3RkLmg+DQojaW5j
bHVkZSA8c3lzL2lvY3RsLmg+DQojaW5jbHVkZSA8ZmNudGwuaD4NCiNpbmNs
dWRlIDxzeXMvbW1hbi5oPg0KI2luY2x1ZGUgPHN5cy90aW1lLmg+DQojaW5j
bHVkZSA8bGludXgvdHlwZXMuaD4NCiNpbmNsdWRlIDxsaW51eC9hZ3BnYXJ0
Lmg+DQojaW5jbHVkZSA8YXNtL210cnIuaD4NCiNpbmNsdWRlIDxlcnJuby5o
Pg0KDQp1bnNpZ25lZCBjaGFyICpnYXJ0Ow0KaW50IGdhcnRmZDsNCmludCBt
dHJyOw0KDQppbnQgdXNlYyggdm9pZCApIHsNCiAgc3RydWN0IHRpbWV2YWwg
dHY7DQogIHN0cnVjdCB0aW1lem9uZSB0ejsNCiAgDQogIGdldHRpbWVvZmRh
eSggJnR2LCAmdHogKTsNCiAgcmV0dXJuICh0di50dl9zZWMgJiAyMDQ3KSAq
IDEwMDAwMDAgKyB0di50dl91c2VjOw0KfQ0KDQppbnQgTWVtb3J5QmVuY2ht
YXJrKCB2b2lkICpidWZmZXIsIGludCBkd29yZHMgKSB7DQogIGludCAgICAg
ICAgICAgICBpOw0KICBpbnQgICAgICAgICAgICAgc3RhcnQsIGVuZDsNCiAg
aW50ICAgICAgICAgICAgIG1iOw0KICBpbnQgICAgICAgICAgICAgKmJhc2U7
DQogIA0KICBiYXNlID0gKGludCAqKWJ1ZmZlcjsNCiAgc3RhcnQgPSB1c2Vj
KCk7DQogIGZvciAoIGkgPSAwIDsgaSA8IGR3b3JkcyA7IGkgKz0gOCApIHsN
CiAgICBiYXNlW2ldID0NCiAgICAgIGJhc2VbaSsxXSA9DQogICAgICBiYXNl
W2krMl0gPQ0KICAgICAgYmFzZVtpKzNdID0NCiAgICAgIGJhc2VbaSs0XSA9
DQogICAgICBiYXNlW2krNV0gPQ0KICAgICAgYmFzZVtpKzZdID0NCiAgICAg
IGJhc2VbaSs3XSA9IDB4MTUxNTE1MTU7ICAgICAgICAgLyogZG1hcGFkIG5v
cHMgKi8NCiAgfQ0KICBlbmQgPSB1c2VjKCk7DQogIG1iID0gKCAoZmxvYXQp
ZHdvcmRzIC8gMHg0MDAwMCApICogMTAwMDAwMCAvIChlbmQgLSBzdGFydCk7
DQogIHByaW50ZigiTWVtb3J5QmVuY2htYXJrOiAlaSBtYi9zXG4iLCBtYiAp
Ow0KICByZXR1cm4gbWI7DQp9DQoNCmludCBpbnNlcnRfZ2FydChpbnQgcGFn
ZSwgaW50IHNpemUpDQp7DQogICBhZ3BfYWxsb2NhdGUgZW50cnk7DQogICBh
Z3BfYmluZCBiaW5kOw0KICAgDQogICBlbnRyeS50eXBlID0gMDsNCiAgIGVu
dHJ5LnBnX2NvdW50ID0gc2l6ZTsNCiNpZmRlZiBERUJVRw0KICAgcHJpbnRm
KCJVc2luZyBBR1BJT0NfQUxMT0NBVEVcbiIpOw0KI2VuZGlmDQogICBpZihp
b2N0bChnYXJ0ZmQsIEFHUElPQ19BTExPQ0FURSwgJmVudHJ5KSAhPSAwKQ0K
ICAgIHsNCiAgICAgIHBlcnJvcigiaW9jdGwoQUdQSU9DX0FMTE9DQVRFKSIp
Ow0KICAgICAgZXhpdCgxKTsNCiAgICB9DQogICANCiAgIGJpbmQua2V5ID0g
ZW50cnkua2V5Ow0KICAgYmluZC5wZ19zdGFydCA9IHBhZ2U7DQojaWZkZWYg
REVCVUcNCiAgIHByaW50ZigiVXNpbmcgQUdQSU9DX0JJTkRcbiIpOw0KI2Vu
ZGlmDQogICBpZihpb2N0bChnYXJ0ZmQsIEFHUElPQ19CSU5ELCAmYmluZCkp
DQogICAgIHsNCglwZXJyb3IoImlvY3RsKEFHUElPQ19CSU5EKSIpOw0KCWV4
aXQoMSk7DQogICAgIH0NCiAgIA0KICAgcHJpbnRmKCJlbnRyeS5rZXkgOiAl
aVxuIiwgZW50cnkua2V5KTsNCiAgIA0KICAgcmV0dXJuKGVudHJ5LmtleSk7
DQp9DQoNCmludCB1bmJpbmRfZ2FydChpbnQga2V5KQ0Kew0KICAgYWdwX3Vu
YmluZCB1bmJpbmQ7DQogICANCiAgIHVuYmluZC5rZXkgPSBrZXk7DQojaWZk
ZWYgREVCVUcNCiAgIHByaW50ZigiVXNpbmcgQUdQSU9DX1VOQklORFxuIik7
DQojZW5kaWYNCiAgIGlmKGlvY3RsKGdhcnRmZCwgQUdQSU9DX1VOQklORCwg
JnVuYmluZCkgIT0gMCkNCiAgICAgew0KCXBlcnJvcigiaW9jdGwoQUdQSU9D
X1VOQklORCkiKTsNCglleGl0KDEpOw0KICAgICB9DQogICANCiAgIHJldHVy
bigwKTsNCn0NCg0KaW50IGJpbmRfZ2FydChpbnQga2V5LCBpbnQgcGFnZSkN
CnsNCiAgIGFncF9iaW5kIGJpbmQ7DQogICANCiAgIGJpbmQua2V5ID0ga2V5
Ow0KICAgYmluZC5wZ19zdGFydCA9IHBhZ2U7DQojaWZkZWYgREVCVUcNCiAg
IHByaW50ZigiVXNpbmcgQUdQSU9DX0JJTkRcbiIpOw0KI2VuZGlmDQogICBp
Zihpb2N0bChnYXJ0ZmQsIEFHUElPQ19CSU5ELCAmYmluZCkgIT0gMCkNCiAg
ICAgew0KCXBlcnJvcigiaW9jdGwoQUdQSU9DX0JJTkQpIik7DQoJZXhpdCgx
KTsNCiAgICAgfQ0KICAgDQogICByZXR1cm4oMCk7DQp9DQoNCmludCByZW1v
dmVfZ2FydChpbnQga2V5KQ0Kew0KI2lmZGVmIERFQlVHDQogICBwcmludGYo
IlVzaW5nIEFHUElPQ19ERUFMTE9DQVRFXG4iKTsNCiNlbmRpZg0KICBpZihp
b2N0bChnYXJ0ZmQsIEFHUElPQ19ERUFMTE9DQVRFLCBrZXkpICE9IDApDQog
ICAgew0KICAgICAgcGVycm9yKCJpb2N0bChHQVJUSU9DUkVNT1ZFKSIpOw0K
ICAgICAgZXhpdCgxKTsNCiAgICB9DQogICANCiAgIHJldHVybigwKTsNCn0N
Cg0Kdm9pZCBvcGVubXRycih2b2lkKSANCnsNCiAgIGlmICgobXRyciA9IG9w
ZW4oIi9wcm9jL210cnIiLCBPX1dST05MWSwgMCkpID09IC0xKSANCiAgICAg
ew0KCWlmIChlcnJubyA9PSBFTk9FTlQpIHsNCgkgICBwZXJyb3IoIi9wcm9j
L210cnIgbm90IGZvdW5kOiBNVFJSIG5vdCBlbmFibGVkXG4iKTsNCgl9ICBl
bHNlIHsNCgkgICBwZXJyb3IoIkVycm9yIG9wZW5pbmcgL3Byb2MvbXRycjoi
KTsNCgkgICBwZXJyb3IoIk1UUlIgbm90IGVuYWJsZWRcbiIpOw0KCSAgIGV4
aXQoMSk7DQoJfQ0KCXJldHVybjsNCiAgICAgfQ0KfQ0KDQppbnQgQ292ZXJS
YW5nZVdpdGhNVFJSKCBpbnQgYmFzZSwgaW50IHJhbmdlLCBpbnQgdHlwZSAp
DQp7DQogICBpbnQgICAgICAgICAgY291bnQ7ICAgDQogICAgICANCiAgIC8q
IHNldCBpdCBpZiB3ZSBhcmVuJ3QganVzdCBjaGVja2luZyB0aGUgbnVtYmVy
ICovDQogICBpZiAoIHR5cGUgIT0gLTEgKSB7DQogICAgICBzdHJ1Y3QgbXRy
cl9zZW50cnkgc2VudHJ5Ow0KICAgICAgDQogICAgICBzZW50cnkuYmFzZSA9
IGJhc2U7DQogICAgICBzZW50cnkuc2l6ZSA9IHJhbmdlOw0KICAgICAgc2Vu
dHJ5LnR5cGUgPSB0eXBlOw0KICAgICAgDQogICAgICBpZiAoIGlvY3RsKG10
cnIsIE1UUlJJT0NfQUREX0VOVFJZLCAmc2VudHJ5KSA9PSAtMSApIHsNCgkg
cGVycm9yKCJtdHJyIik7DQoJIGV4aXQoMSk7DQogICAgICB9DQogICB9DQog
ICANCn0NCg0KaW50IGluaXRfYWdwKHZvaWQpDQp7DQogICBhZ3BfaW5mbyBp
bmZvOw0KICAgYWdwX3NldHVwIHNldHVwOw0KDQojaWZkZWYgREVCVUcNCiAg
IHByaW50ZigiVXNpbmcgQUdQSU9DX0FDUVVJUkVcbiIpOw0KI2VuZGlmDQog
ICBpZihpb2N0bChnYXJ0ZmQsIEFHUElPQ19BQ1FVSVJFKSAhPSAwKQ0KICAg
ICB7DQoJcGVycm9yKCJpb2N0bChBR1BJT0NfQUNRVUlSRSkiKTsNCglleGl0
KDEpOw0KICAgICB9DQojaWZkZWYgREVCVUcNCiAgIHByaW50ZigiVXNpbmcg
QUdQSU9DX0lORk9cbiIpOw0KI2VuZGlmDQogICBpZihpb2N0bChnYXJ0ZmQs
IEFHUElPQ19JTkZPLCAmaW5mbykgIT0gMCkNCiAgICAgew0KCXBlcnJvcigi
aW9jdGwoQUdQSU9DX0lORk8pIik7DQoJZXhpdCgxKTsNCiAgICAgfQ0KICAg
DQogICBwcmludGYoInZlcnNpb246ICVpLiVpXG4iLCBpbmZvLnZlcnNpb24u
bWFqb3IsIGluZm8udmVyc2lvbi5taW5vcik7DQogICBwcmludGYoImJyaWRn
ZSBpZDogMHglbHhcbiIsIGluZm8uYnJpZGdlX2lkKTsNCiAgIHByaW50Zigi
YWdwX21vZGU6IDB4JWx4XG4iLCBpbmZvLmFncF9tb2RlKTsNCiAgIHByaW50
ZigiYXBlcl9iYXNlOiAweCVseFxuIiwgaW5mby5hcGVyX2Jhc2UpOw0KICAg
cHJpbnRmKCJhcGVyX3NpemU6ICVpXG4iLCBpbmZvLmFwZXJfc2l6ZSk7DQog
ICBwcmludGYoInBnX3RvdGFsOiAlaVxuIiwgaW5mby5wZ190b3RhbCk7DQog
ICBwcmludGYoInBnX3N5c3RlbTogJWlcbiIsIGluZm8ucGdfc3lzdGVtKTsN
CiAgIHByaW50ZigicGdfdXNlZDogJWlcbiIsIGluZm8ucGdfdXNlZCk7DQoN
CiAgIG9wZW5tdHJyKCk7DQogICBpZiAobXRyciAhPSAtMSkgeyANCiAgICAg
Q292ZXJSYW5nZVdpdGhNVFJSKGluZm8uYXBlcl9iYXNlLCBpbmZvLmFwZXJf
c2l6ZSAqIDB4MTAwMDAwLCANCiAgICAgICBNVFJSX1RZUEVfV1JDT01CKTsN
CiAgIH0NCg0KICAgZ2FydCA9IG1tYXAoTlVMTCwgaW5mby5hcGVyX3NpemUg
KiAweDEwMDAwMCwgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwgTUFQX1NIQVJF
RCwgZ2FydGZkLCAwKTsNCg0KICAgaWYoZ2FydCA9PSAodW5zaWduZWQgY2hh
ciAqKSAweGZmZmZmZmZmKQ0KICAgICB7DQoJcGVycm9yKCJtbWFwIik7DQoJ
Y2xvc2UoZ2FydGZkKTsNCglleGl0KDEpOw0KICAgICB9CQ0KICAgDQogICBz
ZXR1cC5hZ3BfbW9kZSA9IGluZm8uYWdwX21vZGU7DQojaWZkZWYgREVCVUcN
CiAgIHByaW50ZigiVXNpbmcgQUdQSU9DX1NFVFVQXG4iKTsNCiNlbmRpZg0K
ICAgaWYoaW9jdGwoZ2FydGZkLCBBR1BJT0NfU0VUVVAsICZzZXR1cCkgIT0g
MCkNCiAgICAgew0KCXBlcnJvcigiaW9jdGwoQUdQSU9DX1NFVFVQKSIpOw0K
CWV4aXQoMSk7DQogICAgIH0NCiAgIA0KICAgcmV0dXJuKDApOw0KfQ0KDQpp
bnQgeGNoYW5nZUR1bW15Ow0KDQp2b2lkIEZsdXNoV3JpdGVDb21iaW5pbmco
IHZvaWQgKSB7DQoJX19hc21fXyB2b2xhdGlsZSggIiBwdXNoICUlZWF4IDsg
eGNoZyAlJWVheCwgJTAgOyBwb3AgJSVlYXgiIDogOiAibSIgKHhjaGFuZ2VE
dW1teSkpOw0KCV9fYXNtX18gdm9sYXRpbGUoICIgcHVzaCAlJWVheCA7IHB1
c2ggJSVlYnggOyBwdXNoICUlZWN4IDsgcHVzaCAlJWVkeCA7IG1vdmwgJDAs
JSVlYXggOyBjcHVpZCA7IHBvcCAlJWVkeCA7IHBvcCAlJWVjeCA7IHBvcCAl
JWVieCA7IHBvcCAlJWVheCIgOiAvKiBubyBvdXRwdXRzICovIDogIC8qIG5v
IGlucHV0cyAqLyApOw0KfQ0KDQp2b2lkIEJlbmNoTWFyaygpDQp7DQogIGlu
dCBpLCB3b3JrZWQgPSAxOw0KDQogIGkgPSBNZW1vcnlCZW5jaG1hcmsoZ2Fy
dCwgKDEwMjQgKiAxMDI0ICogNCkgLyA0KSArDQogICAgTWVtb3J5QmVuY2ht
YXJrKGdhcnQsICgxMDI0ICogMTAyNCAqIDQpIC8gNCkgKw0KICAgIE1lbW9y
eUJlbmNobWFyayhnYXJ0LCAoMTAyNCAqIDEwMjQgKiA0KSAvIDQpOw0KICAN
CiAgcHJpbnRmKCJBdmVyYWdlIHNwZWVkOiAlaSBtYi9zXG4iLCBpIC8zKTsN
CiAgDQogIHByaW50ZigiVGVzdGluZyBkYXRhIGludGVncml0eSAoMXN0IHBh
c3MpOiAiKTsNCiAgZmZsdXNoKHN0ZG91dCk7DQogICANCiAgRmx1c2hXcml0
ZUNvbWJpbmluZygpOw0KICANCiAgZm9yIChpPTA7IGkgPCA4ICogMHgxMDAw
MDA7IGkrKykNCiAgICB7DQogICAgICBnYXJ0W2ldID0gaSAlIDI1NjsNCiAg
ICB9DQogICANCiAgRmx1c2hXcml0ZUNvbWJpbmluZygpOw0KICAgDQogIA0K
ICBmb3IgKGk9MDsgaSA8IDggKiAweDEwMDAwMDsgaSsrKQ0KICAgIHsNCiAg
ICAgICBpZighKGdhcnRbaV0gPT0gaSAlIDI1NikpDQoJIHsNCiNpZmRlZiBE
RUJVRw0KCSAgICBwcmludGYoImZhaWxlZCBvbiAlaSwgZ2FydFtpXSA9ICVp
XG4iLCBpLCBnYXJ0W2ldKTsNCiNlbmRpZg0KCSAgICB3b3JrZWQgPSAwOw0K
CSB9DQogICAgfQ0KICANCiAgaWYgKCF3b3JrZWQpDQogICAgcHJpbnRmKCJm
YWlsZWQgb24gZmlyc3QgcGFzcyFcbiIpOw0KICBlbHNlDQogICAgcHJpbnRm
KCJwYXNzZWQgb24gZmlyc3QgcGFzcy5cbiIpOw0KICAgDQogICB1bmJpbmRf
Z2FydCgwKTsNCiAgIHVuYmluZF9nYXJ0KDEpOw0KICAgYmluZF9nYXJ0KDAs
IDApOw0KICAgYmluZF9nYXJ0KDEsIDEwMjQpOw0KDQogICB3b3JrZWQgPSAx
Ow0KICAgcHJpbnRmKCJUZXN0aW5nIGRhdGEgaW50ZWdyaXR5ICgybmQgcGFz
cyk6ICIpOw0KICAgZmZsdXNoKHN0ZG91dCk7DQogICANCiAgIGZvciAoaT0w
OyBpIDwgOCAqIDB4MTAwMDAwOyBpKyspDQogICAgew0KICAgICAgIGlmKCEo
Z2FydFtpXSA9PSBpICUgMjU2KSkNCgkgew0KI2lmZGVmIERFQlVHDQoJICAg
IHByaW50ZigiZmFpbGVkIG9uICVpLCBnYXJ0W2ldID0gJWlcbiIsIGksIGdh
cnRbaV0pOw0KI2VuZGlmDQoJICAgIHdvcmtlZCA9IDA7DQoJIH0NCiAgICB9
DQoNCiAgIGlmICghd29ya2VkKQ0KICAgIHByaW50ZigiZmFpbGVkIG9uIHNl
Y29uZCBwYXNzIVxuIik7DQogIGVsc2UNCiAgICBwcmludGYoInBhc3NlZCBv
biBzZWNvbmQgcGFzcy5cbiIpOw0KfQ0KDQppbnQgbWFpbigpDQp7DQogICBp
bnQgaTsNCiAgIGludCBrZXk7DQogICBpbnQga2V5MjsNCiAgIGFncF9pbmZv
IGluZm87DQogIA0KICAgZ2FydGZkID0gb3BlbigiL2Rldi9hZ3BnYXJ0Iiwg
T19SRFdSKTsNCiAgIGlmIChnYXJ0ZmQgPT0gLTEpDQogICAgIHsJDQoJcGVy
cm9yKCJvcGVuIik7DQoJZXhpdCgxKTsNCiAgICAgfQ0KICAgDQogICBpbml0
X2FncCgpOw0KICAgDQogICBrZXkgPSBpbnNlcnRfZ2FydCgwLCAxMDI0KTsN
CiAgIGtleTIgPSBpbnNlcnRfZ2FydCgxMDI0LCAxMDI0KTsNCiAgIA0KI2lm
ZGVmIERFQlVHDQogICBwcmludGYoIlVzaW5nIEFHUElPQ19JTkZPXG4iKTsN
CiAgIGlmKGlvY3RsKGdhcnRmZCwgQUdQSU9DX0lORk8sICZpbmZvKSAhPSAw
KQ0KICAgICB7DQoJcGVycm9yKCJpb2N0bChBR1BJT0NfSU5GTykiKTsNCgll
eGl0KDEpOw0KICAgICB9DQogICANCiAgIHByaW50ZigidmVyc2lvbjogJWku
JWlcbiIsIGluZm8udmVyc2lvbi5tYWpvciwgaW5mby52ZXJzaW9uLm1pbm9y
KTsNCiAgIHByaW50ZigiYnJpZGdlIGlkOiAweCVseFxuIiwgaW5mby5icmlk
Z2VfaWQpOw0KICAgcHJpbnRmKCJhZ3BfbW9kZTogMHglbHhcbiIsIGluZm8u
YWdwX21vZGUpOw0KICAgcHJpbnRmKCJhcGVyX2Jhc2U6IDB4JWx4XG4iLCBp
bmZvLmFwZXJfYmFzZSk7DQogICBwcmludGYoImFwZXJfc2l6ZTogJWlcbiIs
IGluZm8uYXBlcl9zaXplKTsNCiAgIHByaW50ZigicGdfdG90YWw6ICVpXG4i
LCBpbmZvLnBnX3RvdGFsKTsNCiAgIHByaW50ZigicGdfc3lzdGVtOiAlaVxu
IiwgaW5mby5wZ19zeXN0ZW0pOw0KICAgcHJpbnRmKCJwZ191c2VkOiAlaVxu
IiwgaW5mby5wZ191c2VkKTsNCiNlbmRpZg0KICAgDQogICBwcmludGYoIkFs
bG9jYXRlZCA4IG1lZ3Mgb2YgR0FSVCBtZW1vcnlcbiIpOw0KICAgDQogICBC
ZW5jaE1hcmsoKTsNCiAgIA0KICAgcmVtb3ZlX2dhcnQoa2V5KTsNCiAgIHJl
bW92ZV9nYXJ0KGtleTIpOw0KDQojaWZkZWYgREVCVUcgICANCiAgIHByaW50
ZigiVXNpbmcgQUdQSU9DX1JFTEVBU0VcbiIpOw0KI2VuZGlmDQogICBpZihp
b2N0bChnYXJ0ZmQsIEFHUElPQ19SRUxFQVNFKSAhPSAwKQ0KICAgICB7DQoJ
cGVycm9yKCJpb2N0bChBR1BJT0NfUkVMRUFTRSkiKTsNCglleGl0KDEpOw0K
ICAgICB9DQogICANCiAgIGNsb3NlKGdhcnRmZCk7DQp9DQoNCg==
--8323328-1848710380-973445588=:1154--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
