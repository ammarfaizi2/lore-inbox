Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVCGQqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVCGQqU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 11:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbVCGQqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 11:46:20 -0500
Received: from perlsupport.com ([66.180.163.120]:25539 "EHLO
	mail.perlsupport.com") by vger.kernel.org with ESMTP
	id S261345AbVCGQqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 11:46:04 -0500
Date: Mon, 7 Mar 2005 11:45:54 -0500
From: Chip Salzenberg <chip@pobox.com>
To: axboe@suse.de, B.Zolnierkiewicz@elka.pw.edu.pl
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: NEC IDE DVD writer breaks when writing with DMA; is this normal?
Message-ID: <20050307164553.GA21402@perlsupport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've recently added an NEC DVD writer (ND-6450A) to my ThinkPad A30.
It breaks badly if I try to write with it with cdrecord or
dvd+rw-tools when DMA is on.  With DMA off, it works, but it uses a
heck of a lot of CPU time -- the whole laptop is really really doggy.

Is this the kind of thing I should just expect from DVD writers?  Or
is this a good candidate for some driver work to adjust for the quirks
of this device?

System info follows:

[boot log]

kernel: ICH3M: chipset revision 1
kernel: ICH3M: not 100%% native mode: will probe irqs later
kernel:     ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
kernel:     ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
kernel: hda: HTS548080M9AT00, ATA DISK drive
kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
kernel: hdc: _NEC DVD+/-RW ND-6450A, ATAPI CD/DVD-ROM drive
kernel: ide1 at 0x170-0x177,0x376 on irq 15
kernel: hda: max request size: 1024KiB
kernel: hda: 156301488 sectors (80026 MB) w/7877KiB Cache, CHS=16383/255/63, UDMA(100)
kernel:  hda: hda1 hda2 < hda5 hda6 hda7 hda8 >

[error log]

Feb 18 12:13:00 kernel: sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Feb 18 12:13:00 kernel: Uniform CD-ROM driver Revision: 3.20
Feb 18 12:13:00 kernel: Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
[...]
Feb 18 12:19:46 kernel: hdc: DMA timeout retry
Feb 18 12:19:46 kernel: hdc: timeout waiting for DMA
Feb 18 12:19:46 kernel: hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Feb 18 12:19:46 kernel: ide: failed opcode was: unknown
Feb 18 12:19:46 kernel: hdc: drive not ready for command
Feb 18 12:19:46 kernel: hdc: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
Feb 18 12:19:46 kernel: hdc: status error: error=0x04 { AbortedCommand }
Feb 18 12:19:46 kernel: ide: failed opcode was: unknown
Feb 18 12:19:46 kernel: hdc: drive not ready for command
Feb 18 12:19:46 kernel: hdc: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
Feb 18 12:19:46 kernel: hdc: status error: error=0x04 { AbortedCommand }
Feb 18 12:19:46 kernel: ide: failed opcode was: unknown
Feb 18 12:19:46 kernel: hdc: drive not ready for command
Feb 18 12:19:46 kernel: hdc: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
Feb 18 12:19:46 kernel: hdc: status error: error=0x04 { AbortedCommand }
Feb 18 12:19:46 kernel: ide: failed opcode was: unknown
Feb 18 12:19:46 kernel: hdc: drive not ready for command
Feb 18 12:19:46 kernel: ide-scsi: No active request in idescsi_eh_reset
Feb 18 12:19:46 kernel: scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 0 lun 0
Feb 18 12:19:46 kernel: SCSI error : <0 0 0 0> return code = 0x2
Feb 18 12:19:46 kernel: scsi0 (0:0): rejecting I/O to offline device
Feb 18 12:19:46 kernel: scsi0 (0:0): rejecting I/O to offline device

[hdparm -i]

 Model=_NEC DVD+/-RW ND-6450A, FwRev=2.36, SerialNo=
 Config={ Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=yes, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 *mdma2 
 AdvancedPM=no

[lspci -v]

0000:00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: IBM ThinkPad A/T/X Series
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at 1860 [size=16]
        Memory at 28000000 (32-bit, non-prefetchable) [size=1K]

-- 
Chip Salzenberg            - a.k.a. -            <chip@pobox.com>
         Open Source is not an excuse to write fun code
            then leave the actual work to others.
