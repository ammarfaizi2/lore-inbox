Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270201AbRHYGvy>; Sat, 25 Aug 2001 02:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271095AbRHYGvo>; Sat, 25 Aug 2001 02:51:44 -0400
Received: from dfw-smtpout2.email.verio.net ([129.250.36.42]:6379 "EHLO
	dfw-smtpout2.email.verio.net") by vger.kernel.org with ESMTP
	id <S270201AbRHYGva>; Sat, 25 Aug 2001 02:51:30 -0400
Message-ID: <3B874B01.EB7F19E9@bigfoot.com>
Date: Fri, 24 Aug 2001 23:51:45 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20p9ai i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: Re: mount failure, SCSI emulation, 2.2.20pre9
In-Reply-To: <3B85B1E8.99D125C1@bigfoot.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More info.  Immediately after a burn and before the CD-R is ejected, it is mountable and has this TOC:

first: 1 last 1
track:   1 lba:         0 (        0) 00:02:00 adr: 1 control: 4 mode: 0
track:lout lba:    257759 (  1031036) 57:18:59 adr: 1 control: 4 mode: -1

After ejecting and reloading, unmountable with this TOC:

first: 0 last 1
track:   0 lba:         0 (        0) 00:02:00 adr: 1 control: 4 mode: -1
track:   1 lba:         0 (        0) 00:02:00 adr: 1 control: 4 mode: -1
track:lout lba:         0 (        0) 00:00:00 adr: 1 control: 4 mode: -1

As before, the CD-R is mountable if the IDE CDROM driver is used rather than SCSI emulation.  I'm trying 2.2.19, different media and other cdrecord versions.  Other ideas appreciated..

Also, apologies to one who wrote me off-list.  I unadvertently deleted your email.  Please resend if possible.

rgds,
tim.

Full log
--------

[23:44] abit:/<1>iso/i386 > cat test.log
# cdrecord -v speed=4 dev=0,1,0 driver=mmc_cdr -data roswell-i386-SRPMS-disc2.iso
Cdrecord 1.9 (i686-pc-linux-gnu) Copyright (C) 1995-2000 Jörg Schilling
TOC Type: 1 = CD-ROM
scsidev: '0,1,0'
scsibus: 0 target: 1 lun: 0
Linux sg driver version: 2.1.40
Using libscg version 'schily-0.1'
atapi: 1
Device type    : Removable CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'YAMAHA  '
Identifikation : 'CRW4416E        '
Revision       : '1.0e'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
Driver flags   : SWABAUDIO
Drive buf size : 1176000 = 1148 KB
FIFO size      : 6291456 = 6144 KB
Track 01: data  503 MB        
Total size:     578 MB (57:16.78) = 257759 sectors
Lout start:     578 MB (57:18/59) = 257759 sectors
Current Secsize: 2048
ATIP info from disk:
  Indicated writing power: 5
  Is not unrestricted
  Is not erasable
  Disk sub type: Medium Type A, high Beta category (A+) (3)
  ATIP start of lead in:  -11324 (97:31/01)
  ATIP start of lead out: 336225 (74:45/00)
Disk type:    Long strategy type (Cyanine, AZO or similar)
Manuf. index: 22
Manufacturer: Ritek Co.
Blocks total: 336225 Blocks current: 336225 Blocks remaining: 78466
Starting to write CD/DVD at speed 4 in write mode for single session.
Last chance to quit, starting real write in 9 seconds...1 seconds.
Waiting for reader process to fill input buffer ... input buffer ready.
Performing OPC...
Starting new track at sector: 0
Track 01:   0 of 503 MB written.
Track 01:   1 of 503 MB written (fifo  98%).
Track 01:   2 of 503 MB written (fifo 100%).
...
Track 01: 501 of 503 MB written (fifo 100%).
Track 01: 502 of 503 MB written (fifo 100%).
Track 01: 503 of 503 MB written (fifo 100%).
Track 01: Total bytes read/written: 527886336/527886336 (257757 sectors).
Writing  time:  889.461s
Fixating...
Fixating time:   68.620s
cdrecord: fifo had 8315 puts and 8315 gets.
cdrecord: fifo was 0 times empty and 8195 times full, min fill was 95%.

# mount -v /cdrom
/dev/sr0 on /cdrom type iso9660 (ro,noexec,nosuid,nodev)
# ls -l /cdrom
total 60
drwxr-xr-x    2 root     root        59392 Aug 16 14:15 SRPMS
-r--r--r--    1 root     root          100 Aug 16 14:20 TRANS.TBL
# umount -v /cdrom
/dev/sr0 umounted

# cdrecord -toc
Cdrecord 1.9 (i686-pc-linux-gnu) Copyright (C) 1995-2000 Jörg Schilling
scsidev: '0,1,0'
scsibus: 0 target: 1 lun: 0
Linux sg driver version: 2.1.40
Using libscg version 'schily-0.1'
Device type    : Removable CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'YAMAHA  '
Identifikation : 'CRW4416E        '
Revision       : '1.0e'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
Driver flags   : SWABAUDIO
first: 1 last 1
track:   1 lba:         0 (        0) 00:02:00 adr: 1 control: 4 mode: 0
track:lout lba:    257759 (  1031036) 57:18:59 adr: 1 control: 4 mode: -1

# eject -v /dev/cdrom
eject: device name is `/dev/cdrom'
eject: expanded name is `/dev/cdrom'
eject: `/dev/cdrom' is a link to `/dev/sr0'
eject: `/dev/sr0' is not mounted
eject: `/dev/sr0' is not a mount point
eject: `/dev/sr0' is not a multipartition device
eject: trying to eject `/dev/sr0' using CD-ROM eject command
eject: CD-ROM eject command succeeded

# cdrecord -toc
Cdrecord 1.9 (i686-pc-linux-gnu) Copyright (C) 1995-2000 Jörg Schilling
scsidev: '0,1,0'
scsibus: 0 target: 1 lun: 0
Linux sg driver version: 2.1.40
Using libscg version 'schily-0.1'
Device type    : Removable CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'YAMAHA  '
Identifikation : 'CRW4416E        '
Revision       : '1.0e'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
Driver flags   : SWABAUDIO
first: 0 last 1
track:   0 lba:         0 (        0) 00:02:00 adr: 1 control: 4 mode: -1
track:   1 lba:         0 (        0) 00:02:00 adr: 1 control: 4 mode: -1
track:lout lba:         0 (        0) 00:00:00 adr: 1 control: 4 mode: -1

# mount -v /cdrom
mount: wrong fs type, bad option, bad superblock on /dev/cdrom,
       or too many mounted file systems

--
