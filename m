Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbTIQIYj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 04:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbTIQIYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 04:24:39 -0400
Received: from pop.gmx.de ([213.165.64.20]:61897 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262707AbTIQIY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 04:24:28 -0400
Date: Wed, 17 Sep 2003 10:24:26 +0200 (MEST)
From: "Daniel Engelschalt" <daniel.engelschalt@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: 2.6.0-test5: Unable to handle kernel paging request
X-Priority: 3 (Normal)
X-Authenticated: #1538274
Message-ID: <31985.1063787066@www40.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

using 2.6.0-test5 vanilla i get the following:

ksymoops 2.4.9 on i686 2.6.0-test5.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test5/ (default)
     -m /usr/src/linux/System.map (default)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Sep 17 09:04:05 A405a kernel: Unable to handle kernel paging request at
virtual address 080000b0
Sep 17 09:04:05 A405a kernel: c0184cff
Sep 17 09:04:05 A405a kernel: *pde = 151b9067
Sep 17 09:04:05 A405a kernel: Oops: 0000 [#3]
Sep 17 09:04:05 A405a kernel: CPU:    0
Sep 17 09:04:05 A405a kernel: EIP:    0060:[iput+11/112]    Tainted: PF 
Sep 17 09:04:05 A405a kernel: EIP:    0060:[<c0184cff>]    Tainted: PF 
Using defaults from ksymoops -t elf32-i386 -a i386
Sep 17 09:04:05 A405a kernel: EFLAGS: 00010206
Sep 17 09:04:05 A405a kernel: eax: 00000000   ebx: 08000000   ecx: da5e29a4 
 edx: da5e29a4
Sep 17 09:04:05 A405a kernel: esi: da5e2968   edi: dfe00000   ebp: dfe01e84 
 esp: dfe01e80
Sep 17 09:04:05 A405a kernel: ds: 007b   es: 007b   ss: 0068
Sep 17 09:04:05 A405a kernel: Stack: 08000000 dfe01e9c c017f026 08000000
0000005f 0000005f dffea730 dfe01ea8 
Sep 17 09:04:05 A405a kernel:        c017fd9e 00000024 dfe01ee0 c0149ed0
0000005f 000000d0 000001fa c03176e4 
Sep 17 09:04:05 A405a kernel:        ffffff03 00000000 00000000 c0317de0
dfe00000 000000df 00000000 0001cf72 
Sep 17 09:04:05 A405a kernel: Call Trace:
Sep 17 09:04:05 A405a kernel:  [<c017f026>] prune_dcache+0x416/0x5fc
Sep 17 09:04:05 A405a kernel:  [<c017fd9e>] shrink_dcache_memory+0x16/0x34
Sep 17 09:04:05 A405a kernel:  [<c0149ed0>] shrink_slab+0x108/0x160
Sep 17 09:04:05 A405a kernel:  [<c014bb30>] balance_pgdat+0x134/0x1e0
Sep 17 09:04:05 A405a kernel:  [<c014bcc1>] kswapd+0xe5/0xec
Sep 17 09:04:05 A405a kernel:  [<c014bbdc>] kswapd+0x0/0xec
Sep 17 09:04:05 A405a kernel:  [<c011c120>]
autoremove_wake_function+0x0/0x3c
Sep 17 09:04:05 A405a kernel:  [<c011c120>]
autoremove_wake_function+0x0/0x3c
Sep 17 09:04:05 A405a kernel:  [<c0107385>] kernel_thread_helper+0x5/0xc
Sep 17 09:04:05 A405a kernel: Code: 8b 83 b0 00 00 00 8b 40 24 83 bb a0 01
00 00 20 75 08 0f 0b 


>>EIP; c0184cff <iput+b/70>   <=====

>>ecx; da5e29a4 <_end+1a23dd38/3fc59394>
>>edx; da5e29a4 <_end+1a23dd38/3fc59394>
>>esi; da5e2968 <_end+1a23dcfc/3fc59394>
>>edi; dfe00000 <_end+1fa5b394/3fc59394>
>>ebp; dfe01e84 <_end+1fa5d218/3fc59394>
>>esp; dfe01e80 <_end+1fa5d214/3fc59394>

Trace; c017f026 <prune_dcache+416/5fc>
Trace; c017fd9e <shrink_dcache_memory+16/34>
Trace; c0149ed0 <shrink_slab+108/160>
Trace; c014bb30 <balance_pgdat+134/1e0>
Trace; c014bcc1 <kswapd+e5/ec>
Trace; c014bbdc <kswapd+0/ec>
Trace; c011c120 <autoremove_wake_function+0/3c>
Trace; c011c120 <autoremove_wake_function+0/3c>
Trace; c0107385 <kernel_thread_helper+5/c>

Code;  c0184cff <iput+b/70>
00000000 <_EIP>:
Code;  c0184cff <iput+b/70>   <=====
   0:   8b 83 b0 00 00 00         mov    0xb0(%ebx),%eax   <=====
Code;  c0184d05 <iput+11/70>
   6:   8b 40 24                  mov    0x24(%eax),%eax
Code;  c0184d08 <iput+14/70>
   9:   83 bb a0 01 00 00 20      cmpl   $0x20,0x1a0(%ebx)
Code;  c0184d0f <iput+1b/70>
  10:   75 08                     jne    1a <_EIP+0x1a> c0184d19
<iput+25/70>
Code;  c0184d11 <iput+1d/70>
  12:   0f 0b                     ud2a  


---------------------------------------------------------------------------------------
ver_linux:
Linux lisi 2.6.0-test5 #3 Tue Sep 16 17:54:25 CEST 2003 i686 AMD Athlon(tm)
Processor AuthenticAMD GNU/Linux

Gnu C                  2.95.3
Gnu make               3.80
util-linux             2.11r
mount                  2.11r
e2fsprogs              1.33
reiserfsprogs          3.6.2
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               5.0
Modules Loaded         ipt_limit ipt_LOG ipt_state iptable_filter
ip_conntrack_ftp ip_conntrack snd_seq_midi snd_emu10k1_synth snd_emux_synth
snd_seq_virmidi snd_seq_midi_emul snd_emu10k1 snd_rawmidi snd_ac97_codec snd_util_mem
snd_hwdep snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss
snd_pcm snd_page_alloc snd_timer snd_mixer_oss snd usbcore ip_tables tuner
tvaudio msp3400 bttv video_buf btcx_risc v4l2_common videodev soundcore nvidia
sr_mod sg ide_scsi scsi_mod
3c59x
---------------------------------------------------------------------------------------
 cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 807.511
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        :
1589.24
---------------------------------------------------------------------------------------
cat /proc/ioports
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
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
8000-803f : 0000:00:11.0
  8000-8007 : ide2
  8008-800f : ide3
  8010-803f : PDC20265
8400-8403 : 0000:00:11.0
8800-8807 : 0000:00:11.0
9000-9003 : 0000:00:11.0
  9002-9002 : ide2
9400-9407 : 0000:00:11.0
  9400-9407 : ide2
9800-9807 : 0000:00:0d.1
a000-a01f : 0000:00:0d.0
  a000-a01f : EMU10K1
a400-a47f : 0000:00:09.0
  a400-a47f : 0000:00:09.0
d000-d01f : 0000:00:04.3
d400-d41f : 0000:00:04.2
d800-d80f : 0000:00:04.1
  d800-d807 : ide0
  d808-d80f : ide1
e200-e27f : 0000:00:04.4
e400-e4ff : 0000:00:04.4
e800-e80f :
0000:00:04.4
---------------------------------------------------------------------------------------
cat /proc/iomem
00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000cc000-000ce7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffebfff : System RAM
  00100000-0029d126 : Kernel code
  0029d127-003480ff : Kernel data
1ffec000-1ffeefff : ACPI Tables
1ffef000-1fffefff : reserved
1ffff000-1fffffff : ACPI Non-volatile Storage
d3000000-d301ffff : 0000:00:11.0
d3800000-d3803fff : 0000:00:0d.2
d4000000-d40007ff : 0000:00:0d.2
d4800000-d480007f : 0000:00:09.0
d5000000-d66fffff : PCI Bus #01
  d5000000-d5ffffff : 0000:01:00.0
d6800000-d6800fff : 0000:00:0a.1
d7000000-d7000fff : 0000:00:0a.0
  d7000000-d7000fff : bttv0
d7f00000-e77fffff : PCI Bus #01
  d8000000-dfffffff : 0000:01:00.0
e7800000-e7bfffff : 0000:00:00.0
ffff0000-ffffffff :
reserved
---------------------------------------------------------------------------------------
lspci -vvv

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev
02)
        Subsystem: Asustek Computer, Inc. A7V Mainboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at e7800000 (32-bit, prefetchable) [size=4M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
(prog-i
f 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: d5000000-d66fffff
        Prefetchable memory behind bridge: d7f00000-e77fffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: d5000000-d66fffff
        Prefetchable memory behind bridge: d7f00000-e77fffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 22)
        Subsystem: Asustek Computer, Inc. A7V Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus
Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d800 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 7
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 7
        Region 4: I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
        Subsystem: Asustek Computer, Inc. A7V Mainboard
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 7
        Region 0: I/O ports at a400 [size=128]
        Region 1: Memory at d4800000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at d7000000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
(rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at d6800000 (32-bit, prefetchable) [disabled]
[size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Multimedia audio controller: Creative Labs SB Audigy (rev 03)
        Subsystem: Creative Labs SB0090 Audigy Player/OEM
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 7
        Region 0: I/O ports at a000 [size=32]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (rev
03)
        Subsystem: Creative Labs SB Audigy MIDI/Game Port
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at 9800 [disabled] [size=8]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (prog-if
10 [OHCI])
        Subsystem: Creative Labs SB Audigy FireWire Port
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max), cache line size 08
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at d4000000 (32-bit, non-prefetchable) [disabled]
[size=2K]
        Region 1: Memory at d3800000 (32-bit, non-prefetchable) [disabled]
[size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev
02)
        Subsystem: Promise Technology, Inc. Ultra100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 9400 [size=8]
        Region 1: I/O ports at 9000 [size=4]
        Region 2: I/O ports at 8800 [size=8]
        Region 3: I/O ports at 8400 [size=4]
        Region 4: I/O ports at 8000 [size=64]
        Region 5: Memory at d3000000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV15 [GeForce2
GTS/Pro] (rev a4) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d5000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at d7ff0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

