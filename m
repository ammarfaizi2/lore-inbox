Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422996AbWJVFMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422996AbWJVFMq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 01:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422997AbWJVFMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 01:12:46 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:48513 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1422996AbWJVFMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 01:12:46 -0400
Message-ID: <453AFE24.706@oracle.com>
Date: Sat, 21 Oct 2006 22:14:12 -0700
From: "Randy.Dunlap" <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] raid: fix printk format warnings
References: <20061021113406.535d8243.randy.dunlap@oracle.com> <17722.60989.448470.587430@cse.unsw.edu.au>
In-Reply-To: <17722.60989.448470.587430@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Saturday October 21, randy.dunlap@oracle.com wrote:
>> From: Randy Dunlap <randy.dunlap@oracle.com>
>>
>> Fix printk format warnings, seen on powerpc64:
>> drivers/md/raid1.c:1479: warning: long long unsigned int format, long unsigned int arg (arg 4)
>> drivers/md/raid10.c:1475: warning: long long unsigned int format, long unsigned int arg (arg 4)
>>
>> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
>> ---
>>
>>  drivers/md/raid1.c  |    4 ++--
>>  drivers/md/raid10.c |    4 ++--
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff -Naurp linux-2619-rc2g4/drivers/md/raid1.c~raid_printk linux-2619-rc2g4/drivers/md/raid1.c
>> --- linux-2619-rc2g4/drivers/md/raid1.c~raid_printk	2006-10-21 11:16:30.066109000 -0700
>> +++ linux-2619-rc2g4/drivers/md/raid1.c	2006-10-21 11:20:57.288004000 -0700
>> @@ -1474,8 +1474,8 @@ static void fix_read_error(conf_t *conf,
>>  					       "raid1:%s: read error corrected "
>>  					       "(%d sectors at %llu on %s)\n",
>>  					       mdname(mddev), s,
>> -					       (unsigned long long)sect +
>> -					           rdev->data_offset,
>> +					       (unsigned long long)(sect +
>> +					           rdev->data_offset),
>>  					       bdevname(rdev->bdev,
>> b));
> 
> So you're saying that if you add an 'unsigned long long int' to an
> 'unsigned long int', the result is an 'unsigned long int'???
> That is not what I would have expected.
> I'm happy with the patch, but I'm very surprised that it is needed.
> Is this behaviour consistent across various versions of gcc (if it is
> convenient to check)??

I've only seen it on powerpc64.  It could well be a gcc problem AFAICT.
Feel free to drop it.  Thanks for the discussion.

gfs2 and DLM also produce about 10-12 of these warnings IIRC (still on
powerpc64).

-- 
~Randy
