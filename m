Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbWAWXC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWAWXC0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 18:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbWAWXC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 18:02:26 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:59814 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964978AbWAWXCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 18:02:25 -0500
Message-ID: <0ad101c62071$261ebde0$03c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: "Neil Brown" <neilb@suse.de>
Cc: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
References: <20060117174531.27739.patches@notabene> <20060121234234.A32306@mail.kroptech.com> <17364.3266.29943.914861@cse.unsw.edu.au>
Subject: Re: [PATCH 000 of 5] md: Introduction
Date: Mon, 23 Jan 2006 18:02:56 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Saturday January 21, akropel1@rochester.rr.com wrote:
>> On the first try I neglected to read the directions and increased the
>> number of devices first (which worked) and then attempted to add the
>> physical device (which didn't work; at least not the way I intended).
>
> Thanks, this is exactly the sort of feedback I was hoping for - people
> testing thing that I didn't think to...
>
>>   mdadm --create -l5 -n3 /dev/md0 /dev/sda /dev/sdb /dev/sdc
>>
>>     md0 : active raid5 sda[0] sdc[2] sdb[1]
>>           2097024 blocks level 5, 64k chunk, algorithm 2 [3/3] [UUU]
>>
>>   mdadm --grow -n4 /dev/md0
>>
>>     md0 : active raid5 sda[0] sdc[2] sdb[1]
>>           3145536 blocks level 5, 64k chunk, algorithm 2 [4/3] [UUU_]
>
> I assume that no "resync" started at this point?  It should have done.

Actually, it did start a resync. Sorry, I should have mentioned that. I 
waited until the resync completed before I issued the 'mdadm --add' 
command.

>>     md0 : active raid5 sdd[3] sdc[2] sdb[1] sda[0]
>>           2097024 blocks level 5, 64k chunk, algorithm 2 [4/4] [UUUU]
>>                                 ...should this be... --> [4/3]
>> [UUU_] perhaps?
>
> Well, part of the array is "4/4 UUUU" and part is "3/3 UUU".  How do
> you represent that?  I think "4/4 UUUU" is best.

I see your point. I was expecting some indication that that my array was 
vulnerable and that the new disk was not fully utilized yet. I guess the 
resync in progress indicator is sufficient.

>> My final test was a repeat of #2, but with data actively being
>> written
>> to the array during the reshape (the previous tests were on an idle,
>> unmounted array). This one failed pretty hard, with several processes
>> ending up in the D state.
>
> Hmmm... I tried similar things but didn't get this deadlock.  Somehow
> the fact that mdadm is holding the reconfig_sem semaphore means that
> some IO cannot proceed and so mdadm cannot grab and resize all the
> stripe heads... I'll have to look more deeply into this.

For what it's worth, I'm using the Buslogic SCSI driver for the disks in 
the array.

>> I'm happy to do more tests. It's easy to conjur up virtual disks and
>> load them with irrelevant data (like kernel trees ;)
>
> Great.  I'll probably be putting out a new patch set  late this week
> or early next.  Hopefully it will fix the issues you can found and you
> can try it again..

Looking forward to it...

--Adam

