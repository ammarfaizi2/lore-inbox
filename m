Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbTJ0Ie0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 03:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbTJ0Ie0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 03:34:26 -0500
Received: from odin.sis.hu ([212.92.23.29]:8582 "EHLO odin.sis.hu")
	by vger.kernel.org with ESMTP id S261344AbTJ0IeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 03:34:08 -0500
Date: Mon, 27 Oct 2003 09:34:06 +0100
From: Burjan Gabor <buga@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22 usbserial/pl2303 oops
Message-ID: <20031027083406.GA9326@odin.sis.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[1.] One line summary of the problem:

Kernel oops related to emulated(?) serial device using pl2303 and pppd.

[2.] Full description of the problem/report:

I get the following oops shortly after pppd begins using the ttyUSB0
device.  After the case I cannot use ttyUSB0 and the pppd process sticks
in too (kill -9 is inefficient after the oops), so I have to reboot to
redial.

[3.] Keywords (i.e., modules, networking, kernel):

usb, serial, kernel

[4.] Kernel version (from /proc/version):

Linux version 2.4.22-grsec (buga@piccolo) (gcc version 3.3.2 20030908 (Debian prerelease)) #1 Thu Sep 18 21:23:04 CEST 2003

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

Unable to handle kernel NULL pointer dereference at virtual address 00000014
d085e714
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d085e714>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010087
eax: cfec7000   ebx: cf3e1d20   ecx: 00000001   edx: 00000000
esi: cff32960   edi: cf3e1d20   ebp: 00000292   esp: c0793e80
ds: 0018   es: 0018   ss: 0018
Process pppd (pid: 7343, stackpage=c0793000)
Stack: cf3e1d20 cff32960 00000286 cf3e1d24 d085f483 cf3e1d20 cf3e1d20 00000000
       cfab61d4 00000000 ce10581c ce105874 00000000 d085245d cf3e1d20 d08c1490
       cf3e1d20 00000000 c0217009 ce10581c c0720000 d08ba407 ce10581c ce689440
Call Trace:    [<d085f483>] [<d085245d>] [<d08c1490>] [<c0217009>] [<d08ba407>]
  [<d08ba4d5>] [<c0212a9f>] [<c0217173>] [<c0212eaf>] [<c01c6e8c>] [<c01c547d>]
  [<c01c54fe>] [<c01942af>]
Code: 8b 52 14 83 ea 1c 8b 42 04 8b 5a 08 25 00 00 00 2f 0d 00 00


>>EIP; d085e714 <[uhci]uhci_reset_interrupt+24/a0>   <=====

>>eax; cfec7000 <_end+fba6140/1051f1a0>
>>ebx; cf3e1d20 <_end+f0c0e60/1051f1a0>
>>esi; cff32960 <_end+fc11aa0/1051f1a0>
>>edi; cf3e1d20 <_end+f0c0e60/1051f1a0>
>>esp; c0793e80 <_end+472fc0/1051f1a0>

Trace; d085f483 <[uhci]uhci_unlink_urb+133/180>
Trace; d085245d <[usbcore]usb_unlink_urb+3d/40>
Trace; d08c1490 <[snd-seq-device]snd_seq_device_register_driver+30/120>
Trace; c0217009 <change_termios+1b9/230>
Trace; d08ba407 <[ip_tables]mark_source_chains+27/1d0>
Trace; d08ba4d5 <[ip_tables]mark_source_chains+f5/1d0>
Trace; c0212a9f <release_dev+55f/5a0>
Trace; c0217173 <set_termios+f3/140>
Trace; c0212eaf <tty_release+f/20>
Trace; c01c6e8c <fput+fc/120>
Trace; c01c547d <filp_close+4d/80>
Trace; c01c54fe <sys_close+4e/60>
Trace; c01942af <system_call+33/38>

Code;  d085e714 <[uhci]uhci_reset_interrupt+24/a0>
00000000 <_EIP>:
Code;  d085e714 <[uhci]uhci_reset_interrupt+24/a0>   <=====
   0:   8b 52 14                  mov    0x14(%edx),%edx   <=====
Code;  d085e717 <[uhci]uhci_reset_interrupt+27/a0>
   3:   83 ea 1c                  sub    $0x1c,%edx
Code;  d085e71a <[uhci]uhci_reset_interrupt+2a/a0>
   6:   8b 42 04                  mov    0x4(%edx),%eax
Code;  d085e71d <[uhci]uhci_reset_interrupt+2d/a0>
   9:   8b 5a 08                  mov    0x8(%edx),%ebx
Code;  d085e720 <[uhci]uhci_reset_interrupt+30/a0>
   c:   25 00 00 00 2f            and    $0x2f000000,%eax
Code;  d085e725 <[uhci]uhci_reset_interrupt+35/a0>
  11:   0d 00 00 00 00            or     $0x0,%eax

[6.] A small shell script or example program which triggers the
     problem (if possible)

   pon wgprs
   wget ...largefile...

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux piccolo 2.4.22-grsec #1 Thu Sep 18 21:23:04 CEST 2003 i686 GNU/Linux

Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
modutils               2.4.25
e2fsprogs              1.35-WIP
pcmcia-cs              3.2.2
PPP                    2.4.2b3
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.14
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         pl2303 usbserial apm snd-seq-oss snd-seq-midi-event snd-seq snd-seq-device ipt_REJECT ipt_LOG ipt_state ip_conntrack iptable_filter ip_tables snd-pcm-oss snd-mixer-oss snd-maestro3 snd-pcm snd-timer snd-page-alloc snd-ac97-codec snd soundcore keybdev mousedev hid input uhci usbcore e100

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 697.430
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1392.64

[7.3.] Module information (from /proc/modules):

pl2303                 13016   0 (unused)
usbserial              18460   0 [pl2303]
apm                    10188   2 (autoclean)
snd-seq-oss            29632   0 (unused)
snd-seq-midi-event      3264   0 [snd-seq-oss]
snd-seq                36816   2 [snd-seq-oss snd-seq-midi-event]
snd-seq-device          4288   0 [snd-seq-oss snd-seq]
ipt_REJECT              3448   2 (autoclean)
ipt_LOG                 3416   1 (autoclean)
ipt_state                568   1 (autoclean)
ip_conntrack           18084   1 (autoclean) [ipt_state]
iptable_filter          1740   1 (autoclean)
ip_tables              12480   4 [ipt_REJECT ipt_LOG ipt_state iptable_filter]
snd-pcm-oss            39556   0
snd-mixer-oss          13592   0 [snd-pcm-oss]
snd-maestro3           14756   0
snd-pcm                61092   0 [snd-pcm-oss snd-maestro3]
snd-timer              14436   0 [snd-seq snd-pcm]
snd-page-alloc          6420   0 [snd-pcm]
snd-ac97-codec         41400   0 [snd-maestro3]
snd                    29700   0 [snd-seq-oss snd-seq-midi-event snd-seq snd-seq-device snd-pcm-oss snd-mixer-oss snd-maestro3 snd-pcm snd-timer snd-ac97-codec]
soundcore               3652   5 [snd]
keybdev                 2116   0 (unused)
mousedev                4372   1
hid                    15496   0 (unused)
input                   3328   0 [keybdev mousedev hid]
uhci                   25916   0 (unused)
usbcore                40004   0 [pl2303 usbserial hid uhci]
e100                   49096   1

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

ioports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
1000-103f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
1100-111f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
2000-2fff : PCI Bus #01
  2000-20ff : ATI Technologies Inc Rage Mobility P/M AGP 2x
3000-30ff : ESS Technology ES1988 Allegro-1
  3000-30ff : Allegro
3400-343f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  3400-343f : e100
3440-345f : Intel Corp. 82371AB/EB/MB PIIX4 USB
  3440-345f : usb-uhci
3460-346f : Intel Corp. 82371AB/EB/MB PIIX4 IDE
  3460-3467 : ide0
  3468-346f : ide1
3470-3477 : Lucent Microelectronics LT WinModem
4000-40ff : PCI CardBus #02
4400-44ff : PCI CardBus #02

iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d17ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ffcffff : System RAM
  00190000-002e8ce5 : Kernel code
0ffd0000-0fff0bff : reserved
0fff0c00-0fffbfff : ACPI Non-volatile Storage
0fffc000-0fffffff : reserved
10000000-103fffff : PCI CardBus #02
10400000-107fffff : PCI CardBus #02
40000000-410fffff : PCI Bus #01
  40000000-40ffffff : ATI Technologies Inc Rage Mobility P/M AGP 2x
  41000000-41000fff : ATI Technologies Inc Rage Mobility P/M AGP 2x
41100000-4111ffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  41100000-4111ffff : e100
41180000-41180fff : Texas Instruments PCI1211
41200000-41200fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  41200000-41200fff : e100
41280000-41280fff : Lucent Microelectronics LT WinModem
50000000-53ffffff : Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
	Subsystem: Compaq Computer Corporation Armada M700
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at 50000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x2

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: 40000000-410fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

00:04.0 CardBus bridge: Texas Instruments PCI1211
	Subsystem: Compaq Computer Corporation: Unknown device b103
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 41180000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=176
	Memory window 0: 10000000-103ff000 (prefetchable)
	Memory window 1: 10400000-107ff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:07.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 3460 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 3440 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:08.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 12)
	Subsystem: Compaq Computer Corporation: Unknown device b114
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 3000 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 09)
	Subsystem: Intel Corp. EtherExpress PRO/100 P Mobile Combo Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min, 14000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 41200000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 3400 [size=64]
	Region 2: Memory at 41100000 (32-bit, non-prefetchable) [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:09.1 Serial controller: Lucent Microelectronics LT WinModem (prog-if 00 [8250])
	Subsystem: Intel Corp.: Unknown device 2201
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 3470 [size=8]
	Region 1: Memory at 41280000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 64) (prog-if 00 [VGA])
	Subsystem: Compaq Computer Corporation Armada M700
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 40000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 2000 [size=256]
	Region 2: Memory at 41000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)

(no scsi)

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

/proc/tty/driver/usb-serial:

usbserinfo:1.0 driver:v1.4
0: module:pl2303 name:"PL-2303" vendor:067b product:2303 num_ports:1 port:1 path:usb-00:07.2-2.2

  Buga
