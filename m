Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbTKJFnb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 00:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbTKJFnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 00:43:31 -0500
Received: from 205-158-62-67.outblaze.com ([205.158.62.67]:24507 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S262914AbTKJFn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 00:43:29 -0500
Message-ID: <20031110054327.22352.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Gavin Baker" <gavbaker@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Mon, 10 Nov 2003 13:43:27 +0800
Subject: (HPT372A) cat /proc/ide/hpt366 == crash
X-Originating-Ip: 213.130.156.17
X-Originating-Server: ws5-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an Highpoint "RocketRaid 133" dual channel PCI IDE "raid" controller that uses an HPT372A.

With the latest 2.4's and 2.6.0-test9, if I cat /proc/ide/hpt366 I get the ide channel status followed shortly after by:

  hdg: status timeout: status=0xd0 {Busy}
                                                                                               
  hdg: DMA disabled 
  hdg: drive not ready for command
  ide3: reset: master: error (0x00?)
  hdg: status timeout: status=0xd0 {Busy}
                                                                                               
  hdg: drive not ready for command
  ide3: reset: master: error (0x00?)
  end-request: I/O error, dev hdg, sector xxxxxx
  EXT3-fs error (device md0): ext3_get_inode_loc: unable to read inode
  block - inode = xxxxxx, block = xxxxxx

With the last two lines repeating until there is total filesystem corruption.

In regular usage they have been fine (I've built my distro from source without a problem).

dmesg:								                                     
HPT372A: IDE controller at PCI slot 0000:02:06.0
HPT372A: chipset revision 1
HPT37X: using 33MHz PCI clock
HPT372A: 100% native mode on irq 18
    ide2: BM-DMA at 0xd800-0xd807, BIOS settings: hde:DMA, hdf:pio
HPT366: reg5ah=0x00 ATA-66 Cable Port0
    ide3: BM-DMA at 0xd808-0xd80f, BIOS settings: hdg:DMA, hdh:pio
HPT366: reg5ah=0x00 ATA-66 Cable Port0
hde: ST3120026A, ATA DISK drive
ide2 at 0xc800-0xc807,0xcc02 on irq 18
hdg: ST3120026A, ATA DISK drive
ide3 at 0xd000-0xd007,0xd402 on irq 18
                                                                                                 
hde: max request size: 1024KiB
hde: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63,
UDMA(100)
 /dev/ide/host2/bus0/target0/lun0: p1 p2 p3
hdg: max request size: 1024KiB
hdg: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63,
UDMA(100)
 /dev/ide/host2/bus1/target0/lun0: p1 p2 p3
                                                                                               
                                                                                               
lspci:
02:06.0 RAID bus controller: Triones Technologies, Inc. HPT372A (rev
01)
        Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at c800 [size=8]
        Region 1: I/O ports at cc00 [size=4]
        Region 2: I/O ports at d000 [size=8]
        Region 3: I/O ports at d400 [size=4]
        Region 4: I/O ports at d800 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Both drives are new seagate barracudas. They both have DMA enabled. I use regular kernel raid0, not the software raid drivers.

Probably related, the SMART data from these drives is showing Hardware_ECC_Recovered is up over 31 and 120 million, with Power_On_Hours less than 250.

Any ideas?

Thanks,
Gavin Baker
(PS, please CC: me)
-- 
______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org 
This allows you to send and receive SMS through your mailbox.


Powered by Outblaze
