Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423042AbWJYHhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423042AbWJYHhJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 03:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423045AbWJYHhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 03:37:09 -0400
Received: from eva.fit.vutbr.cz ([147.229.176.14]:48123 "EHLO eva.fit.vutbr.cz")
	by vger.kernel.org with ESMTP id S1423042AbWJYHhH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 03:37:07 -0400
Message-ID: <453F01CF.2040106@eva.fit.vutbr.cz>
Date: Wed, 25 Oct 2006 08:18:55 +0200
From: =?ISO-8859-2?Q?Radim_Lu=BEa?= <xluzar00@stud.fit.vutbr.cz>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: suspend to disk -> resume -> X with DRI extension on R100 chips hangs
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning

I noticed following problem:
After resuming from suspend to disk Xorg with DRI switched on hangs. 
System is not affected by Xorg hang. If I login via SSH I can kill X 
server and start it again - with same result. X server hangs even after 
I suspend from text mode with X not running and with unloaded modules 
radeon and drm and resume then and try to start X server. With DRI 
switched off in xorg.conf X resumes correctly.

Info about my system:

cat /proc/version
  Linux version 2.6.18 (root@b02-307b.kn.vutbr.cz) (gcc version 3.4.3 
(Mandrakelinux 10.2 3.4.3-7mdk)) #6 Wed Sep 27 10:07:17 CEST 2006

cat /proc/modules
tun 8576 1 - Live 0xe0c94000
8139too 22272 0 - Live 0xe0c9d000
mii 5120 1 8139too, Live 0xe0c38000
usbmouse 4736 0 - Live 0xe0c35000
usbhid 48160 0 - Live 0xe0cc4000
snd_rtctimer 2572 0 - Live 0xe0c17000
tsdev 6336 0 - Live 0xe0c32000
radeon 110880 1 - Live 0xe0ca7000
drm 60692 2 radeon, Live 0xe0c40000
joydev 8256 0 - Live 0xe0c1d000
mousedev 10144 1 - Live 0xe0c19000
psmouse 37512 0 - Live 0xe0c21000
cpufreq_ondemand 5104 0 - Live 0xe0bf0000
cpufreq_userspace 3220 0 - Live 0xe0bba000
cpufreq_powersave 1664 0 - Live 0xe0bb8000
p4_clockmod 4364 0 - Live 0xe0bb5000
speedstep_lib 3972 1 p4_clockmod, Live 0xe0bb3000
freq_table 3716 1 p4_clockmod, Live 0xe087c000
ipv6 228192 16 - Live 0xe0c51000
snd_seq_dummy 2948 0 - Live 0xe0bb1000
snd_seq_oss 30208 0 - Live 0xe0bbc000
snd_seq_midi_event 6016 1 snd_seq_oss, Live 0xe0b9a000
snd_seq 44752 5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event, Live 
0xe0be4000
snd_seq_device 6668 3 snd_seq_dummy,snd_seq_oss,snd_seq, Live 0xe0ba2000
snd_pcm_oss 42400 0 - Live 0xe0bd8000
snd_mixer_oss 15744 1 snd_pcm_oss, Live 0xe0b9d000
snd_ali5451 20108 1 - Live 0xe0b6c000
snd_ac97_codec 91168 1 snd_ali5451, Live 0xe0bf6000
snd_ac97_bus 2176 1 snd_ac97_codec, Live 0xe0b6a000
snd_pcm 69000 3 snd_pcm_oss,snd_ali5451,snd_ac97_codec, Live 0xe0bc6000
snd_timer 19588 3 snd_rtctimer,snd_seq,snd_pcm, Live 0xe0b45000
snd_page_alloc 8072 1 snd_pcm, Live 0xe0b67000
snd 42852 11 
snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_ali5451,snd_ac97_codec,snd_pcm,snd_timer, 
Live0xe0ba5000
soundcore 7392 1 snd, Live 0xe0b64000
parport_pc 31556 1 - Live 0xe0b8e000
lp 10312 0 - Live 0xe0b60000
parport 31560 2 parport_pc,lp, Live 0xe0b50000
irlan 24208 0 - Live 0xe0b59000
irda 108472 1 irlan, Live 0xe0b72000
crc_ccitt 2048 1 irda, Live 0xe087e000
af_packet 16136 0 - Live 0xe0b4b000
eeprom 5648 0 - Live 0xe0b42000
i2c_ali1535 6276 0 - Live 0xe0860000
pcmcia 30764 2 - Live 0xe0b30000
yenta_socket 24844 2 - Live 0xe0b3a000
rsrc_nonstatic 11264 1 yenta_socket, Live 0xe0b2c000
pcmcia_core 34064 3 pcmcia,yenta_socket,rsrc_nonstatic, Live 0xe0af6000
sbs 12448 0 - Live 0xe0af1000
i2c_ec 4224 1 sbs, Live 0xe0876000
i2c_core 16912 3 eeprom,i2c_ali1535,i2c_ec, Live 0xe0aeb000
ide_cd 36868 0 - Live 0xe0b21000
loop 13064 0 - Live 0xe0ae6000
nls_iso8859_2 4608 1 - Live 0xe0873000
nls_cp852 4864 1 - Live 0xe0863000
vfat 10112 1 - Live 0xe086f000
fat 46876 1 vfat, Live 0xe0ad9000
ali_agp 5760 1 - Live 0xe085d000
agpgart 28080 2 drm,ali_agp, Live 0xe0867000
nvram 6792 0 - Live 0xe082f000
evdev 8320 1 - Live 0xe0859000
ohci_hcd 18436 0 - Live 0xe0853000
usbcore 113924 4 usbmouse,usbhid,ohci_hcd, Live 0xe0a56000
video 14852 0 - Live 0xe0834000
thermal 11656 0 - Live 0xe0839000
processor 22956 1 thermal, Live 0xe0845000
ibm_acpi 24064 0 - Live 0xe083e000
fan 3844 0 - Live 0xe0832000
dock 5768 0 - Live 0xe081b000
container 3584 0 - Live 0xe0823000
button 5392 0 - Live 0xe0820000
battery 8196 0 - Live 0xe082b000
asus_acpi 14104 0 - Live 0xe0826000
ac 3844 0 - Live 0xe081e000


cat /proc/ioports
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
04d0-04d1 : pnp 00:07
04d6-04d6 : pnp 00:07
0778-077a : parport0
0cf8-0cff : PCI conf1
1000-10ff : 0000:00:04.0
  1000-10ff : ALI 5451
1400-14ff : 0000:00:08.0
  1400-14ff : 8139too
1800-180f : 0000:00:0b.0
1810-181f : 0000:00:0f.0
  1810-1817 : ide0
  1818-181f : ide1
1c00-1cff : PCI CardBus #02
2000-20ff : PCI CardBus #02
3810-381f : motherboard
  3810-381f : pnp 00:07
8000-803f : 0000:00:06.0
  8000-8003 : ACPI PM1a_EVT_BLK
  8004-8005 : motherboard
  8008-800b : ACPI PM_TMR
  8010-8015 : ACPI CPU throttle
  8018-8027 : ACPI GPE0_BLK
  8030-8030 : ACPI PM2_CNT_BLK
8040-805f : 0000:00:06.0
  8040-805f : ali1535_smbus
9000-9fff : PCI Bus #01
  9000-90ff : 0000:01:00.0
fe10-fe11 : motherboard
  fe10-fe11 : ACPI PM1a_CNT_BLK


cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cefff : Video ROM
000cf000-000cffff : Adapter ROM
000f0000-000fffff : System ROM
00100000-1feeffff : System RAM
  00100000-0032dcff : Kernel code
  0032dd00-003e44f3 : Kernel data
1fef0000-1fefefff : ACPI Tables
1feff000-1fefffff : ACPI Non-volatile Storage
1ff00000-1fffffff : reserved
30000000-31ffffff : PCI CardBus #02
32000000-33ffffff : PCI CardBus #02
34000000-34000fff : 0000:00:0a.0
  34000000-34000fff : yenta_socket
e0000000-e0000fff : 0000:00:02.0
  e0000000-e0000fff : ohci_hcd
e0001000-e0001fff : 0000:00:04.0
  e0001000-e0001fff : ALI 5451
e0002000-e00020ff : 0000:00:08.0
  e0002000-e00020ff : 8139too
e0003000-e0003fff : 0000:00:09.0
e0100000-e01fffff : PCI Bus #01
  e0100000-e010ffff : 0000:01:00.0
  e0120000-e013ffff : 0000:01:00.0
e8000000-efffffff : PCI Bus #01
  e8000000-efffffff : 0000:01:00.0
    e8000000-e9ffffff : vesafb
f0000000-f7ffffff : 0000:00:00.0
fffc0000-ffffffff : reserved




lspci -vvv
00:00.0 Host bridge: ALi Corporation M1671 Super P4 Northbridge 
[AGP4X,PCI and SDR/DDR] (rev 02)
        Subsystem: Hewlett-Packard Company: Unknown device 0027
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: <available only to root>

00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller (prog-if 00 
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: e0100000-e01fffff
        Prefetchable memory behind bridge: e8000000-efffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) 
(prog-if 10 [OHCI])
        Subsystem: Hewlett-Packard Company: Unknown device 0027
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <available only to root>

00:04.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link 
Controller Audio Device (rev 02)
        Subsystem: Hewlett-Packard Company: Unknown device 0027
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR+ <PERR+
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 1000 [size=256]
        Region 1: Memory at e0001000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <available only to root>

00:06.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
        Subsystem: Hewlett-Packard Company: Unknown device 0027
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
        Subsystem: Hewlett-Packard Company: Unknown device 0027
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: <available only to root>

00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Hewlett-Packard Company: Unknown device 0027
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 1400 [size=256]
        Region 1: Memory at e0002000 (32-bit, non-prefetchable) [size=256]
        Capabilities: <available only to root>

00:09.0 Network controller: Intersil Corporation Prism 2.5 Wavelan 
chipset (rev 01)
        Subsystem: Actiontec Electronics Inc: Unknown device 1406
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e0003000 (32-bit, prefetchable) [size=4K]
        Capabilities: <available only to root>

00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus 
Controller (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 20
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 34000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 30000000-31fff000 (prefetchable)
        Memory window 1: 32000000-33fff000
        I/O window 0: 00001c00-00001cff
        I/O window 1: 00002000-000020ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ 
PostWrite+

00:0b.0 Communication controller: ESS Technology ES2838/2839 SuperLink 
Modem (rev 01)
        Subsystem: Hewlett-Packard Company: Unknown device 0020
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 1800 [size=16]
        Capabilities: <available only to root>

00:0f.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if fa)
        Subsystem: Hewlett-Packard Company: Unknown device 0027
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 255
        Region 4: I/O ports at 1810 [size=16]
        Capabilities: <available only to root>

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility 
M6 LY (prog-if 00 [VGA])
        Subsystem: Hewlett-Packard Company: Unknown device 0027
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR+ FastB2B+
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 9000 [size=256]
        Region 2: Memory at e0100000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at e0120000 [disabled] [size=128K]
        Capabilities: <available only to root>




cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 Mobile CPU 1.40GHz
stepping        : 4
cpu MHz         : 1400.000
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2802.66




My distro is Mandriva 2005 with Xorg 6.8.2.

This problem also appeared on another computer with Madriva 2007 and 
Xorg 7.1 - same kernel 2.6.18.

