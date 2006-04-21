Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWDUVRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWDUVRN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 17:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWDUVRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 17:17:13 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7371 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964786AbWDUVRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 17:17:11 -0400
Date: Fri, 21 Apr 2006 23:15:55 +0200
From: Pavel Machek <pavel@suse.cz>
To: Hugh Dickins <hugh@veritas.com>
Cc: Arkadiusz Miskiewicz <arekm@maven.pl>,
       Jeff Chua <jeffchua@silk.corp.fedex.com>, Jeff Garzik <jeff@garzik.org>,
       Matt Mackall <mpm@selenic.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sata suspend resume ...
Message-ID: <20060421211555.GB3206@elf.ucw.cz>
References: <Pine.LNX.4.64.0604192324040.29606@indiana.corp.fedex.com> <Pine.LNX.4.64.0604191659230.7660@blonde.wat.veritas.com> <20060420134713.GA2360@ucw.cz> <Pine.LNX.4.64.0604211333050.4891@blonde.wat.veritas.com> <20060421163930.GA1648@elf.ucw.cz> <Pine.LNX.4.64.0604212108010.7531@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604212108010.7531@blonde.wat.veritas.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is a patch I'd not be ashamed to send Jeff Garzik cc linux-ide,
> even if we can't name precisely why it's ATA_BUSY then.  But I'll
> give it a day or so of real-life suspend/resuming first - Arkadiusz
> and I both noticed we're more likely to resume successfully after
> a brief suspend, so longer suspends are needed for proper testing.

Thanks, looks good.
							Pavel

> Hugh
> 
> --- 2.6.17-rc2/drivers/scsi/libata-core.c	2006-04-19 09:14:11.000000000 +0100
> +++ linux/drivers/scsi/libata-core.c	2006-04-21 20:55:48.000000000 +0100
> @@ -4288,6 +4288,7 @@ int ata_device_resume(struct ata_port *a
>  {
>  	if (ap->flags & ATA_FLAG_SUSPENDED) {
>  		ap->flags &= ~ATA_FLAG_SUSPENDED;
> +		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
>  		ata_set_mode(ap);
>  	}
>  	if (!ata_dev_present(dev))

-- 
Thanks for all the (sleeping) penguins.
