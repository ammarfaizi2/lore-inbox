Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWCTAxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWCTAxT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 19:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWCTAxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 19:53:19 -0500
Received: from nessie.weebeastie.net ([220.233.7.36]:60174 "EHLO
	bunyip.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S1751028AbWCTAxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 19:53:18 -0500
Date: Mon, 20 Mar 2006 11:53:34 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: 2.6.15.4: Can't get running id for drives on ite8212 controller
Message-ID: <20060320005334.GU2057@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organisation: Furball Inc.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# hdparm -I /dev/hda

/dev/hda:
 HDIO_DRIVE_CMD(identify) failed: Input/output error

No SMART access either. This is a ST3200822A drive hanging off an
IT/ITE8212 controller. Linux kernel is 2.6.15.4 and dmesg spits out:

[1683890.974231] hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
[1683890.974243] hda: drive_cmd: error=0x04 { DriveStatusError }
[1683890.974248] ide: failed opcode was: 0xa1

# hdparm -i /dev/hda

/dev/hda:

 Model=ST3200822A, FwRev=3.01, SerialNo=3LJ22Y8F
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=8192kB, MaxMultSect=16, MultSect=16
 CurCHS=65535/1/63, CurSects=4128705, LBA=yes, LBAsects=268435455
 IORDY=on/off
 PIO modes:  pio0 pio1 pio2 
 DMA modes:  mdma0 mdma1 mdma2 
 AdvancedPM=no
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2: 

 * signifies the current active mode

hdparm version is: hdparm v6.1

Now I've never had a drive not be able to give me something for -I so
I'm thinking that this is not quite cricket. Other drives on the
controller are:

/dev/hdc: SAMSUNG SV1022D
/dev/hdd: QUANTUM FIREBALLlct20 10

and they all fail in the same manner.

AFAIK I'm not using it in RAID mode and this is what it spat out at
startup:

[   31.710110] IT8212: IDE controller at PCI slot 0000:00:0a.0
[   31.710164] ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 18 (level, low) -> IRQ 18
[   31.710254] IT8212: chipset revision 17
[   31.710296] it821x: controller in smart mode.
[   31.710338] IT8212: 100% native mode on irq 18
[   31.710398]     ide0: BM-DMA at 0xa800-0xa807, BIOS settings: hda:DMA, hdb:pio
[   31.710518]     ide1: BM-DMA at 0xa808-0xa80f, BIOS settings: hdc:pio, hdd:DMA
[   31.710636] Probing IDE interface ide0...
[   31.974258] hda: ST3200822A, ATA DISK drive
[   32.280538] hda: Performing identify fixups.
[   32.280604] ide0 at 0x9800-0x9807,0x9c02 on irq 18
[   32.280743] Probing IDE interface ide1...
[   32.543812] hdc: SAMSUNG SV1022D, ATA DISK drive
[   32.798613] hdd: QUANTUM FIREBALLlct20 10, ATA DISK drive
[   32.850133] hdc: Performing identify fixups.
[   32.850175] hdd: Performing identify fixups.

-- 
    "To the extent that we overreact, we proffer the terrorists the
    greatest tribute."
    	- High Court Judge Michael Kirby
