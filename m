Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbVAPLCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbVAPLCR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 06:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbVAPLCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 06:02:17 -0500
Received: from tornado.reub.net ([60.234.136.108]:51134 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S262474AbVAPLCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 06:02:13 -0500
Message-ID: <41EA49AC.7070504@reub.net>
Date: Mon, 17 Jan 2005 00:02:04 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Mozilla Thunderbird 0.6+ (Windows/20050115)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: fa.linux.kernel
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Breakage with raid in 2.6.11-rc1-mm1 [Regression in mm]
References: <fa.h2tu7ia.m3ir1o@ifi.uio.no> <fa.kv41q3p.1nn82gh@ifi.uio.no>
In-Reply-To: <fa.kv41q3p.1nn82gh@ifi.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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

<snip>

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
> 
> reuben

I did a full untar of the source and rebuilt my (crusty old) config file
from scratch, and it seems to have come right now.  Can't really explain
it though...but obviously wasn't a problem with the -mm release as I
first though.  Now running -rc1-mm1 with no problems and no other patches.

Thanks to those who helped on what turned out to be a false alarm.

reuben



