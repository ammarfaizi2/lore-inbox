Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932560AbWFBTuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbWFBTuJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWFBTuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:50:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:11804 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932558AbWFBTt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:49:58 -0400
Date: Fri, 2 Jun 2006 21:50:46 +0200
From: Jens Axboe <axboe@suse.de>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgewood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Mark Lord <liml@rtr.ca>,
       Jeff Garzik <jeff@garzik.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 07/11] the latest consensus libata resume fix
Message-ID: <20060602195046.GO4400@suse.de>
References: <20060602194618.482948000@sous-sol.org> <20060602194742.420464000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060602194742.420464000@sous-sol.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02 2006, Chris Wright wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
> 
> From: Mark Lord <liml@rtr.ca>
> 
> Okay, just to sum things up.
> 
> This forces libata to wait for up to 2 seconds for BUSY|DRQ to clear
> on resume before continuing.
> 
> [jgarzik adds...]  During testing we never saw DRQ asserted, but
> nonetheless (a) this works and (b) testing for DRQ won't hurt.
> 
> Signed-off-by:  Mark Lord <liml@rtr.ca>
> Acked-by: Jens Axboe <axboe@suse.de>
> Signed-off-by: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> ---
> 
>  drivers/scsi/libata-core.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-2.6.16.19.orig/drivers/scsi/libata-core.c
> +++ linux-2.6.16.19/drivers/scsi/libata-core.c
> @@ -4293,6 +4293,7 @@ static int ata_start_drive(struct ata_po
>  int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
>  {
>  	if (ap->flags & ATA_FLAG_SUSPENDED) {
> +		ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 200000);
>  		ap->flags &= ~ATA_FLAG_SUSPENDED;
>  		ata_set_mode(ap);
>  	}

I'm not against the patch as such, but last I checked 2.6.16 actually
worked ok. The timer fixes in 2.6.17-rc is what apparently got the
resume breaking.

So unless there's a bug report on 2.6.16.x for this, then it's a little
against the -stable rules to add it.

-- 
Jens Axboe

