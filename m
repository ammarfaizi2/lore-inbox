Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265604AbTL3H3s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 02:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265689AbTL3H3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 02:29:48 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:28631 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S265604AbTL3H3o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 02:29:44 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None that appears to be detectable by casual observers
To: Omkhar Arasaratnam <omkhar@rogers.com>
Subject: Re: [PATCH] drivers/cdrom/sjcd.c check_region() fix
Date: Tue, 30 Dec 2003 02:29:39 -0500
User-Agent: KMail/1.5.1
Cc: emoenke@gwdg.de, linux-kernel@vger.kernel.org
References: <20031229195757.GA26168@omkhar.ibm.com> <200312300112.00823.gene.heskett@verizon.net> <20031230064521.GA21141@omkhar.ibm.com>
In-Reply-To: <20031230064521.GA21141@omkhar.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312300229.39044.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.9.137] at Tue, 30 Dec 2003 01:29:42 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 December 2003 01:45, Omkhar Arasaratnam wrote:
>On Tue, Dec 30, 2003 at 01:12:00AM -0500, Gene Heskett wrote:
>> On Monday 29 December 2003 14:57, Omkhar Arasaratnam wrote:
>> >Here is another check_region fix, this time for sjcd.c
>> >
>> >--- /usr/src/linux-2.6.0/drivers/cdrom/sjcd.c	2003-12-17
>> > 21:59:05.000000000 -0500 +++ drivers/cdrom/sjcd.c	2003-12-29
>> > 14:52:05.000000000 -0500 @@ -1700,12 +1700,13 @@
>> > 	sprintf(sjcd_disk->disk_name, "sjcd");
>> > 	sprintf(sjcd_disk->devfs_name, "sjcd");
>> >
>> >-	if (check_region(sjcd_base, 4)) {
>> >+	if (!request_region(sjcd_base, 4,"sjcd")) {
>> > 		printk
>> > 		    ("SJCD: Init failed, I/O port (%X) is already in use\n",
>> > 		     sjcd_base);
>> > 		goto out2;
>> > 	}
>> >+	release_region(sjcd_base,4);
>> >
>> > 	/*
>> > 	 * Check for card. Since we are booting now, we can't use
>> > standard
>>
>> I've got two of those check_region() warnings in advansys.c.
>>
>> Would it be appropriate to do a similar fix to it?
>
>Believe it or not I was actually working on advant.c as well. That's
> a big file. I was going to leave it till the AM to post after doing
> a final sanity check (it's almost 2am local time :) 

Humm, 2:26am here...

>I believe this
> _should_ work - perhaps you can advise if line 5390 (after applying
> my patch) will fail because of a duplicate request_region()...
> Either way here is my patch:

I'll give it a try sometime tomorrow, many thanks!  But tonight I'm 
running out of eyeballs.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

