Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269356AbUICExx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269356AbUICExx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 00:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269485AbUICExw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 00:53:52 -0400
Received: from gsstark.mtl.istop.com ([66.11.160.162]:26754 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S269356AbUICExK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 00:53:10 -0400
To: Brad Campbell <brad@wasp.net.au>
Cc: Greg Stark <gsstark@mit.edu>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Crashed Drive, libata wedges when trying to recover data
References: <87oekpvzot.fsf@stark.xeocode.com> <4136E277.6000408@wasp.net.au>
In-Reply-To: <4136E277.6000408@wasp.net.au>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 03 Sep 2004 00:52:34 -0400
Message-ID: <87u0ugt0ml.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Campbell <brad@wasp.net.au> writes:

> Greg Stark wrote:
> 
> > Any clue what I need to do to achieve this? Is this a bug because this isn't a
> > well-travelled code-path? (Dead drives not being something you can conjure up
> > on demand)? Or is this indicative of more problems than just a crashed drive?
> > This is on a stock 2.6.6 kernel tree, btw.
> >
> 
> Known issue, fixed in 2.6.9-rc1. Apply this to 2.6.6 and your good to go.

Hm. I'm running 2.6.0-rc1 now. I'm not sure this really fixed the problem.

I get the same message and the same basic symptom -- any process touching the
bad disk goes into disk-wait for a long time. But whereas before as far as I
know they never came out, now they seem to come out of disk-wait after a good
long time. But then maybe I just never waited long enough with 2.6.6.

I do still get the "ATA: abnormal status 0x59 on port 0xEFE7" so if that's a
sign something's wrong then something's still wrong. I also now get additional
messages that I don't recall seeing before. They're included below.

And as I said, every other process touching the drive, even in good areas,
enters disk-wait. If I kill -9 the process generating the errors and wait a
few minutes they seem to eventually exit disk-wait though.

This means I would be able to do the recovery in theory, but in practice it'll
just take an infeasible length of time. I have gigs of data to go through and
at the amount of time it takes to time out after each error it'll take me many
days (years I think) to just to figure out which blocks to avoid.

Sep  2 23:55:26 stark kernel: EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
Sep  2 23:55:49 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:55:49 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:55:50 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:55:50 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:55:51 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:55:51 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:55:53 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:55:53 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:55:54 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:55:54 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:55:54 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 3b f7 90 00 00 08 00 
Sep  2 23:55:54 stark kernel: Current sda: sense = 70  3
Sep  2 23:55:54 stark kernel: ASC=11 ASCQ= 4
Sep  2 23:55:54 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x11 0x04 0x00 0x00 0x00 0x00 
Sep  2 23:55:54 stark kernel: end_request: I/O error, dev sda, sector 305919888
Sep  2 23:55:55 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:55:55 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:55:55 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 3b f7 91 00 00 07 00 
Sep  2 23:55:55 stark kernel: Current sda: sense = 70  3
Sep  2 23:55:55 stark kernel: ASC=11 ASCQ= 4
Sep  2 23:55:55 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x11 0x04 0x00 0x00 0x00 0x00 
Sep  2 23:55:55 stark kernel: end_request: I/O error, dev sda, sector 305919889
Sep  2 23:55:57 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:55:57 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:55:57 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 3b f7 92 00 00 06 00 
Sep  2 23:55:57 stark kernel: Current sda: sense = 70  3
Sep  2 23:55:57 stark kernel: ASC=11 ASCQ= 4
Sep  2 23:55:57 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x11 0x04 0x00 0x00 0x00 0x00 
Sep  2 23:55:57 stark kernel: end_request: I/O error, dev sda, sector 305919890
Sep  2 23:55:58 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:55:58 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:55:58 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 3b f7 93 00 00 05 00 
Sep  2 23:55:58 stark kernel: Current sda: sense = 70  3
Sep  2 23:55:58 stark kernel: ASC=11 ASCQ= 4
Sep  2 23:55:58 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x11 0x04 0x00 0x00 0x00 0x00 
Sep  2 23:55:58 stark kernel: end_request: I/O error, dev sda, sector 305919891
Sep  2 23:55:59 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:55:59 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:55:59 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 3b f7 94 00 00 04 00 
Sep  2 23:55:59 stark kernel: Current sda: sense = 70  3
Sep  2 23:55:59 stark kernel: ASC=11 ASCQ= 4
Sep  2 23:55:59 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x11 0x04 0x00 0x00 0x00 0x00 
Sep  2 23:55:59 stark kernel: end_request: I/O error, dev sda, sector 305919892
Sep  2 23:56:01 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:01 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:01 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 3b f7 95 00 00 03 00 
Sep  2 23:56:01 stark kernel: Current sda: sense = 70  3
Sep  2 23:56:01 stark kernel: ASC=11 ASCQ= 4
Sep  2 23:56:01 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x11 0x04 0x00 0x00 0x00 0x00 
Sep  2 23:56:01 stark kernel: end_request: I/O error, dev sda, sector 305919893
Sep  2 23:56:02 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:02 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:02 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 3b f7 96 00 00 02 00 
Sep  2 23:56:02 stark kernel: Current sda: sense = 70  3
Sep  2 23:56:02 stark kernel: ASC=11 ASCQ= 4
Sep  2 23:56:02 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x11 0x04 0x00 0x00 0x00 0x00 
Sep  2 23:56:02 stark kernel: end_request: I/O error, dev sda, sector 305919894
Sep  2 23:56:03 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:03 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:03 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 3b f7 97 00 00 01 00 
Sep  2 23:56:03 stark kernel: Current sda: sense = 70  3
Sep  2 23:56:03 stark kernel: ASC=11 ASCQ= 4
Sep  2 23:56:03 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x11 0x04 0x00 0x00 0x00 0x00 
Sep  2 23:56:03 stark kernel: end_request: I/O error, dev sda, sector 305919895
Sep  2 23:56:03 stark kernel: EXT2-fs error (device sda4): ext2_get_inode: unable to read inode block - inode=4112385, block=8224770
Sep  2 23:56:05 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:05 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:06 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:06 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:07 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:07 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:09 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:09 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:10 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:10 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:10 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 13 8f f7 90 00 00 08 00 
Sep  2 23:56:10 stark kernel: Current sda: sense = 70  3
Sep  2 23:56:10 stark kernel: ASC=11 ASCQ= 4
Sep  2 23:56:10 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x11 0x04 0x00 0x00 0x00 0x00 
Sep  2 23:56:10 stark kernel: end_request: I/O error, dev sda, sector 328202128
Sep  2 23:56:11 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:11 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:11 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 13 8f f7 91 00 00 07 00 
Sep  2 23:56:11 stark kernel: Current sda: sense = 70  3
Sep  2 23:56:11 stark kernel: ASC=11 ASCQ= 4
Sep  2 23:56:11 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x11 0x04 0x00 0x00 0x00 0x00 
Sep  2 23:56:11 stark kernel: end_request: I/O error, dev sda, sector 328202129
Sep  2 23:56:13 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:13 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:13 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 13 8f f7 92 00 00 06 00 
Sep  2 23:56:13 stark kernel: Current sda: sense = 70  3
Sep  2 23:56:13 stark kernel: ASC=11 ASCQ= 4
Sep  2 23:56:13 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x11 0x04 0x00 0x00 0x00 0x00 
Sep  2 23:56:13 stark kernel: end_request: I/O error, dev sda, sector 328202130
Sep  2 23:56:14 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:14 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:14 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 13 8f f7 93 00 00 05 00 
Sep  2 23:56:14 stark kernel: Current sda: sense = 70  3
Sep  2 23:56:14 stark kernel: ASC=11 ASCQ= 4
Sep  2 23:56:14 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x11 0x04 0x00 0x00 0x00 0x00 
Sep  2 23:56:14 stark kernel: end_request: I/O error, dev sda, sector 328202131
Sep  2 23:56:15 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:15 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:15 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 13 8f f7 94 00 00 04 00 
Sep  2 23:56:15 stark kernel: Current sda: sense = 70  3
Sep  2 23:56:15 stark kernel: ASC=11 ASCQ= 4
Sep  2 23:56:15 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x11 0x04 0x00 0x00 0x00 0x00 
Sep  2 23:56:15 stark kernel: end_request: I/O error, dev sda, sector 328202132
Sep  2 23:56:17 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:17 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:17 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 13 8f f7 95 00 00 03 00 
Sep  2 23:56:17 stark kernel: Current sda: sense = 70  3
Sep  2 23:56:17 stark kernel: ASC=11 ASCQ= 4
Sep  2 23:56:17 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x11 0x04 0x00 0x00 0x00 0x00 
Sep  2 23:56:17 stark kernel: end_request: I/O error, dev sda, sector 328202133
Sep  2 23:56:18 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:18 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:18 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 13 8f f7 96 00 00 02 00 
Sep  2 23:56:18 stark kernel: Current sda: sense = 70  3
Sep  2 23:56:18 stark kernel: ASC=11 ASCQ= 4
Sep  2 23:56:18 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x11 0x04 0x00 0x00 0x00 0x00 
Sep  2 23:56:18 stark kernel: end_request: I/O error, dev sda, sector 328202134
Sep  2 23:56:19 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:19 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:19 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 13 8f f7 97 00 00 01 00 
Sep  2 23:56:19 stark kernel: Current sda: sense = 70  3
Sep  2 23:56:19 stark kernel: ASC=11 ASCQ= 4
Sep  2 23:56:19 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x11 0x04 0x00 0x00 0x00 0x00 
Sep  2 23:56:19 stark kernel: end_request: I/O error, dev sda, sector 328202135
Sep  2 23:56:19 stark kernel: EXT2-fs error (device sda4): ext2_get_inode: unable to read inode block - inode=5505025, block=11010050
Sep  2 23:56:21 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:21 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:22 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:22 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:23 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:23 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:25 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:25 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:26 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:26 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:26 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 f7 f7 90 00 00 08 00 
Sep  2 23:56:26 stark kernel: Current sda: sense = 70  3
Sep  2 23:56:26 stark kernel: ASC=11 ASCQ= 4
Sep  2 23:56:26 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x11 0x04 0x00 0x00 0x00 0x00 
Sep  2 23:56:26 stark kernel: end_request: I/O error, dev sda, sector 318240656
Sep  2 23:56:27 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:27 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:27 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 f7 f7 91 00 00 07 00 
Sep  2 23:56:27 stark kernel: Current sda: sense = 70  3
Sep  2 23:56:27 stark kernel: ASC=11 ASCQ= 4
Sep  2 23:56:27 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x11 0x04 0x00 0x00 0x00 0x00 
Sep  2 23:56:27 stark kernel: end_request: I/O error, dev sda, sector 318240657
Sep  2 23:56:28 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:28 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:28 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 f7 f7 92 00 00 06 00 
Sep  2 23:56:28 stark kernel: Current sda: sense = 70  3
Sep  2 23:56:28 stark kernel: ASC=11 ASCQ= 4
Sep  2 23:56:28 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x11 0x04 0x00 0x00 0x00 0x00 
Sep  2 23:56:28 stark kernel: end_request: I/O error, dev sda, sector 318240658
Sep  2 23:56:30 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:30 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:30 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 f7 f7 93 00 00 05 00 
Sep  2 23:56:30 stark kernel: Current sda: sense = 70  3
Sep  2 23:56:30 stark kernel: ASC=11 ASCQ= 4
Sep  2 23:56:30 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x11 0x04 0x00 0x00 0x00 0x00 
Sep  2 23:56:30 stark kernel: end_request: I/O error, dev sda, sector 318240659
Sep  2 23:56:31 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:31 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:31 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 f7 f7 94 00 00 04 00 
Sep  2 23:56:31 stark kernel: Current sda: sense = 70  3
Sep  2 23:56:31 stark kernel: ASC=11 ASCQ= 4
Sep  2 23:56:31 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x11 0x04 0x00 0x00 0x00 0x00 
Sep  2 23:56:31 stark kernel: end_request: I/O error, dev sda, sector 318240660
Sep  2 23:56:32 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:32 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:32 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 f7 f7 95 00 00 03 00 
Sep  2 23:56:32 stark kernel: Current sda: sense = 70  3
Sep  2 23:56:32 stark kernel: ASC=11 ASCQ= 4
Sep  2 23:56:32 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x11 0x04 0x00 0x00 0x00 0x00 
Sep  2 23:56:32 stark kernel: end_request: I/O error, dev sda, sector 318240661
Sep  2 23:56:33 stark kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
Sep  2 23:56:33 stark kernel: ata1: error=0x40 { UncorrectableError }
Sep  2 23:56:33 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 f7 f7 96 00 00 02 00 
Sep  2 23:56:33 stark kernel: Current sda: sense = 70  3
Sep  2 23:56:33 stark kernel: ASC=11 ASCQ= 4
Sep  2 23:56:33 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x11 0x04 0x00 0x00 0x00 0x00 
Sep  2 23:56:33 stark kernel: end_request: I/O error, dev sda, sector 318240662
Sep  2 23:57:03 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  2 23:57:03 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  2 23:57:03 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  2 23:57:03 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 f7 f7 97 00 00 01 00 
Sep  2 23:57:03 stark kernel: Current sda: sense = 70  3
Sep  2 23:57:03 stark kernel: ASC=13 ASCQ= 0
Sep  2 23:57:03 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  2 23:57:03 stark kernel: end_request: I/O error, dev sda, sector 318240663
Sep  2 23:57:03 stark kernel: EXT2-fs error (device sda4): ext2_get_inode: unable to read inode block - inode=4882433, block=9764866
Sep  2 23:57:03 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  2 23:57:03 stark last message repeated 2 times
Sep  2 23:57:33 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  2 23:57:33 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  2 23:57:33 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  2 23:57:33 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 0e c3 f7 90 00 00 08 00 
Sep  2 23:57:33 stark kernel: Current sda: sense = 70  3
Sep  2 23:57:33 stark kernel: ASC=13 ASCQ= 0
Sep  2 23:57:33 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  2 23:57:33 stark kernel: end_request: I/O error, dev sda, sector 247723920
Sep  2 23:57:33 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  2 23:57:33 stark last message repeated 2 times
Sep  2 23:58:03 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  2 23:58:03 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  2 23:58:03 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  2 23:58:03 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 0e c3 f7 91 00 00 07 00 
Sep  2 23:58:03 stark kernel: Current sda: sense = 70  3
Sep  2 23:58:03 stark kernel: ASC=13 ASCQ= 0
Sep  2 23:58:03 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  2 23:58:03 stark kernel: end_request: I/O error, dev sda, sector 247723921
Sep  2 23:58:03 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  2 23:58:03 stark last message repeated 2 times
Sep  2 23:58:33 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  2 23:58:33 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  2 23:58:33 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  2 23:58:33 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 0e c3 f7 92 00 00 06 00 
Sep  2 23:58:33 stark kernel: Current sda: sense = 70  3
Sep  2 23:58:33 stark kernel: ASC=13 ASCQ= 0
Sep  2 23:58:33 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  2 23:58:33 stark kernel: end_request: I/O error, dev sda, sector 247723922
Sep  2 23:58:33 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  2 23:58:33 stark last message repeated 2 times
Sep  2 23:59:03 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  2 23:59:03 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  2 23:59:03 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  2 23:59:03 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 0e c3 f7 93 00 00 05 00 
Sep  2 23:59:03 stark kernel: Current sda: sense = 70  3
Sep  2 23:59:03 stark kernel: ASC=13 ASCQ= 0
Sep  2 23:59:03 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  2 23:59:03 stark kernel: end_request: I/O error, dev sda, sector 247723923
Sep  2 23:59:03 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  2 23:59:03 stark last message repeated 2 times
Sep  2 23:59:33 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  2 23:59:33 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  2 23:59:33 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  2 23:59:33 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 0e c3 f7 94 00 00 04 00 
Sep  2 23:59:33 stark kernel: Current sda: sense = 70  3
Sep  2 23:59:33 stark kernel: ASC=13 ASCQ= 0
Sep  2 23:59:33 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  2 23:59:33 stark kernel: end_request: I/O error, dev sda, sector 247723924
Sep  2 23:59:33 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  2 23:59:33 stark last message repeated 2 times
Sep  3 00:00:03 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:00:03 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:00:03 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:00:03 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 0e c3 f7 95 00 00 03 00 
Sep  3 00:00:03 stark kernel: Current sda: sense = 70  3
Sep  3 00:00:03 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:00:03 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:00:03 stark kernel: end_request: I/O error, dev sda, sector 247723925
Sep  3 00:00:03 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:00:03 stark last message repeated 2 times
Sep  3 00:00:33 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:00:33 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:00:33 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:00:33 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 0e c3 f7 96 00 00 02 00 
Sep  3 00:00:33 stark kernel: Current sda: sense = 70  3
Sep  3 00:00:33 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:00:33 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:00:33 stark kernel: end_request: I/O error, dev sda, sector 247723926
Sep  3 00:00:33 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:00:33 stark last message repeated 2 times
Sep  3 00:01:03 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:01:03 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:01:03 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:01:03 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 0e c3 f7 97 00 00 01 00 
Sep  3 00:01:03 stark kernel: Current sda: sense = 70  3
Sep  3 00:01:03 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:01:03 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:01:03 stark kernel: end_request: I/O error, dev sda, sector 247723927
Sep  3 00:01:03 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:01:03 stark last message repeated 2 times
Sep  3 00:01:03 stark kernel: EXT2-fs error (device sda4): ext2_get_inode: unable to read inode block - inode=475137, block=950274
Sep  3 00:01:33 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:01:33 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:01:33 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:01:33 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 1b 17 f7 90 00 00 08 00 
Sep  3 00:01:33 stark kernel: Current sda: sense = 70  3
Sep  3 00:01:33 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:01:33 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:01:33 stark kernel: end_request: I/O error, dev sda, sector 454555536
Sep  3 00:01:33 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:01:33 stark last message repeated 2 times
Sep  3 00:02:03 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:02:03 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:02:03 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:02:03 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 1b 17 f7 91 00 00 07 00 
Sep  3 00:02:03 stark kernel: Current sda: sense = 70  3
Sep  3 00:02:03 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:02:03 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:02:03 stark kernel: end_request: I/O error, dev sda, sector 454555537
Sep  3 00:02:03 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:02:03 stark last message repeated 2 times
Sep  3 00:02:33 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:02:33 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:02:33 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:02:33 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 1b 17 f7 92 00 00 06 00 
Sep  3 00:02:33 stark kernel: Current sda: sense = 70  3
Sep  3 00:02:33 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:02:33 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:02:33 stark kernel: end_request: I/O error, dev sda, sector 454555538
Sep  3 00:02:33 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:02:33 stark last message repeated 2 times
Sep  3 00:03:03 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:03:03 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:03:03 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:03:03 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 1b 17 f7 93 00 00 05 00 
Sep  3 00:03:03 stark kernel: Current sda: sense = 70  3
Sep  3 00:03:03 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:03:03 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:03:03 stark kernel: end_request: I/O error, dev sda, sector 454555539
Sep  3 00:03:03 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:03:03 stark last message repeated 2 times
Sep  3 00:03:33 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:03:33 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:03:33 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:03:33 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 1b 17 f7 94 00 00 04 00 
Sep  3 00:03:33 stark kernel: Current sda: sense = 70  3
Sep  3 00:03:33 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:03:33 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:03:33 stark kernel: end_request: I/O error, dev sda, sector 454555540
Sep  3 00:03:33 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:03:33 stark last message repeated 2 times
Sep  3 00:04:03 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:04:03 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:04:03 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:04:03 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 1b 17 f7 95 00 00 03 00 
Sep  3 00:04:03 stark kernel: Current sda: sense = 70  3
Sep  3 00:04:03 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:04:03 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:04:03 stark kernel: end_request: I/O error, dev sda, sector 454555541
Sep  3 00:04:03 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:04:03 stark last message repeated 2 times
Sep  3 00:04:33 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:04:33 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:04:33 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:04:33 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 1b 17 f7 96 00 00 02 00 
Sep  3 00:04:33 stark kernel: Current sda: sense = 70  3
Sep  3 00:04:33 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:04:33 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:04:33 stark kernel: end_request: I/O error, dev sda, sector 454555542
Sep  3 00:04:33 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:04:33 stark last message repeated 2 times
Sep  3 00:05:03 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:05:03 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:05:03 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:05:03 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 1b 17 f7 97 00 00 01 00 
Sep  3 00:05:03 stark kernel: Current sda: sense = 70  3
Sep  3 00:05:03 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:05:03 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:05:03 stark kernel: end_request: I/O error, dev sda, sector 454555543
Sep  3 00:05:03 stark kernel: EXT2-fs error (device sda4): ext2_get_inode: unable to read inode block - inode=13402115, block=26804226
Sep  3 00:19:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:19:07 stark last message repeated 2 times
Sep  3 00:19:37 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:19:37 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:19:37 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:19:37 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 b3 f7 90 00 00 08 00 
Sep  3 00:19:37 stark kernel: Current sda: sense = 70  3
Sep  3 00:19:37 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:19:37 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:19:37 stark kernel: end_request: I/O error, dev sda, sector 313784208
Sep  3 00:19:37 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:19:37 stark last message repeated 2 times
Sep  3 00:20:07 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:20:07 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:20:07 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:20:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 b3 f7 91 00 00 07 00 
Sep  3 00:20:07 stark kernel: Current sda: sense = 70  3
Sep  3 00:20:07 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:20:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:20:07 stark kernel: end_request: I/O error, dev sda, sector 313784209
Sep  3 00:20:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:20:07 stark last message repeated 2 times
Sep  3 00:20:37 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:20:37 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:20:37 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:20:37 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 b3 f7 92 00 00 06 00 
Sep  3 00:20:37 stark kernel: Current sda: sense = 70  3
Sep  3 00:20:37 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:20:37 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:20:37 stark kernel: end_request: I/O error, dev sda, sector 313784210
Sep  3 00:20:37 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:20:37 stark last message repeated 2 times
Sep  3 00:21:07 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:21:07 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:21:07 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:21:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 b3 f7 93 00 00 05 00 
Sep  3 00:21:07 stark kernel: Current sda: sense = 70  3
Sep  3 00:21:07 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:21:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:21:07 stark kernel: end_request: I/O error, dev sda, sector 313784211
Sep  3 00:21:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:21:07 stark last message repeated 2 times
Sep  3 00:21:37 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:21:37 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:21:37 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:21:37 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 b3 f7 94 00 00 04 00 
Sep  3 00:21:37 stark kernel: Current sda: sense = 70  3
Sep  3 00:21:37 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:21:37 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:21:37 stark kernel: end_request: I/O error, dev sda, sector 313784212
Sep  3 00:21:37 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:21:37 stark last message repeated 2 times
Sep  3 00:22:07 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:22:07 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:22:07 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:22:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 b3 f7 95 00 00 03 00 
Sep  3 00:22:07 stark kernel: Current sda: sense = 70  3
Sep  3 00:22:07 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:22:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:22:07 stark kernel: end_request: I/O error, dev sda, sector 313784213
Sep  3 00:22:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:22:07 stark last message repeated 2 times
Sep  3 00:22:37 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:22:37 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:22:37 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:22:37 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 b3 f7 96 00 00 02 00 
Sep  3 00:22:37 stark kernel: Current sda: sense = 70  3
Sep  3 00:22:37 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:22:37 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:22:37 stark kernel: end_request: I/O error, dev sda, sector 313784214
Sep  3 00:22:37 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:22:37 stark last message repeated 2 times
Sep  3 00:23:07 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:23:07 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:23:07 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:23:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 b3 f7 97 00 00 01 00 
Sep  3 00:23:07 stark kernel: Current sda: sense = 70  3
Sep  3 00:23:07 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:23:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:23:07 stark kernel: end_request: I/O error, dev sda, sector 313784215
Sep  3 00:23:07 stark kernel: EXT2-fs error (device sda4): ext2_get_inode: unable to read inode block - inode=4603905, block=9207810
Sep  3 00:23:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:23:07 stark last message repeated 2 times
Sep  3 00:23:37 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:23:37 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:23:37 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:23:37 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 11 37 f7 90 00 00 08 00 
Sep  3 00:23:37 stark kernel: Current sda: sense = 70  3
Sep  3 00:23:37 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:23:37 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:23:37 stark kernel: end_request: I/O error, dev sda, sector 288880528
Sep  3 00:23:37 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:23:37 stark last message repeated 2 times
Sep  3 00:24:07 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:24:07 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:24:07 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:24:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 11 37 f7 91 00 00 07 00 
Sep  3 00:24:07 stark kernel: Current sda: sense = 70  3
Sep  3 00:24:07 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:24:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:24:07 stark kernel: end_request: I/O error, dev sda, sector 288880529
Sep  3 00:24:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:24:07 stark last message repeated 2 times
Sep  3 00:24:37 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:24:37 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:24:37 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:24:37 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 11 37 f7 92 00 00 06 00 
Sep  3 00:24:37 stark kernel: Current sda: sense = 70  3
Sep  3 00:24:37 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:24:37 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:24:37 stark kernel: end_request: I/O error, dev sda, sector 288880530
Sep  3 00:24:37 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:24:37 stark last message repeated 2 times
Sep  3 00:25:07 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:25:07 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:25:07 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:25:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 11 37 f7 93 00 00 05 00 
Sep  3 00:25:07 stark kernel: Current sda: sense = 70  3
Sep  3 00:25:07 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:25:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:25:07 stark kernel: end_request: I/O error, dev sda, sector 288880531
Sep  3 00:25:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:25:07 stark last message repeated 2 times
Sep  3 00:25:37 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:25:37 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:25:37 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:25:37 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 11 37 f7 94 00 00 04 00 
Sep  3 00:25:37 stark kernel: Current sda: sense = 70  3
Sep  3 00:25:37 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:25:37 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:25:37 stark kernel: end_request: I/O error, dev sda, sector 288880532
Sep  3 00:25:37 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:25:37 stark last message repeated 2 times
Sep  3 00:26:07 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:26:07 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:26:07 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:26:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 11 37 f7 95 00 00 03 00 
Sep  3 00:26:07 stark kernel: Current sda: sense = 70  3
Sep  3 00:26:07 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:26:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:26:07 stark kernel: end_request: I/O error, dev sda, sector 288880533
Sep  3 00:26:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:26:07 stark last message repeated 2 times
Sep  3 00:26:37 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:26:37 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:26:37 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:26:37 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 11 37 f7 96 00 00 02 00 
Sep  3 00:26:37 stark kernel: Current sda: sense = 70  3
Sep  3 00:26:37 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:26:37 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:26:37 stark kernel: end_request: I/O error, dev sda, sector 288880534
Sep  3 00:26:37 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:26:37 stark last message repeated 2 times
Sep  3 00:27:07 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:27:07 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:27:07 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:27:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 11 37 f7 97 00 00 01 00 
Sep  3 00:27:07 stark kernel: Current sda: sense = 70  3
Sep  3 00:27:07 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:27:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:27:07 stark kernel: end_request: I/O error, dev sda, sector 288880535
Sep  3 00:27:07 stark kernel: EXT2-fs error (device sda4): ext2_get_inode: unable to read inode block - inode=3047425, block=6094850
Sep  3 00:27:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:27:07 stark last message repeated 2 times
Sep  3 00:27:37 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:27:37 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:27:37 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:27:37 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 11 db f7 90 00 00 08 00 
Sep  3 00:27:37 stark kernel: Current sda: sense = 70  3
Sep  3 00:27:37 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:27:37 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:27:37 stark kernel: end_request: I/O error, dev sda, sector 299628432
Sep  3 00:27:37 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:27:37 stark last message repeated 2 times
Sep  3 00:28:07 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:28:07 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:28:07 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:28:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 11 db f7 91 00 00 07 00 
Sep  3 00:28:07 stark kernel: Current sda: sense = 70  3
Sep  3 00:28:07 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:28:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:28:07 stark kernel: end_request: I/O error, dev sda, sector 299628433
Sep  3 00:28:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:28:07 stark last message repeated 2 times
Sep  3 00:28:37 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:28:37 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:28:37 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:28:37 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 11 db f7 92 00 00 06 00 
Sep  3 00:28:37 stark kernel: Current sda: sense = 70  3
Sep  3 00:28:37 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:28:37 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:28:37 stark kernel: end_request: I/O error, dev sda, sector 299628434
Sep  3 00:28:37 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:28:37 stark last message repeated 2 times
Sep  3 00:29:07 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:29:07 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:29:07 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:29:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 11 db f7 93 00 00 05 00 
Sep  3 00:29:07 stark kernel: Current sda: sense = 70  3
Sep  3 00:29:07 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:29:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:29:07 stark kernel: end_request: I/O error, dev sda, sector 299628435
Sep  3 00:29:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:29:07 stark last message repeated 2 times
Sep  3 00:29:37 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:29:37 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:29:37 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:29:37 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 11 db f7 94 00 00 04 00 
Sep  3 00:29:37 stark kernel: Current sda: sense = 70  3
Sep  3 00:29:37 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:29:37 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:29:37 stark kernel: end_request: I/O error, dev sda, sector 299628436
Sep  3 00:29:37 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:29:37 stark last message repeated 2 times
Sep  3 00:30:07 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:30:07 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:30:07 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:30:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 11 db f7 95 00 00 03 00 
Sep  3 00:30:07 stark kernel: Current sda: sense = 70  3
Sep  3 00:30:07 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:30:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:30:07 stark kernel: end_request: I/O error, dev sda, sector 299628437
Sep  3 00:30:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:30:07 stark last message repeated 2 times
Sep  3 00:30:37 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:30:37 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:30:37 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:30:37 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 11 db f7 96 00 00 02 00 
Sep  3 00:30:37 stark kernel: Current sda: sense = 70  3
Sep  3 00:30:37 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:30:37 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:30:37 stark kernel: end_request: I/O error, dev sda, sector 299628438
Sep  3 00:30:37 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:30:37 stark last message repeated 2 times
Sep  3 00:31:07 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:31:07 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:31:07 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:31:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 11 db f7 97 00 00 01 00 
Sep  3 00:31:07 stark kernel: Current sda: sense = 70  3
Sep  3 00:31:07 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:31:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:31:07 stark kernel: end_request: I/O error, dev sda, sector 299628439
Sep  3 00:31:07 stark kernel: EXT2-fs error (device sda4): ext2_get_inode: unable to read inode block - inode=3719169, block=7438338
Sep  3 00:31:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:31:07 stark last message repeated 2 times
Sep  3 00:31:37 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:31:37 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:31:37 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:31:37 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 11 f3 f7 90 00 00 08 00 
Sep  3 00:31:37 stark kernel: Current sda: sense = 70  3
Sep  3 00:31:37 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:31:37 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:31:37 stark kernel: end_request: I/O error, dev sda, sector 301201296
Sep  3 00:31:37 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:31:37 stark last message repeated 2 times
Sep  3 00:32:07 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:32:07 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:32:07 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:32:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 11 f3 f7 91 00 00 07 00 
Sep  3 00:32:07 stark kernel: Current sda: sense = 70  3
Sep  3 00:32:07 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:32:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:32:07 stark kernel: end_request: I/O error, dev sda, sector 301201297
Sep  3 00:32:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:32:07 stark last message repeated 2 times
Sep  3 00:32:37 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:32:37 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:32:37 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:32:37 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 11 f3 f7 92 00 00 06 00 
Sep  3 00:32:37 stark kernel: Current sda: sense = 70  3
Sep  3 00:32:37 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:32:37 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:32:37 stark kernel: end_request: I/O error, dev sda, sector 301201298
Sep  3 00:32:37 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:32:37 stark last message repeated 2 times
Sep  3 00:33:07 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:33:07 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:33:07 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:33:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 11 f3 f7 93 00 00 05 00 
Sep  3 00:33:07 stark kernel: Current sda: sense = 70  3
Sep  3 00:33:07 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:33:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:33:07 stark kernel: end_request: I/O error, dev sda, sector 301201299
Sep  3 00:33:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:33:07 stark last message repeated 2 times
Sep  3 00:33:37 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:33:37 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:33:37 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:33:37 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 11 f3 f7 94 00 00 04 00 
Sep  3 00:33:37 stark kernel: Current sda: sense = 70  3
Sep  3 00:33:37 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:33:37 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:33:37 stark kernel: end_request: I/O error, dev sda, sector 301201300
Sep  3 00:33:37 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:33:37 stark last message repeated 2 times
Sep  3 00:34:07 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:34:07 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:34:07 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:34:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 11 f3 f7 95 00 00 03 00 
Sep  3 00:34:07 stark kernel: Current sda: sense = 70  3
Sep  3 00:34:07 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:34:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:34:07 stark kernel: end_request: I/O error, dev sda, sector 301201301
Sep  3 00:34:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:34:07 stark last message repeated 2 times
Sep  3 00:34:37 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:34:37 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:34:37 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:34:37 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 11 f3 f7 96 00 00 02 00 
Sep  3 00:34:37 stark kernel: Current sda: sense = 70  3
Sep  3 00:34:37 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:34:37 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:34:37 stark kernel: end_request: I/O error, dev sda, sector 301201302
Sep  3 00:34:37 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:34:37 stark last message repeated 2 times
Sep  3 00:35:07 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:35:07 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:35:07 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:35:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 11 f3 f7 97 00 00 01 00 
Sep  3 00:35:07 stark kernel: Current sda: sense = 70  3
Sep  3 00:35:07 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:35:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:35:07 stark kernel: end_request: I/O error, dev sda, sector 301201303
Sep  3 00:35:07 stark kernel: EXT2-fs error (device sda4): ext2_get_inode: unable to read inode block - inode=3817473, block=7634946
Sep  3 00:35:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:35:07 stark last message repeated 2 times
Sep  3 00:35:37 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:35:37 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:35:37 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:35:37 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 13 07 f7 90 00 00 08 00 
Sep  3 00:35:37 stark kernel: Current sda: sense = 70  3
Sep  3 00:35:37 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:35:37 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:35:37 stark kernel: end_request: I/O error, dev sda, sector 319289232
Sep  3 00:35:37 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:35:37 stark last message repeated 2 times
Sep  3 00:36:07 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:36:07 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:36:07 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:36:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 13 07 f7 91 00 00 07 00 
Sep  3 00:36:07 stark kernel: Current sda: sense = 70  3
Sep  3 00:36:07 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:36:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:36:07 stark kernel: end_request: I/O error, dev sda, sector 319289233
Sep  3 00:36:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:36:07 stark last message repeated 2 times
Sep  3 00:36:37 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:36:37 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:36:37 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:36:37 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 13 07 f7 92 00 00 06 00 
Sep  3 00:36:37 stark kernel: Current sda: sense = 70  3
Sep  3 00:36:37 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:36:37 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:36:37 stark kernel: end_request: I/O error, dev sda, sector 319289234
Sep  3 00:36:37 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:36:37 stark last message repeated 2 times
Sep  3 00:37:07 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:37:07 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:37:07 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:37:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 13 07 f7 93 00 00 05 00 
Sep  3 00:37:07 stark kernel: Current sda: sense = 70  3
Sep  3 00:37:07 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:37:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:37:07 stark kernel: end_request: I/O error, dev sda, sector 319289235
Sep  3 00:37:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:37:07 stark last message repeated 2 times
Sep  3 00:37:37 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:37:37 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:37:37 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:37:37 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 13 07 f7 94 00 00 04 00 
Sep  3 00:37:37 stark kernel: Current sda: sense = 70  3
Sep  3 00:37:37 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:37:37 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:37:37 stark kernel: end_request: I/O error, dev sda, sector 319289236
Sep  3 00:37:37 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:37:37 stark last message repeated 2 times
Sep  3 00:38:07 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:38:07 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:38:07 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:38:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 13 07 f7 95 00 00 03 00 
Sep  3 00:38:07 stark kernel: Current sda: sense = 70  3
Sep  3 00:38:07 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:38:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:38:07 stark kernel: end_request: I/O error, dev sda, sector 319289237
Sep  3 00:38:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:38:07 stark last message repeated 2 times
Sep  3 00:38:37 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:38:37 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:38:37 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:38:37 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 13 07 f7 96 00 00 02 00 
Sep  3 00:38:37 stark kernel: Current sda: sense = 70  3
Sep  3 00:38:37 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:38:37 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:38:37 stark kernel: end_request: I/O error, dev sda, sector 319289238
Sep  3 00:38:37 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:38:37 stark last message repeated 2 times
Sep  3 00:39:07 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:39:07 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:39:07 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:39:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 13 07 f7 97 00 00 01 00 
Sep  3 00:39:07 stark kernel: Current sda: sense = 70  3
Sep  3 00:39:07 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:39:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:39:07 stark kernel: end_request: I/O error, dev sda, sector 319289239
Sep  3 00:39:07 stark kernel: EXT2-fs error (device sda4): ext2_get_inode: unable to read inode block - inode=4947969, block=9895938
Sep  3 00:39:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:39:07 stark last message repeated 2 times
Sep  3 00:39:37 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:39:37 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:39:37 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:39:37 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 23 f7 90 00 00 08 00 
Sep  3 00:39:37 stark kernel: Current sda: sense = 70  3
Sep  3 00:39:37 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:39:37 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:39:37 stark kernel: end_request: I/O error, dev sda, sector 304347024
Sep  3 00:39:37 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:39:37 stark last message repeated 2 times
Sep  3 00:40:07 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:40:07 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:40:07 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:40:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 23 f7 91 00 00 07 00 
Sep  3 00:40:07 stark kernel: Current sda: sense = 70  3
Sep  3 00:40:07 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:40:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:40:07 stark kernel: end_request: I/O error, dev sda, sector 304347025
Sep  3 00:40:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:40:07 stark last message repeated 2 times
Sep  3 00:40:37 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:40:37 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:40:37 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:40:37 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 23 f7 92 00 00 06 00 
Sep  3 00:40:37 stark kernel: Current sda: sense = 70  3
Sep  3 00:40:37 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:40:37 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:40:37 stark kernel: end_request: I/O error, dev sda, sector 304347026
Sep  3 00:40:37 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:40:37 stark last message repeated 2 times
Sep  3 00:41:07 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:41:07 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:41:07 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:41:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 23 f7 93 00 00 05 00 
Sep  3 00:41:07 stark kernel: Current sda: sense = 70  3
Sep  3 00:41:07 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:41:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:41:07 stark kernel: end_request: I/O error, dev sda, sector 304347027
Sep  3 00:41:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:41:07 stark last message repeated 2 times
Sep  3 00:41:37 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:41:37 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:41:37 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:41:37 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 23 f7 94 00 00 04 00 
Sep  3 00:41:37 stark kernel: Current sda: sense = 70  3
Sep  3 00:41:37 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:41:37 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:41:37 stark kernel: end_request: I/O error, dev sda, sector 304347028
Sep  3 00:41:37 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:41:37 stark last message repeated 2 times
Sep  3 00:42:07 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:42:07 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:42:07 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:42:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 23 f7 95 00 00 03 00 
Sep  3 00:42:07 stark kernel: Current sda: sense = 70  3
Sep  3 00:42:07 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:42:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:42:07 stark kernel: end_request: I/O error, dev sda, sector 304347029
Sep  3 00:42:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:42:07 stark last message repeated 2 times
Sep  3 00:42:37 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:42:37 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:42:37 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:42:37 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 23 f7 96 00 00 02 00 
Sep  3 00:42:37 stark kernel: Current sda: sense = 70  3
Sep  3 00:42:37 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:42:37 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:42:37 stark kernel: end_request: I/O error, dev sda, sector 304347030
Sep  3 00:42:37 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:42:37 stark last message repeated 2 times
Sep  3 00:43:07 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:43:07 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:43:07 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:43:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 23 f7 97 00 00 01 00 
Sep  3 00:43:07 stark kernel: Current sda: sense = 70  3
Sep  3 00:43:07 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:43:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:43:07 stark kernel: end_request: I/O error, dev sda, sector 304347031
Sep  3 00:43:07 stark kernel: EXT2-fs error (device sda4): ext2_get_inode: unable to read inode block - inode=4014081, block=8028162
Sep  3 00:43:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:43:07 stark last message repeated 2 times
Sep  3 00:43:37 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:43:37 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:43:37 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:43:37 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 0f f7 90 00 00 08 00 
Sep  3 00:43:37 stark kernel: Current sda: sense = 70  3
Sep  3 00:43:37 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:43:37 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:43:37 stark kernel: end_request: I/O error, dev sda, sector 303036304
Sep  3 00:43:37 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 00:43:37 stark last message repeated 2 times
Sep  3 00:44:07 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 00:44:07 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 00:44:07 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 00:44:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 0f f7 91 00 00 07 00 
Sep  3 00:44:07 stark kernel: Current sda: sense = 70  3
Sep  3 00:44:07 stark kernel: ASC=13 ASCQ= 0
Sep  3 00:44:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 00:44:07 stark kernel: end_request: I/O error, dev sda, sector 303036305
Sep  3 00:44:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7



> brad@srv:/usr/src$ diff -u temp/linux-2.6.8.1/drivers/scsi/libata-scsi.c
> linux-2.6.8.1/drivers/scsi/libata-scsi.c
> --- temp/linux-2.6.8.1/drivers/scsi/libata-scsi.c       2004-08-14 14:55:19.000000000 +0400
> +++ linux-2.6.8.1/drivers/scsi/libata-scsi.c    2004-08-18 01:04:11.000000000 +0400
> @@ -213,6 +213,7 @@
> 
>          ap = (struct ata_port *) &host->hostdata[0];
>          ap->ops->eng_timeout(ap);
> +       host->host_failed--;
> 
>          DPRINTK("EXIT\n");
>          return 0;
> 

-- 
greg

