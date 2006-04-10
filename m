Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWDJS6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWDJS6t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 14:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWDJS6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 14:58:48 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:7871 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932100AbWDJS6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 14:58:47 -0400
Message-ID: <443AAAE5.2020208@garzik.org>
Date: Mon, 10 Apr 2006 14:58:45 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [git patch] libata scsi eh fixed to use transport class
References: <20060410185039.GA32027@havoc.gtf.org>
In-Reply-To: <20060410185039.GA32027@havoc.gtf.org>
Content-Type: multipart/mixed;
 boundary="------------020001030408040004000904"
X-Spam-Score: -3.8 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.8 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020001030408040004000904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
> index fa901fd..0ebf136 100644
> --- a/drivers/scsi/sata_mv.c
> +++ b/drivers/scsi/sata_mv.c
> @@ -378,8 +378,6 @@ static struct scsi_host_template mv_sht 
>  	.name			= DRV_NAME,
>  	.ioctl			= ata_scsi_ioctl,
>  	.queuecommand		= ata_scsi_queuecmd,
> -	.eh_strategy_handler	= ata_scsi_error,
> -	.can_queue		= MV_USE_Q_DEPTH,
>  	.this_id		= ATA_SHT_THIS_ID,
>  	.sg_tablesize		= MV_MAX_SG_CT / 2,
>  	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,

And the obvious patch (attached) was just checked in, to fix the above 
deletion that was in Christoph's original patch, subsequently merged.

	Jeff



--------------020001030408040004000904
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

commit 1b72373491a061be6d456d219a4e2d054ac2aaad
Author: Jeff Garzik <jeff@garzik.org>
Date:   Mon Apr 10 14:56:39 2006 -0400

    [libata] sata_mv: fix can_queue line accidentally removed in scsi-eh patch

1b72373491a061be6d456d219a4e2d054ac2aaad
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 0ebf136..b64b077 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -378,6 +378,7 @@ static struct scsi_host_template mv_sht 
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
+	.can_queue		= MV_USE_Q_DEPTH,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= MV_MAX_SG_CT / 2,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,

--------------020001030408040004000904--
