Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261627AbREOVxt>; Tue, 15 May 2001 17:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261611AbREOVxl>; Tue, 15 May 2001 17:53:41 -0400
Received: from du-011-190.access.de.clara.net ([212.82.252.190]:12672 "EHLO
	sledgehammer.now") by vger.kernel.org with ESMTP id <S261618AbREOVxc>;
	Tue, 15 May 2001 17:53:32 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Thomas Baecker <baecker@irf.de>
Reply-To: baecker@irf.de
To: linux-kernel@vger.kernel.org
Subject: Re: CD-RW ide-scsi problem presists with 2.4.4 (was Re: Problem with 2.4.1/2.4.3 and CD-RW ide-scsi drive)
Date: Tue, 15 May 2001 23:53:32 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01051523533200.00655@Sledgehammer>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

in fact I had the same problem with ide-scsi that you mentioned.
I also tried the kernel version 2.4.4 but it did not solve the problem.
I have a CD-RW drive (/dev/hdd resp. /dev/sr1) that was fully functional even 
in ide-scsi mode. I also have a CD-ROM drive (/dev/hdb resp. /dev/sr0) that 
worked perfectly as ide drive but did not work at all in ide-scsi mode. For 
example,
	dd if=/dev/sr0 of=/dev/null
which should read a CD-ROM in iso9660 format yielded lots of error messages.
So I tried to disable the UDMA mode using the hdparm utility
	hdparm -d 1 -X 34 /dev/hdb
which activates 'multiword DMA mode 2'. Now the CD-ROM drive is fully 
functional (at least for me...) !

You could even try to disable DMA mode completely typing
	hdparm -d 0 /dev/hdb (e.g.)

May be this works around the bug for now.

I hope, this is somewhat helpul.

Thomas	
	

On Wed, Apr 11, 2001 at 10:53:57PM -0400, Tim Meushaw wrote:
> Hi there.  I just got a new CD-RW drive and am trying to get it working
> under Linux.  I've got the ide-scsi modules all loaded, but have weird
> errors when trying to mount a disk.
>
> Here are the messages from "dmesg" that I get when the ide-cd and
> ide-scsi modules are loaded.  My DVD-ROM is /dev/hdc, and the CD-RW is
> /dev/hdd (or /dev/sr0):
>
> -----------------------------------------------------
> hdc: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.12
> ide-cd: ignoring drive hdd
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
>   Vendor: SONY      Model: CD-RW  CRX160E    Rev: 1.0e
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
> sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
> -----------------------------------------------------
>
> So, it looks like the drive is attached to /dev/sr0 properly.  Then, I
> run "cdrecord -scanbus" to make sure:
>
> -----------------------------------------------------
> Cdrecord 1.9 (i686-pc-linux-gnu) Copyright (C) 1995-2000 Jörg Schilling
> Linux sg driver version: 3.1.17
> Using libscg version 'schily-0.1'
> scsibus0:
>         0,0,0     0) 'SONY    ' 'CD-RW  CRX160E  ' '1.0e' Removable CD-ROM
> -----------------------------------------------------
>
> So, it REALLY looks like it's working.  However, here's what I get when
> I try to mount an ordinary data CD:
>
> -----------------------------------------------------
> athens:~# mount -t iso9660 /dev/sr0 /cdrw
> mount: block device /dev/sr0 is write-protected, mounting read-only
> SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 28000000
> [valid=0] Info fld=0x0, Current sd0b:00: sense key Hardware Error
> Additional sense indicates Logical unit communication CRC error 
(Ultra-DMA/32)
>  I/O error: dev 0b:00, sector 64
> isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=32
> mount: wrong fs type, bad option, bad superblock on /dev/sr0,
>        or too many mounted file systems
> -----------------------------------------------------
>
> I've tried this with both kernel 2.4.1 and 2.4.3 and have the exact same
> error.  I've also tried multiple data CDs and have the same messages.
> The CD-RW is a Sony CRX-160E, plugged in to an Asus A7V motherboard (the
> PCI bus is described by "lspci" as "VIA Technologies, Inc. VT8363/8365
> [KT133/KM133 AGP]").  I'm not sure what other information I can provide,
> but I'll be happy to give anything else that might be needed to help fix
> this problem.
>
> Thanks a lot!
> Tim


-- 

Thomas Baecker
email: T.Baecker@Bigfoot.de

