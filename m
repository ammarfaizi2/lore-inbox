Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWEWJbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWEWJbH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 05:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWEWJbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 05:31:07 -0400
Received: from www1.cdi.cz ([194.213.194.49]:27620 "EHLO www1.cdi.cz")
	by vger.kernel.org with ESMTP id S932151AbWEWJbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 05:31:06 -0400
Message-ID: <4472D651.5010206@cdi.cz>
Date: Tue, 23 May 2006 11:30:57 +0200
From: Martin Devera <devik@cdi.cz>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: wrong in_flight diskstat in 2.6.16.1
References: <4472CD62.5060906@cdi.cz> <20060523092324.GO26261@suse.de>
In-Reply-To: <20060523092324.GO26261@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, May 23 2006, Martin Devera wrote:
>> Hello,
>>
>> I see weird output from /sys/block/sd{a,b}/stat on our AMD64-X2 smp 
>> machine with HT1000 (Broadcom) SATA with 2 WD 250GB HDDs in MD raid1. AS 
>> scheduler was used, change to noop didn't change anything. It is vanilla 
>> 2.6.16.1 and here are absolute values in hex and one second differences 
>> below:
>>
>> 132CDF 56D62 61753C0 6966BC 165A8EB 5FF5B6C 3B32D6C0 1110594C FFCA89A4 
>> FEE85878 49FF74E4
>> 132CDF 56D62 61753C0 6966BC 165A8EF 5FF5B6C 3B32D6E0 111059D0 FFCA89A1 
>> FEE85C60 79291244
>>  0: 0
>>  1: 0
>>  2: 0
>>  3: 0
>>  4: 4
>>  5: 0
>>  6: 32
>>  7: 132
>>  8: -3
>>  9: 1000
>> 10: 791256416
>>
>> As you can see in_flight is constantly negative and it is DECREASING 
>> slowly all the time.
>> I can't find any reason for it :-\
> 
> Are you using io barriers?
> 
> [PATCH] blk: fix gendisk->in_flight accounting during barrier sequence

I don't think so, I just used
mount / -o remount,barrier=0
to make it sure and it keeps decrementing. I'll however apply the patch 
(and others up to 2.6.16.18) at night (I'm not allowed to restart the 
machine just now).
thanks, Martin
