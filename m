Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbTGBCLv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 22:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbTGBCLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 22:11:51 -0400
Received: from mta07bw.bigpond.com ([144.135.24.134]:16859 "EHLO
	mta07bw.bigpond.com") by vger.kernel.org with ESMTP id S264546AbTGBCLd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 22:11:33 -0400
Date: Wed, 02 Jul 2003 12:22:09 +1000
From: Srihari Vijayaraghavan <harisri@bigpond.com>
Subject: PROBLEM: USB Serial oops in 2.4.22-pre2
To: lkml <linux-kernel@vger.kernel.org>
Message-id: <200307021222.09764.harisri@bigpond.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
USB Serial oops in 2.4.22-pre2

[2.] Full description of the problem/report:
I use PL-2303 USB to Serial converter to connect to the modem, which connects 
to the internet. When I accidentally disconnected that USB device (I thought 
I was disconnecting the Laptop's battery cable :-), kernel oopsed.

[3.] Keywords (i.e., modules, networking, kernel):
2.4.21-pre2, USB (usb-ohci, usbserial, pl2303)

[4.] Kernel version (from /proc/version):
Linux version 2.4.22-pre2 (hari@laptop) (gcc version 3.2.2 20030222 (Red Hat 
Linux 3.2.2-5)) #3 Fri Jun 27 23:57:46 EST 2003

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
Unable to handle kernel NULL pointer dereference at virtual address 00000998
df88530a
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<df88530a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: de54f400   ecx: de84dec4   edx: de84deb4
esi: de54f41c   edi: 00000000   ebp: de54f400   esp: de84df18
ds: 0018   es: 0018   ss: 0018
Process khubd (pid: 62, stackpage=de84d000)
Stack: de54f41c 00000000 00000010 df886ee0 df886ec0 00000000 de84fa00 df818264 
       de828400 de54f400 de828404 00000002 00000000 de828400 00000100 0000000a 
       deaa5e00 00000000 df81b0cf deaa5f0c 00000001 00000010 de2e01c0 df81ab2c 
Call Trace:    [<df886ee0>] [<df886ec0>] [<df818264>] [<df81b0cf>] 
[<df81ab2c>]
  [<df81b3b8>] [<df81b446>] [<df81b410>] [<c010577e>] [<df81b410>]
Code: c7 80 98 09 00 00 00 00 00 00 8d 4e 58 ff 43 74 0f 8e 1f 05 


>>EIP; df88530a <[usbserial]usb_serial_disconnect+6a/240>   <=====

>>ebx; de54f400 <_end+1e291750/1f5523d0>
>>ecx; de84dec4 <_end+1e590214/1f5523d0>
>>edx; de84deb4 <_end+1e590204/1f5523d0>
>>esi; de54f41c <_end+1e29176c/1f5523d0>
>>ebp; de54f400 <_end+1e291750/1f5523d0>
>>esp; de84df18 <_end+1e590268/1f5523d0>

Trace; df886ee0 <[usbserial].data.start+20/38>
Trace; df886ec0 <[usbserial]usb_serial_driver+0/0>
Trace; df818264 <[usbcore]usb_disconnect+94/160>
Trace; df81b0cf <[usbcore]usb_hub_port_connect_change+26f/280>
Trace; df81ab2c <[usbcore]usb_hub_port_status+6c/a0>
Trace; df81b3b8 <[usbcore]usb_hub_events+2d8/330>
Trace; df81b446 <[usbcore]usb_hub_thread+36/c0>
Trace; df81b410 <[usbcore]usb_hub_thread+0/c0>
Trace; c010577e <arch_kernel_thread+2e/40>
Trace; df81b410 <[usbcore]usb_hub_thread+0/c0>

Code;  df88530a <[usbserial]usb_serial_disconnect+6a/240>
00000000 <_EIP>:
Code;  df88530a <[usbserial]usb_serial_disconnect+6a/240>   <=====
   0:   c7 80 98 09 00 00 00      movl   $0x0,0x998(%eax)   <=====
Code;  df885311 <[usbserial]usb_serial_disconnect+71/240>
   7:   00 00 00 
Code;  df885314 <[usbserial]usb_serial_disconnect+74/240>
   a:   8d 4e 58                  lea    0x58(%esi),%ecx
Code;  df885317 <[usbserial]usb_serial_disconnect+77/240>
   d:   ff 43 74                  incl   0x74(%ebx)
Code;  df88531a <[usbserial]usb_serial_disconnect+7a/240>
  10:   0f 8e 1f 05 00 00         jle    535 <_EIP+0x535>


1 warning issued.  Results may not be reliable.

[6.] A small shell script or example program which triggers the
     problem (if possible)
Just connect to the internet, let the ppp interface get activated, then 
disconnect the USB device, kernel should oops (the local telephone calls are 
a bit expensive, hence I'm unable to verify if this behavior is repetitive).

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux laptop 2.4.22-pre2 #3 Fri Jun 27 23:57:46 EST 2003 i686 athlon
 i386 GNU/Linux

Gnu C                  3.2.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
modutils               2.4.22
e2fsprogs              1.32
jfsutils               1.0.17
reiserfsprogs          3.6.4
pcmcia-cs              3.1.31
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.11
Net-tools              1.60
Kbd                    1.08
Sh-utils               4.5.3
Modules Loaded         ipt_state ip_conntrack iptable_filter ip_tabl     es 
ppp_deflate zlib_inflate zlib_deflate ppp_async ppp_generic slhc      trident 
ac97_codec soundcore thermal processor fan button battery ac      ide-cd 
cdrom 8139too mii crc32 af_packet floppy pl2303 usbserial ke     ybdev 
mousedev input hid usb-ohci usbcore unix

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : Mobile AMD Athlon(tm) XP 1800+
stepping        : 0
cpu MHz         : 1523.885
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3040.87

[7.3.] Module information (from /proc/modules):
ipt_state               1080   2 (autoclean)
ip_conntrack           26760   1 (autoclean) [ipt_state]
iptable_filter          2412   1 (autoclean)
ip_tables              15328   2 [ipt_state iptable_filter]
ppp_deflate             4472   1 (autoclean)
zlib_inflate           21348   0 (autoclean) [ppp_deflate]
zlib_deflate           20888   0 (autoclean) [ppp_deflate]
ppp_async               9376   1 (autoclean)
ppp_generic            20028   3 (autoclean) [ppp_deflate ppp_async]
slhc                    6948   1 (autoclean) [ppp_generic]
trident                32692   1 (autoclean)
ac97_codec             14536   0 (autoclean) [trident]
soundcore               6468   2 (autoclean) [trident]
thermal                 8256   0 (unused)
processor              10776   0 [thermal]
fan                     2496   0 (unused)
button                  3660   0 (unused)
battery                 7040   0 (unused)
ac                      2752   0 (unused)
ide-cd                 35360   0 (autoclean)
cdrom                  33216   0 (autoclean) [ide-cd]
8139too                17352   0
mii                     3976   0 [8139too]
crc32                   3680   0 [8139too]
af_packet              15464   0 (autoclean)
floppy                 55836   0 (autoclean)
pl2303                 14360   1
usbserial              20444   0 [pl2303]
keybdev                 2912   0 (unused)
mousedev                5428   1
input                   5664   0 [keybdev mousedev]
hid                    12344   0 (unused)
usb-ohci               21192   0 (unused)
usbcore                77472   1 [pl2303 usbserial hid usb-ohci]
unix                   18056 119 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
/proc/ioports:
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
0376-0376 : ide1
03b0-03bb : RadeonIGP
03c0-03df : vga+
  03d3-03d3 : RadeonIGP
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
4000-40ff : PCI CardBus #02
4400-44ff : PCI CardBus #02
8000-803f : ALi Corporation. [ALi] M7101 PMU
8040-805f : ALi Corporation. [ALi] M7101 PMU
8080-808f : ALi Corporation. [ALi] M5229 IDE
  8080-8087 : ide0
  8088-808f : ide1
8090-8093 : PCI device 1002:cab0 (ATI Technologies Inc)
8098-809f : Conexant HSF 56k HSFi Modem
8400-84ff : ALi Corporation. [ALi] M5451 PCI AC-Link Controller Audio Device
  8400-84ff : ALi Audio Accelerator
8800-88ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  8800-88ff : 8139too
9000-9fff : PCI Bus #01
  9000-90ff : PCI device 1002:4336 (ATI Technologies Inc)

/proc/iomem:
00000000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-1eeeffff : System RAM
  00100000-0021b4c6 : Kernel code
  0021b4c7-0028045f : Kernel data
1eef0000-1eefefff : ACPI Tables
1eeff000-1eefffff : ACPI Non-volatile Storage
1ef00000-1effffff : System RAM
1f000000-1f3fffff : PCI CardBus #02
f4000000-f400ffff : Conexant HSF 56k HSFi Modem
f4010000-f4010fff : ALi Corporation. [ALi] USB 1.1 Controller
  f4010000-f4010fff : usb-ohci
f4011000-f4011fff : ALi Corporation. [ALi] M5451 PCI AC-Link Controller Audio 
Device
f4012000-f4012fff : ALi Corporation. [ALi] USB 1.1 Controller (#2)
  f4012000-f4012fff : usb-ohci
f4013000-f40130ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  f4013000-f40130ff : 8139too
f4100000-f41fffff : PCI Bus #01
  f4100000-f410ffff : PCI device 1002:4336 (ATI Technologies Inc)
f4400000-f4400fff : PCI device 1002:cab0 (ATI Technologies Inc)
f6000000-f7ffffff : PCI Bus #01
  f6000000-f7ffffff : PCI device 1002:4336 (ATI Technologies Inc)
f8000000-fbffffff : PCI device 1002:cab0 (ATI Technologies Inc)
ffbfd000-ffbfdfff : PCI CardBus #02
ffbfe000-ffbfefff : Texas Instruments PCI1410 PC card Cardbus Controller
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: ATI Technologies Inc: Unknown device cab0 (rev 13)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Region 1: Memory at f4400000 (32-bit, prefetchable) [size=4K]
        Region 2: I/O ports at 8090 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=15 SBA+ 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: ATI Technologies Inc U1/A3 AGP Bridge [IGP 320M] (rev 01) 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 99
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: f4100000-f41fffff
        Prefetchable memory behind bridge: f6000000-f7ffffff
        Secondary status: SERR
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 
10 [OHCI])
        Subsystem: ALi Corporation USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f4010000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
        Subsystem: ALi Corporation ALI M1533 Aladdin IV ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [a0] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link 
Controller Audio Device (rev 02)
        Subsystem: Compaq Computer Corporation: Unknown device 00b0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR+ <PERR+
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 8400 [size=256]
        Region 1: Memory at f4011000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller 
(rev 02)
        Subsystem: Compaq Computer Corporation: Unknown device 00b0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 10
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at ffbfe000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: ffbfd000-ffbfd000 (prefetchable)
        Memory window 1: 1f000000-1f3ff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 20)
        Subsystem: Compaq Computer Corporation: Unknown device 00b0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 8800 [size=256]
        Region 1: Memory at f4013000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
        Subsystem: Compaq Computer Corporation: Unknown device 8d89
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=64K]
        Region 1: I/O ports at 8098 [size=8]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 
10 [OHCI])
        Subsystem: ALi Corporation USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f4012000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if fa)
        Subsystem: ALi Corporation M5229 IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at 8080 [size=16]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Bridge: ALi Corporation M7101 PMU
        Subsystem: ALi Corporation ALI M7101 Power Management Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

01:05.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility U1 
(prog-if 00 [VGA])
        Subsystem: Compaq Computer Corporation: Unknown device 00b0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B+
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), cache line size 10
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f6000000 (32-bit, prefetchable) [size=32M]
        Region 1: I/O ports at 9000 [size=256]
        Region 2: Memory at f4100000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
N/A

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
None

[X.] Other notes, patches, fixes, workarounds:
None

Please cc me on replies as I'm not subscribed to LKML.

Thank you.
-- 
Hari

