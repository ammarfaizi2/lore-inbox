Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268515AbTBWQ5D>; Sun, 23 Feb 2003 11:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268516AbTBWQ5D>; Sun, 23 Feb 2003 11:57:03 -0500
Received: from [212.180.54.8] ([212.180.54.8]:24068 "EHLO colibri.dagami.org")
	by vger.kernel.org with ESMTP id <S268515AbTBWQ46>;
	Sun, 23 Feb 2003 11:56:58 -0500
Subject: PROBLEM: probing scsi hangs
From: nb <nb@dagami.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046020020.1784.16.camel@hades.dagami.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 23 Feb 2003 18:07:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Booting kernel hangs on scsi devices probing.


Full description :
----------------

This is what I sent on march 2002 to 
deischen@iworks.InterWorks.org,dledford@redhat.com,groudier@club-internet.fr and gibbs@scsiguy.com but with no answer :

I've recently bought a MSI K7N420 PRO motherboard (MS-6373).
It is based on Nvidia 420D chipset which includes sound and
lan adapter. I couldn't boot under Linux (Debian testing with
2.4.17 kernel). Same pb with 2.4.18. It hangs on boot when the
adaptec 29160 card was being detected. Boot was possible when
the lan adapter was disabled via the bios.
I've tried to put traces and I've found that in aic7xxx_linux.c
the program was calling aic7770_linux_probe when it hangs !
I have commented the two following lines :

//      if (aic7xxx_no_probe == 0)
//              aic7770_linux_probe(template);

After that boot was possible.

I'm not a kernel hacker but if you want I can make further tests.
If you tell me what.
I have to say that the motherboard works fine under Windows XP.
The W98 SE boot disk didn't detect it correctly until I've changed
the driver ( a new one was on the CD shipped with the motherboard).

Keywords :
--------

kernel, modules, scsi, nvidia, K7N420PRO, MSI6373, hang, boot,
aic7xxx_linux.c

Kernel version 
--------------

2.4.17, 2.4.18 and 2.4.19

Environment :
-----------

Processor information : 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) 
stepping        : 2
cpu MHz         : 1173.764
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 2339.63

PCI information :
---------------

00:00.0 Host bridge: nVidia Corporation nForce CPU bridge (rev b2)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: <available only to root>

00:00.1 RAM memory: nVidia Corporation nForce 220/420 Memory Controller
(rev b2)
        Subsystem: Micro-star International Co Ltd: Unknown device 3730
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: nVidia Corporation nForce 220/420 Memory Controller
(rev b2)
        Subsystem: Micro-star International Co Ltd: Unknown device 3730
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:00.3 RAM memory: nVidia Corporation nForce 420 Memory Controller
(DDR) (rev b2)
        Subsystem: Micro-star International Co Ltd: Unknown device 3730
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:01.0 ISA bridge: nVidia Corporation nForce ISA Bridge (rev c3)
        Subsystem: Micro-star International Co Ltd: Unknown device 3730
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: <available only to root>

00:01.1 SMBus: nVidia Corporation nForce PCI System Management (rev c1)
        Subsystem: Micro-star International Co Ltd: Unknown device 3730
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 15
        Region 0: I/O ports at 5000 [size=16]
        Region 1: I/O ports at 5020 [size=16]
        Region 2: I/O ports at 6000 [size=32]
        Capabilities: <available only to root>

00:02.0 USB Controller: nVidia Corporation nForce USB Controller (rev
c3) (prog-if 10 [OHCI])
        Subsystem: Micro-star International Co Ltd: Unknown device 3730
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e1083000 (32-bit, non-prefetchable)
[size=4K]
        Capabilities: <available only to root>

00:03.0 USB Controller: nVidia Corporation nForce USB Controller (rev
c3) (prog-if 10 [OHCI])
        Subsystem: Micro-star International Co Ltd: Unknown device 3730
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e1081000 (32-bit, non-prefetchable)
[size=4K]
        Capabilities: <available only to root>

00:04.0 Ethernet controller: nVidia Corporation nForce Ethernet
Controller (rev c2)
        Subsystem: Micro-star International Co Ltd: Unknown device 373c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e1082000 (32-bit, non-prefetchable)
[size=1K]
        Region 1: I/O ports at a800 [size=8]
        Capabilities: <available only to root>

00:05.0 Multimedia audio controller: nVidia Corporation: Unknown device
01b0 (rev c2)
        Subsystem: Micro-star International Co Ltd: Unknown device 3730
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 3000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e1000000 (32-bit, non-prefetchable)
[size=512K]
        Capabilities: <available only to root>

00:06.0 Multimedia audio controller: nVidia Corporation nForce Audio
(rev c2)
        Subsystem: Micro-star International Co Ltd: Unknown device 3730
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (500ns min, 1250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at ac00 [size=256]
        Region 1: I/O ports at b000 [size=128]
        Region 2: Memory at e1084000 (32-bit, non-prefetchable)
[size=4K]
        Capabilities: <available only to root>

00:06.1 Modem: nVidia Corporation Intel 537 [nForce MC97 Modem] (rev c1)
(prog-if 00 [Generic])
        Subsystem: Micro-star International Co Ltd: Unknown device 3730
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (500ns min, 1250ns max)
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at b400 [size=256]
        Region 1: I/O ports at b800 [size=128]
        Region 2: Memory at e1080000 (32-bit, non-prefetchable)
[size=4K]
        Capabilities: <available only to root>

00:08.0 PCI bridge: nVidia Corporation nForce PCI-to-PCI bridge (rev c2)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: df000000-e0ffffff
        Prefetchable memory behind bridge: dc000000-dcffffff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:09.0 IDE interface: nVidia Corporation nForce IDE (rev c3) (prog-if
8a [Master SecP PriP])
        Subsystem: Micro-star International Co Ltd: Unknown device 3730
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Region 4: I/O ports at c000 [size=16]
        Capabilities: <available only to root>

00:1e.0 PCI bridge: nVidia Corporation nForce AGP to PCI Bridge (rev b2)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 99
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: dd000000-deffffff
        Prefetchable memory behind bridge: d0000000-d7ffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

01:00.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV/GO
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 15
        Region 0: Memory at dc000000 (32-bit, prefetchable) [size=4K]
        Capabilities: <available only to root>

01:00.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
(rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV/GO
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 15
        Region 0: Memory at dc001000 (32-bit, prefetchable) [size=4K]
        Capabilities: <available only to root>

01:02.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
        Subsystem: Adaptec 29160 Ultra160 SCSI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 15
        BIST result: 00
        Region 0: I/O ports at 9000 [disabled] [size=256]
        Region 1: Memory at e0104000 (64-bit, non-prefetchable)
[size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: <available only to root>

01:03.0 FireWire (IEEE 1394): Texas Instruments TSB12LV23 IEEE-1394
Controller (prog-if 10 [OHCI])
        Subsystem: Ads Technologies Inc: Unknown device 0000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 15
        Region 0: Memory at e0105000 (32-bit, non-prefetchable)
[size=2K]
        Region 1: Memory at e0100000 (32-bit, non-prefetchable)
[size=16K]
        Capabilities: <available only to root>

01:04.0 Multimedia controller: Sigma Designs, Inc. REALmagic Hollywood
Plus DVD Decoder (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 15
        Region 0: Memory at e0000000 (32-bit, non-prefetchable)
[size=1M]
        Capabilities: <available only to root>

02:00.0 VGA compatible controller: nVidia Corporation NV15 [GeForce2 -
nForce GPU] (rev b1) (prog-if 00 [VGA])
        Subsystem: Micro-star International Co Ltd: Unknown device 3738
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at dd000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: <available only to root

SCSI information :
----------------

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: COMPAQ   Model: BD036734A5       Rev: 3B06
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: COMPAQ   Model: BD036734A5       Rev: 3B06
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: MATSHITA Model: CD-R   CW-7502   Rev: 3.17
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-40TS   Rev: 1.05
  Type:   CD-ROM                           ANSI SCSI revision: 02

workaround :
----------

commenting the two lines in aic7xxx_linux.c

      if (aic7xxx_no_probe == 0)
              aic7770_linux_probe(template);



regards

-- 
nb <nb@dagami.org>
