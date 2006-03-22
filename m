Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWCVRKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWCVRKH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 12:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWCVRKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 12:10:07 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:33960 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1750968AbWCVRKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 12:10:01 -0500
Date: Wed, 22 Mar 2006 18:09:59 +0100
From: Sander <sander@humilis.net>
To: Mark Lord <lkml@rtr.ca>
Cc: sander@humilis.net, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>,
       Andrew Morton <akpm@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
Message-ID: <20060322170959.GA3222@favonius>
Reply-To: sander@humilis.net
References: <20060321121354.GB24977@favonius> <Pine.LNX.4.64.0603211316580.3622@g5.osdl.org> <20060322090006.GA8462@favonius> <200603220950.11922.lkml@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603220950.11922.lkml@rtr.ca>
X-Uptime: 18:01:26 up 19 days, 22:11, 30 users,  load average: 3.25, 3.02, 2.70
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote (ao):
> > The 2.6.16-git3 snapshot is stable for me like -rc6-mm1 and -rc6-mm2
> > are :-)
> ..
> > Btw, I do still get these (any kernel), but with no visible effect:
> > 
> > [ 2306.952183] ata6: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 
> 0xb/47/00
> > [ 2306.952246] ata6: status=0xd0 { Busy }
> > [ 2891.892225] ata5: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 
> 0xb/47/00
> > [ 2891.892277] ata5: status=0xd0 { Busy }
> > [ 4550.013582] ata6: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 
> 0xb/47/00
> > [ 4550.013637] ata6: status=0xd0 { Busy }
> > [ 4864.850340] ata9: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 
> 0xb/47/00
> > [ 4864.850393] ata9: status=0xd0 { Busy }
> > [ 4968.681651] ata9: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 
> 0xb/47/00
> > [ 4968.681711] ata9: status=0xd0 { Busy }
> 
> The 2.6.16-git3 (and -git4) drivers are still missing the latest
> critical fix that started this thread. Could you apply that also, and
> see if the messages above go away?

I've applied the patch against 2.6.16-git4. I'm sorry to say the
messages are still there:

[ 1038.536894] kjournald starting.  Commit interval 5 seconds
[ 1038.555040] EXT3 FS on md0, internal journal
[ 1038.555072] EXT3-fs: mounted filesystem with writeback data mode.
[ 1418.639290] ata11: status=0x50 { DriveReady SeekComplete }
[ 1418.639356] ata11: error=0x50 { UncorrectableError SectorIdNotFound }
[ 1418.639418] sdh: Current: sense key=0x0
[ 1418.639448]     ASC=0x0 ASCQ=0x0
[ 1418.639481] Info fld=0x505050
[ 1684.727367] ata9: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[ 1684.727420] ata9: status=0xd0 { Busy }
[ 2223.664107] ata6: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[ 2223.664162] ata6: status=0xd0 { Busy }
[ 2381.589354] ata11: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[ 2381.589416] ata11: status=0xd0 { Busy }
[ 2511.238690] ata9: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[ 2511.238753] ata9: status=0xd0 { Busy }
[ 2990.792908] ata7: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[ 2990.792960] ata7: status=0xd0 { Busy }
[ 4672.691569] ata8: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[ 4672.691623] ata8: status=0xd0 { Busy }
[ 4988.884663] ata6: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[ 4988.884717] ata6: status=0xd0 { Busy }


Could the ata11/sdh message be bogus? I re-create the raid5 and fs every
reboot.

-- 
Humilis IT Services and Solutions
http://www.humilis.net
