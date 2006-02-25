Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161101AbWBYTq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161101AbWBYTq5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 14:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161097AbWBYTq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 14:46:57 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:40154 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1161090AbWBYTqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 14:46:54 -0500
Message-ID: <4400B439.8050202@dgreaves.com>
Date: Sat, 25 Feb 2006 19:47:05 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <liml@rtr.ca>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, Mark Lord <lkml@rtr.ca>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca>
In-Reply-To: <4400A1BF.7020109@rtr.ca>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:

> Justin Piszcz wrote:
>
>> Should I be using 2.6.16-rcX?
>
>
> Mmm... that's what I'm using (plus other patches),
> so, yes.. give that a try.  2.6.16 does seem to
> be shaping up to be a nice kernel.

OK, failed for me too - I updated to 2.6.16-rc4 and it still failed
(despite -F) so I fixed by hand.
(printk -> DPRINTK

anyway:
Linux haze 2.6.16-rc4patched #1 PREEMPT Sat Feb 25 19:29:11 UTC 2006
i686 GNU/Linux

ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: error=0x04 { DriveStatusError }
ata2: no sense translation for op=0x2a cmd=0x3d status: 0x51
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: no sense translation for op=0x2a cmd=0x3d status: 0x51
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: no sense translation for op=0x2a cmd=0x3d status: 0x51
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: no sense translation for op=0x2a cmd=0x3d status: 0x51
ata2: status=0x51 { DriveReady SeekComplete Error }
sd 1:0:0:0: SCSI error: return code = 0x8000002
sdb: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdb, sector 398283329
raid1: Disk failure on sdb2, disabling device.
        Operation continuing on 1 devices


and later...


device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
XFS mounting filesystem dm-0
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x04 { DriveStatusError }
ata1: no sense translation for op=0x2a cmd=0x3d status: 0x51
ata1: status=0x51 { DriveReady SeekComplete Error }
ata2: no sense translation for op=0x2a cmd=0x3d status: 0x51
ata2: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for op=0x2a cmd=0x3d status: 0x51
ata1: status=0x51 { DriveReady SeekComplete Error }
ata2: no sense translation for op=0x2a cmd=0x3d status: 0x51
ata2: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for op=0x2a cmd=0x3d status: 0x51
ata1: status=0x51 { DriveReady SeekComplete Error }
ata2: no sense translation for op=0x2a cmd=0x3d status: 0x51
ata2: status=0x51 { DriveReady SeekComplete Error }
ata1: no sense translation for op=0x2a cmd=0x3d status: 0x51
ata1: status=0x51 { DriveReady SeekComplete Error }
ata2: no sense translation for op=0x2a cmd=0x3d status: 0x51
ata2: status=0x51 { DriveReady SeekComplete Error }
sd 0:0:0:0: SCSI error: return code = 0x8000002
sda: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 390716735
raid5: Disk failure on sda1, disabling device. Operation continuing on 2
devices
ata2: no sense translation for op=0x2a cmd=0x3d status: 0x51
ata2: status=0x51 { DriveReady SeekComplete Error }
sd 1:0:0:0: SCSI error: return code = 0x8000002
sdb: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdb, sector 390716735
raid5: Disk failure on sdb1, disabling device. Operation continuing on 1
devices
RAID5 conf printout:
 --- rd:3 wd:1 fd:2
 disk 0, o:1, dev:sdd1
 disk 1, o:0, dev:sdb1
 disk 2, o:0, dev:sda1
xfs_force_shutdown(dm-0,0x1) called from line 338 of file
fs/xfs/xfs_rw.c.  Return address = 0xc020c0e9
Filesystem "dm-0": I/O Error Detected.  Shutting down filesystem: dm-0
Please umount the filesystem, and rectify the problem(s)
I/O error in filesystem ("dm-0") meta-data dev dm-0 block
0x640884a       ("xlog_bwrite") error 5 buf count 262144
XFS: failed to locate log tail
XFS: log mount/recovery failed: error 5
XFS: log mount failed
RAID5 conf printout:
 --- rd:3 wd:1 fd:2
 disk 0, o:1, dev:sdd1
 disk 1, o:0, dev:sdb1
RAID5 conf printout:
 --- rd:3 wd:1 fd:2
 disk 0, o:1, dev:sdd1
 disk 1, o:0, dev:sdb1
RAID5 conf printout:
 --- rd:3 wd:1 fd:2
 disk 0, o:1, dev:sdd1


So I guess my raid just blew up too... hope there's no corruption!

David

(PS Hi Mark, this is lbt from the Empeg BBS :) )

-- 

