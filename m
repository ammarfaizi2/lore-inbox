Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbTJAEZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 00:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTJAEZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 00:25:29 -0400
Received: from hadar.cse.Buffalo.EDU ([128.205.32.1]:16318 "EHLO
	hadar.cse.Buffalo.EDU") by vger.kernel.org with ESMTP
	id S261895AbTJAEZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 00:25:06 -0400
Date: Wed, 1 Oct 2003 00:25:05 -0400 (EDT)
From: JaReK <myszewsk@cse.Buffalo.EDU>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Ethernet Card PCI ID # not included
Message-ID: <Pine.SOL.4.56.0309302327470.16423@pollux.cse.Buffalo.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The pci id # for the Edimax Ethernet Controller 9130 is not included;
init_module failure during driver module loading.


Purchased Siemens 1020 Ethernet Card and installed on a PC running
Slackware Linux 9.0 kernel 2.4.23-pre5
Card provides instruction on using the tulip driver.
Tulip ethernet driver failed when loading its module; failure error
init_module - no such device

Ran lspci
result of lspci:
00:0a.0 Ethernet Controller: Edimax Computer Co.: Unknown Device 9130 (rev
10)

Visited the Edimax Computer Co. Website (http://www.edimax.com) and read
about 9130 Ethernet Cards; downloaded its driver package (windows and linux); linux driver
folder contained a README file instructing to use rtl8139 driver.

I've downloaded the rtl8139 driver from the
http://www.scyld.com/network/rtl8139.html website and compiled it;
when attempting to 'insmod' it again got a response
rtl8139.o: init_module: No such device

I've tried the new realtek driver 8139too   as well with the same failure
results.
Finally, I've inspected the PCI Ethernet card itself; it has two chips on
it.

Chip 1 has the following text:
RTL8139C
2A031Q1
241B Taiwan


Chip 2 has the following text:
HE-MX2021
0237

The card itself has the following text:
SpeedStream SS1020
Efficient Networks
SS10202BE2501467



Below are the error messages that get generated when attempting to load
the module and the computer hardware info (I followed your suggestions on
what info to include):

bash-2.05a# insmod rtl8139.o
rtl8139.o: init_module: No such device
rtl8139.o: Hint: insmod errors can be caused by incorrect module
parameters, including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg


bash-2.05a# modprobe 8139too
/lib/modules/2.4.23-pre5/kernel/drivers/net/8139too.o: init_module: No
such device
/lib/modules/2.4.23-pre5/kernel/drivers/net/8139too.o: Hint: insmod errors
can be caused by incorrect module parameters, including invalid IO or IRQ
parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.23-pre5/kernel/drivers/net/8139too.o: insmod
/lib/modules/2.4.23-pre5/kernel/drivers/net/8139too.o failed
/lib/modules/2.4.23-pre5/kernel/drivers/net/8139too.o: insmod 8139too
failed

I thnk I'm loading the proper driver but it is having trouble identifying
the device. (ethernet card).  I'm open for suggesitons how to solve this;
my guess is that this card is not included in the pci device list.


Below is the computer hardware info:
bash-2.05a# lspci
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:09.0 SCSI storage controller: Adaptec AHA-2940U2/U2W
00:0a.0 Ethernet controller: Edimax Computer Co.: Unknown device 9130 (r
00:0b.0 Multimedia audio controller: IC Ensemble Inc ICE1712 [Envy24] (r
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (r

bash-2.05a# lspci -v
00:0a.0 Ethernet controller: Edimax Computer Co.: Unknown device 9130 (rev
10)
        Subsystem: Efficient Networks, Inc: Unknown device 1020
        Flags: bus master, medium devsel, latency 64, IRQ 9
        I/O ports at d800 [size=256]
        Memory at e3000000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at e2000000 [disabled] [size=64K]
        Capabilities: [50] Power Management version 2

bash-2.05a# cat /proc/version
Linux version 2.4.23-pre5 (root@BALZAAC) (gcc version 2.95.3 20010315
(release)) #2 SMP Tue Sep 30 20:48:27 EDT 2003

bash-2.05a# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 2
cpu MHz         : 451.028
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 897.84

bash-2.05a# cat /proc/modules
pci-scan                3784   0
bash-2.05a#

bash-2.05a# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
02f8-02ff : serial(auto)
03c0-03df : vga+
  03c0-03df : matrox
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-403f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
5000-501f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
c000-cfff : PCI Bus #01
d000-d01f : Intel Corp. 82371AB/EB/MB PIIX4 USB
d400-d4ff : Adaptec AHA-2940U2/U2W
d800-d8ff : PCI device 1432:9130 (Edimax Computer Co.)
dc00-dc1f : IC Ensemble Inc ICE1712 [Envy24]
e000-e00f : IC Ensemble Inc ICE1712 [Envy24]
e400-e40f : IC Ensemble Inc ICE1712 [Envy24]
e800-e83f : IC Ensemble Inc ICE1712 [Envy24]
f000-f00f : Intel Corp. 82371AB/EB/MB PIIX4 IDE
bash-2.05a# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000ce5ff : Extension ROM
000f0000-000fffff : System ROM
00100000-27feffff : System RAM
  00100000-00251f64 : Kernel code
  00251f65-002e825f : Kernel data
27ff0000-27ff2fff : ACPI Non-volatile Storage
27ff3000-27ffffff : ACPI Tables
d8000000-dbffffff : Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
dc000000-dfffffff : PCI Bus #01
  dc000000-dc003fff : Matrox Graphics, Inc. MGA G200 AGP
    dc000000-dc003fff : matroxfb MMIO
  dd000000-dd7fffff : Matrox Graphics, Inc. MGA G200 AGP
e0000000-e0ffffff : PCI Bus #01
  e0000000-e0ffffff : Matrox Graphics, Inc. MGA G200 AGP
    e0000000-e0ffffff : matroxfb FB
e3000000-e30000ff : PCI device 1432:9130 (Edimax Computer Co.)
e3001000-e3001fff : Adaptec AHA-2940U2/U2W
  e3001000-e3001fff : aic7xxx
ffff0000-ffffffff : reserved
bash-2.05a#


00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
(rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: dc000000-dfffffff
        Prefetchable memory behind bridge: e0000000-e0ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
arErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at d000 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:09.0 SCSI storage controller: Adaptec AHA-2940U2/U2W
        Subsystem: Adaptec AHA-2940U2W SCSI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (9750ns min, 6250ns max)
        Interrupt: pin A routed to IRQ 5
        BIST result: 00
        Region 0: I/O ports at d400 [disabled] [size=256]
        Region 1: Memory at e3001000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at e1000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Edimax Computer Co.: Unknown device 9130 (rev
10)
        Subsystem: Efficient Networks, Inc: Unknown device 1020
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- Fast
B2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR
- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at d800 [size=256]
        Region 1: Memory at e3000000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at e2000000 [disabled] [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Multimedia audio controller: IC Ensemble Inc ICE1712 [Envy24] (rev
02)
        Subsystem: IC Ensemble Inc: Unknown device d630
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- Fast
B2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR
- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at dc00 [size=32]
        Region 1: I/O ports at e000 [size=16]
        Region 2: I/O ports at e400 [size=16]
        Region 3: I/O ports at e800 [size=64]
        Capabilities: [80] Power Management version 1
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev
01) (prog-if 00 [VGA]
)
        Subsystem: Matrox Graphics, Inc. MGA-G200 AGP
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- Fast
B2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR
- <PERR-
        Latency: 64 (4000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=16M]
        Region 1: Memory at dc000000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at dd000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x2



bash-2.05a# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: WDIGTL   Model: WDE9100 ULTRA2   Rev: 1.22
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: TOSHIBA  Model: CD-ROM XM-6401TA Rev: 1009
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: WDIGTL   Model: WDE18300 ULTRA2  Rev: 1.30
  Type:   Direct-Access                    ANSI SCSI revision: 02
bash-2.05a#




Regards ...
Yarek


  "Only two things are infinite, the universe and human stupidity, and I'm
			  not sure about the former."

			     - Albert Einstein

