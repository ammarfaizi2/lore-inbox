Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVANRLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVANRLQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 12:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbVANRLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 12:11:15 -0500
Received: from fire.osdl.org ([65.172.181.4]:43458 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262028AbVANRJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 12:09:33 -0500
Message-ID: <41E7F9DB.8070707@osdl.org>
Date: Fri, 14 Jan 2005 08:56:59 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Reuben Farrelly <reuben-lkml@reub.net>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Breakage with raid in 2.6.11-rc1-mm1 [Regression in mm]
References: <6.2.0.14.2.20050114233439.01cbb8d8@tornado.reub.net> <20050114035852.3b5ff1a3.akpm@osdl.org> <6.2.0.14.2.20050115014139.01dab5e0@tornado.reub.net>
In-Reply-To: <6.2.0.14.2.20050115014139.01dab5e0@tornado.reub.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly wrote:
> At 12:58 a.m. 15/01/2005, Andrew Morton wrote:
> 
>> Reuben Farrelly <reuben-lkml@reub.net> wrote:
>> >
>> > Something seems to have broken with 2.6.11-rc1-mm1, which worked ok 
>> with
>> > 2.6.10-mm3.
>> >
>> > NET: Registered protocol family 17
>> > Starting balanced_irq
>> > BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
>> > md: Autodetecting RAID arrays.
>> > md: autorun ...
>> > md: ... autorun DONE.
>> > VFS: Waiting 19sec for root device...
>> > VFS: Waiting 18sec for root device...
>> > VFS: Waiting 17sec for root device...
>> > VFS: Waiting 16sec for root device...
>> > VFS: Waiting 15sec for root device...
>> > VFS: Waiting 14sec for root device...
>> > VFS: Waiting 13sec for root device...
>> > VFS: Waiting 12sec for root device...
>> > VFS: Waiting 11sec for root device...
>> > VFS: Waiting 10sec for root device...
>> > VFS: Waiting 9sec for root device...
>> > VFS: Waiting 8sec for root device...
>> > VFS: Waiting 7sec for root device...
>> > VFS: Waiting 6sec for root device...
>> > VFS: Waiting 5sec for root device...
>> > VFS: Waiting 4sec for root device...
>> > VFS: Waiting 3sec for root device...
>> > VFS: Waiting 2sec for root device...
>> > VFS: Waiting 1sec for root device...
>> > VFS: Cannot open root device "md2" or unknown-block(0,0)
>> > Please append a correct "root=" boot option
>> > Kernel panic - not syncing: VFS: Unable to mount root fs on 
>> unknown-block(0,0)
>> >
>> > The system is running 5 RAID-1 partitions, and md2 is the root as per
>> > grub.conf.  Problem seems to be that raid autodetection finds no raid
>> > partitions :(
>> >
>> > The two ST380013AS SATA drives are detected earlier in the boot, so 
>> I don't
>> > think that's the problem..
>>
>> hm, the only raidy thing we have in there is the below.  Maybe you could
>> try reverting that?
>>
>>
>> --- 25/drivers/md/raid5.c~raid5-overlapping-read-hack   2005-01-09 
>> 22:20:40.211246912 -0800
>> +++ 25-akpm/drivers/md/raid5.c  2005-01-09 22:20:40.216246152 -0800
>> @@ -232,6 +232,7 @@ static struct stripe_head *__find_stripe
>>  }
>>
>>  static void unplug_slaves(mddev_t *mddev);
>> +static void raid5_unplug_device(request_queue_t *q);
>>
>>  static struct stripe_head *get_active_stripe(raid5_conf_t *conf, 
>> sector_t sector,
>>                                              int pd_idx, int noblock)
> 
> 
> Ok the breakage occurred somewhere between 2.6.10-mm3 (works) and 
> 2.6.11-rc1 (doesn't work) ie wasn't introduced into the latest -mm 
> patchset as I first thought.
> 
> Are there any other patches that might be worth a try backing out?

Someone else reported that they had to back out this one:
waiting-10s-before-mounting-root-filesystem.patch

Can you revert that one and let us know how it goes?

-- 
~Randy
