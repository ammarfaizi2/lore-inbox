Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265532AbSLVXXZ>; Sun, 22 Dec 2002 18:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbSLVXXZ>; Sun, 22 Dec 2002 18:23:25 -0500
Received: from main.gmane.org ([80.91.224.249]:7593 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S265532AbSLVXXV>;
	Sun, 22 Dec 2002 18:23:21 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Simon Michael <simon@joyful.com>
Subject: [PROBLEM 2.5.52] "bad: scheduling while atomic!" errors during boot
 of 2.5.52, 2.5.51, 2.5.50
Date: Sun, 22 Dec 2002 15:19:21 -0800
Organization: Joyful Systems
Message-ID: <87znqxabgm.fsf@joyful.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
"bad: scheduling while atomic!" errors during boot of 2.5.52, 2.5.51, 2.5.50

[2.] Full description of the problem/report:
When trying to boot 2.5.52, right after "NET4: Unix domain sockets 1.0/SMP
for Linux NET4.0." I see:

bad: scheduling while atomic!
Call Trace: (hex numbers available if needed)
 schedule+0x3e/0x2e8
 add_timer+0x126/0x12c
 schedule_timeout+0x84/0xac
 process_timeout+0x0/0xc
 proc_register+0xf/0x98
 create_proc_entry+0x8d/0xa4
 cache_register+0x38/0xb4
 cache_register+0xaf/0xb4
 init+0x2f/0x180
 init+0x0/0x180
 kernel_thread_helper+0x5/0xc

then many more similar errors with various different traces (involving
prepare_namespace, __call_console_drivers, prepare_binprm,
search_binary_handler etc.) culminating in an OOPS like this:

Unable to handle kernel paging request at virtual address 40000be0
 printing eip:
40000be0
*pde: 00000000
oops: 0004
CPU: 0
EIP: 0023: [<40000be0>] not tainted
EFLAGS: 00010246
eax: 00000000 ebx: 00000000 ecx: 00000000 edx: 00000000
esi: 00000000 edi: 00000000 ebp: 00000000 esp: bfffff20
ds: 002b es: 002b ss: 002b
Process init (pid: 1, threadinfo: c7faa000, task: c7fa8040)
<0> Kernel panic: Attempted to kill init!

I saw similar errors with 2.5.51 & 2.5.50 (but without the trace symbols).

[3.] Keywords (i.e., modules, networking, kernel):
kernel, boot

[4.] Kernel version (from /proc/version):
I'm attempting to boot 2.5.52.

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
See above

[6.] A small shell script or example program which triggers the
     problem (if possible)
N/A

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
 
Linux readymix 2.4.18-pre8-mjc #1 Sun Feb 10 10:37:34 PST 2002 i586 unknown unknown GNU/Linux (this is what I'm building with, not what I'm trying to boot)
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.19
e2fsprogs              1.28
pcmcia-cs              3.1.31
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.15
Modules Loaded         sb sb_lib uart401 xirc2ps_cs


[7.2.] Processor information (from /proc/cpuinfo):
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 5
model		: 8
model name	: Mobile Pentium MMX
stepping	: 1
cpu MHz		: 265.269
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 mmx
bogomips	: 529.20


[7.3.] Module information (from /proc/modules):
should be empty, building no modules


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0110-0110 : PnPBIOS PNP0c02
0114-0114 : PnPBIOS PNP0c02
01f0-01f7 : ide0
0220-022f : soundblaster
0300-030f : xirc2ps_cs
0378-037a : parport0
037b-037f : parport0
0398-0399 : PnPBIOS PNP0c02
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
04d0-04d1 : PnPBIOS PNP0c02
0800-0807 : PnPBIOS PNP0c02
0cf8-0cff : PCI conf1
2180-219f : Intel Corp. 82371AB PIIX4 ACPI
  2180-218f : PnPBIOS PNP0c02
4000-40ff : PCI CardBus #01
4400-44ff : PCI CardBus #01
4800-48ff : PCI CardBus #05
4c00-4cff : PCI CardBus #05
8000-803f : Intel Corp. 82371AB PIIX4 ACPI
  8000-803f : PnPBIOS PNP0c02
fcc0-fcdf : Intel Corp. 82371AB PIIX4 USB
  fcc0-fcdf : usb-uhci
fcf0-fcff : Intel Corp. 82371AB PIIX4 IDE
  fcf0-fcf7 : ide0


00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-0029119a : Kernel code
  0029119b-0031ab57 : Kernel data
10000000-10000fff : O2 Micro, Inc. 6832
10001000-10001fff : O2 Micro, Inc. 6832 (#2)
10400000-107fffff : PCI CardBus #01
10800000-10bfffff : PCI CardBus #01
10c00000-10ffffff : PCI CardBus #05
11000000-113fffff : PCI CardBus #05
a0100000-a0100fff : card services
fd000000-fdffffff : Neomagic Corporation NM2160 [MagicGraph 128XD]
fea00000-febfffff : Neomagic Corporation NM2160 [MagicGraph 128XD]
fed00000-fedfffff : Neomagic Corporation NM2160 [MagicGraph 128XD]
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corp. 430TX - 82439TX MTXC (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32

00:01.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:01.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at fcf0 [size=16]

00:01.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at fcc0 [size=32]

00:01.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 01)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:03.0 VGA compatible controller: Neomagic Corporation NM2160 [MagicGraph 128XD] (rev 01) (prog-if 00 [VGA])
	Subsystem: Unknown device 4320:4756
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at fd000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at fea00000 (32-bit, non-prefetchable) [size=2M]
	Region 2: Memory at fed00000 (32-bit, non-prefetchable) [size=1M]

00:04.0 CardBus bridge: O2 Micro, Inc. 6832 (rev 34)
	Subsystem: Unknown device 4320:4756
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:04.1 CardBus bridge: O2 Micro, Inc. 6832 (rev 34)
	Subsystem: Unknown device 4320:4756
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=05, subordinate=08, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001


[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices: 
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: IOMEGA   Model: ZIP 100          Rev: C.19
  Type:   Direct-Access                    ANSI SCSI revision: 02


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
I've tried building both with APM and with ACPI, and I am building with
ALSA for the first time. I'm not building any modules.


[X.] Other notes, patches, fixes, workarounds:


Regards,
-Simon


