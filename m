Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSGGKFK>; Sun, 7 Jul 2002 06:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314548AbSGGKFJ>; Sun, 7 Jul 2002 06:05:09 -0400
Received: from smtp.polymtl.ca ([132.207.4.11]:49376 "EHLO smtp.polymtl.ca")
	by vger.kernel.org with ESMTP id <S314446AbSGGKFH> convert rfc822-to-8bit;
	Sun, 7 Jul 2002 06:05:07 -0400
Message-ID: <3D2812F0.C3A4441D@sympatico.ca>
Date: Sun, 07 Jul 2002 06:07:44 -0400
From: Christian Robert <xtian-test@sympatico.ca>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc1 i686)
X-Accept-Language: en, fr-CA
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ittle problems with /dev/sr0 with 2.4.19-rc1
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Problem with read back a fresh written cdrom.

[root@X-home:/btemp] # uname -a
Linux X-home 2.4.19-rc1 #2 Sat Jul 6 03:10:16 EDT 2002 i686 unknown


[root@X-home:/btemp] # ls -ld rescue.iso 
-rw-r--r--    1 root     root      6881280 May 19 22:26 rescue.iso

[root@X-home:/btemp] # cdrecord dev=0,0 speed=4 -v rescue.iso 
Cdrecord 1.10 (i686-pc-linux-gnu) Copyright (C) 1995-2001 Jörg Schilling
TOC Type: 1 = CD-ROM
scsidev: '0,0'
scsibus: 0 target: 0 lun: 0
Linux sg driver version: 3.1.24
Using libscg version 'schily-0.5'
atapi: 1
Device type    : Removable CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'SONY    '
Identifikation : 'CD-RW  CRX160E  '
Revision       : '1.0e'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
Driver flags   : SWABAUDIO
Drive buf size : 4183552 = 4085 KB
FIFO size      : 4194304 = 4096 KB
Track 01: data    6 MB        
Total size:       7 MB (00:44.82) = 3362 sectors
Lout start:       7 MB (00:46/62) = 3362 sectors
Current Secsize: 2048
ATIP info from disk:
  Indicated writing power: 3
  Reference speed: 6
  Is not unrestricted
  Is erasable
  Disk sub type: High speed Rewritable (CAV) media (1)
  ATIP start of lead in:  -11625 (97:27/00)
  ATIP start of lead out: 333750 (74:12/00)
  speed low: 4 speed high: 8
  power mult factor: 1 5
  recommended erase/write power: 5
  A2 values: 26 B2 4A
Disk type:    Phase change
Manuf. index: 0
Manufacturer: Illegal Manufacturer code
Blocks total: 333750 Blocks current: 333750 Blocks remaining: 330388
RBlocks total: 336246 RBlocks current: 336246 RBlocks remaining: 332884
Starting to write CD/DVD at speed 4 in write mode for single session.
Last chance to quit, starting real write in 0 seconds. Operation starts.
Waiting for reader process to fill input buffer ... input buffer ready.
Performing OPC...
Starting new track at sector: 0
Track 01:   6 of   6 MB written (fifo 100%).
Track 01: Total bytes read/written: 6881280/6881280 (3360 sectors).
Writing  time:   18.307s
Fixating...
Fixating time:   61.619s
cdrecord: fifo had 109 puts and 109 gets.
cdrecord: fifo was 0 times empty and 7 times full, min fill was 89%.

[root@X-home:/btemp] # md5sum /dev/sr0
md5sum: /dev/sr0: Input/output error         <- oups, it failed

[root@X-home:/btemp] # dd if=/dev/sr0 | md5sum
dd: reading `/dev/sr0': Input/output error   <- failed here too
13440+0 records in
13440+0 records out
5ec08b6fa7bf09741d1310e5baa800de  -          <- but md5sum is OK

[root@X-home:/btemp] # md5sum rescue.iso 
5ec08b6fa7bf09741d1310e5baa800de  rescue.iso

[root@X-home:/btemp] # cat /dev/sr0 > xxx

[root@X-home:/btemp] # diff xxx rescue.iso

[root@X-home:/btemp] # cksum /dev/sr0
3592423142 6881280 /dev/sr0

[root@X-home:/btemp] # cksum rescue.iso
3592423142 6881280 rescue.iso

[root@X-home:/btemp] # dd if=/dev/sr0 | md5sum     <- Note this one do not get input/output error
13440+0 records in
13440+0 records out
5ec08b6fa7bf09741d1310e5baa800de  -

[root@X-home:/btemp] # md5sum /dev/sr0
5ec08b6fa7bf09741d1310e5baa800de  /dev/sr0

[root@X-home:/btemp] # md5sum /dev/sr0 rescue.iso 
5ec08b6fa7bf09741d1310e5baa800de  /dev/sr0
5ec08b6fa7bf09741d1310e5baa800de  rescue.iso

[root@X-home:/btemp] # md5sum /dev/sr0 rescue.iso  <- it now work every time
5ec08b6fa7bf09741d1310e5baa800de  /dev/sr0
5ec08b6fa7bf09741d1310e5baa800de  rescue.iso

[root@X-home:/btemp] # eject

After re-insertion...

[root@X-home:/btemp] # md5sum /dev/sr0 rescue.iso 
md5sum: /dev/sr0: Input/output error               <- inout/output error on /dev/sr0
5ec08b6fa7bf09741d1310e5baa800de  rescue.iso


Can someone reproduce the "Input/output error" I get sometimes with "dd" and  with "md5sum" on /dev/sr0 
after burning a new CD ?

I'm pretty sure it was not doing that with 2.4.18
Looks like it fix itself after several minutes or many trys.
 

running 2.4.19-rc1

Xtian.
