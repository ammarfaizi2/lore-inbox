Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbTFJMiT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 08:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTFJMiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 08:38:19 -0400
Received: from vhe-400091.sshn.net ([195.169.216.157]:53889 "EHLO
	mail.bzzt.net") by vger.kernel.org with ESMTP id S262568AbTFJMiM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 08:38:12 -0400
Date: Tue, 10 Jun 2003 14:51:53 +0200
From: Arnout Engelen <arnouten@bzzt.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel oops in 2.4.20
Message-ID: <20030610125153.GA2000@mintzer.sci.kun.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Face: +5<4p=wAw9CfJeb1<hQ00$(XX}yW8|;[cNn$0-g3^'hK]x<&P!src8~L,{Kc!=@^B]qREua(*y9Iq*bYeNSB<}n5pcUmHO'18A>)}#72dL9Kz#0|wnyTLORn(~.;+B3?(:8HXkA^9yzF/aHD/p~Ge]GlYyLtI3+U<""hFLN3JH}}n=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] a kernel oops occured. 
[2.] First my X terminal (tektronix) stopped working, then when I pinged the
machine:

arnouten@setzer:~$ ping mintzer
PING mintzer.bzzt.net (195.169.216.157) 56(84) bytes of data.
64 bytes from vhe-400091.sshn.net (195.169.216.157): icmp_seq=1 ttl=64 time=0.192 ms
64 bytes from 195.169.216.157: icmp_seq=2 ttl=64 time=0.135 ms
WARNING: failed to install socket filter
: Protocol not available
>From setzer (172.16.3.2) icmp_seq=38 Destination Host Unreachable

Information below was taken after the reboot directly after the crash.
Oops.file was copy-pasted from /var/log/messages.
I hope it means more to you than it does to me :)
I only used USAGI, no other patches applied.

[3.] kernel oops.
[4.] Linux version 2.4.20usagi-s20030414 (root@mintzer) (gcc version
2.95.4 20011002 (Debian prerelease)) #1 Fri Apr 25 13:47:03 CEST 2003
[5.] 

Jun 10 13:33:40 mintzer kernel: c01069c5
Jun 10 13:33:40 mintzer kernel: Oops: 0000
Jun 10 13:33:40 mintzer kernel: CPU:    0
Jun 10 13:33:40 mintzer kernel: EIP:    0010:[<c01069c5>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jun 10 13:33:40 mintzer kernel: EFLAGS: 00210286
Jun 10 13:33:40 mintzer kernel: eax: c89b5f5e   ebx: c89b4000   ecx:
c0a9d000   edx: 00000000
Jun 10 13:33:40 mintzer kernel: esi: 00000000   edi: 00000000   ebp:
c89b5fc4   esp: c89b5f28
Jun 10 13:33:40 mintzer kernel: ds: 0018   es: 0018   ss: 0018
Jun 10 13:33:40 mintzer kernel: Process ntpd (pid: 430,
stackpage=c89b5000)
Jun 10 13:33:40 mintzer kernel: Stack: c89b4000 00000000 00000000
bffffdac c8a32f40 00000000 c013bd68 c89b5f6c
Jun 10 13:33:40 mintzer kernel:        00000004 00000001 c0a9ddd8
00000304 00000080 c89b4000 00200286 00000004
Jun 10 13:33:40 mintzer kernel:        00000001 c0a9ddd8 fffffdfe
c013bdaa c0a9ddc0 c013c20f c0a9ddc0 00000004
Jun 10 13:33:40 mintzer kernel: Call Trace:    [<c013bd68>] [<c013bdaa>]
[<c013c20f>] [<c0106d3c>]
Jun 10 13:33:40 mintzer kernel: Code: 03 83 f8 03 74 0a b8 01 00 00 00
e9 23 02 00 00 83 7c 24 14


>>EIP; c01069c5 <do_signal+15/260>   <=====

>>eax; c89b5f5e <_end+86c97d6/105e2878>
>>ebx; c89b4000 <_end+86c7878/105e2878>
>>ecx; c0a9d000 <_end+7b0878/105e2878>
>>ebp; c89b5fc4 <_end+86c983c/105e2878>
>>esp; c89b5f28 <_end+86c97a0/105e2878>

Trace; c013bd68 <do_select+1c8/1e0>
Trace; c013bdaa <select_bits_free+a/10>
Trace; c013c20f <sys_select+45f/470>
Trace; c0106d3c <signal_return+14/18>

Code;  c01069c5 <do_signal+15/260>
00000000 <_EIP>:
Code;  c01069c5 <do_signal+15/260>   <=====
   0:   03 83 f8 03 74 0a         add    0xa7403f8(%ebx),%eax   <=====
Code;  c01069cb <do_signal+1b/260>
   6:   b8 01 00 00 00            mov    $0x1,%eax
Code;  c01069d0 <do_signal+20/260>
   b:   e9 23 02 00 00            jmp    233 <_EIP+0x233> c0106bf8 <do_signal+248/260>
Code;  c01069d5 <do_signal+25/260>
  10:   83 7c 24 14 00            cmpl   $0x0,0x14(%esp,1)

[6.] unknown, it only occured once until now.

[7.1.]
Linux mintzer 2.4.20usagi-s20030414 #1 Fri Apr 25 13:47:03 CEST 2003
i686 unknown
 
 Gnu C                  2.95.4
 Gnu make               3.79.1
 util-linux             2.11n
 mount                  2.11n
 modutils               2.4.15
 e2fsprogs              1.27
 reiserfsprogs          3.x.1b
 Linux C Library        2.2.5
 Dynamic linker (ldd)   2.2.5
 Procps                 2.0.7
 Net-tools              1.60
 Console-tools          0.2.3
 Sh-utils               2.0.11
 Modules Loaded         snd-pcm-oss snd-pcm-plugin ipt_state
 iptable_mangle iptable_nat iptable_filter 3c59x snd-mixer-oss
 snd-card-via686a snd-pcm snd-timer snd-ac97-codec snd-mixer
 snd-mpu401-uart snd-rawmidi snd-seq-device snd ide-scsi scsi_mod

[7.2.]
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 7
model name      : AMD Duron(tm) processor
stepping        : 0
cpu MHz         : 999.561
cache size      : 64 KB
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
bogomips        : 1992.29

[7.3.]
snd-pcm-oss            18560   1 (autoclean)
snd-pcm-plugin         14864   0 (autoclean) [snd-pcm-oss]
ipt_state                608   2 (autoclean)
iptable_mangle          2304   0 (autoclean) (unused)
iptable_nat            14644   1 (autoclean)
iptable_filter          1760   1 (autoclean)
3c59x                  25320   2
snd-mixer-oss           4992   0 (autoclean) [snd-pcm-oss]
snd-card-via686a        6912   1 (autoclean)
snd-pcm                30720   0 (autoclean) [snd-pcm-oss snd-pcm-plugin
snd-card-via686a]
snd-timer               9024   0 (autoclean) [snd-pcm]
snd-ac97-codec         23584   0 (autoclean) [snd-card-via686a]
snd-mixer              27592   0 (autoclean) [snd-mixer-oss
snd-ac97-codec]
snd-mpu401-uart         2336   0 (autoclean) [snd-card-via686a]
snd-rawmidi            10272   0 (autoclean) [snd-mpu401-uart]
snd-seq-device          3820   0 (autoclean) [snd-rawmidi]
snd                    33152   1 (autoclean) [snd-pcm-oss snd-pcm-plugin
snd-mixer-oss snd-card-via686a snd-pcm snd-timer snd-ac97-codec
snd-mixer snd-mpu401-uart snd-rawmidi snd-seq-device]
ide-scsi                7776   0
scsi_mod               83576   1 [ide-scsi]

[7.4.]
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0300-0301 : VIA 82C686A - MPU401
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
c000-c00f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
00-c007 : ide0
  c008-c00f : ide1
c400-c41f : VIA Technologies, Inc. USB
c800-c81f : VIA Technologies, Inc. USB (#2)
cc00-ccff : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
  cc00-ccff : VIA 82C686A - AC'97
d000-d003 : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
d400-d403 : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
  d400-d403 : VIA 82C686A - MPU401 config
dc00-dc7f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
  dc00-dc7f : 00:09.0
e000-e07f : 3Com Corporation 3c905C-TX/TX-M [Tornado] (#2)
  e000-e07f : 00:0a.0

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c87ff : Extension ROM
000c9000-000c97ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-002387c4 : Kernel code
  002387c5-002ac6c3 : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
d0000000-d3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
d5000000-d57fffff : S3 Inc. 86c764/765 [Trio32/64/64V+]
d5800000-d580007f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
d5801000-d580107f : 3Com Corporation 3c905C-TX/TX-M [Tornado] (#2)
ffff0000-ffffffff : reserved

[7.5.]

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at c000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at c400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at c800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 50)
	Subsystem: Micro-star International Co Ltd: Unknown device 3300
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 11
	Region 0: I/O ports at cc00 [size=256]
	Region 1: I/O ports at d000 [size=4]
	Region 2: I/O ports at d400 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at d5000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at dc00 [size=128]
	Region 1: Memory at d5800000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0a.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e000 [size=128]
	Region 1: Memory at d5801000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

[7.6.] (though I don't have scsi physically)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: LITE-ON  Model: LTR-52246S       Rev: 6S0D
  Type:   CD-ROM                           ANSI SCSI revision: 02


