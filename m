Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWDZJ0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWDZJ0w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 05:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWDZJ0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 05:26:52 -0400
Received: from ns.bitdefender.com ([217.156.83.1]:36737 "EHLO
	mail.bitdefender.com") by vger.kernel.org with ESMTP
	id S1751111AbWDZJ0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 05:26:51 -0400
Date: Wed, 26 Apr 2006 12:26:46 +0300
From: Razvan Stoica <mstoica@bitdefender.com>
X-Mailer: The Bat! (v3.60.07) Professional
Reply-To: Razvan Stoica <mstoica@bitdefender.com>
Organization: SOFTWIN
X-Priority: 3 (Normal)
Message-ID: <98045022.20060426122646@bitdefender.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM  when restarting xdm
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-BitDefender-SpamStamp: 1.1.4 
 049000040111AAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAQ
X-BitDefender-Scanner: Clean, Agent: BitDefender Qmail 1.6.2 on
 mail.bitdefender.com
X-BitDefender-Spam: No (16)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
As directed by the helpful REPORTING-BUGS document, I am submitting to
your attention this info, in the hope that it may be useful. I suspect
I should be actually submitting this report to ATI, but perhaps you
guys could also help, or I may be mistaken:

1. apparent kernel bug surfaces when restarting xdm
2. when restarting xdm, the following is spit into dmesg and the local
display, keyboard and mouse go dead. The machine is still accessible
remotely and nothing else seems amiss afaict.

Here's the dmesg output:
------------[ cut here ]------------
kernel BUG at arch/i386/mm/pageattr.c:137!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: fglrx agpgart it87 hwmon_vid i2c_isa ip_nat_irc ip_conntrack_irc lp snd_seq_midi snd_seq_midi_event snd_seq usbhid ns558 snd_mpu401 parport_pc parport pcspkr via_rhine snd_via82xx gameport snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd i2c_viapro btaudio soundcore tuner bttv video_buf firmware_class v4l2_common btcx_risc tveeprom videodev hangcheck_timer rtc msr cpuid
CPU:    0
EIP:    0060:[<c0113a16>]    Tainted: P      VLI
EFLAGS: 00013082   (2.6.15-gentoo-r1)
EIP is at __change_page_attr+0xba/0x15a
eax: 1a0001e3   ebx: 1a080000   ecx: c10086c0   edx: da080000
esi: c0436da0   edi: c1000000   ebp: 00000163   esp: dc229e74
ds: 007b   es: 007b   ss: 0068
Process X (pid: 25290, threadinfo=dc228000 task=ddac7070)
Stack: da080000 c1341000 00000020 00000000 00003246 c0113adf c1341000 00000163
       dc607fe0 e0b40000 e0b34b60 00000000 c0113795 c1340c00 00000021 00000163
       e0b34b60 00000005 e0aced7d e0b40000 c1340c00 00000020 00000163 e0b34b60
Call Trace:
 [<c0113adf>] change_page_attr+0x29/0x5a
 [<c0113795>] iounmap+0xb2/0xe9
 [<e0aced7d>] agp_generic_free_gatt_table+0x62/0xce [fglrx]
 [<e0ad4de0>] agp_backend_cleanup+0xc/0x4a [fglrx]
 [<e0ad8061>] __ke_agp_uninit+0xe/0x24 [fglrx]
 [<e0aeff45>] _firegl_release_agp+0x15/0x140 [fglrx]
 [<e0add525>] firegl_takedown+0x335/0xb80 [fglrx]
 [<e0adc8cf>] firegl_release+0x12f/0x190 [fglrx]
 [<e0ad51cb>] ip_firegl_release+0xd/0x10 [fglrx]
 [<c0151328>] __fput+0x83/0x130
 [<c014fe48>] filp_close+0x4c/0x55
 [<c014feb2>] sys_close+0x61/0x84
 [<c0102b8d>] syscall_call+0x7/0xb
Code: 24 04 56 e8 03 ff ff ff 89 d9 83 c4 0c 8b 01 89 ca f6 c4 40 74 03 8b 51 0c ff 42 04 eb 15 84 c0 78 09 09 eb 89 1e ff 49 04 eb 08 <0f> 0b 89 00 a5 9c 35 c0 8b 01 f6 c4 04 0f 85 85 00 00 00 8b 01
 <6>note: X[25290] exited with preempt_count 2

3. Keywords: X, pageattr.c, agp

4. cat /proc/version
Linux version 2.6.15-gentoo-r1 (root@home-104020) (gcc version 3.4.5 (Gentoo 3.4.5, ssp-3.4.5-1.0, pie-8.7.9)) #9 PREEMPT

5. The most recent kernel version which did not exhibit the same
problem was 2.6.14 However, I have made a lot of changes when
switching to 2.6.15, most notably reverting to the use of the fglrx
ATI driver instead of the radeon driver provided with the kernel (as
my radeon 9200 SE card behaves strangely with the in-kernel driver) and
upgrading X.

6.

8. Environment
8.1 ver_linux output
Linux home-104020 2.6.15-gentoo-r1 #9 PREEMPT Tue Apr 4 11:30:34 EEST 2006 i686 AMD Athlon(TM) XP 2000+ AuthenticAMD GNU/Linux

Gnu C                  3.4.5
Gnu make               3.80
binutils               2.16.1
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.1
e2fsprogs              1.38
jfsutils               1.1.8
reiserfsprogs          line
reiser4progs           line
xfsprogs               2.7.11
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.6
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   079
Modules Loaded         bttv video_buf firmware_class v4l2_common btcx_risc tveeprom videodev via_agp it87 hwmon_vid i2c_isa fglrx agpgart ip_nat_irc ip_conntrack_irc lp snd_seq_midi snd_seq_midi_event snd_seq usbhid ns558 snd_mpu401 parport_pc parport pcspkr via_rhine snd_via82xx gameport snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd i2c_viapro btaudio soundcore tuner hangcheck_timer rtc msr cpuid
 
8.2 cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(TM) XP 2000+
stepping        : 0
cpu MHz         : 1244.163
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 2489.59

8.3 cat /proc/modules
bttv 143568 0 - Live 0xe0ba1000
video_buf 15364 1 bttv, Live 0xe08c9000
firmware_class 7296 1 bttv, Live 0xe08f3000
v4l2_common 4608 1 bttv, Live 0xe08f0000
btcx_risc 3592 1 bttv, Live 0xe0823000
tveeprom 12176 1 bttv, Live 0xe08ab000
videodev 6784 1 bttv, Live 0xe08c0000
via_agp 7232 1 - Live 0xe08b4000
it87 16804 0 - Live 0xe0a4a000
hwmon_vid 1984 1 it87, Live 0xe0825000
i2c_isa 3264 1 it87, Live 0xe09e9000
fglrx 430944 5 - Live 0xe0acd000
agpgart 25672 2 via_agp,fglrx, Live 0xe0a42000
ip_nat_irc 1856 0 - Live 0xe0827000
ip_conntrack_irc 4912 1 ip_nat_irc, Live 0xe09ff000
lp 8196 0 - Live 0xe0a0c000
snd_seq_midi 6048 0 - Live 0xe09d8000
snd_seq_midi_event 5504 1 snd_seq_midi, Live 0xe09f9000
snd_seq 42064 2 snd_seq_midi,snd_seq_midi_event, Live 0xe0a1a000
usbhid 30816 0 - Live 0xe0a03000
ns558 4292 0 - Live 0xe09f6000
snd_mpu401 4872 0 - Live 0xe09f3000
parport_pc 28164 1 - Live 0xe09e1000
parport 28616 2 lp,parport_pc, Live 0xe09eb000
pcspkr 1540 0 - Live 0xe09d6000
via_rhine 17860 0 - Live 0xe09db000
snd_via82xx 20888 0 - Live 0xe0925000
gameport 10568 3 ns558,snd_via82xx, Live 0xe0959000
snd_ac97_codec 78624 1 snd_via82xx, Live 0xe0932000
snd_ac97_bus 1792 1 snd_ac97_codec, Live 0xe08d8000
snd_pcm 68232 2 snd_via82xx,snd_ac97_codec, Live 0xe0947000
snd_timer 18372 2 snd_seq,snd_pcm, Live 0xe092c000
snd_page_alloc 7496 2 snd_via82xx,snd_pcm, Live 0xe091b000
snd_mpu401_uart 5312 2 snd_mpu401,snd_via82xx, Live 0xe0918000
snd_rawmidi 18208 2 snd_seq_midi,snd_mpu401_uart, Live 0xe091f000
snd_seq_device 6156 3 snd_seq_midi,snd_seq,snd_rawmidi, Live 0xe0915000
snd 41252 9 snd_seq,snd_mpu401,snd_via82xx,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 0xe08e4000
i2c_viapro 6548 0 - Live 0xe08c6000
btaudio 12816 0 - Live 0xe08d1000
soundcore 6816 2 snd,btaudio, Live 0xe08ce000
tuner 35492 0 - Live 0xe08da000
hangcheck_timer 3160 0 - Live 0xe08b2000
rtc 6612 0 - Live 0xe08af000
msr 2564 0 - Live 0xe08a7000
cpuid 2308 0 - Live 0xe08a9000


8.4.1 cat /proc/ioports
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
0200-0207 : ns558-pnp
0290-0297 : pnp 00:0e
  0290-0297 : it87-isa
0330-0331 : MPU401 UART
0370-0375 : pnp 00:0e
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0778-077a : parport0
0cf8-0cff : PCI conf1
a400-a4ff : 0000:00:12.0
  a400-a4ff : via-rhine
a800-a80f : 0000:00:11.1
  a800-a807 : ide0
  a808-a80f : ide1
b000-b01f : 0000:00:10.2
  b000-b01f : uhci_hcd
b400-b41f : 0000:00:10.1
  b400-b41f : uhci_hcd
b800-b81f : 0000:00:10.0
  b800-b81f : uhci_hcd
d000-dfff : PCI Bus #01
  d800-d8ff : 0000:01:00.0
e000-e0ff : 0000:00:11.5
  e000-e0ff : VIA8233
e400-e47f : 0000:00:11.0
  e400-e47f : motherboard
    e400-e403 : PM1a_EVT_BLK
    e404-e405 : PM1a_CNT_BLK
    e408-e40b : PM_TMR
    e420-e423 : GPE0_BLK
e800-e80f : 0000:00:11.0
  e800-e807 : vt596_smbus

8.4.2  cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000ccfff : Video ROM
000d8000-000d97ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-1fffbfff : System RAM
  00100000-00346702 : Kernel code
  00346703-0040df1f : Kernel data
1fffc000-1fffefff : ACPI Tables
1ffff000-1fffffff : ACPI Non-volatile Storage
e5000000-e50000ff : 0000:00:12.0
  e5000000-e50000ff : via-rhine
e5800000-e58000ff : 0000:00:10.3
  e5800000-e58000ff : ehci_hcd
e6000000-e67fffff : PCI Bus #01
  e6000000-e600ffff : 0000:01:00.0
e6800000-e6800fff : 0000:00:0b.1
  e6800000-e6800fff : btaudio
e7000000-e7000fff : 0000:00:0b.0
  e7000000-e7000fff : bttv0
e7f00000-efffffff : PCI Bus #01
  e7fe0000-e7ffffff : 0000:01:00.0
  e8000000-efffffff : 0000:01:00.0
f0000000-f7ffffff : 0000:00:00.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved


8.5 lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge
        Subsystem: ASUSTeK Computer Inc. A7V8X motherboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [80] AGP version 3.5
                Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW+ Rate=x8
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: e6000000-e67fffff
        Prefetchable memory behind bridge: e7f00000-efffffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 177
        Region 0: Memory at e7000000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 177
        Region 0: Memory at e6800000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. A7V8X-X motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Interrupt: pin A routed to IRQ 169
        Region 4: I/O ports at b800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. A7V8X-X motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Interrupt: pin B routed to IRQ 169
        Region 4: I/O ports at b400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. A7V8X-X motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Interrupt: pin C routed to IRQ 169
        Region 4: I/O ports at b000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
        Subsystem: ASUSTeK Computer Inc. A7V8X-X motherboard rev 1.01
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 10
        Interrupt: pin D routed to IRQ 169
        Region 0: Memory at e5800000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
        Subsystem: ASUSTeK Computer Inc. A7V8X-X motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: ASUSTeK Computer Inc. A7V8X-X motherboard rev. 1.01
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 255
        Region 4: I/O ports at a800 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
        Subsystem: ASUSTeK Computer Inc. A7V8X-X Motherboard
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 185
        Region 0: I/O ports at e000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
        Subsystem: ASUSTeK Computer Inc. A7V8X-X Motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 193
        Region 0: I/O ports at a400 [size=256]
        Region 1: Memory at e5000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01) (prog-if 00 [VGA])
        Subsystem: C.P. Technology Co. Ltd CN-AG92E
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 255 (2000ns min), Cache Line Size 08
        Interrupt: pin A routed to IRQ 201
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at d800 [size=256]
        Region 2: Memory at e6000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at e7fe0000 [disabled] [size=128K]
        Capabilities: [58] AGP version 3.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW+ Rate=x8
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

8.6 Other stuff I think might help:

cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0xe8000000 (3712MB), size=  64MB: write-combining, count=1
reg07: base=0xf0000000 (3840MB), size= 128MB: write-combining, count=2

That's all, folks. Hope I was of assistance.

-- 

 Razvan Stoica 




-- 
This message was scanned for spam and viruses by BitDefender.
For more information please visit http://www.bitdefender.com/

