Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266308AbUBDEXj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 23:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266305AbUBDEXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 23:23:39 -0500
Received: from mail01e.rapidsite.net ([208.55.43.102]:12208 "HELO
	mail01e.rapidsite.net") by vger.kernel.org with SMTP
	id S266308AbUBDEXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 23:23:21 -0500
Date: Tue, 3 Feb 2004 23:23:14 -0500
From: Peter Hartzler <pete@hartzler.net>
To: linux-kernel@vger.kernel.org, perex@suse.cz, alsa-devel@alsa-project.org
Subject: 2.6.2-rc3: VIA ALSA Interrupt Bogosity
Message-ID: <20040204042314.GA9390@hartzler.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Loop-Detect: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've found a problem that seems to relate to interrupt handling in ALSA
VIA Audio subsystem.

The userland symptom is merely that xmms goes into an audible loop when
one clicks the stop button.

A pkill for xmms and a reload of the alsa modules clears the issue,
e.g., xmms seems OK again.

This is on a GA-6VTXD mobo.

I have not figured out how to reproduce the issue.  It does not happen
often, and does not seem to be correlated with any particular activity
that I can put my finger on.  It does happen reliably after running for
a day or three.

Please let me know if I can help track this down.  Please note that I am
not currently receiving LKML traffic.

-----------------------------------------------------------------------------
Syslog gets this:

Feb  3 11:05:01 boink kernel: irq 5: nobody cared!
Feb  3 11:05:01 boink kernel: Call Trace:
Feb  3 11:05:01 boink kernel:  [__report_bad_irq+42/144] __report_bad_irq+0x2a/0x90
Feb  3 11:05:01 boink kernel:  [note_interrupt+112/176] note_interrupt+0x70/0xb0
Feb  3 11:05:01 boink kernel:  [do_IRQ+352/416] do_IRQ+0x160/0x1a0
Feb  3 11:05:01 boink kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Feb  3 11:05:01 boink kernel:  [pcibios_lookup_irq+955/1008] pcibios_lookup_irq+0x3bb/0x3f0
Feb  3 11:05:01 boink kernel:  [tcp_recvmsg+391/1920] tcp_recvmsg+0x187/0x780
Feb  3 11:05:01 boink kernel:  [tcp_transmit_skb+1051/1584] tcp_transmit_skb+0x41b/0x630
Feb  3 11:05:01 boink kernel:  [inet_recvmsg+88/128] inet_recvmsg+0x58/0x80
Feb  3 11:05:01 boink kernel:  [sock_recvmsg+150/192] sock_recvmsg+0x96/0xc0
Feb  3 11:05:01 boink kernel:  [inet_wait_for_connect+218/240] inet_wait_for_connect+0xda/0xf0
Feb  3 11:05:01 boink kernel:  [sockfd_lookup+28/128] sockfd_lookup+0x1c/0x80
Feb  3 11:05:01 boink kernel:  [sys_recvfrom+178/288] sys_recvfrom+0xb2/0x120
Feb  3 11:05:01 boink kernel:  [inet_stream_connect+85/448] inet_stream_connect+0x55/0x1c0
Feb  3 11:05:01 boink kernel:  [sys_connect+143/176] sys_connect+0x8f/0xb0
Feb  3 11:05:01 boink kernel:  [sock_map_fd+278/320] sock_map_fd+0x116/0x140
Feb  3 11:05:01 boink kernel:  [sys_recv+51/64] sys_recv+0x33/0x40
Feb  3 11:05:01 boink kernel:  [sys_socketcall+404/688] sys_socketcall+0x194/0x2b0
Feb  3 11:05:01 boink kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb  3 11:05:01 boink kernel: 
Feb  3 11:05:01 boink kernel: handlers:
Feb  3 11:05:01 boink kernel: [_end+809465288/1068847048] (snd_via82xx_interrupt+0x0/0x190 [snd_via82xx])
Feb  3 11:05:01 boink kernel: Disabling IRQ #5
-----------------------------------------------------------------------------
! /usr/src/linux/scripts/ver_linux

Linux boink 2.6.2-rc3-200401302328 #1 SMP Fri Jan 30 23:43:02 EST 2004 i686 GNU/Linux
 
 Gnu C                  3.3.3
 Gnu make               3.80
 util-linux             2.12
 mount                  2.12
 module-init-tools      3.0-pre9
 e2fsprogs              1.35-WIP
 PPP                    2.4.2
 Linux C Library        2.3.2
 Dynamic linker (ldd)   2.3.2
 Procps                 3.1.15
 Net-tools              1.60
 Console-tools          0.2.3
 Sh-utils               5.0.91
 Modules Loaded         videodev ip6table_filter ip6_tables radeon ipv6 ipt_LOG ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_via82xx snd_pcm snd_timer snd_ac97_codec snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore tulip crc32 rtc

-----------------------------------------------------------------------------
:r /proc/version

Linux version 2.6.2-rc3-200401302328 (ph@boink) (gcc version 3.3.3 20040125 (prerelease) (Debian)) #1 SMP Fri Jan 30 23:43:02 EST 2004
-----------------------------------------------------------------------------
:r /proc/cpuinfo

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 6
cpu MHz		: 730.973
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1437.69

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 6
cpu MHz		: 730.973
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1458.17

-----------------------------------------------------------------------------
:r /proc/modules

videodev 7872 0 - Live 0xf0959000
ip6table_filter 2176 0 - Live 0xf08a8000
ip6_tables 17952 1 ip6table_filter, Live 0xf095c000
radeon 120972 0 - Live 0xf09d6000
ipv6 247904 20 - Live 0xf0998000
ipt_LOG 5344 3 - Live 0xf0931000
ipt_REJECT 5760 3 - Live 0xf0934000
ipt_state 1600 1 - Live 0xf092f000
ip_conntrack 28780 1 ipt_state, Live 0xf0939000
iptable_filter 2336 1 - Live 0xf0897000
ip_tables 17120 4 ipt_LOG,ipt_REJECT,ipt_state,iptable_filter, Live 0xf0929000
snd_seq_oss 36448 0 - Live 0xf08d0000
snd_seq_midi_event 6528 1 snd_seq_oss, Live 0xf0864000
snd_seq 62160 4 snd_seq_oss,snd_seq_midi_event, Live 0xf0906000
snd_pcm_oss 60676 0 - Live 0xf0919000
snd_mixer_oss 20256 1 snd_pcm_oss, Live 0xf08ca000
snd_via82xx 25344 1 - Live 0xf08a0000
snd_pcm 105440 2 snd_pcm_oss,snd_via82xx, Live 0xf08da000
snd_timer 26340 2 snd_seq,snd_pcm, Live 0xf0873000
snd_ac97_codec 56100 1 snd_via82xx, Live 0xf08aa000
snd_page_alloc 10116 2 snd_via82xx,snd_pcm, Live 0xf085a000
snd_mpu401_uart 7520 1 snd_via82xx, Live 0xf0861000
snd_rawmidi 23840 1 snd_mpu401_uart, Live 0xf087c000
snd_seq_device 7720 3 snd_seq_oss,snd_seq,snd_rawmidi, Live 0xf085e000
snd 59588 14 snd_seq_oss,snd_seq_midi_event,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_via82xx,snd_pcm,snd_timer,snd_ac97_codec,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 0xf0887000
soundcore 7840 1 snd, Live 0xf084e000
tulip 44704 0 - Live 0xf0867000
crc32 4032 1 tulip, Live 0xf0851000
rtc 11976 0 - Live 0xf0854000
-----------------------------------------------------------------------------
:r /proc/ioports

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0400-040f : 0000:00:07.4
0c00-0c7f : 0000:00:07.4
0cf8-0cff : PCI conf1
a000-afff : PCI Bus #01
  a800-a8ff : 0000:01:00.0
d400-d4ff : 0000:00:0a.0
  d400-d4ff : tulip
d800-d81f : 0000:00:07.2
  d800-d81f : uhci_hcd
dc00-dc1f : 0000:00:07.3
  dc00-dc1f : uhci_hcd
e000-e003 : 0000:00:07.5
  e000-e001 : VIA82xx MPU401
e400-e403 : 0000:00:07.5
e800-e8ff : 0000:00:07.5
  e800-e8ff : VIA686A
ec00-ecff : 0000:00:0c.0
fc00-fc0f : 0000:00:07.1
-----------------------------------------------------------------------------
:r /proc/iomem

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000cb000-000d15ff : Extension ROM
000f0000-000fffff : System ROM
00100000-2ffeffff : System RAM
  00100000-003652bc : Kernel code
  003652bd-0045531f : Kernel data
2fff0000-2fff7fff : ACPI Tables
2fff8000-2fffffff : ACPI Non-volatile Storage
cfb00000-dfbfffff : PCI Bus #01
  d0000000-d7ffffff : 0000:01:00.0
dfd00000-dfefffff : PCI Bus #01
  dfe80000-dfefffff : 0000:01:00.0
dfffec00-dfffefff : 0000:00:0a.0
  dfffec00-dfffefff : tulip
dffff000-dfffffff : 0000:00:0c.0
  dffff000-dfffffff : aic7xxx
e0000000-e3ffffff : 0000:00:00.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fffc0000-ffffffff : reserved
-----------------------------------------------------------------------------
:r /proc/interrupts

           CPU0       CPU1       
  0:  310972004         69    IO-APIC-edge  timer
  1:      42421          1    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  4:          1          0    IO-APIC-edge  serial
  5:     999999          1   IO-APIC-level  VIA686A
  8:         56          1    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 10:          0          0   IO-APIC-level  uhci_hcd, uhci_hcd
 12:    1589680          1    IO-APIC-edge  i8042
 14:     467089          1    IO-APIC-edge  ide0
 16:     485568          1   IO-APIC-level  aic7xxx
 18:     274068     442208   IO-APIC-level  eth0
NMI:          0          0 
LOC:  310982309  310982405 
ERR:          0
MIS:          0
-----------------------------------------------------------------------------
! lspci -v -v

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
        Subsystem: Giga-byte Technology: Unknown device 5000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
        Latency: 16
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: dfd00000-dfefffff
        Prefetchable memory behind bridge: cfb00000-dfbfffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
        Subsystem: Giga-byte Technology: Unknown device 5001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: Giga-byte Technology GA-7VAX Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at fc00 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology GA-7VAX Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology GA-7VAX Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Subsystem: Giga-byte Technology: Unknown device 5003
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 50)
        Subsystem: Giga-byte Technology: Unknown device a004
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 5
        Region 0: I/O ports at e800 [size=256]
        Region 1: I/O ports at e400 [size=4]
        Region 2: I/O ports at e000 [size=4]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Linksys Network Everywhere Fast Ethernet 10/100 model NC100 (rev 11)
        Subsystem: Linksys: Unknown device 0574
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63750ns min, 63750ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at d400 [size=256]
        Region 1: Memory at dfffec00 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at dffa0000 [disabled] [size=128K]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
        Subsystem: Adaptec 29160 Ultra160 SCSI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 16
        BIST result: 00
        Region 0: I/O ports at ec00 [disabled] [size=256]
        Region 1: Memory at dffff000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at dffc0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R100 QD [Radeon 7200] (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Radeon 7000/Radeon
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at a800 [size=256]
        Region 2: Memory at dfe80000 (32-bit, non-prefetchable) [size=512K]
        Expansion ROM at dfe60000 [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

-----------------------------------------------------------------------------
Thank you!

