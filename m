Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264218AbUE2Uoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264218AbUE2Uoo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 16:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUE2Uoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 16:44:44 -0400
Received: from pop.gmx.de ([213.165.64.20]:8364 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264218AbUE2Unz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 16:43:55 -0400
X-Authenticated: #4512188
Message-ID: <40B8F601.2000600@gmx.de>
Date: Sat, 29 May 2004 22:43:45 +0200
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040525)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc1-mm1: libata flooding my log
References: <40B8E8D4.1010905@gmx.de> <40B8EB07.6000700@pobox.com>
In-Reply-To: <40B8EB07.6000700@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Prakash K. Cheemplavam wrote:
> 
[snip]

>> FAILED
>>   status = 1, message = 00, host = 0, driver = 08
>>   Current sd: sense = 70  5
>> ASC=20 ASCQ= 0
>> Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 
>> 0x00 0x20 0x00
>> FAILED
>>   status = 1, message = 00, host = 0, driver = 08
>>   Current sd: sense = 70  5
>> ASC=20 ASCQ= 0
>> Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 
>> 0x00 0x20 0x00
>> FAILED
>>   status = 1, message = 00, host = 0, driver = 08
>>   Current sd: sense = 70  5
>> ASC=20 ASCQ= 0
>> Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 
>> 0x00 0x20 0x00
>>
>>
>> Any idea of what is going on? Is dmesg output needed? The system seesm 
>> to behave rel normal, beside a bit performance degration, I think.
> 
> 
> Reading REPORTING-BUGS for the info that is needed.

Oh OK, so here it goes (I have rebooted to a patched mm kernel, but tha 
plain mm showed the same behaviour, just in cae you are wondering...):

Linux tachyon 2.6.7-rc1-love1 #3 Sat May 29 10:40:18 CEST 2004 i686 AMD 
Athlon(tm)  AuthenticAMD GNU/Linux

Gnu C                  3.4.0
Gnu make               3.80
binutils               2.14.90.0.8
util-linux             2.12
mount                  2.12
module-init-tools      3.0
e2fsprogs              1.35
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         usblp ehci_hcd ohci_hcd usbcore nvidia

root@tachyon linux # cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm)
stepping        : 1
cpu MHz         : 2205.234
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
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 4358.14


root@tachyon linux # cat /proc/modules
usblp 10624 0 - Live 0xf89e2000
ehci_hcd 28612 0 - Live 0xf89c1000
ohci_hcd 18756 0 - Live 0xf89b2000
usbcore 97504 5 usblp,ehci_hcd,ohci_hcd, Live 0xf89c9000
nvidia 2075080 0 - Live 0xf8b10000

root@tachyon linux # cat /proc/ioports
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
0290-0297 : w83627hf
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
5000-5007 : nForce2 SMBus
5100-5107 : nForce2 SMBus
9000-afff : PCI Bus #01
   9000-9007 : 0000:01:0b.0
     9000-9007 : sata_sil
   9400-9403 : 0000:01:0b.0
     9400-9403 : sata_sil
   9800-9807 : 0000:01:0b.0
     9800-9807 : sata_sil
   9c00-9c03 : 0000:01:0b.0
     9c00-9c03 : sata_sil
   a000-a00f : 0000:01:0b.0
     a000-a00f : sata_sil
b000-b007 : 0000:00:04.0
   b000-b007 : eth0
b400-b4ff : 0000:00:06.0
b800-b87f : 0000:00:06.0
   b800-b83f : NVidia nForce2 - Controller
c400-c41f : 0000:00:01.1
f000-f00f : 0000:00:09.0
   f000-f007 : ide0
   f008-f00f : ide1


root@tachyon linux # cat /proc/iomem
00000000-0009f3ff : System RAM
0009f400-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cebff : Video ROM
000d0000-000d47ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
   00100000-0038dc11 : Kernel code
   0038dc12-0047b53f : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
a0000000-bfffffff : 0000:00:00.0
c0000000-c7ffffff : PCI Bus #02
   c0000000-c7ffffff : 0000:02:00.0
c8000000-c9ffffff : PCI Bus #02
   c8000000-c8ffffff : 0000:02:00.0
ca000000-cbffffff : PCI Bus #01
   cb000000-cb0001ff : 0000:01:0b.0
     cb000000-cb0001ff : sata_sil
cc000000-cc07ffff : 0000:00:05.0
cc080000-cc080fff : 0000:00:02.0
   cc080000-cc080fff : ohci_hcd
cc081000-cc081fff : 0000:00:06.0
   cc081000-cc0811ff : NVidia nForce2 - AC'97
cc083000-cc083fff : 0000:00:02.1
   cc083000-cc083fff : ohci_hcd
cc084000-cc0847ff : 0000:00:0d.0
cc085000-cc08503f : 0000:00:0d.0
cc086000-cc0860ff : 0000:00:02.2
   cc086000-cc0860ff : ehci_hcd
cc087000-cc087fff : 0000:00:04.0
   cc087000-cc087fff : eth0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

root@tachyon linux # lspci -vvv
0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different 
version?) (rev c1)
         Subsystem: ABIT Computer Corp.: Unknown device 1c00
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Region 0: Memory at a0000000 (32-bit, prefetchable)
         Capabilities: [40] AGP version 3.0
                 Status: RQ=32 Iso- ArqSz=2 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                 Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- 
FW+ Rate=x8
         Capabilities: [60] #08 [2001]

0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 
(rev c1)
         Subsystem: nVidia Corporation: Unknown device 0c17
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 
(rev c1)
         Subsystem: nVidia Corporation: Unknown device 0c17
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 
(rev c1)
         Subsystem: nVidia Corporation: Unknown device 0c17
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 
(rev c1)
         Subsystem: nVidia Corporation: Unknown device 0c17
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 
(rev c1)
         Subsystem: nVidia Corporation: Unknown device 0c17
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a3)
         Subsystem: ABIT Computer Corp.: Unknown device 1c00
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Capabilities: [48] #08 [01e1]

0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
         Subsystem: ABIT Computer Corp.: Unknown device 1c00
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 23
         Region 0: I/O ports at c400
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller 
(rev a3) (prog-if 10 [OHCI])
         Subsystem: ABIT Computer Corp.: Unknown device 1c00
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin A routed to IRQ 22
         Region 0: Memory at cc080000 (32-bit, non-prefetchable)
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller 
(rev a3) (prog-if 10 [OHCI])
         Subsystem: ABIT Computer Corp.: Unknown device 1c00
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin B routed to IRQ 21
         Region 0: Memory at cc083000 (32-bit, non-prefetchable)
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller 
(rev a3) (prog-if 20 [EHCI])
         Subsystem: ABIT Computer Corp.: Unknown device 1c00
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin C routed to IRQ 20
         Region 0: Memory at cc086000 (32-bit, non-prefetchable)
         Capabilities: [44] #0a [2080]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet 
Controller (rev a1)
         Subsystem: ABIT Computer Corp.: Unknown device 1c00
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (250ns min, 5000ns max)
         Interrupt: pin A routed to IRQ 22
         Region 0: Memory at cc087000 (32-bit, non-prefetchable)
         Region 1: I/O ports at b000 [size=8]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

0000:00:05.0 Multimedia audio controller: nVidia Corporation nForce 
MultiMedia audio [Via VT82C686B] (rev a2)
         Subsystem: ABIT Computer Corp.: Unknown device 1c00
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (250ns min, 3000ns max)
         Interrupt: pin A routed to IRQ 21
         Region 0: Memory at cc000000 (32-bit, non-prefetchable)
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 
AC97 Audio Controler (MCP) (rev a1)
         Subsystem: ABIT Computer Corp.: Unknown device 1c00
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (500ns min, 1250ns max)
         Interrupt: pin A routed to IRQ 20
         Region 0: I/O ports at b400
         Region 1: I/O ports at b800 [size=128]
         Region 2: Memory at cc081000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge 
(rev a3) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
         I/O behind bridge: 00009000-0000afff
         Memory behind bridge: ca000000-cbffffff
         Prefetchable memory behind bridge: fff00000-000fffff
         Expansion ROM at 00009000 [disabled] [size=8K]
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) 
(prog-if 8a [Master SecP PriP])
         Subsystem: ABIT Computer Corp.: Unknown device 1c00
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Region 4: I/O ports at f000 [size=16]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire 
(IEEE 1394) Controller (rev a3) (prog-if 10 [OHCI])
         Subsystem: ABIT Computer Corp.: Unknown device 1c00
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin A routed to IRQ 22
         Region 0: Memory at cc084000 (32-bit, non-prefetchable)
         Region 1: Memory at cc085000 (32-bit, non-prefetchable) [size=64]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) 
(prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: c8000000-c9ffffff
         Prefetchable memory behind bridge: c0000000-c7ffffff
         BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:01:0b.0 RAID bus controller: CMD Technology Inc Silicon Image SiI 
3112 SATARaid Controller (rev 02)
         Subsystem: CMD Technology Inc: Unknown device 6112
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin A routed to IRQ 18
         Region 0: I/O ports at 9000
         Region 1: I/O ports at 9400 [size=4]
         Region 2: I/O ports at 9800 [size=8]
         Region 3: I/O ports at 9c00 [size=4]
         Region 4: I/O ports at a000 [size=16]
         Region 5: Memory at cb000000 (32-bit, non-prefetchable) [size=512]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:02:00.0 VGA compatible controller: nVidia Corporation NV28 
[GeForce4 Ti 4200 AGP 8x] (rev a1) (prog-if 00 [VGA])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 248 (1250ns min, 250ns max)
         Interrupt: pin A routed to IRQ 19
         Region 0: Memory at c8000000 (32-bit, non-prefetchable)
         Region 1: Memory at c0000000 (32-bit, prefetchable) [size=128M]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [44] AGP version 3.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                 Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- 
FW+ Rate=x8

root@tachyon linux # cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: SAMSUNG SP1614N  Rev: TM10
   Type:   Direct-Access                    ANSI SCSI revision: 05



> 
> I wonder if you have a bad SATA cable, initially, though.

I don't think so, because previous mm kernels didn't show anything like 
this.

bye,

Prakash
