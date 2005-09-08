Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbVIHCjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbVIHCjF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 22:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbVIHCjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 22:39:05 -0400
Received: from main.gmane.org ([80.91.229.2]:53663 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932570AbVIHCjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 22:39:04 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Aric Cyr <Aric.Cyr@gmail.com>
Subject: Re: 2.6.13 (was 2.6.11.11) and rsync oops (SATA or NFS related?)
Date: Thu, 8 Sep 2005 02:37:16 +0000 (UTC)
Message-ID: <loom.20050908T042646-261@post.gmane.org>
References: <dfg2sa$peu$2@sea.gmane.org> <dfguoq$eng$1@sea.gmane.org> <dfhjp3$fd4$1@sea.gmane.org> <dfjjp9$f7k$1@sea.gmane.org> <loom.20050907T055454-169@post.gmane.org> <431F21DB.2010504@thinrope.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 203.179.48.72 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Firefox/1.0.6)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kalin KOZHUHAROV <kalin <at> thinrope.net> writes:

> ata1: dev 0 configured for UDMA/100
> ata2: dev 0 configured for UDMA/100
> scsi1 : sata_sil
>    Vendor: ATA       Model: WDC WD360GD-00FL  Rev: 21.0
>    Type:   Direct-Access                      ANSI SCSI revision: 05
>    Vendor: ATA       Model: ST3300831AS       Rev: 3.03
>    Type:   Direct-Access                      ANSI SCSI revision: 05

Looks like UDMA/100 is set up fine for both your drives.

>   # hdparm -t /dev/sdb
> 
> /dev/sdb:
>   Timing buffered disk reads:  176 MB in  3.01 seconds =  58.43 MB/sec
> HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl
> for device
> 
> I don't like the error MSG above, but 58MB/s is not bad, compared to 36.5MB/s
> with ide-sata driver!

This is normal.  hdparm doesn't know much about SCSI drives... SATA drives are
closer to SCSI than IDE.  In particular the various direct IDE ioctls are not
supported by the SCSI layer.  Don't worry about these errors.

> Might be a stupid question... but is UDMA relevant to SATA drives run by
> libata??
> If yes, how do I get the current value of it?

See above.

> And upgrading firmware to a harddrive is done how?
> Done on my BIOSes, my Plextor CD-Rs and DVD+RWs, but on a hard drive?
> Any pointers, or that was just a random thought 
> 
> According to linux-2.6.13/drivers/scsi/sata_sil.c:94 my drives are not
> blacklisted.

Sorry, I thought your drive might be blacklisted, but I didn't actually check
the driver for your model.  You are getting UDMA/100 so your drive is just
fine, no firmware update is required.  If you were interested though, poking 
around seagates site would probably turn up some firmware updates, if any are
available.  I did have a blacklisted seagate drive, but it works fine after
the firmware update and removal from the blacklist.

Regards

