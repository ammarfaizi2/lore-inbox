Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316623AbSEVSAH>; Wed, 22 May 2002 14:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316624AbSEVSAG>; Wed, 22 May 2002 14:00:06 -0400
Received: from [195.63.194.11] ([195.63.194.11]:54546 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316623AbSEVSAF>; Wed, 22 May 2002 14:00:05 -0400
Message-ID: <3CEBCDCA.8030905@evision-ventures.com>
Date: Wed, 22 May 2002 18:56:42 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jan Kara <jack@suse.cz>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Russell King <rmk@arm.linux.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
In-Reply-To: <Pine.LNX.4.44.0205220901430.7580-100000@home.transmeta.com> <3CEBB385.5040904@evision-ventures.com> <20020522165834.GD12982@atrey.karlin.mff.cuni.cz> <3CEBC29B.2050601@evision-ventures.com> <20020522175636.GB24755@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Jan Kara napisa?:
>>Uz.ytkownik Jan Kara napisa?:
>>
>>>>Uz.ytkownik Linus Torvalds napisa?:
>>>>
>>>>
>>>>>On Wed, 22 May 2002, Russell King wrote:
>>>>>
>>>>>
>>>>>
>>>>>>/proc/sys has a clean and clear purpose.
>>>>>
>>>>>
>>>>>Yes, but it _:would_ be good to make the quota stuff use the existign
>>>>>helper functions to make it much cleaner.
>>>>>
>>>>>And some of those helper functions are definitely from sysctl's: 
>>>>>splitting
>>>>>up the quota file into multiple sysctls (_and_ moving it to /proc/sys/fs)
>>>>>sounds like a good idea to me.
>>>>
>>>>Well I'm actually coding this right now :-).
>>>
>>> Thanks. I'll update quota tools to use your new files if you send me
>>>new layout of interface...
>>
>>I'm not ready right now but...
>>Well actually I went the cheapest way possible:
>>
>>
>>Here is the layout of the /proc/sys/fs/dquotas array:
>>
>>/*
>> * Statistics about disc quota.
>> */
>>enum {
>>	DQSTATS_LOOKUPS,
>>	DQSTATS_DROPS,
>>	DQSTATS_READS,
>>	DQSTATS_WRITES,
>>	DQSTATS_CACHE_HITS,
>>	DQSTATS_ALLOCATED, // formerly known as nr_dquts inside kernel.
>>	DQSTATS_FREE,       // formerly known as nr_free_dquots inside 
>>	kernel.
>>	DQSTATS_SYNCS,
>>	DQSTATS_SIZE
>>};
>>
>>extern __u32 dqstats_array[DQSTATS_SIZE];
>>
>>And here is the allocated sysctl id number:
>>
>>	FS_DQSTATS=16,	/* int: disc quota suage statistics *
>>
>>All of this appears under:
>>
>>static ctl_table fs_table[] = {
>>	{FS_DQSTATS, "dqstats", dqstats_array, sizeof(dqstats_array), 0444, 
>>	NULL, &proc_dointvec},
>>	{},
>>};
>>
>>inside /proc/sys/fs/dqstats
>>
>>I dodn't think the particular fields are subject to change soon
>>so I wen't for the array.
>>If yes - please feel rather free to complain :-).
>>Switch over to sysctl() and see the client code
>>melting down :-).
> 
>   The array is OK (I don't expect any changes in statistics too).
> I'd just like to have that 'version' and 'formats' fields somewhere.
> Otherwise it's rather hard for quota tools to recognize quota
> interface...

You have the sysctl id number for this purpose and the /proc/sys/fs file
name is right now unique. So there is no need for more
treatment here then just trying to stick to what we get once it's there.
The versioning of syscall returns I will just preserve.

Going through sysctl *will be much easier* in code
then fs lookup of the file above.

