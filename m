Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWE2VgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWE2VgK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWE2VgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:36:07 -0400
Received: from gate.crashing.org ([63.228.1.57]:30944 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751364AbWE2VfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:35:03 -0400
Subject: Re: [git patch] libata resume fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060528203419.GA15087@havoc.gtf.org>
References: <20060528203419.GA15087@havoc.gtf.org>
Content-Type: text/plain
Date: Tue, 30 May 2006 07:34:42 +1000
Message-Id: <1148938482.5959.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-28 at 16:34 -0400, Jeff Garzik wrote:
> Please pull from 'upstream-fixes' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> 
> to receive the following updates:
> 
>  drivers/scsi/libata-core.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> Mark Lord:
>       the latest consensus libata resume fix

If your devices are coming from poweron-reset then you will have to wait
up to 31 seconds :( And yes, I _did_ have such a device at one point.

Ben.


> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index fa476e7..b046ffa 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -4297,6 +4297,7 @@ static int ata_start_drive(struct ata_po
>  int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
>  {
>  	if (ap->flags & ATA_FLAG_SUSPENDED) {
> +		ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 200000);
>  		ap->flags &= ~ATA_FLAG_SUSPENDED;
>  		ata_set_mode(ap);
>  	}
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

