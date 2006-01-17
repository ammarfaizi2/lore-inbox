Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWAQVEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWAQVEO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 16:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWAQVEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 16:04:14 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:44974 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S932430AbWAQVEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 16:04:13 -0500
Message-ID: <43CD42DE.8040209@wolfmountaingroup.com>
Date: Tue, 17 Jan 2006 12:17:50 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Max Waterman <davidmaxwaterman+kernel@fastmail.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: io performance...
References: <43CB4CC3.4030904@fastmail.co.uk> <43CB4C03.7070304@wolfmountaingroup.com> <20060117135731.GM3945@suse.de>
In-Reply-To: <20060117135731.GM3945@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Mon, Jan 16 2006, Jeff V. Merkey wrote:
>  
>
>>Max Waterman wrote:
>>
>>    
>>
>>>Hi,
>>>
>>>I've been referred to this list from the linux-raid list.
>>>
>>>I've been playing with a RAID system, trying to obtain best bandwidth
>>>      
>>>
>>>from it.
>>    
>>
>>>I've noticed that I consistently get better (read) numbers from kernel 
>>>2.6.8
>>>than from later kernels.
>>>      
>>>
>>To open the bottlenecks, the following works well.  Jens will shoot me 
>>for recommending this,
>>but it works well.  2.6.9 so far has the highest numbers with this fix.  
>>You can manually putz
>>around with these numbers, but they are an artificial constraint if you 
>>are using RAID technology
>>that caches ad elevators requests and consolidates them.
>>
>>
>>Jeff
>>
>>
>>    
>>
>
>  
>
>>diff -Naur ./include/linux/blkdev.h ../linux-2.6.9/./include/linux/blkdev.h
>>--- ./include/linux/blkdev.h	2004-10-18 15:53:43.000000000 -0600
>>+++ ../linux-2.6.9/./include/linux/blkdev.h	2005-12-06 09:54:46.000000000 -0700
>>@@ -23,8 +23,10 @@
>> typedef struct elevator_s elevator_t;
>> struct request_pm_state;
>> 
>>-#define BLKDEV_MIN_RQ	4
>>-#define BLKDEV_MAX_RQ	128	/* Default maximum */
>>+//#define BLKDEV_MIN_RQ	4
>>+//#define BLKDEV_MAX_RQ	128	/* Default maximum */
>>+#define BLKDEV_MIN_RQ	4096
>>+#define BLKDEV_MAX_RQ	8192	/* Default maximum */
>>    
>>
>
>Yeah I could shoot you. However I'm more interested in why this is
>necessary, eg I'd like to see some numbers from you comparing:
>
>- The stock settings
>- Doing
>        # echo 8192 > /sys/block/<dev>/queue/nr_requests
>  for each drive you are accessing.
>- The kernel with your patch.
>
>If #2 and #3 don't provide very similar profiles/scores, then we have
>something to look at.
>
>The BLKDEV_MIN_RQ increase is just silly and wastes a huge amount of
>memory for no good reason.
>
>  
>
Yep. I build it into the kernel to save the trouble of sending it to 
proc. Jens recommendation
will work just fine. It has the same affect of increasing the max 
requests outstanding.

Jeff
