Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVCABph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVCABph (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 20:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVCABpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 20:45:36 -0500
Received: from bender.bawue.de ([193.7.176.20]:39072 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S261195AbVCABpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 20:45:22 -0500
Date: Tue, 1 Mar 2005 02:45:14 +0100
From: Joerg Sommrey <jo@sommrey.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.11-rc5: Promise SATA150 TX4 failure
Message-ID: <20050301014514.GA10653@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

a problem that was introduced between 2.6.10-ac9 and 2.6.10-ac11 made
it's way into 2.6.11-rc5.  While taking a backup onto a SCSI-streamer one
of my RAID1-arrays gets corrupted.  Afterwards the system hangs and
isn't even bootable.  Need to raidhotadd the failed partition in single
user mode to get the box working again. Error messages:

Mar  1 01:46:15 bear kernel: ata2: status=0x51 { DriveReady SeekComplete Error }
Mar  1 01:46:15 bear kernel: ata2: called with no error (51)!
Mar  1 01:46:15 bear kernel: ata2: status=0x51 { DriveReady SeekComplete Error }
Mar  1 01:46:15 bear kernel: ata2: called with no error (51)!
Mar  1 01:46:15 bear kernel: ata2: status=0x51 { DriveReady SeekComplete Error }
Mar  1 01:46:15 bear kernel: ata2: called with no error (51)!
Mar  1 01:46:15 bear kernel: ata2: status=0x51 { DriveReady SeekComplete Error }
Mar  1 01:46:15 bear kernel: ata2: called with no error (51)!
Mar  1 01:46:15 bear kernel: ata2: status=0x51 { DriveReady SeekComplete Error }
Mar  1 01:46:15 bear kernel: ata2: called with no error (51)!
Mar  1 01:46:15 bear kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Mar  1 01:46:15 bear kernel: sdc: Current: sense key: Medium Error
Mar  1 01:46:15 bear kernel:     Additional sense: Unrecovered read error - auto
reallocate failed
Mar  1 01:46:15 bear kernel: end_request: I/O error, dev sdc, sector 52694606
Mar  1 01:46:15 bear kernel: raid1: Disk failure on sdc2, disabling device.
Mar  1 01:46:15 bear kernel: ^IOperation continuing on 1 devices
Mar  1 01:46:15 bear kernel: raid1: sdc2: rescheduling sector 12499976
Mar  1 01:46:16 bear kernel: ata2: status=0x51 { DriveReady SeekComplete Error }
Mar  1 01:46:16 bear kernel: ata2: called with no error (51)!
Mar  1 01:46:16 bear kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Mar  1 01:46:16 bear kernel: sdc: Current: sense key: Medium Error
Mar  1 01:46:16 bear kernel:     Additional sense: Unrecovered read error - auto
reallocate failed
Mar  1 01:46:16 bear kernel: end_request: I/O error, dev sdc, sector 52694614
Mar  1 01:46:16 bear kernel: ata2: status=0x51 { DriveReady SeekComplete Error }
Mar  1 01:46:16 bear kernel: ata2: called with no error (51)!
Mar  1 01:46:16 bear kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Mar  1 01:46:16 bear kernel: sdc: Current: sense key: Medium Error
Mar  1 01:46:16 bear kernel:     Additional sense: Unrecovered read error - auto
reallocate failed
Mar  1 01:46:16 bear kernel: end_request: I/O error, dev sdc, sector 52694622
Mar  1 01:46:16 bear kernel: raid1: sdc2: rescheduling sector 12499984
Mar  1 01:46:16 bear kernel: ata2: status=0x51 { DriveReady SeekComplete Error }
Mar  1 01:46:16 bear kernel: ata2: called with no error (51)!
Mar  1 01:46:16 bear kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Mar  1 01:46:16 bear kernel: sdc: Current: sense key: Medium Error
Mar  1 01:46:16 bear kernel:     Additional sense: Unrecovered read error - auto
reallocate failed
Mar  1 01:46:16 bear kernel: end_request: I/O error, dev sdc, sector 52694630
Mar  1 01:46:16 bear kernel: raid1: sdc2: rescheduling sector 12500000
Mar  1 01:46:16 bear kernel: RAID1 conf printout:
Mar  1 01:46:16 bear kernel:  --- wd:1 rd:2
Mar  1 01:46:16 bear kernel:  disk 0, wo:0, o:1, dev:sdb2
Mar  1 01:46:16 bear kernel:  disk 1, wo:1, o:0, dev:sdc2
Mar  1 01:46:16 bear kernel: RAID1 conf printout:
Mar  1 01:46:16 bear kernel:  --- wd:1 rd:2
Mar  1 01:46:16 bear kernel:  disk 0, wo:0, o:1, dev:sdb2
Mar  1 01:46:16 bear kernel: raid1: sdb2: redirecting sector 12499976 to another
mirror
Mar  1 01:46:16 bear kernel: raid1: sdb2: redirecting sector 12499984 to another
mirror
Mar  1 01:46:16 bear kernel: raid1: sdb2: redirecting sector 12500000 to another
mirror
Mar  1 01:46:16 bear kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Mar  1 01:46:16 bear kernel: ata1: called with no error (51)!
Mar  1 01:46:16 bear kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Mar  1 01:46:16 bear kernel: ata1: called with no error (51)!
Mar  1 01:46:16 bear kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Mar  1 01:46:16 bear kernel: ata1: called with no error (51)!
Mar  1 01:46:16 bear kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Mar  1 01:46:16 bear kernel: ata1: called with no error (51)!
Mar  1 01:46:16 bear kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Mar  1 01:46:16 bear kernel: ata1: called with no error (51)!
Mar  1 01:46:16 bear kernel: SCSI error : <1 0 0 0> return code = 0x8000002
Mar  1 01:46:16 bear kernel: sdb: Current: sense key: Medium Error

etc. until hard reboot.

The failing array consists of two partitions of two SATA disks connected
to a Promise SATA150 TX4 controller.

-jo

-- 
-rw-r--r--  1 jo users 63 2005-03-01 02:26 /home/jo/.signature
