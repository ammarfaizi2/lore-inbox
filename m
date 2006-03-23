Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWCWNJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWCWNJZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 08:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWCWNJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 08:09:25 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:56868 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751117AbWCWNJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 08:09:24 -0500
Date: Thu, 23 Mar 2006 14:09:20 +0100
From: Jens Axboe <axboe@suse.de>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make libata not powerdown drivers on PM_EVENT_FREEZE.
Message-ID: <20060323130919.GZ4285@suse.de>
References: <200603232151.47346.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603232151.47346.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23 2006, Nigel Cunningham wrote:
> diff -ruNp 9904-libata-freeze.patch-old/drivers/scsi/libata-scsi.c 9904-libata-freeze.patch-new/drivers/scsi/libata-scsi.c
> --- 9904-libata-freeze.patch-old/drivers/scsi/libata-scsi.c	2006-03-23 21:16:22.000000000 +1000
> +++ 9904-libata-freeze.patch-new/drivers/scsi/libata-scsi.c	2006-03-23 21:24:06.000000000 +1000
> @@ -419,7 +419,7 @@ int ata_scsi_device_suspend(struct scsi_
>  	struct ata_port *ap = (struct ata_port *) &sdev->host->hostdata[0];
>  	struct ata_device *dev = &ap->device[sdev->id];
>  
> -	return ata_device_suspend(ap, dev);
> +	return ata_device_suspend(ap, dev, state);
>  }

Eh this looks odd, you are forgetting to add pm_message_t state as an
extra argument to that function.

Apart from that, patch looks good. It should definitely be included
asap.

-- 
Jens Axboe

