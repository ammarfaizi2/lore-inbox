Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVBISVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVBISVb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 13:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVBISVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 13:21:31 -0500
Received: from mail.xor.at ([62.99.218.147]:7114 "EHLO merkur.xor.at")
	by vger.kernel.org with ESMTP id S261882AbVBISUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 13:20:49 -0500
Message-ID: <420A547A.4000008@xor.at>
Date: Wed, 09 Feb 2005 19:20:42 +0100
From: Johannes Resch <jr@xor.at>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Problem on SATA-disk with Promise SATAII 150 TX4 ("DriveReady SeekComplete
 Error")
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.16; AVE: 6.29.0.11; VDF: 6.29.0.114; host: mail.xor.at)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[please CC me on replies]

I've got a box running 2.6.10 (with the patch[0] needed to support the 
Promise SATAII 150 TX4 controller).
This box has three software raid1 partitions mirrored on a SATA disk on 
the Promise controller and a disk on the mainboard IDE controller (VIA 
vt8235).

Within 4 days running the raid1, I got those three errors pasted below, 
each marking the SATA-raidmember as faulty. After "raidhotremove" and 
"raidhotadd" the SATA-raidmember syncs again fine and works at least a 
day until it is marked as faulty again.

Any pointers where I could look at to resolve this problem?
The SATA drive is a new Seagate ST3250823AS.

Feb  6 04:49:04 mars kernel: ata4: status=0x51 { DriveReady SeekComplete 
Error }
Feb  6 04:49:04 mars kernel: SCSI error : <3 0 0 0> return code = 0x8000002
Feb  6 04:49:04 mars kernel: FMK Current sda: sense = 70 88
Feb  6 04:49:04 mars kernel: ASC=40 ASCQ=c0
Feb  6 04:49:04 mars kernel: end_request: I/O error, dev sda, sector 
311900096
Feb  6 04:49:04 mars kernel: raid1: Disk failure on sda2, disabling device.
Feb  6 04:49:04 mars kernel: ^IOperation continuing on 1 devices
Feb  6 04:49:04 mars kernel: raid1: sda2: rescheduling sector 302518136
Feb  6 04:49:04 mars kernel: RAID1 conf printout:
Feb  6 04:49:04 mars kernel:  --- wd:1 rd:2
Feb  6 04:49:04 mars kernel:  disk 0, wo:1, o:0, dev:sda2
Feb  6 04:49:04 mars kernel:  disk 1, wo:0, o:1, dev:hda2
Feb  6 04:49:04 mars kernel: RAID1 conf printout:
Feb  6 04:49:05 mars kernel:  --- wd:1 rd:2
Feb  6 04:49:05 mars kernel:  disk 1, wo:0, o:1, dev:hda2
Feb  6 04:49:05 mars kernel: raid1: hda2: redirecting sector 302518136 
to another mirror

Feb  7 06:25:18 mars kernel: ata4: status=0x51 { DriveReady SeekComplete 
Error }
Feb  7 06:25:18 mars kernel: SCSI error : <3 0 0 0> return code = 0x8000002
Feb  7 06:25:18 mars kernel: FMK Current sda: sense = 70 88
Feb  7 06:25:18 mars kernel: ASC=40 ASCQ=c0
Feb  7 06:25:18 mars kernel: end_request: I/O error, dev sda, sector 
364654755
Feb  7 06:25:18 mars kernel: raid1: Disk failure on sda5, disabling device.
Feb  7 06:25:18 mars kernel: ^IOperation continuing on 1 devices
Feb  7 06:25:18 mars kernel: raid1: sda5: rescheduling sector 3706272
Feb  7 06:25:18 mars kernel: RAID1 conf printout:
Feb  7 06:25:18 mars kernel:  --- wd:1 rd:2
Feb  7 06:25:18 mars kernel:  disk 0, wo:1, o:0, dev:sda5
Feb  7 06:25:18 mars kernel:  disk 1, wo:0, o:1, dev:hda5
Feb  7 06:25:18 mars kernel: RAID1 conf printout:
Feb  7 06:25:18 mars kernel:  --- wd:1 rd:2
Feb  7 06:25:18 mars kernel:  disk 1, wo:0, o:1, dev:hda5
Feb  7 06:25:18 mars kernel: raid1: hda5: redirecting sector 3706272 to 
another mirror

Feb  9 06:25:02 mars kernel: ata4: status=0x51 { DriveReady SeekComplete 
Error }
Feb  9 06:25:02 mars kernel: SCSI error : <3 0 0 0> return code = 0x8000002
Feb  9 06:25:02 mars kernel: FMK Current sda: sense = 70 88
Feb  9 06:25:02 mars kernel: ASC=40 ASCQ=c0
Feb  9 06:25:02 mars kernel: end_request: I/O error, dev sda, sector 
310063304
Feb  9 06:25:02 mars kernel: raid1: Disk failure on sda2, disabling device.
Feb  9 06:25:02 mars kernel: ^IOperation continuing on 1 devices
Feb  9 06:25:02 mars kernel: raid1: sda2: rescheduling sector 300681344
Feb  9 06:25:02 mars kernel: RAID1 conf printout:
Feb  9 06:25:02 mars kernel:  --- wd:1 rd:2
Feb  9 06:25:02 mars kernel:  disk 0, wo:1, o:0, dev:sda2
Feb  9 06:25:02 mars kernel:  disk 1, wo:0, o:1, dev:hda2
Feb  9 06:25:02 mars kernel: RAID1 conf printout:
Feb  9 06:25:02 mars kernel:  --- wd:1 rd:2
Feb  9 06:25:02 mars kernel:  disk 1, wo:0, o:1, dev:hda2
Feb  9 06:25:02 mars kernel: raid1: hda2: redirecting sector 300681344 
to another mirror


[0] http://marc.theaimsgroup.com/?l=linux-ide&m=110426005503319&q=raw


Best regards,
-jr

