Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264410AbTL3GMJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 01:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbTL3GMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 01:12:09 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:56458 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S264410AbTL3GMG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 01:12:06 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Omkhar Arasaratnam <omkhar@rogers.com>, emoenke@gwdg.de
Subject: Re: [PATCH] drivers/cdrom/sjcd.c check_region() fix
Date: Tue, 30 Dec 2003 01:12:00 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <20031229195757.GA26168@omkhar.ibm.com>
In-Reply-To: <20031229195757.GA26168@omkhar.ibm.com>
Organization: Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312300112.00823.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.9.137] at Tue, 30 Dec 2003 00:12:04 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 December 2003 14:57, Omkhar Arasaratnam wrote:
>Here is another check_region fix, this time for sjcd.c
>
>--- /usr/src/linux-2.6.0/drivers/cdrom/sjcd.c	2003-12-17
> 21:59:05.000000000 -0500 +++ drivers/cdrom/sjcd.c	2003-12-29
> 14:52:05.000000000 -0500 @@ -1700,12 +1700,13 @@
> 	sprintf(sjcd_disk->disk_name, "sjcd");
> 	sprintf(sjcd_disk->devfs_name, "sjcd");
>
>-	if (check_region(sjcd_base, 4)) {
>+	if (!request_region(sjcd_base, 4,"sjcd")) {
> 		printk
> 		    ("SJCD: Init failed, I/O port (%X) is already in use\n",
> 		     sjcd_base);
> 		goto out2;
> 	}
>+	release_region(sjcd_base,4);
>
> 	/*
> 	 * Check for card. Since we are booting now, we can't use standard

I've got two of those check_region() warnings in advansys.c.

Would it be appropriate to do a similar fix to it?

>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

