Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbUCRK44 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 05:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbUCRK44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 05:56:56 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:10446 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S262515AbUCRK4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 05:56:48 -0500
Date: Thu, 18 Mar 2004 18:52:56 +0800
To: "kernel mailing list" <linux-kernel@vger.kernel.org>
Subject: 2.6.4 under heavy ioload disables sis5513 DMA
From: "Michael Frank" <mhf@linuxmail.org>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr410iiid4evsfm@smtp.pacific.net.th>
User-Agent: Opera M2/7.50 (Linux, build 615)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Happens every few hours with heavy io and cpu load:

hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0xd0 { Busy }

hda: DMA disabled
ide0: reset: success

DMA auto-reenabled by boot time hdparm -k

lspci -vv

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 80 [Master])
         Subsystem: Micro-Star International Co., Ltd.: Unknown device 5332
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 128
         Interrupt: pin ? routed to IRQ 10
         Region 4: I/O ports at 4000 [size=16]
         Capabilities: [58] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-


hdparm -iI

/dev/hda:

  Model=IC35L090AVV207-0, FwRev=V23OA63A, SerialNo=VNVC00G3CABSMD
  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=52
  BuffType=DualPortCache, BuffSize=1821kB, MaxMultSect=16, MultSect=16
  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=160836480
  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes:  pio0 pio1 pio2 pio3 pio4
  DMA modes:  mdma0 mdma1 mdma2
  UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
  AdvancedPM=yes: disabled (255) WriteCache=enabled
  Drive conforms to: ATA/ATAPI-6 T13 1410D revision 3a:  2 3 4 5 6


ATA device, with non-removable media
powers-up in standby; SET FEATURES subcmd spins-up.
         Model Number:       IC35L090AVV207-0
         Serial Number:      VNVC00G3CABSMD
         Firmware Revision:  V23OA63A
Standards:
         Used: ATA/ATAPI-6 T13 1410D revision 3a
         Supported: 6 5 4 3
Configuration:
         Logical         max     current
         cylinders       16383   65535
         heads           16      1
         sectors/track   63      63
         --
         CHS current addressable sectors:    4128705
         LBA    user addressable sectors:  160836480
         LBA48  user addressable sectors:  160836480
         device size with M = 1024*1024:       78533 MBytes
         device size with M = 1000*1000:       82348 MBytes (82 GB)
Capabilities:
         LBA, IORDY(can be disabled)
         bytes avail on r/w long: 52     Queue depth: 32
         Standby timer values: spec'd by Standard, no device specific minimum
         R/W multiple sector transfer: Max = 16  Current = 16
         Advanced power management level: unknown setting (0x0000)
         Recommended acoustic management value: 128, current value: 254
         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
              Cycle time: min=120ns recommended=120ns
         PIO: pio0 pio1 pio2 pio3 pio4
              Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
         Enabled Supported:
            *    NOP cmd
            *    READ BUFFER cmd
            *    WRITE BUFFER cmd
            *    Host Protected Area feature set
                 Release interrupt
            *    Look-ahead
            *    Write cache
            *    Power Management feature set
                 Security Mode feature set
            *    SMART feature set
            *    FLUSH CACHE EXT command
            *    Mandatory FLUSH CACHE command
            *    Device Configuration Overlay feature set
            *    48-bit Address feature set
                 Automatic Acoustic Management feature set
                 SET MAX security extension
                 Address Offset Reserved Area Boot
                 SET FEATURES subcommand required to spinup after power up
                 Power-Up In Standby feature set
                 Advanced Power Management feature set
            *    READ/WRITE DMA QUEUED
            *    General Purpose Logging feature set
            *    SMART self-test
            *    SMART error logging
Security:
         Master password revision code = 65534
                 supported
         not     enabled
         not     locked
         not     frozen
         not     expired: security count
         not     supported: enhanced erase
         46min for SECURITY ERASE UNIT.
HW reset results:
         CBLID- above Vih
         Device num = 0 determined by the jumper
Checksum: correct

Regards
Michael
