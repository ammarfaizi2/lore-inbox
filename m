Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130526AbQJaV4D>; Tue, 31 Oct 2000 16:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130515AbQJaVzx>; Tue, 31 Oct 2000 16:55:53 -0500
Received: from hibernia.clubi.ie ([212.17.32.129]:58266 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP
	id <S130502AbQJaVzg>; Tue, 31 Oct 2000 16:55:36 -0500
Date: Tue, 31 Oct 2000 01:11:44 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: scsi-cdrom lockup and ide-scsi problem (both EFS related)
Message-ID: <Pine.LNX.4.21.0010310054200.1041-100000@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I have 2 problems related to reading IRIX EFS cd's.

-------problem 1:

mounting an EFS cd from my Yamaha CDR-4416S SCSI CDRW consistently
causes a lockup when i try to read directory/file data from the CD. I
observed this initially with EFS CDR's, and assumed something had
gone wrong when burning that CD. But the exact same thing happens
with original SGI IRIX media. I have no problems with any of my EFS
CDs when accesed from an ATAPI CDROM.

i havn't been able to capture an oops, but the following made it to
the remote syslog host:

Oct 30 18:48:29 fogarty kernel: EFS: 1.0a -
http://aeschi.ch.eu.org/efs/ 
Oct 30 18:48:44 fogarty kernel: scsi0 channel 0 : resetting for
second half of retries. 
Oct 30 18:48:44 fogarty kernel: SCSI bus is being reset for host 0
channel 0. 
Oct 30 18:48:44 fogarty kernel: scsi0: Sending Bus Device Reset CCB
#10912 to Target 4 
Oct 30 18:48:44 fogarty kernel: scsi0: Bus Device Reset CCB #10912 to
Target 4 Completed 
Oct 30 18:48:44 fogarty kernel: Device 0b:00 not ready. 
Oct 30 18:48:44 fogarty kernel:  I/O error: dev 0b:00, sector 1233661 
Oct 30 18:48:44 fogarty kernel: EFS: readdir(): failed to read dir
block 0 
Oct 30 18:48:44 fogarty kernel: Device 0b:00 not ready. 
Oct 30 18:48:44 fogarty kernel:  I/O error: dev 0b:00, sector 1215956 
Oct 30 18:48:44 fogarty kernel: EFS: readdir(): failed to read dir
block 0 
Oct 30 18:48:44 fogarty kernel: Device 0b:00 not ready. 
Oct 30 18:48:44 fogarty kernel:  I/O error: dev 0b:00, sector 1236972 
Oct 30 18:48:44 fogarty kernel: EFS: readdir(): failed to read dir
block 0 
Oct 30 18:48:44 fogarty kernel: Device 0b:00 not ready. 
Oct 30 18:48:44 fogarty kernel:  I/O error: dev 0b:00, sector 1243717 
Oct 30 18:48:44 fogarty kernel: EFS: readdir(): failed to read dir
block 0 
Oct 30 18:48:44 fogarty kernel: Device 0b:00 not ready. 
Oct 30 18:48:44 fogarty kernel:  I/O error: dev 0b:00, sector 48130 
Oct 30 18:48:44 fogarty kernel: EFS: readdir(): failed to read dir
block 0

<box is locked>

------problem 2:

My IDE CDROM under ide-scsi emulation does not like trying to mount
EFS CDs, here are the logs of multiple mount attempts:

Oct 31 00:06:50 fogarty kernel: EFS: 1.0a -
http://aeschi.ch.eu.org/efs/ 
Oct 31 00:06:50 fogarty kernel: sr.c:Bad 2K block number requested (0
1) I/O error: dev 0b:01, sector 0 
Oct 31 00:06:50 fogarty kernel: EFS: cannot read volume header
Oct 31 00:06:53 fogarty kernel: Device not ready.  Make sure there is
a disc in the drive. 
Oct 31 00:06:56 fogarty kernel: Device not ready.  Make sure there is
a disc in the drive. 
Oct 31 00:06:59 fogarty kernel: Device not ready.  Make sure there is
a disc in the drive. 
Oct 31 00:07:20 fogarty kernel: sr.c:Bad 2K block number requested (0
1) I/O error: dev 0b:01, sector 0 
Oct 31 00:07:20 fogarty kernel: EFS: cannot read volume header 
Oct 31 00:07:32 fogarty kernel: ide-scsi: hdd: unsupported command in
request queue (0) 
Oct 31 00:07:32 fogarty kernel: end_request: I/O error, dev 16:40
(hdd), sector 0 
Oct 31 00:07:32 fogarty kernel: EFS: cannot read volume header 
Oct 31 00:07:49 fogarty kernel: sr.c:Bad 2K block number requested (0
1) I/O error: dev 0b:01, sector 0 
Oct 31 00:07:49 fogarty kernel: EFS: cannot read volume header 
Oct 31 00:07:56 fogarty kernel: sr.c:Bad 2K block number requested (0
1) I/O error: dev 0b:01, sector 0 
Oct 31 00:07:56 fogarty kernel: EFS: cannot read volume header

after this the CDROM behaves strange (gtoaster can't read data track,
which it could before), until i put another disk (eg audio) into it
first.

-----------------------

result:

to mount an EFS cd i have to use my IDE CDROM in ATAPI mode, as the
SCSI CDRW locks the machine.

then to burn an EFS cd i have to reboot and set my ATAPI CDROM to use
ide-scsi emulation - if i want to mount the CD for any reason i have
to reboot again to get the IDE CDROM back to pure ATAPI mode, then
reboot again for ide-scsi to burn a cd... slightly frustrating. :)

the devices are:
[root@fogarty xinetd.d]# cat /proc/scsi/scsi 
Attached devices: 
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: YAMAHA   Model: CRW4416S         Rev: 1.0g
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: CREATIVE Model: CD2422E  MC102   Rev: 1.02
  Type:   CD-ROM                           ANSI SCSI revision: 02

please contact me if you need further debugging info. 

regards,
-- 
Paul Jakma	paul@clubi.ie
PGP5 key: http://www.clubi.ie/jakma/publickey.txt
-------------------------------------------
Fortune:
%DCL-MEM-BAD, bad memory
VMS-F-PDGERS, pudding between the ears

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
