Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946015AbWBOQb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946015AbWBOQb3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 11:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946014AbWBOQb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 11:31:29 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:2934 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1946013AbWBOQb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 11:31:28 -0500
Date: Wed, 15 Feb 2006 17:31:35 +0100
From: Sander <sander@humilis.net>
To: Jens Axboe <axboe@suse.de>
Cc: Sander <sander@humilis.net>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc3 kernel BUG at drivers/scsi/sata_mv.c:1018
Message-ID: <20060215163135.GA20806@favonius>
Reply-To: sander@humilis.net
References: <20060215131653.GA26178@favonius> <20060215145925.GU4203@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060215145925.GU4203@suse.de>
X-Uptime: 16:36:36 up 15 days,  7:55, 23 users,  load average: 3.20, 2.85, 2.58
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote (ao):
> On Wed, Feb 15 2006, Sander wrote:
> > I get a kernel BUG message when I try to create a raid1 or raid5 over
> > nine 64MB partitions located on nine sata disks (Maxtor Pro 500) on a
> > fresh setup. The system locks hard: no sysrq.
> > 
> > The onboard controller is an nVidia nForce with three disks.
> > The six other disks are connected to a Marvell 88SX6081 controller.

> It's barfing on a barrier write, I bet. The attached patch should fix
> it.

Your patch does indeed fix the hang. The raid1 is done, and raid5 over
the second partition is building.

Thanks a lot Jens!!

	Sander


> [PATCH] Add missing FUA write to sata_mv dma command list
> 
> Signed-off-by: Jens Axboe <axboe@suse.de>
> 
> diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
> index 6fddf17..2770005 100644
> --- a/drivers/scsi/sata_mv.c
> +++ b/drivers/scsi/sata_mv.c
> @@ -997,6 +997,7 @@ static void mv_qc_prep(struct ata_queued
>  	case ATA_CMD_READ_EXT:
>  	case ATA_CMD_WRITE:
>  	case ATA_CMD_WRITE_EXT:
> +	case ATA_CMD_WRITE_FUA_EXT:
>  		mv_crqb_pack_cmd(cw++, tf->hob_nsect, ATA_REG_NSECT, 0);
>  		break;
>  #ifdef LIBATA_NCQ		/* FIXME: remove this line when NCQ added */
> 
> -- 
> Jens Axboe

-- 
Humilis IT Services and Solutions
http://www.humilis.net
