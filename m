Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264106AbTEaCTE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 22:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264107AbTEaCTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 22:19:04 -0400
Received: from smtp1.cistron.nl ([62.216.30.40]:34220 "EHLO smtp1.cistron.nl")
	by vger.kernel.org with ESMTP id S264106AbTEaCSz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 22:18:55 -0400
Message-ID: <3ED81447.5020109@cistron.nl>
Date: Sat, 31 May 2003 04:32:39 +0200
From: Niels Werensteijn <messenjah@cistron.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG] SMP system hangs very often seemingly  at random.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
SMP system hangs very often seemingly at random.

[2.] Full description of the problem/report:
OK here goes:
I installed gentoo linux on my SMP system. During installation, 
everything went very smooth. But when i rebooted into my installed 
system, i noticed this bug.

The whole system seems to pause. It happens most often when i am typing.
The only way to get it going again is to press numlock or capslock 
(havent tested scrolllock). "normal keys" dont seem to work for it.
I am reporting this for a 2.4.20 kernel (vanilla), but i also tried 
2.4.18 and 2.4.21_pre7 (since that came on the gentoo cd).

Now here is the twist. I went back and booted my gentoo boot cd again. 
That perforned flawlessly. So i copied that kernel (they have an smp 
kernel) + its modules to my harddrive and booted into that from 
harddisk. To my surprise, i encountered the bug again. So it seems that 
if i boot from cd, i dont have the bug, if i boot from hd, i have the bug.

Last but not least, i compiled a non-smp kernel. That seems to work ok.

I also removed my scsi card and installed linux on my ide disk. That did 
not improve things

Some more info that might irrelevant. My first kernel was a heavily 
patched one (gentoo default kernel) which included pre-emptable kernel 
and low-latency scheduling.  When i had that running, and i would start 
top, it would halt in +/- 2 seconds. It would stay halted untill i 
pressed numlock. The clock would continue like there was never a pause!! 
(so after a while, the system clock was way behind).
However, after using vanilla kernels only, i have not seen top pause yet.

I also run windows 2000 on this machine. No problems with it.

[3.] Keywords :
smp, hang, lock, keyboard

[4.] Kernel version (from /proc/version):
cat /proc/version
Linux version 2.4.20-smp  (root@MollyMillions) (gcc version 3.2.2) #2 
SMP Sat May 31 03:43:00 CEST 2003

[7.] Environment
[7.1.] Software
Linux MollyMillions 2.4.20-smp  #2 SMP Sat May 31 03:43:00 CEST 2003 
i686 AMD Athlon(tm) MP 1800+ AuthenticAMD GNU/Linux

Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11y
mount                  2.11y
modutils               2.4.25
e2fsprogs              1.32
reiserfsprogs          3.6.4
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.8
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.15
Modules Loaded

[7.2.] Processor information (from /proc/cpuinfo):
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) MP 1800+
stepping	: 2
cpu MHz		: 1533.411
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 3060.53

processor	: 1
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) MP
stepping	: 2
cpu MHz		: 1533.411
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 3060.53


[7.3.] Module information (from /proc/modules):
cat /proc/modules
cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #02
   c000-c0ff : QLogic Corp. ISP12160 Dual Channel Ultra3 SCSI Processor
d000-dfff : PCI Bus #04
   d000-d0ff : PCI device 1050:6692 (Winbond Electronics Corp)
   d400-d43f : Intel Corp. 82559ER
     d400-d43f : eepro100
e000-e0ff : Advanced Micro Devices [AMD] AMD-768 [Opus] Audio
e400-e43f : Advanced Micro Devices [AMD] AMD-768 [Opus] Audio
e800-e803 : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System 
Controller
ec00-ec0f : Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
   ec00-ec07 : ide0
   ec08-ec0f : ide1
cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d4000-000d53ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
   00100000-002d2082 : Kernel code
   002d2083-0033fbc3 : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
d0000000-d7ffffff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] 
System Controller
d8000000-e7ffffff : PCI Bus #01
   d8000000-dfffffff : nVidia Corporation NV25 [GeForce4 Ti4200]
   e0000000-e007ffff : nVidia Corporation NV25 [GeForce4 Ti4200]
e8000000-ebffffff : PCI Bus #02
   e8000000-ebffffff : PCI Bus #03
     e8000000-ebffffff : American Megatrends Inc. MegaRAID
ec000000-eeffffff : PCI Bus #02
   ec000000-ecffffff : PCI Bus #03
   ee000000-ee000fff : QLogic Corp. ISP12160 Dual Channel Ultra3 SCSI 
Processor
ef000000-f0ffffff : PCI Bus #01
   ef000000-efffffff : nVidia Corporation NV25 [GeForce4 Ti4200]
f1000000-f2ffffff : PCI Bus #04
   f2000000-f20fffff : Cirrus Logic CS 4614/22/24 [CrystalClear 
SoundFusion Audio Accelerator]
   f2100000-f211ffff : Intel Corp. 82559ER
   f2120000-f2120fff : Advanced Micro Devices [AMD] AMD-768 [Opus] USB
   f2121000-f2121fff : Intel Corp. 82559ER
     f2121000-f2121fff : eepro100
   f2122000-f2122fff : PCI device 1050:6692 (Winbond Electronics Corp)
   f2123000-f2123fff : Cirrus Logic CS 4614/22/24 [CrystalClear 
SoundFusion Audio Accelerator]
f3000000-f3000fff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] 
System Controller
fec00000-ffffffff : reserved

[7.4.] Loaded driver and hardware information
MSI k7d-master-l motherboard (amd760mpx chipset + intel ethernet)
2* athlon-mp 1800
2* kingston registered ram (256 mb) (512 total)
GF4 ti 4200
lsi megaraid elite 1600 (former ami megaraid) with 3 maxtor 10k3 18Gb 
disks in raid-5
1 ibm 30 GB ide hd
1 pioneer dvd
1 plextor 16 speed cd writer
1 floppy (disabled in the bios i think)
1 dynalink isdn adaptor (no drivers for linux :( )
1 hercules game theater xp soundcard

[7.5.] PCI information ('lspci -vvv' as root)
lspci -vvv
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] 
System Controller (rev 11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at f3000000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at e800 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=15 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA+ AGP- 64bit- FW+ Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] 
AGP Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: ef000000-f0ffffff
	Prefetchable memory behind bridge: d8000000-e7ffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE 
(rev 04) (prog-if 8a [Master SecP PriP])
	Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at ec00 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
	Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:07.5 Multimedia audio controller: Advanced Micro Devices [AMD] 
AMD-768 [Opus] Audio (rev 03)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at e000 [size=256]
	Region 1: I/O ports at e400 [size=64]

00:09.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 05) 
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=02, subordinate=03, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: ec000000-eeffffff
	Prefetchable memory behind bridge: 00000000e8000000-00000000ebf00000
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 
05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: f1000000-f2ffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

01:05.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 
4200] (rev a3) (prog-if 00 [VGA])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 8700
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at ef000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 2: Memory at e0000000 (32-bit, prefetchable) [size=512K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

02:00.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 05) 
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: ec000000-ecffffff
	Prefetchable memory behind bridge: 00000000e8000000-00000000ebf00000
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

02:01.0 SCSI storage controller: QLogic Corp. ISP12160 Dual Channel 
Ultra3 SCSI Processor (rev 05)
	Subsystem: American Megatrends Inc. QLA12160 on AMI MegaRAID
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (16000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at c000 [size=256]
	Region 1: Memory at ee000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:00.0 RAID bus controller: American Megatrends Inc. MegaRAID (rev 02)
	Subsystem: American Megatrends Inc. MegaRAID 493 Elite 1600 RAID Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
	Expansion ROM at <unassigned> [disabled] [size=32K]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

04:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB 
(rev 07) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 0: Memory at f2120000 (32-bit, non-prefetchable) [size=4K]

04:05.0 Network controller: Winbond Electronics Corp W6692
	Subsystem: Askey Computer Corp.: Unknown device 1707
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f2122000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at d000 [size=256]

04:06.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
	Subsystem: Hercules Game Theater XP
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f2123000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at f2000000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

04:09.0 Ethernet controller: Intel Corp. 82559ER (rev 09)
	Subsystem: Intel Corp.: Unknown device 3000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f2121000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at d400 [size=64]
	Region 2: Memory at f2100000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 02 Id: 00 Lun: 00
   Vendor: MegaRAID Model: LD 0 RAID5   35G Rev: G170
   Type:   Direct-Access                    ANSI SCSI revision: 02


Thats about it.

Regards
Niels Werensteijn

