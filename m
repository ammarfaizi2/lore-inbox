Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130355AbQL0MHu>; Wed, 27 Dec 2000 07:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130362AbQL0MHk>; Wed, 27 Dec 2000 07:07:40 -0500
Received: from irz301.inf.tu-dresden.de ([141.76.2.1]:6185 "EHLO
	irz301.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id <S130355AbQL0MH1>; Wed, 27 Dec 2000 07:07:27 -0500
Date: Wed, 27 Dec 2000 12:36:59 +0100
From: Adam Lackorzynski <al10@inf.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test13-pre4 doesn't detect PCI devices
Message-ID: <20001227123659.A23236@inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Kernel 2.4.0-test13-pre4 (without any patches) does not see some of the PCI
devices with my setup here. The machine is a IBM Netfinity 7100 Quad-Xeon with
a Serverworks Chipset.

The RAID-Controller (a IBM ServeRAID-4L) is not detected.  Kernel 2.2.17
detects it. I also checked -test10 and -test12 kernels which suffer the same
problem.


$ lspci
00:00.0 Host bridge: ServerWorks CNB20HE (rev 21)
00:00.1 Host bridge: ServerWorks CNB20HE (rev 01)
00:00.2 Host bridge: ServerWorks: Unknown device 0006
00:00.3 Host bridge: ServerWorks: Unknown device 0006
00:01.0 SCSI storage controller: Adaptec 7896
00:01.1 SCSI storage controller: Adaptec 7896
00:05.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (rev 44)
00:06.0 VGA compatible controller: S3 Inc. Trio 64 3D (rev 01)
00:0f.0 ISA bridge: ServerWorks OSB4 (rev 4f)
00:0f.1 IDE interface: ServerWorks: Unknown device 0211
00:0f.2 USB Controller: ServerWorks: Unknown device 0220 (rev 04)

$ lspci -vv -s 00:00.0
00:00.0 Host bridge: ServerWorks CNB20HE (rev 21)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

$ lspci -vv -s 00:00.1
00:00.1 Host bridge: ServerWorks CNB20HE (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 96, cache line size 08

$ lspci -vv -s 00:00.2
00:00.2 Host bridge: ServerWorks: Unknown device 0006
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-

$ lspci -vv -s 00:00.3
00:00.3 Host bridge: ServerWorks: Unknown device 0006
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-


Additional output when using a 2.2.17 kernel (actually it's a 2.2.17pre6-1
kernel coming with the Debian 2.2r0-boot-disks):

02:06.0 RAID bus controller: IBM: Unknown device 01bd
        Subsystem: IBM: Unknown device 01bf
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 96 set, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f6ffe000 (32-bit, prefetchable)

$ uname -r
2.2.17
$ dmesg | grep -i pci
PCI: PCI BIOS revision 2.10 entry at 0xfd5cc
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: 00:00 [1166/0008]: Scanning peer host bridges
PCI: Scanning ServerWorks HE/LE Peer Bus Bridge 00/00
PCI: 00:01 [1166/0008]: Scanning peer host bridges
PCI: Scanning ServerWorks HE/LE Peer Bus Bridge 00/01
PCI_IDE: unknown IDE controller on PCI bus 00 device 79, VID=1166, DID=0211
PCI_IDE: not 100% native mode: will probe irqs later
(scsi0) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/1/0
(scsi1) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/1/1
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.31/3.2.4
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.31/3.2.4
pcnet32.c: PCI bios is present, checking for devices...
Found PCnet/PCI at 0x2200, irq 11.


$ uname -r
2.4.0-test13-pre4
$ dmesg | grep -i pci
Bus #0 is PCI   
Bus #1 is PCI   
Bus #2 is PCI   
Bus #3 is PCI   
Bus #4 is PCI   
Bus #5 is PCI   
Bus #6 is PCI   
PCI: PCI BIOS revision 2.10 entry at 0xfd5cc, last bus=6
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: ServerWorks host bridge: secondary bus 01
PCI: ServerWorks host bridge: secondary bus 00
PCI->APIC IRQ transform: (B0,I1,P0) -> 17
PCI->APIC IRQ transform: (B0,I1,P0) -> 17
PCI->APIC IRQ transform: (B0,I5,P0) -> 16
PCI->APIC IRQ transform: (B0,I15,P0) -> 26
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
pcnet32_probe_pci: found device 0x001022.0x002000
(scsi0) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/1/0
(scsi1) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/1/1
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0


I plugged an additional nic (tulip) into the same bus but it is not detected as
well.


Any hints?


Adam
-- 
Adam                 al10@inf.tu-dresden.de
  Lackorzynski         http://a.home.dhs.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
