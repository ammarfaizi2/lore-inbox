Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSHMOcz>; Tue, 13 Aug 2002 10:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315431AbSHMOcz>; Tue, 13 Aug 2002 10:32:55 -0400
Received: from [213.4.129.150] ([213.4.129.150]:183 "EHLO telesmtp1.mail.isp")
	by vger.kernel.org with ESMTP id <S315427AbSHMOcw>;
	Tue, 13 Aug 2002 10:32:52 -0400
Message-ID: <3D5919A8.1080908@imente.com>
Date: Tue, 13 Aug 2002 16:37:28 +0200
From: =?ISO-8859-1?Q?Pau_Montero_Par=E9s?= <pau@imente.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: ca, es, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SMP Athlon troubles under high load 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
hangs on dual athlon system under heavy load.

[2.] Full description of the problem/report:
The systems hangs only under heavy load or during shutdown. It still 
happens appending
noapic and mem=nopentium, removing the networking card or the ati 
graphic card.
Although i can't remove the Adaptec 2100s RAID in order to boot. The 
system works
fine compiled with only one CPU support. The temperature seems fine
around 55C.

[3.] Keywords (i.e., modules, networking, kernel):
with or without networking and with or without modules.

[4.] Kernel version (from /proc/version):
Linux version 2.4.19 (pau@lorien) (gcc version 2.95.4 20011002 (Debian 
prerelease)) #6 SMP
It still happens under SuSE 7.3, 7.2 and 8 kernels. (2.4.16 and 2.4.18)


[5.] Output of Oops.. message (if applicable) with symbolic information
   Aug  6 13:53:29 lorien kernel: Unable to handle kernel paging request 
at virtual address 00009000
   Aug  6 13:53:29 lorien kernel:  printing eip:
   Aug  6 13:53:29 lorien kernel: 00009000
   Aug  6 13:53:29 lorien kernel: *pde = 04bde001
   Aug  6 13:53:29 lorien kernel: Oops: 0000
   Aug  6 13:53:29 lorien kernel: CPU:    1
   Aug  6 13:53:29 lorien kernel: EIP:    0010:[<00009000>]    Not tainted
   Aug  6 13:53:29 lorien kernel: EFLAGS: 00010246
   Aug  6 13:53:29 lorien kernel: eax: c4854cc0   ebx: c42ef1c0   ecx: 
c426d7c0   edx: 00000000
   Aug  6 13:53:29 lorien kernel: esi: c4853ec0   edi: 080ed000   ebp: 
00009000   esp: c4bbfe94
   Aug  6 13:53:29 lorien kernel: ds: 0018   es: 0018   ss: 0018
   Aug  6 13:53:29 lorien kernel: Process perl (pid: 392, 
stackpage=c4bbf000)
   Aug  6 13:53:29 lorien kernel: Stack: c0331020 c3b21ac8 48048000 
000a5000 fffd3768 3b61d025 00000000 fffd3240
   Aug  6 13:53:29 lorien kernel:        00000062 000a5000 000a5000 
00000062 080ed000 00000286 c426d7c0 c4853ec0
   Aug  6 13:53:29 lorien kernel:        08048000 c426d7c0 c012e59f 
c012e579 c42ef1c0 c4853ec0 c4bbe000 c4bbe000
   Aug  6 13:53:29 lorien kernel: Call Trace: [<c012e59f>] [<c012e579>] 
[<c011b4db>] [<c01200a8>] [<c010702b>]
   Aug  6 13:53:29 lorien kernel:    [<c01188f0>] [<c0119c20>] 
[<c013f24e>] [<c01072cc>] [<c0107214>]
   Aug  6 13:53:29 lorien kernel:
   Aug  6 13:53:29 lorien kernel: Code:  Bad EIP value.

[6.] A small shell script or example program which triggers the
problem (if possible)

I'm only able fastly hang the machine using something like this:
#!/usr/bin/perl
my $a = 0;
while ($a == 0) {rand();}

It usualy returns a Segmentation Faults and the machine hangs in a few 
seconds.
It can become freeze during the perl script too. The script can run 
during 10 seconds to 30 minutes.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux lorien 2.4.19 #6 SMP lun ago 12 19:08:58 CEST 2002 i686 unknown

gcc version 2.95.4 20011002 (Debian prerelease)
GNU Make version 3.79.1
util-linux 2.11n-4
ldd (GNU libc) 2.2.5
procps 2.0.7-8

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 4
cpu MHz         : 1400.071
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov p
at pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2791.83

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 4
cpu MHz         : 1400.071
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov p
at pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2798.38

[7.3.] Module information (from /proc/modules):
none

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
/proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
03c0-03df : vga+
0cf8-0cff : PCI conf1
1000-107f : PCI device 10b7:7646
  1000-107f : 00:0c.0
1090-1093 : PCI device 1022:700c
2000-2fff : PCI Bus #01
  2000-20ff : PCI device 1002:5046
f000-f00f : PCI device 1022:7411

/proc/iomem
00000000-0009ebff : System RAM
0009ec00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-7fffffff : System RAM
  00100000-001e32eb : Kernel code
  001e32ec-002139df : Kernel data
f0000000-f000007f : PCI device 10b7:7646
f0001000-f0001fff : PCI device 1022:700c
f0100000-f01fffff : PCI Bus #01
  f0100000-f0103fff : PCI device 1002:5046
f2000000-f3ffffff : PCI device 1044:a501
f4000000-f7ffffff : PCI device 1022:700c
f8000000-fbffffff : PCI Bus #01
  f8000000-fbffffff : PCI device 1002:5046
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700c 
(rev 11)
  Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
  Latency: 64
  Region 0: Memory at f4000000 (32-bit, prefetchable) [size=64M]
  Region 1: Memory at f0001000 (32-bit, prefetchable) [size=4K]
  Region 2: I/O ports at 1090 [disabled] [size=4]
  Capabilities: [a0] AGP version 2.0
    Status: RQ=15 SBA+ 64bit- FW+ Rate=x1,x2
    Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700d 
(prog-if 00 [Normal decode])
  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
  Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
  Latency: 99
  Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
  I/O behind bridge: 00002000-00002fff
  Memory behind bridge: f0100000-f01fffff
  Prefetchable memory behind bridge: f8000000-fbffffff
  BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-765 [Viper] ISA 
(rev 02)
  Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
  Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
  Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-765 [Viper] IDE 
(rev 01) (prog-if 8a [Master SecP PriP])
  Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
  Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
  Latency: 64
  Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-765 [Viper] ACPI (rev 01)
  Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
  Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:0c.0 Ethernet controller: 3Com Corporation 3cSOHO100-TX Hurricane 
(rev 30)
  Subsystem: 3Com Corporation 3cSOHO100-TX Hurricane
  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
  Latency: 80 (2500ns min, 2500ns max), cache line size 10
  Interrupt: pin A routed to IRQ 5
  Region 0: I/O ports at 1000 [size=128]
  Region 1: Memory at f0000000 (32-bit, non-prefetchable) [size=128]
  Expansion ROM at <unassigned> [disabled] [size=128K]
  Capabilities: [dc] Power Management version 1
    Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 PCI bridge: Distributed Processing Technology PCI Bridge (rev 
02) (prog-if 00 [Normal decode])
  Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
  Latency: 64, cache line size 10
  Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
  I/O behind bridge: 0000f000-00000fff
  Memory behind bridge: 00100000-000fffff
  Prefetchable memory behind bridge: 00100000-000fffff
  BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
  Capabilities: [68] Power Management version 2
    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.1 I2O: Distributed Processing Technology SmartRAID V Controller 
(rev 02) (prog-if 01)
  Subsystem: Distributed Processing Technology: Unknown device c03c
  Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
  Latency: 64 (250ns min, 250ns max), cache line size 10
  Interrupt: pin A routed to IRQ 11
  BIST result: 00
  Region 0: Memory at f2000000 (32-bit, prefetchable) [size=32M]
  Expansion ROM at <unassigned> [disabled] [size=32K]
  Capabilities: [80] Power Management version 2
    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF 
(prog-if 00 [VGA])
  Subsystem: ATI Technologies Inc: Unknown device 0008
  Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B+
  Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
  Interrupt: pin A routed to IRQ 11
  Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
  Region 1: I/O ports at 2000 [size=256]
  Region 2: Memory at f0100000 (32-bit, non-prefetchable) [size=16K]
  Expansion ROM at <unassigned> [disabled] [size=128K]
  Capabilities: [50] AGP version 2.0
    Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
    Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
  Capabilities: [5c] Power Management version 2
    Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: ADAPTEC  Model: RAID-5           Rev: 370F
  Type:   Direct-Access                    ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
/proc/interrupts
           CPU0       CPU1
  0:     143027          0          XT-PIC  timer
  1:       5401          0          XT-PIC  keyboard
  2:          0          0          XT-PIC  cascade
  5:       1715          0          XT-PIC  eth0
  8:          3          0          XT-PIC  rtc
 11:       5744          0          XT-PIC  dpti0
NMI:          0          0
LOC:     142944     143078
ERR:          8
MIS:          0

More logs that i can't understand:

   Aug  6 13:48:13 lorien kernel:  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 
2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
   Aug  6 13:48:14 lorien kernel:         : booting with the "noapic" 
option.
----
   Aug  6 13:48:13 lorien kernel: mtrr: detected mtrr type: Intel
   Aug  6 13:48:14 lorien kernel: mtrr: your CPUs had inconsistent fixed 
MTRR settings
   Aug  6 13:48:14 lorien kernel: mtrr: probably your BIOS does not 
setup all CPUs

The system hangs both 1.1 and 1.4 SMP specification and with or without 
using MP interrupts table.
MainBoard: Tyan 2460 with registered ECC memory.

The MB can't reboot normaly, but i think it is a BIOS issue, i should 
update it.

Good luck!

Pau Montero Parés.
http://pau.no-ip.com

