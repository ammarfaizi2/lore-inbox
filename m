Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVBHJo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVBHJo2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 04:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVBHJo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 04:44:27 -0500
Received: from bender.bawue.de ([193.7.176.20]:27840 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S261499AbVBHJoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 04:44:08 -0500
Date: Tue, 8 Feb 2005 10:43:58 +0100
From: Joerg Sommrey <jo@sommrey.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-ac12
Message-ID: <20050208094358.GA1831@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 04:02:42PM +0000, Alan Cox wrote:

>Arjan van de Ven is now building RPMS of the kernel and those can be found
>in the RPM subdirectory and should be yum-able. Expect the RPMS to lag the
>diff a little as the RPM builds and tests do take time.

>Nothing terribly exciting here security wise but various bugs for problems
>people have been hitting that are now fixed upstream, and also the ULi
>tulip variant should now work. If you are running IPv6 you may well want
>the networking fixes.

Something broke my box after 2.6.10-ac8.  Both -ac11 and -ac12 cause
problems when backing up sata/md-raid/dm-snapshots/reiserfs to a SCSI
tape drive.  (Works fine when writing to /dev/null :-)

Backup started 1:30 a.m., errors messges start with:

Feb  8 01:34:07 bear kernel: ata2: status=0x51 { DriveReady SeekComplete Error }Feb  8 01:34:07 bear kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Feb  8 01:34:07 bear kernel: FMK Current sdc: sense = 70 99
Feb  8 01:34:07 bear kernel: ASC=26 ASCQ=c0
Feb  8 01:34:07 bear kernel: end_request: I/O error, dev sdc, sector 52294166
Feb  8 01:34:07 bear kernel: ata2: status=0x51 { DriveReady SeekComplete Error }Feb  8 01:34:07 bear kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Feb  8 01:34:07 bear kernel: FMK Current sdc: sense = 70 99
Feb  8 01:34:07 bear kernel: ASC=26 ASCQ=c0
Feb  8 01:34:07 bear kernel: end_request: I/O error, dev sdc, sector 52294174
Feb  8 01:34:07 bear kernel: raid1: Disk failure on sdc2, disabling device.
Feb  8 01:34:07 bear kernel: ^IOperation continuing on 1 devices
Feb  8 01:34:07 bear kernel: raid1: sdc2: rescheduling sector 12099536
Feb  8 01:34:07 bear kernel: ata2: status=0x51 { DriveReady SeekComplete Error }Feb  8 01:34:07 bear kernel: SCSI error : <2 0 0 0> return code = 0x8000002
Feb  8 01:34:07 bear kernel: FMK Current sdc: sense = 70 99
Feb  8 01:34:07 bear kernel: ASC=26 ASCQ=c0
Feb  8 01:34:07 bear kernel: end_request: I/O error, dev sdc, sector 52294182
Feb  8 01:34:07 bear kernel: raid1: sdc2: rescheduling sector 12099552
etc. until hard reboot via sysrq-b

I found only one patch that seems to be related:
>2.6.10-ac11
>*	Fix oops with md over dm			(Jens Axboe)

Can this by any chance cause my problems?

-jo

-- 
-rw-r--r--  1 jo users 63 2005-02-08 01:47 /home/jo/.signature
