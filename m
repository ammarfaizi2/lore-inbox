Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319497AbSIMCHc>; Thu, 12 Sep 2002 22:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319501AbSIMCHc>; Thu, 12 Sep 2002 22:07:32 -0400
Received: from host.greatconnect.com ([209.239.40.135]:17427 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S319497AbSIMCHa>; Thu, 12 Sep 2002 22:07:30 -0400
Message-ID: <3D8149F1.4010008@rackable.com>
Date: Thu, 12 Sep 2002 19:14:09 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Lord <lord@sgi.com>
CC: Andrea Arcangeli <andrea@suse.de>, Austin Gonyou <austin@coremetrics.com>,
       Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
Subject: Re: 2.4.20pre5aa2
References: <20020911201602.A13655@pc9391.uni-regensburg.de>	<1031768655.24629.23.camel@UberGeek.coremetrics.com>	<20020911184111.GY17868@dualathlon.random> <3D81235B.6080809@rackable.com> 	<20020913002316.GG11605@dualathlon.random> <1031878070.1236.29.camel@snafu> <3D813EE8.6090700@rackable.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Stephen is there any reason to leave the system in it's current state? 
 (IE You guys want the output of some tool.)  Or shall I give it a go at 
a kernel  with CONFIG_3GB, and maybe play with vmalloc settings?

Samuel Flory wrote:

> Stephen Lord wrote:
>
>> On Thu, 2002-09-12 at 19:23, Andrea Arcangeli wrote:
>>  
>>
>>> that seems a bug in xfs, it BUG() if vmap fails, it must not BUG(), it
>>> must return -ENOMEM to userspace instead, or it can try to recollect 
>>> and
>>> release some of the other vmalloced entries. Most probably you run into
>>> an address space shortage, not a real ram shortage, so to workaround it
>>> you can recompile with CONFIG_2G and it'll probably work, also dropping
>>> the gap page in vmalloc may help workaround it (there's no config 
>>> option
>>> for it though). It could be also a vmap leak, maybe a missing vfree,
>>> just some idea.
>>>
>>>   
>>
>>
>> We hold vmalloced space for very short periods of time, in fact
>> filesystem recovery and large extended attributes are the only
>> cases. In this case we should be attempting to remap 2 pages
>> together. The only way out of this would be to fail the whole
>> mount at this point. I suspect a leak elsewhere.
>>
>> Samuel, when you mounted xfs and it oopsed, was it shortly after bootup?
>>
>
>  Yes I'd just logged in and manually mounted it.
>
>> Also, how far did your dbench run get before it hung? I tried the
>> kernel, but I paniced during startup - then I realized I did not 
>> apply the patch to fix the xfs/scheduler interactions first.
>>  
>>
> It looked around 1/4 to 1/2 done with dbench 32.  I'm not sure if it 
> was the 1st or second run.  I run dbench from a script:
> sync
> sync
> ./dbench 2
> sync
> sync
> ./dbench 4
> sync
> sync
> ./dbench 8
> sync
> sync
> ./dbench 16
> sync
> sync
> ./dbench 32
> sync
> sync
> ./dbench 64
> sync
> sync
> <repeats >
>
>  I generally use this script narrow down which configurations seem to 
> be most promising.
>
>> How much memory is in the machine by the way?
>
> 4G ram, and 4G swap.
>
>
>
>


