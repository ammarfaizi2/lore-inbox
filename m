Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262158AbSJ2JWq>; Tue, 29 Oct 2002 04:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262159AbSJ2JWq>; Tue, 29 Oct 2002 04:22:46 -0500
Received: from [212.3.242.3] ([212.3.242.3]:44284 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id <S262158AbSJ2JWo>;
	Tue, 29 Oct 2002 04:22:44 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org
Subject: [2.5.44] IDE cdrom DMA errors
Date: Tue, 29 Oct 2002 10:28:57 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210291028.57586.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

With 2.5.44 I have encountered DMA errors when using my cdrom device. In 
2.5.40 it worked fine.

cdrom:
/dev/hdc:
 Model=SAMSUNG CD-ROM SCR-2438, FwRev=zd023, SerialNo=
 Config={ SpinMotCtl Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2 
 AdvancedPM=no

removable ATA device, with non-removable media
Standards:
        Likely used: 1
Configuration:
        Logical         max     current
        cylinders       0       0
        heads           0       0
        sectors/track   0       0
        bytes/track:    0
        bytes/sector:   0
        LBA user addressable sectors = 0
Capabilities:
        no IORDY
        Cannot perform double-word IO
        r/w multiple sector transfer: not supported
        DMA: not supported
        PIO: pio0

IDE chipset:
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 
80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at 0860 [size=16]

Errors when trying to read some files from a disk:


end_request: I/O error, dev 16:00, sector 0
end_request: I/O error, dev 16:00, sector 0
hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdc: drive_cmd: error=0x04Aborted Command 
hdc: lost interrupt
hdc: DMA interrupt recovery
hdc: lost interrupt
hdc: status timeout: status=0xd0 { Busy }
hdc: status timeout: error=0x00
hdc: DMA disabled
hdc: drive not ready for command
hdc: ATAPI reset complete
Buffer I/O error on device ide1(22,0), logical block 146
ide-cd: hard_nr_sectors differs from nr_sectors! 248 252

As a result, trying to read anything from the drive results in a sort of 
'lockup' of the drive, while it tries to get the data but constantly fails. 
The only way to get out of this deadlock is by rebooting the machine.
-- 
Wit, n.:
	The salt with which the American Humorist spoils his cookery
... by leaving it out.
		-- Ambrose Bierce, "The Devil's Dictionary"

