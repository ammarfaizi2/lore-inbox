Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbTD3EkS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 00:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbTD3EkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 00:40:18 -0400
Received: from adsl-065-081-070-095.sip.gnv.bellsouth.net ([65.81.70.95]:4842
	"HELO medicaldictation.com") by vger.kernel.org with SMTP
	id S262058AbTD3EkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 00:40:11 -0400
Date: Wed, 30 Apr 2003 00:52:37 -0400
From: Chuck Berg <chuck@encinc.com>
To: linux-kernel@vger.kernel.org
Subject: oops with Soyo KT400 and onboard HPT372
Message-ID: <20030430005237.A25703@timetrax.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Soyo KT400 motherboard with an onboard Highpoint HPT372 IDE
controller. The system consistently crashes if (and only if as far as
I can tell) I read from drives on this controller at the same time as
exercising a PCI card. Redhat's 2.4.18-27.8.0 just locks solid, but with
2.4.20 and 3.4.21-rc1 I get an Oops.

Sometimes I get messages like this right before the oops:
hdc: dma_timer_expiry: dma status == 0x24
hdc: lost interrupt
hdc: dma_intr: bad DMA status (dma_stat=30)
hdc: dma_intr: status=0x50 { DriveReady SeekComplete }

ksymoops output:
ksymoops 2.4.5 on i686 2.4.21-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-rc1/ (default)
     -m /boot/System.map-2.4.21-rc1 (default)
     -i

Unable to handle kernel NULL pointer dereference at virtual address 00000024
c01bb8c2
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01bb8c2>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: c162e380   ebx: 00000050   ecx: 00000005   edx: 0000a007
esi: c030a870   edi: 00000000   ebp: c030a7c0   esp: c02b3ee0
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02b3000)
Stack: 0000a007 00000016 00000016 c030a870 c162e380 c01bb850 c01b45f4 c030a870 
       c030a870 00000000 00000286 c162e3a4 c01b4550 fffffffe 00000046 c0122e7e 
       c162e380 c162e2a4 c162e2a4 00000000 c02d3dc0 fffffffe 00000046 c011eb82 
Call Trace:    [<c01bb850>] [<c01b45f4>] [<c01b4550>] [<c0122e7e>] [<c011eb82>]
  [<c011ea96>] [<c011e8d4>] [<c010a53e>] [<c010ca98>] [<c0106ec3>] [<c0114818>]
  [<c0114770>] [<c0114770>] [<c0106f32>] [<c0105000>]
Code: 8b 5f 24 85 db 7e 22 8d b4 26 00 00 00 00 2b 5f 38 8b 86 a4 


>>EIP; c01bb8c2 <ide_dma_intr+72/c0>   <=====

>>eax; c162e380 <_end+1313700/204f2400>
>>edx; 0000a007 Before first symbol
>>esi; c030a870 <ide_hwifs+950/2b20>
>>ebp; c030a7c0 <ide_hwifs+8a0/2b20>
>>esp; c02b3ee0 <init_task_union+1ee0/2000>

Trace; c01bb850 <ide_dma_intr+0/c0>
Trace; c01b45f4 <ide_timer_expiry+a4/1b0>
Trace; c01b4550 <ide_timer_expiry+0/1b0>
Trace; c0122e7e <run_timer_list+ee/160>
Trace; c011eb82 <bh_action+22/40>
Trace; c011ea96 <tasklet_hi_action+46/70>
Trace; c011e8d4 <do_softirq+94/a0>
Trace; c010a53e <do_IRQ+9e/a0>
Trace; c010ca98 <call_do_IRQ+5/d>
Trace; c0106ec3 <default_idle+23/30>
Trace; c0114818 <apm_cpu_idle+a8/130>
Trace; c0114770 <apm_cpu_idle+0/130>
Trace; c0114770 <apm_cpu_idle+0/130>
Trace; c0106f32 <cpu_idle+42/60>
Trace; c0105000 <_stext+0/0>

Code;  c01bb8c2 <ide_dma_intr+72/c0>
00000000 <_EIP>:
Code;  c01bb8c2 <ide_dma_intr+72/c0>   <=====
   0:   8b 5f 24                  mov    0x24(%edi),%ebx   <=====
Code;  c01bb8c5 <ide_dma_intr+75/c0>
   3:   85 db                     test   %ebx,%ebx
Code;  c01bb8c7 <ide_dma_intr+77/c0>
   5:   7e 22                     jle    29 <_EIP+0x29>
Code;  c01bb8c9 <ide_dma_intr+79/c0>
   7:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c01bb8d0 <ide_dma_intr+80/c0>
   e:   2b 5f 38                  sub    0x38(%edi),%ebx
Code;  c01bb8d3 <ide_dma_intr+83/c0>
  11:   8b 86 a4 00 00 00         mov    0xa4(%esi),%eax

 <0>Kernel panic: Aiee, killing interrupt handler!

lspci -vvv:
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3189
	Subsystem: VIA Technologies, Inc.: Unknown device 3189
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 8
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
		Command: RQ=31 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b168 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
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

00:09.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 14)
	Subsystem: LSI Logic / Symbios Logic: Unknown device 1000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (4250ns min, 16000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 9000 [size=256]
	Region 1: Memory at e7002000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at e7001000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:09.1 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 14)
	Subsystem: LSI Logic / Symbios Logic: Unknown device 1000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (4250ns min, 16000ns max), cache line size 08
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at 9400 [size=256]
	Region 1: Memory at e7003000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at e7004000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 9800 [size=128]
	Region 1: Memory at e7000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W [Millennium] (rev 01) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at e4000000 (32-bit, non-prefetchable) [size=16K]
	Region 1: Memory at e5000000 (32-bit, prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0e.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: Soyo Computer, Inc: Unknown device a715
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 9c00 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 RAID bus controller: Triones Technologies, Inc. HPT366/368/370/370A/372 (rev 05)
	Subsystem: Triones Technologies, Inc. HPT370A
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 120 (2000ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at a000 [size=8]
	Region 1: I/O ports at a400 [size=4]
	Region 2: I/O ports at a800 [size=8]
	Region 3: I/O ports at ac00 [size=4]
	Region 4: I/O ports at b000 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 12
	Region 4: I/O ports at b400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at b800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin C routed to IRQ 11
	Region 4: I/O ports at bc00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
	Subsystem: VIA Technologies, Inc. USB 2.0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 10
	Interrupt: pin D routed to IRQ 5
	Region 0: Memory at e7005000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
	Subsystem: VIA Technologies, Inc. VT8233A ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at c000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
	Subsystem: VIA Technologies, Inc.: Unknown device 0102
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at c400 [size=256]
	Region 1: Memory at e7006000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

/proc/cpuinfo:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2100+
stepping        : 1
cpu MHz         : 1733.438
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mmxext
3dnowext 3dnow
bogomips        : 3460.30

/proc/ioports:
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
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
9000-90ff : LSI Logic / Symbios Logic (formerly NCR) 53c875
  9000-907f : sym53c8xx
9400-94ff : LSI Logic / Symbios Logic (formerly NCR) 53c875 (#2)
  9400-947f : sym53c8xx
9800-987f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  9800-987f : 00:0a.0
9c00-9cff : C-Media Electronics Inc CM8738
a000-a007 : Triones Technologies, Inc. HPT366/368/370/370A/372
  a000-a007 : ide2
a400-a403 : Triones Technologies, Inc. HPT366/368/370/370A/372
  a402-a402 : ide2
a800-a807 : Triones Technologies, Inc. HPT366/368/370/370A/372
  a800-a807 : ide3
ac00-ac03 : Triones Technologies, Inc. HPT366/368/370/370A/372
  ac02-ac02 : ide3
b000-b0ff : Triones Technologies, Inc. HPT366/368/370/370A/372
  b000-b007 : ide2
  b008-b00f : ide3
  b010-b0ff : HPT372
b400-b41f : VIA Technologies, Inc. USB
  b400-b41f : usb-uhci
b800-b81f : VIA Technologies, Inc. USB (#2)
  b800-b81f : usb-uhci
bc00-bc1f : VIA Technologies, Inc. USB (#3)
  bc00-bc1f : usb-uhci
c000-c00f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  c000-c007 : ide0
  c008-c00f : ide1
c400-c4ff : VIA Technologies, Inc. VT6102 [Rhine-II]
  c400-c4ff : via-rhine


/proc/iomem:
00000000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cb7ff : Extension ROM
000cc000-000cfbff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-0023ba11 : Kernel code
  0023ba12-002b14a3 : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
e0000000-e3ffffff : VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
e4000000-e4003fff : Matrox Graphics, Inc. MGA 2064W [Millennium]
e5000000-e57fffff : Matrox Graphics, Inc. MGA 2064W [Millennium]
e7000000-e700007f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
e7001000-e7001fff : LSI Logic / Symbios Logic (formerly NCR) 53c875
e7002000-e70020ff : LSI Logic / Symbios Logic (formerly NCR) 53c875
e7003000-e70030ff : LSI Logic / Symbios Logic (formerly NCR) 53c875 (#2)
e7004000-e7004fff : LSI Logic / Symbios Logic (formerly NCR) 53c875 (#2)
e7005000-e70050ff : VIA Technologies, Inc. USB 2.0
  e7005000-e70050ff : ehci-hcd
e7006000-e70060ff : VIA Technologies, Inc. VT6102 [Rhine-II]
  e7006000-e70060ff : via-rhine
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

/proc/interrupts:
           CPU0       
  0:    1338584          XT-PIC  timer
  1:         20          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  ehci-hcd
  8:          1          XT-PIC  rtc
 10:      33040          XT-PIC  sym53c8xx, usb-uhci
 11:    7261355          XT-PIC  ide2, ide3, sym53c8xx, usb-uhci, eth1
 12:      66695          XT-PIC  usb-uhci, eth0, PS/2 Mouse
 14:    2702836          XT-PIC  ide0
 15:    1931929          XT-PIC  ide1
NMI:          0 
ERR:          0
