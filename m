Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbWEOUpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWEOUpq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 16:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWEOUpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 16:45:46 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:6348 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751505AbWEOUpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 16:45:32 -0400
Message-ID: <4468E865.3070601@garzik.org>
Date: Mon, 15 May 2006 16:45:25 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Arkadiusz Miskiewicz <arekm@maven.pl>
CC: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [RFT] major libata update
References: <20060515170006.GA29555@havoc.gtf.org> <20060515101831.0e38d131.akpm@osdl.org> <4468C33F.7070905@garzik.org> <200605152106.08239.arekm@maven.pl>
In-Reply-To: <200605152106.08239.arekm@maven.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arkadiusz Miskiewicz wrote:
> On Monday 15 May 2006 20:06, Jeff Garzik wrote:
> 
>>> http://bugzilla.kernel.org/show_bug.cgi?id=6260
>> waiting on SATA ACPI merge.
> Is this really a case?
> 
> The one (layering breaking; discussed already) patch cures the problem and 
> nothing sata acpi related is needed, so something else is problematic here I 
> guess.
> 
> --- 2.6.17-rc2/drivers/scsi/libata-core.c       2006-04-19 09:14:11.000000000 
> +0100 
> +++ linux/drivers/scsi/libata-core.c    2006-04-21 20:55:48.000000000 +0100 
> @@ -4288,6 +4288,7 @@ int ata_device_resume(struct ata_port *a 
>  { 
>         if (ap->flags & ATA_FLAG_SUSPENDED) { 
>                 ap->flags &= ~ATA_FLAG_SUSPENDED; 
> +               ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT); 
>                 ata_set_mode(ap); 

This libata update should address issues that the above patch also 
addresses.  It will be interesting to hear feedback in the coming days 
on what issues remain after this big lump.

	Jeff



