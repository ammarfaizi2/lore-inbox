Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbVJRMxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVJRMxO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 08:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVJRMxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 08:53:14 -0400
Received: from druzhba.pptus.ru ([212.73.98.220]:53196 "EHLO
	gate.druzhba.pptus.ru") by vger.kernel.org with ESMTP
	id S1750707AbVJRMxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 08:53:14 -0400
Message-ID: <4354EFFA.4080903@druzhba.pptus.ru>
Date: Tue, 18 Oct 2005 16:52:10 +0400
From: Serge <sjb@druzhba.pptus.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Kernel crash after load usb-ohci module.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Summary: Kernel crash after load usb-ohci module.

2. Description: I have Slackware 10.2 standart kernel (bare.i). After adding kernel module usb-uhci (modprobe usb-ohci) I get kernel crash:
	"kernel BUG at usb-ohci.h:464!"

3. Keywords: module usb-ohci

4. Kernel version: Linux version 2.4.31 (root@tree) (gcc version 3.3.5) #6 Sun Jun 5 19:04:47 PDT 2005

5. Output of Oops.. message:

ksymoops 2.4.9 on i586 2.4.31.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.31/ (default)
     -m /boot/System.map (specified)

kernel BUG at usb-ohci.h:464!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c2a2d300>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c2a35000   ecx: c18be800   edx: 000015a0
esi: 00000000   edi: c0365e94   ebp: 00000002   esp: c0365e24
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0365000)
Stack: 00000000 c2a35000 c18be800 c0365e94 00000002 c2a2e6fe c18be800 c095c560 
       04000001 c0365e94 00000009 c0109fbd 00000009 c18be800 c0365e94 c0384990 
       00000009 c095c560 c0365e94 c010a138 00000009 c0365e94 c095c560 c10b2b10 
Call Trace:    [<c2a2e6fe>] [<c0109fbd>] [<c010a138>] [<c010c428>] [<c020841d>]
  [<c0208a28>] [<c0210060>] [<c0109fbd>] [<c010a138>] [<c010c428>] [<c011b6c0>]
  [<c010a16d>] [<c0106f50>] [<c010c428>] [<c0106f50>] [<c0106f73>] [<c0107012>]
  [<c0105000>]
Code: 0f 0b d0 01 c4 f1 a2 c2 e9 5b ff ff ff 8d 76 00 55 57 56 53 


>>EIP; c2a2d300 <END_OF_CODE+55759/????>   <=====

>>ecx; c18be800 <_end+14fda34/25d8294>
>>edi; c0365e94 <init_task_union+1e94/2000>
>>esp; c0365e24 <init_task_union+1e24/2000>

Trace; c2a2e6fe <END_OF_CODE+56b57/????>
Trace; c0109fbd <handle_IRQ_event+3d/70>
Trace; c010a138 <do_IRQ+68/a0>
Trace; c010c428 <call_do_IRQ+5/d>
Trace; c020841d <ide_do_request+1ad/320>
Trace; c0208a28 <ide_intr+d8/120>
Trace; c0210060 <read_intr+0/120>
Trace; c0109fbd <handle_IRQ_event+3d/70>
Trace; c010a138 <do_IRQ+68/a0>
Trace; c010c428 <call_do_IRQ+5/d>
Trace; c011b6c0 <do_softirq+40/a0>
Trace; c010a16d <do_IRQ+9d/a0>
Trace; c0106f50 <default_idle+0/50>
Trace; c010c428 <call_do_IRQ+5/d>
Trace; c0106f50 <default_idle+0/50>
Trace; c0106f73 <default_idle+23/50>
Trace; c0107012 <cpu_idle+52/70>
Trace; c0105000 <_stext+0/0>

Code;  c2a2d300 <END_OF_CODE+55759/????>
00000000 <_EIP>:
Code;  c2a2d300 <END_OF_CODE+55759/????>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c2a2d302 <END_OF_CODE+5575b/????>
   2:   d0 01                     rolb   (%ecx)
Code;  c2a2d304 <END_OF_CODE+5575d/????>
   4:   c4                        les    (bad),%esi
Code;  c2a2d305 <END_OF_CODE+5575e/????>
   5:   f1                        icebp  
Code;  c2a2d306 <END_OF_CODE+5575f/????>
   6:   a2 c2 e9 5b ff            mov    %al,0xff5be9c2
Code;  c2a2d30b <END_OF_CODE+55764/????>
   b:   ff                        (bad)  
Code;  c2a2d30c <END_OF_CODE+55765/????>
   c:   ff 8d 76 00 55 57         decl   0x57550076(%ebp)
Code;  c2a2d312 <END_OF_CODE+5576b/????>
  12:   56                        push   %esi
Code;  c2a2d313 <END_OF_CODE+5576c/????>
  13:   53                        push   %ebx

 <0>Kernel panic: Aiee, killing interrupt handler!

7. Environment
7.1.  Software
Linux sjbrover 2.4.31 #6 Sun Jun 5 19:04:47 PDT 2005 i586 unknown unknown GNU/Linux
 
Gnu C                  3.3.6
Gnu make               3.80
util-linux             2.12p
mount                  2.12p
modutils               2.4.27
e2fsprogs              1.38
pcmcia-cs              3.2.8
quota-tools            3.12.
PPP                    2.4.4b1
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Linux C++ Library      5.0.7
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         usb-ohci usbcore serial_cs pcnet_cs 8390 crc32 ds yenta_socket pcmcia_core ide-scsi

7.2. Processor:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 3
cpu MHz         : 233.322
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 465.30

7.3.  Module information

usb-ohci               19368   0 (unused)
usbcore                59116   0 [usb-ohci]
serial_cs               4532   0 (unused)
pcnet_cs               11260   1
8390                    5776   0 [pcnet_cs]
crc32                   2880   0 [8390]
ds                      6548   3 [serial_cs pcnet_cs]
yenta_socket           10436   3
pcmcia_core            39140   0 [serial_cs pcnet_cs ds yenta_socket]
ide-scsi                9392   0


7.4. Loaded driver and hardware information
root@sjbrover:~# cat /proc/ioports 
0000-001f : dma1
0020-003f : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : pcnet_cs
0300-031f : pcnet_cs
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-40ff : PCI CardBus #01
4400-44ff : PCI CardBus #01
4800-48ff : PCI CardBus #09
4c00-4cff : PCI CardBus #09
5000-50ff : PCI CardBus #05
5400-54ff : PCI CardBus #05
ec80-ecff : ALi Corporation M3307
ffa0-ffaf : OPTi Inc. 82C825 [Firebridge 2]

root@sjbrover:~# cat /proc/iomem 
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-01ffffff : System RAM
  00100000-002ca1ee : Kernel code
  002ca1ef-003620c3 : Kernel data
0e000000-0effffff : Chips and Technologies F65554
  0e000000-0e17ffff : vesafb
10000000-10000fff : OPTi Inc. 82C814 [Firebridge 1]
10001000-10001fff : Texas Instruments PCI1131
10002000-10002fff : Texas Instruments PCI1131 (#2)
10400000-107fffff : PCI CardBus #01
10800000-10bfffff : PCI CardBus #01
10c00000-10ffffff : PCI CardBus #09
11000000-113fffff : PCI CardBus #09
11400000-117fffff : PCI CardBus #05
11800000-11bfffff : PCI CardBus #05
a0000000-a0000fff : card services
febfe000-febfefff : CMD Technology Inc USB0670
febff000-febfffff : ALi Corporation M3307
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fffe0000-ffffffff : reserved


7.5. PCI information 

00:00.0 Host bridge: OPTi Inc. 82C701 [FireStar Plus] (rev 20)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort- >SERR- <PERR-
	Latency: 0

00:01.0 ISA bridge: OPTi Inc. 82C700 [FireStar] (rev 20)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:04.0 CardBus bridge: OPTi Inc. 82C814 [Firebridge 1]
	Subsystem: Unknown device 8040:0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+

00:05.0 USB Controller: Silicon Image, Inc. USB0670 (rev 04) (prog-if 10 [OHCI])
	Subsystem: Silicon Image, Inc. USB0670
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at febfe000 (32-bit, non-prefetchable) [size=4K]

00:06.0 VGA compatible controller: Chips and Technologies F65554 (rev c2) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at 0e000000 (32-bit, non-prefetchable) [size=16M]
	Expansion ROM at 21800000 [disabled] [size=256K]

00:07.0 CardBus bridge: Texas Instruments PCI1131 (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 04
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=05, subordinate=08, sec-latency=176
	Memory window 0: 11400000-117ff000 (prefetchable)
	Memory window 1: 11800000-11bff000
	I/O window 0: 00005000-000050ff
	I/O window 1: 00005400-000054ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:07.1 CardBus bridge: Texas Instruments PCI1131 (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 04
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 10002000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=09, subordinate=0c, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:08.0 Multimedia video controller: ALi Corporation M3307
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 500ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at febff000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at ec80 [size=128]

00:14.0 IDE interface: OPTi Inc. 82C825 [Firebridge 2] (rev 12) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at ffa0 [size=16]


root@sjbrover:~# cat /proc/interrupts 
           CPU0       
  0:     544483          XT-PIC  timer
  1:       2456          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:      28346          XT-PIC  pcnet_cs
  4:        600          XT-PIC  serial
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  usb-ohci
 11:          0          XT-PIC  Texas Instruments PCI1131 (#2), Texas Instruments PCI1131
 12:          0          XT-PIC  PS/2 Mouse
 14:       6327          XT-PIC  ide0
 15:          3          XT-PIC  ide1
NMI:          0 
ERR:          0


7.6. SCSI information

Attached devices: none

