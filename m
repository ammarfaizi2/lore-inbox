Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291372AbSBMMgN>; Wed, 13 Feb 2002 07:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291611AbSBMMgE>; Wed, 13 Feb 2002 07:36:04 -0500
Received: from [195.63.194.11] ([195.63.194.11]:35847 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291372AbSBMMfz>; Wed, 13 Feb 2002 07:35:55 -0500
Message-ID: <3C6A5D99.1040102@evision-ventures.com>
Date: Wed, 13 Feb 2002 13:35:37 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
        Jens Axboe <axboe@suse.de>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
In-Reply-To: <20020211221102.GA131@elf.ucw.cz> <3C68F3F3.8030709@evision-ventures.com> <20020212132846.A7966@suse.cz> <3C690E56.3070606@evision-ventures.com> <20020212135701.A16420@suse.cz> <3C6915FC.2020707@evision-ventures.com> <20020212144300.A18431@suse.cz> <3C691F9C.10303@evision-ventures.com> <20020212154251.A25201@suse.cz> <3C693357.8000204@evision-ventures.com> <20020212112803.P9826@lynx.turbolabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

>On Feb 12, 2002  16:23 +0100, Martin Dalecki wrote:
>
>>>The later (lv_disk_t) struct isn't used anywhere in the kernel -
>>>probably defined for userspace only? That's weird! And also many other
>>>structs in lvm.h are nowhere to be found used. Guess we could swipe them
>>>out as well.
>>>
>>>The first lv_read_ahead (in lv_t) removed. And references to it as well.
>>>
>>Yes I know the lvm coders where too deaf to separate user level 
>>structure layout properly from on disk and kernel space by using just
>>different header files for different purposes.  And then they tryed
>>apparently to embarce anything they could think off, without really
>>thinking hard about what should be there and what shouldn't. It was too 
>>hard for them to have a sneak view on for example Solaris to recognize
>>what's really needed.
>>
>
>>diff -ur linux-2.5.4/include/linux/lvm.h linux/include/linux/lvm.h
>>--- linux-2.5.4/include/linux/lvm.h	Mon Feb 11 02:50:08 2002
>>+++ linux/include/linux/lvm.h	Tue Feb 12 15:52:45 2002
>>@@ -498,7 +498,6 @@
>> 	uint lv_badblock;	/* for future use */
>> 	uint lv_allocation;
>> 	uint lv_io_timeout;	/* for future use */
>>-	uint lv_read_ahead;
>> 
>> 	/* delta to version 1 starts here */
>>        struct lv_v5 *lv_snapshot_org;
>>
>
>Yes, this is true, but since this struct is passed between the kernel
>and user space you can't just delete it, or everyone using LVM has a
>broken system and may not even be able to boot if they have root on
>LVM.  Feel free to delete the code which actually uses this field, but
>don't remove it from the struct unless you are willing to fix the user
>space code also.
>
Please note that there are two structs there: One of them is tagged /* 
core */ and another
of them is tagged as beeing /* disk */. The driver does only touch the 
core version, which is
supposedly only to be used by the driver itself. This is what I was 
complaining about in first
place: Why is the driver's internal struct exposed there at all

All right?


