Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265249AbUG0NXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265249AbUG0NXl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 09:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUG0NXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 09:23:40 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:42154 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265249AbUG0NXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 09:23:23 -0400
Message-ID: <41065748.8050107@comcast.net>
Date: Tue, 27 Jul 2004 09:23:20 -0400
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Nick Piggin <nickpiggin@yahoo.com.au>,
       Jan-Frode Myklebust <janfrode@parallab.uib.no>,
       linux-kernel@vger.kernel.org
Subject: Re: OOM-killer going crazy.
References: <20040725094605.GA18324@zombie.inka.de> <41045EBE.8080708@comcast.net> <20040726091004.GA32403@ii.uib.no> <410500FD.8070206@comcast.net> <4105D7ED.5040206@yahoo.com.au> <20040727100724.GA11189@suse.de>
In-Reply-To: <20040727100724.GA11189@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Tue, Jul 27 2004, Nick Piggin wrote:
>  
>
>>Ed Sweetman wrote:
>>
>>    
>>
>>>This is not the same problem as I and other are describing.  There is 
>>>no free memory when the OOM killer activates in our situation.  The 
>>>kernel has allocated all available ram and as such, the OOM killer 
>>>can't kill the memory hog because it's the kernel, itself.  So the OOM 
>>>killer kills all the big apps running ...but it's to no use because 
>>>the kernel just keeps trying to use more until the cd is completed.   
>>>After which the memory is still never released.
>>>Your thread has nothing to do with mine.
>>>
>>>      
>>>
>>I believe it could be the same problem. Jan-Frode's system has all
>>ZONE_NORMAL memory used up. The free memory would be highmem which
>>would be unsuable for those allocations that are causing OOM.
>>
>>The vfs_cache_pressure change could possibly be responsible for the
>>problem...  I don't have the code in front of me, but I think it
>>divides by 100 first, then multiplies by vfs_cache_pressure. I
>>wouldn't have thought this would have such a large impact though.
>>    
>>
>
>Ed,
>
>Can you please try Nicks suggestion? A vm problem makes sense to me,
>what doesn't make sense is that we leak memory on some hardware while
>burning and don't on others.
>
>  
>
I tried it, i dont slow down or crash when burning the cd the first 
time. It's a small cd that doesn't take up my entire ram size, but the 
memory is still not freed. If i tried it again i would be rebooting 
right now.  I only have 70MB out of 650MB free after burning the cd.  
Cache only takes up 122MB, and buf takes up 1MB.  and i'm using 100MB of 
swap. I will run vmstat when i do it when i get home later today. 

It's not so much that the kernel is leaking memory, I think it thinks 
it's handling a pointer to data it's supposed to write to disk, but it's 
writing the wrong data, either a slightly misaligned offset or mangled 
pointer because the audio cd did write but the audio it wrote is 
unintelligable.  It almost sort of sounds like it should but it's 
completely fubared.  And i've done this with swab on and off before 
thinking the drive automatically wrote audio with SWAB on and cdrecord's 
swab was countering it or something but that was not the case.  The 
audio source files were ripped from a cd using the same drive and they 
sound good on the harddrive.  The drive seems to have no real problem 
ripping audio. Just writing it.  Normal cds show no problem as i've 
previously mentioned. 

If this is a vfs problem then i'd like to know what audio writing has to 
do with filesystems since it's raw data.  Even ignoring the mem leak 
problem that appears to manifest in different ways on different 
computers, this OOM situation only happens to me when burning audio cds, 
not data.
