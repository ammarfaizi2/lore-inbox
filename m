Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbVIEHkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbVIEHkk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 03:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbVIEHkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 03:40:40 -0400
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27]:50705 "EHLO
	smtp-vbr7.xs4all.nl") by vger.kernel.org with ESMTP id S932264AbVIEHkk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 03:40:40 -0400
Message-ID: <431BF66D.4010804@baanhofman.nl>
Date: Mon, 05 Sep 2005 09:40:29 +0200
From: Wilco Baan Hofman <wilco@baanhofman.nl>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: RAID1 ramdisk patch
References: <431B9558.1070900@baanhofman.nl> <17179.40731.907114.194935@cse.unsw.edu.au>
In-Reply-To: <17179.40731.907114.194935@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:

>On Monday September 5, wilco@baanhofman.nl wrote:
>  
>
>>Hi all,
>>
>>I have written a small patch for use with a HDD-backed ramdisk in the md 
>>raid1 driver. The raid1 driver usually does read balancing on the disks, 
>>but I feel that if it encounters a single ram disk in the array that 
>>should be the preferred read disk. The application of this would be for 
>>example a 2GB ram disk in raid1 with a 2GB partition, where the ram disk 
>>is used for reading and both 'disks' used for writing.
>>
>>Attached is a bit of code which checks for a ram-disk and sets it as 
>>preferred disk. It also checks if the ram disk is in sync before 
>>allowing the read.
>>    
>>
>
>Hi,
> equivalent functionality is now available in 2.6-mm and is referred
> to as 'write mostly'.
> If you use mdadm-2.0 and mark a device as --write-mostly, then all
> read requests will go to the other device(s) if possible,.
> e.g.
>   mdadm --create /dev/md0 --level=1 --raid-disks=2 /dev/ramdisk \
>      --writemostly /dev/realdisk
>
> Does this suit your needs?
>
> You can also arrange for the write to the writemostly device to be
> 'write-behind' so that the filesystem doesn't wait for the write to
> complete.  This can reduce write-latency (though not increase write
> throughput) at a very small cost of reliability (if the RAM dies, the
> disk may not be 100% up-to-date).
>
>NeilBrown
>
>  
>
I was looking for that (but couldn't find it)..

At this point I don't see why it wouldn't, if that also syncs from the 
partition then it's basically the same functionality, but written from a 
different perspective.

To use it I'll have to deviate from stock linux and use a non-packaged 
mdadm, but that is better than applying my patch every kernel update ;-)

Thanks, I'll look into it.

Wilco Baan Hofman
