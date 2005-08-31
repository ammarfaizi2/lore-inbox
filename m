Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbVHaTAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbVHaTAP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 15:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbVHaTAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 15:00:15 -0400
Received: from dwdmx4.dwd.de ([141.38.3.230]:9442 "EHLO dwdmx4.dwd.de")
	by vger.kernel.org with ESMTP id S932517AbVHaTAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 15:00:13 -0400
Date: Wed, 31 Aug 2005 19:00:12 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@diagnostix.dwd.de
To: Jens Axboe <axboe@suse.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where is the performance bottleneck?
In-Reply-To: <20050831173525.GJ4018@suse.de>
Message-ID: <Pine.LNX.4.61.0508311846220.16574@diagnostix.dwd.de>
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de>
 <20050829202529.GA32214@midnight.suse.cz> <Pine.LNX.4.61.0508301919250.25574@diagnostix.dwd.de>
 <20050831071126.GA7502@midnight.ucw.cz> <20050831072644.GF4018@suse.de>
 <Pine.LNX.4.61.0508311029170.16574@diagnostix.dwd.de> <20050831120714.GT4018@suse.de>
 <Pine.LNX.4.61.0508311339140.16574@diagnostix.dwd.de> <20050831162053.GG4018@suse.de>
 <Pine.LNX.4.61.0508311648390.16574@diagnostix.dwd.de> <20050831173525.GJ4018@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2005, Jens Axboe wrote:

> On Wed, Aug 31 2005, Holger Kiehl wrote:
>>> # ./oread /dev/sdX
>>>
>>> and it will read 128k chunks direct from that device. Run on the same
>>> drives as above, reply with the vmstat info again.
>>>
>> Using kernel 2.6.12.5 again, here the results:
>
> [snip]
>
> Ok, reads as expected, like the buffered io but using less system time.
> And you are still 1/3 off the target data rate, hmmm...
>
> With the reads, how does the aggregate bandwidth look when you add
> 'clients'? Same as with writes, gradually decreasing per-device
> throughput?
>
I performed the following tests with this command:

    dd if=/dev/sd?1 of=/dev/null bs=256k count=78125

Single disk tests:

    /dev/sdc1 74.954715 MB/s
    /dev/sdg1 74.973417 MB/s

Following disks in parallel:

    2 disks on same channel
    /dev/sdc1 75.034191 MB/s
    /dev/sdd1 74.984643 MB/s

    3 disks on same channel
    /dev/sdc1 75.027850 MB/s
    /dev/sdd1 74.976583 MB/s
    /dev/sde1 75.278276 MB/s

    4 disks on same channel
    /dev/sdc1 58.343166 MB/s
    /dev/sdd1 62.993059 MB/s
    /dev/sde1 66.940569 MB/s
    /dev/sdd1 70.986072 MB/s

    2 disks on different channels
    /dev/sdc1 74.954715 MB/s
    /dev/sdg1 74.973417 MB/s

    4 disks on different channels
    /dev/sdc1 74.959030 MB/s
    /dev/sdd1 74.877703 MB/s
    /dev/sdg1 75.009697 MB/s
    /dev/sdh1 75.028138 MB/s

    6 disks on different channels
    /dev/sdc1 49.640743 MB/s
    /dev/sdd1 55.935419 MB/s
    /dev/sde1 58.795241 MB/s
    /dev/sdg1 50.280864 MB/s
    /dev/sdh1 54.210705 MB/s
    /dev/sdi1 59.413176 MB/s

So this looks different from writting, only as of four disks does the
performance begin to drop.

I just noticed, did you want me to do these test with the oread program?

Thanks,
Holger

