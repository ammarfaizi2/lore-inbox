Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbTJTILL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 04:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbTJTILL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 04:11:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:37098 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262419AbTJTIK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 04:10:57 -0400
Date: Mon, 20 Oct 2003 10:10:56 +0200 (MEST)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: Jens Axboe <axboe@suse.de>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, andre@linux-ide.org,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <20031020064831.GT1128@suse.de>
Subject: Re: HighPoint 374
X-Priority: 3 (Normal)
X-Authenticated: #20183004
Message-ID: <6286.1066637456@www51.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Oct 19 2003, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Andre, thanks for helpful hint.
> > Svetoslav, the right person to whine about TCQ stuff is Jens Axboe 8-).
> 
> Well that's correct, but this looks more like an AS iosched bug :)
> > > You do not enable TCQ on highpoint without using the hosted polling
> timer.
> > > Oh and I have not added it, and so hit Bartlomiej up for the
> additions.
> 
> For what? TCQ tests fine on a HPT370 here.

cmdline : acpi=off pci=noacpi elevator=deadline

hdparm  -d1 -X69 -Q32 /dev/hd[a,e,g]
---------------------------------------------------------------------
blk: queue f7dd2e00, I/O limit 4095Mb (mask 0xffffffff)
hda: tagged command queueing enabled, command queue depth 32
blk: queue f7dd2400, I/O limit 4095Mb (mask 0xffffffff)
ide_dmaq_intr: stat=40, not expected
ide_dmaq_intr: stat=40, not expected
hde: tagged command queueing enabled, command queue depth 32
ide_dmaq_intr: stat=40, not expected
hdg: set_drive_speed_status: status=0x58 { DriveReady SeekComplete
DataRequest }
blk: queue f7dcce00, I/O limit 4095Mb (mask 0xffffffff)
hdg: dma_timer_expiry: dma status == 0x20
hdg: DMA timeout retry
hdg: timeout waiting for DMA
hdg: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hdg: drive not ready for command
hdg: tagged command queueing enabled, command queue depth 32
ide_dmaq_intr: hdg: error status ff
hdg: ide_dmaq_complete: status=0xff { Busy }
hdg: invalidating tag queue (1 commands)
hdg: ide_intr: huh? expected NULL handler on exit
hdg: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdg: drive_cmd: error=0x04 { DriveStatusError }
hdg: set_drive_speed_status: status=0xff { Busy }
ide_tcq_intr_timeout: timeout waiting for completion interrupt
hdg: invalidating tag queue (0 commands)
hdg: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hdg: drive not ready for command
hdg: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hdg: drive not ready for command
hdg: CHECK for good STATUS
ide_dmaq_intr: hde: error status ff
hde: ide_dmaq_complete: status=0xff { Busy }
hde: invalidating tag queue (1 commands)
hde: ide_intr: huh? expected NULL handler on exit
hde: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hde: drive_cmd: error=0x04 { DriveStatusError
}
--------------------------------------------------------------------------------------

hdparm  -m16 -d1 -X69 -Q32
/dev/hd[a,e,g]
--------------------------------------------------------------------------------------
blk: queue f7dd2e00, I/O limit 4095Mb (mask 0xffffffff)
blk: queue f7dd2400, I/O limit 4095Mb (mask 0xffffffff)
hde: tagged command queueing enabled, command queue depth 32
blk: queue f7dcce00, I/O limit 4095Mb (mask 0xffffffff)
hdg: tagged command queueing enabled, command queue depth 32
ide_dmaq_intr: hdg: error status ff
hdg: ide_dmaq_complete: status=0xff { Busy }
hdg: invalidating tag queue (1 commands)
hdg: ide_intr: huh? expected NULL handler on exit
hdg: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdg: drive_cmd: error=0x04 { DriveStatusError
}
--------------------------------------------------------------------------------------

hdparm  -m0 -d1 -X69 -Q32
/dev/hd[a,e,g]
--------------------------------------------------------------------------------------
blk: queue f7dd2e00, I/O limit 4095Mb (mask 0xffffffff)
blk: queue f7dd2400, I/O limit 4095Mb (mask 0xffffffff)
blk: queue f7dcce00, I/O limit 4095Mb (mask 0xffffffff)
hdg: tagged command queueing enabled, command queue depth 32
ide_dmaq_intr: hdg: error status ff
hdg: ide_dmaq_complete: status=0xff { Busy }
hdg: invalidating tag queue (1 commands)
hdg: ide_intr: huh? expected NULL handler on exit
hdg: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdg: drive_cmd: error=0x04 { DriveStatusError
}
-------------------------------------------------------------------------------------

upto now no transfer to the drives, except to the root partition(system
activity) which is on hdg

dd if=/dev/zero of=/mnt/tmp/1/10Gb.zeros bs=512k count=20000
[/dev/hde]
------------------------------------------------------------------------------
ide_dmaq_intr: hde: error status ff
hde: ide_dmaq_complete: status=0xff { Busy }
hde: invalidating tag queue (1 commands)
hde: ide_intr: huh? expected NULL handler on exit
hde: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hde: drive_cmd: error=0x04 { DriveStatusError }

and a bit later

ide_dmaq_intr: hda: error status ff
hda: ide_dmaq_complete: status=0xff { Busy }
hda: invalidating tag queue (1 commands)
hda: ide_intr: huh? expected NULL handler on exit
hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hda: drive_cmd: error=0x04 { DriveStatusError }

only /boot ~ 90Mb was mounted on hda and i don't think the system accessed
it

on second thoght i also have a swap partition on it,
but i have currently 1.9Mb swap used


svetljo

-- 
NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

