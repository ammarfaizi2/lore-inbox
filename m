Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130188AbQKLGQ7>; Sun, 12 Nov 2000 01:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130208AbQKLGQu>; Sun, 12 Nov 2000 01:16:50 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:58128 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130188AbQKLGQf>;
	Sun, 12 Nov 2000 01:16:35 -0500
Date: Sun, 12 Nov 2000 07:16:17 +0100
From: Jens Axboe <axboe@suse.de>
To: Daniel R Risacher <magnus@alum.mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CDROMPLAYTRKIND translation in sr_ioctl.c for idescsi
Message-ID: <20001112071617.M964@suse.de>
In-Reply-To: <200011120255.eAC2tZI19943@risacher.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200011120255.eAC2tZI19943@risacher.yi.org>; from magnus@alum.mit.edu on Sat, Nov 11, 2000 at 09:55:35PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11 2000, Daniel R Risacher wrote:
> Summary:
> 
> Many audio-cdrom-playing programs don't work correctly with ATAPI
> CDROM drives under ide-scsi translation, because ATAPI doesn't support
> the PLAYAUDIO_TI command. The ide-cd driver handles this by
> transforming CDROMPLAYTRKIND ioctls into something that the ATAPI
> drive will understand, but this mechanism is bypassed when using
> ide-scsi translation.

Yup

> This patch creates a new kernel option,
> CONFIG_SCSI_IDESCSI_WORKAROUND, that is available whenever ide-scsi
> translation is enabled. Enabling this new option includes a
> tranlation mechanism into the SCSI CDROM (sr) driver similar to the
> mechanism in the ide-cd driver.
> 
> Hopefully this will make life much easier for those of us who use
> ide-scsi for CDROM drives. It is essentially the same thing as the
> patch I posted for 2.2.12 on 19 Oct 1999, but updated for 2.4.0-test9.
> This probably isn't the most elegant solution, but maybe it'll help
> some people out until Jens figures out something better.

I would take this patch, if you made it a fall back path when
PLAYAUDIO_TI fails with 05/20/00 sense. That makes a lot more sense
to me (pun intended) than a config option. What do you think, will
you do that?

For 2.5 the CD-ROM setup will be feature based. This is all supported
by newer drives, but it should be possible to make pseudo feature
profiles for older drives. This has the advantage that we always
'know' what is supported and what is not -- no more trial and error.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
