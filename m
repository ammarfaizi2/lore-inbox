Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbVHaV6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbVHaV6G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 17:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbVHaV6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 17:58:06 -0400
Received: from dwdmx4.dwd.de ([141.38.3.230]:43947 "EHLO dwdmx4.dwd.de")
	by vger.kernel.org with ESMTP id S932536AbVHaV6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 17:58:04 -0400
Date: Wed, 31 Aug 2005 21:57:32 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@diagnostix.dwd.de
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Jens Axboe <axboe@suse.de>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where is the performance bottleneck?
In-Reply-To: <4315E810.4030305@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0508312148040.1081@diagnostix.dwd.de>
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de>
 <20050829202529.GA32214@midnight.suse.cz> <Pine.LNX.4.61.0508301919250.25574@diagnostix.dwd.de>
 <20050831071126.GA7502@midnight.ucw.cz> <20050831072644.GF4018@suse.de>
 <Pine.LNX.4.61.0508311029170.16574@diagnostix.dwd.de> <4315A179.8070102@yahoo.com.au>
 <Pine.LNX.4.61.0508311524190.16574@diagnostix.dwd.de> <4315E810.4030305@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Sep 2005, Nick Piggin wrote:

> Holger Kiehl wrote:
>
>> meminfo.dump:
>> 
>>    MemTotal:      8124172 kB
>>    MemFree:         23564 kB
>>    Buffers:       7825944 kB
>>    Cached:          19216 kB
>>    SwapCached:          0 kB
>>    Active:          25708 kB
>>    Inactive:      7835548 kB
>>    HighTotal:           0 kB
>>    HighFree:            0 kB
>>    LowTotal:      8124172 kB
>>    LowFree:         23564 kB
>>    SwapTotal:    15631160 kB
>>    SwapFree:     15631160 kB
>>    Dirty:         3145604 kB
>
> Hmm OK, dirty memory is pinned pretty much exactly on dirty_ratio
> so maybe I've just led you on a goose chase.
>
> You could
>    echo 5 > /proc/sys/vm/dirty_background_ratio
>    echo 10 > /proc/sys/vm/dirty_ratio
>
> To further reduce dirty memory in the system, however this is
> a long shot, so please continue your interaction with the
> other people in the thread first.
>
Yes, this does make a difference, here the results of running

   dd if=/dev/full of=/dev/sd?1 bs=4M count=4883

on 8 disks at the same time:

   34.273340
   33.938829
   33.598469
   32.970575
   32.841351
   32.723988
   31.559880
   29.778112

That's 32.710568 MB/s on average per disk with your change and without
it it was 24.958557 MB/s on average per disk.

I will do more tests tomorrow.

Thanks,
Holger

