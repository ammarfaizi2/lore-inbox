Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030337AbWCUCfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbWCUCfz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 21:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbWCUCfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 21:35:55 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:26087 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030327AbWCUCfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 21:35:54 -0500
Message-ID: <441F6684.609@pobox.com>
Date: Mon, 20 Mar 2006 21:35:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: sander@humilis.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, lkml@rtr.ca,
       pjones@redhat.com
Subject: Re: Some sata_mv error messages
References: <20060318044056.350a2931.akpm@osdl.org> <20060320133318.GB32762@favonius> <441F508E.1030008@pobox.com> <20060321022515.GI29589@redhat.com>
In-Reply-To: <20060321022515.GI29589@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.4 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.4 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Mon, Mar 20, 2006 at 08:02:06PM -0500, Jeff Garzik wrote:
>  > Sander wrote:
>  > >Hi all,
>  > >
>  > >While sata_mv in 2.6.16-rc6-mm2 seems stable (yah!) compared to
>  > >2.6.16-rc6 (no crashes, no data corruption), I still get these messages:
>  > >
>  > >[ 3962.139906] ata5: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 
>  > >0xb/47/00
>  > >[ 3962.139959] ata5: status=0xd0 { Busy }
>  > >
>  > >[ 6105.948045] ata6: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 
>  > >0xb/47/00
>  > >[ 6105.948097] ata6: status=0xd0 { Busy }
>  > >
>  > >[ 7981.164936] ata5: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 
>  > >0xb/47/00
>  > >[ 7981.164991] ata5: status=0xd0 { Busy }
>  > >
>  > >[ 8273.951019] ata7: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 
>  > >0xb/47/00
>  > >[ 8273.951072] ata7: status=0xd0 { Busy }
>  > >
>  > >[ 9903.032350] ata8: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 
>  > >0xb/47/00
>  > >[ 9903.032402] ata8: status=0xd0 { Busy }
>  > >
>  > >
>  > >I'm not entirely sure this is only happens on sata_mv (Marvell
>  > >MV88SX6081) as out of eight disks only one is connected to the onboard
>  > >sata_nv (nVidia) and the error doesn't happen very often. But I'll keep
>  > >an eye on it.
>  > >
>  > >Are these messages somehow dangerous or otherwise indicating a
>  > >potentional serious problem? A google search came up with a few links,
>  > >but none of them helped me understand the messages.
>  > 
>  > Without answering your specific question, just remember that sata_mv is 
>  > considerly "highly experimental" right now, and still needs some 
>  > workarounds for hardware errata.
>  > 
>  > For now, the goal is a system that doesn't crash and doesn't corrupt 
>  > data.  If its occasionally slow or spits out a few errors, but otherwise 
>  > still works, that's pretty darned good :)
> 
> Reminds me, this message (though different error codes) gets spewed to the
> console a lot when haldaemon polls SATA CD drives.
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=183348

Yeah, libata is way too noisy on ATAPI.  In ATA, errors were rare so you 
needed all the info.  In ATAPI, some "errors" are expected, and simply 
reported back to the application.  Unfortunately, the solution is 
observation and iteration:

Console spews messages.  Users yell, and paste said messages.  Observe 
ATAPI behavior and return codes, and adjust libata.  Repeat.

As an aside, most recent SATA cd/dvd drives support "asynchronous 
notification", which means you don't have the poll the drive.  HAL needs 
to support that.


> This wasn't occasional, this was every few seconds, making the box
> pretty much unusable.

The entire box or just the console?

	Jeff



