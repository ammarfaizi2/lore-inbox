Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132936AbRDEPsl>; Thu, 5 Apr 2001 11:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132937AbRDEPsb>; Thu, 5 Apr 2001 11:48:31 -0400
Received: from viemta06.chello.at ([195.34.133.56]:25026 "EHLO
	viemta06.chello.at") by vger.kernel.org with ESMTP
	id <S132936AbRDEPsT>; Thu, 5 Apr 2001 11:48:19 -0400
Date: Thu, 5 Apr 2001 17:47:37 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: uninteruptable sleep
Message-ID: <20010405174737.A3397@southpark.chp>
In-Reply-To: <E14kRuT-0008Bc-00@the-village.bc.nu> <Pine.BSF.4.33.0104040122330.63187-100000@ocdi.sb101.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.BSF.4.33.0104040122330.63187-100000@ocdi.sb101.org>; from ocdi@ocdi.org on Wed, Apr 04, 2001 at 01:43:15AM +0930
From: Christian Pernegger <pernegger@chello.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Its a kernel bug if it gets stuck like this. You need to provide more info
> though - what file system, what devices, how much memory. Also ps can give you
> the wait address of a process stuck in 'D' state which is valuable for debug

Let's see if I'm getting this right, processes in D state should be killable?

I do not know if this is related, but I had two occurrences of those within
the last 48 hours, albeit on 2.2.18. 

1. starting tin (1.4.1) as a user - nothing happened, but the ssh session froze.
   Same on second try and a third with mutt (1.2.5) The three processes ended up
   D and unkillable by root. A few seconds later the sytem became totally
   unresponsive, with the kernel spewing 'VM: do_try_to_free_pages faild for
   cupsd' (sp?) at top speed... reboot.

2. The cups (1.1.4) usb backend ended up in this state after I did a
   'rmmod printer; insmod printer'

Regards
	Christian


Kernel: linux-2.2.18 + raid-2.2.17-A0

System: Pentium III 600 w/ 256MB RAM

hard disks: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DDRS-34560D      Rev: DC1B
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: YAMAHA   Model: CRW4260          Rev: 1.0q
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 08 Lun: 00
  Vendor: QUANTUM  Model: ATLAS_V_18_WLS   Rev: 0230
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 09 Lun: 00
  Vendor: QUANTUM  Model: ATLAS_V_18_WLS   Rev: 0230
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 10 Lun: 00
  Vendor: QUANTUM  Model: ATLAS_V_18_WLS   Rev: 0230
  Type:   Direct-Access                    ANSI SCSI revision: 03

RAID info:
Personalities : [raid5] 
read_ahead 1024 sectors
md0 : active raid5 sdd1[2] sdc1[1] sdb1[0] 35069824 blocks level 5, 64k chunk, algorithm 2 [3/3] [UUU]
unused devices: <none>

Layout of RAID disks (sdb-sdd):
Disk /dev/sdb: 64 heads, 32 sectors, 17510 cylinders
Units = cylinders of 2048 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sdb1           387     17510  17534976   fd  Linux raid autodetect
/dev/sdb3           130       386    263168   83  Linux
/dev/sdb4             1       129    132095+  82  Linux swap

lspci -vvv:
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:08.0 VGA compatible controller: Cirrus Logic GD 5430/40 [Alpine] (rev 48)
00:09.0 SCSI storage controller: Adaptec 7892A (rev 02)
00:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
jesus:/raid/home/chris# lspci -vvv
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
        Latency: 64 set
        Region 0: Memory at d8000000 (32-bit, prefetchable)
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=21
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Region 4: I/O ports at f000 [disabled]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Interrupt: pin D routed to IRQ 15
        Region 4: I/O ports at e000

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:08.0 VGA compatible controller: Cirrus Logic GD 5430/40 [Alpine] (rev 48) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at dc000000 (32-bit, prefetchable)
        Expansion ROM at dd000000 [disabled]

00:09.0 SCSI storage controller: Adaptec 7892A (rev 02)
        Subsystem: Adaptec: Unknown device e2a0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 40 min, 25 max, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 10
        BIST result: 00
        Region 0: I/O ports at e400
        Region 1: Memory at e0001000 (64-bit, non-prefetchable)
        Expansion ROM at de000000 [disabled]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
        Subsystem: 3Com Corporation: Unknown device 1000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 10 min, 10 max, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 15
        Region 0: I/O ports at e800
        Region 1: Memory at e0000000 (32-bit, non-prefetchable)
        Expansion ROM at df000000 [disabled]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME+
                Status: D0 PME-Enable+ DSel=0 DScale=2 PME-
