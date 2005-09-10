Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030399AbVIJAMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030399AbVIJAMs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 20:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbVIJAMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 20:12:48 -0400
Received: from ppp59-167.lns1.cbr1.internode.on.net ([59.167.59.167]:53522
	"EHLO triton.bird.org") by vger.kernel.org with ESMTP
	id S1030399AbVIJAMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 20:12:48 -0400
Message-ID: <432225E0.9030606@acquerra.com.au>
Date: Sat, 10 Sep 2005 10:16:32 +1000
From: Anthony Wesley <awesley@acquerra.com.au>
Reply-To: awesley@acquerra.com.au
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nate.diller@gmail.com
CC: Roger Heflin <rheflin@atipa.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.13 buffer strangeness
References: <432151B0.7030603@acquerra.com.au>	 <EXCHG2003Zi71mrvoGd00000659@EXCHG2003.microtech-ks.com> <5c49b0ed05090914394dba42bf@mail.gmail.com>
In-Reply-To: <5c49b0ed05090914394dba42bf@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nate and Roger,

First off, thanks fo taking some time to answer my call for help :-)

I've already spent some time fiddling with dirty_ratio before I posted my question - yes, I can make different things happen by increasing or decreasing it, but overall I still have the same problem - my video streaming runs out of steam after at most 50 seconds instead of the 3 minutes that I think it should take.

Setting dirty_ratio and dirty_background_ratio to 15/10 respectively makes things worse, I hit the wall after only about 25 seconds.

Setting dirty_ratio and dirty_background_ratio to 85/80 makes things worse - disk writes start after about 15 seconds and I hit the wall after about 35 seconds.

Setting dirty_ratio and dirty_background_ratio to 90/10 puts me back at around 50 seconds, i.e. where I started.

So as far as I can see there is *no way* to get 3 minutes worth of buffering by adjusting these parameters.

Just to remind everyone - I have video data coming in at 25MBytes/sec and I am writing it out to a usb2 hard disk that can sustain 17MBytes/sec. I want my video capture to run at full speed as long as possible by having the 7MBytes/sec deficit slowly eat up the available RAM in the machine. I have 1.5Gb of RAM, 1.3Gb available for buffers, so this should take 3 minutes to consume at 7MBytes/sec.

So, I've tried all the combinations on dirty_ratio and dirty_background_ratio and they *do not help*.

Can anyone suggest something else that I might try? The goal is to have 25MBytes/sec streaming video for about 3 minutes. 

Or is this simply not possible with the current kernel I/O setup? Do I have to do something elaborate myself, like build a big RAM buffer, mount the disk synchronous, do the buffering myself in userland...??

regards, Anthony

Nate Diller wrote:

> On 9/9/05, Roger Heflin <rheflin@atipa.com> wrote:
> 
>>I saw it mentioned before that the kernel only allows a certain
>>percentage of total memory to be dirty, I thought the number was
>>around 40%, and I have seen machines with large amounts of ram,
>>hit the 40% and then put the writing application into disk wait
>>until certain amounts of things are written out, and then take
>>it out of disk wait, and repeat when it again hits 40%, given your
>>rate different it would be close to 40% in 50seconds.
>>
> 
> yes, on 2.6 there are two tunables which are important here. 
> dirty_background_ratio is the threshold where the kernel will begin
> flushing dirty buffers, so it should change how soon the disk becomes
> active.  dirty_ratio changes when the write-throttling code kicks in,
> which is what Anthony is seeing.  The purpose of the write throttling
> code is to limit the dirtying process to disk bandwidth, so that is a
> Feature.  Anthony, try *increasing* dirty_ratio, you can go up to 100,
> but you could trigger an OOM if you let it get too high, so maybe try
> setting it at 85 or so.  This should effectively disable the write
> throttling and give you the bandwidth you want.
> 
> NATE
> 
> 
>>And I think that you mean MB(yte) not Mb(it).
>>
>>                           Roger
>>
>>
>>>-----Original Message-----
>>>From: linux-kernel-owner@vger.kernel.org 
>>>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>>>Anthony Wesley
>>>Sent: Friday, September 09, 2005 4:11 AM
>>>To: linux-kernel@vger.kernel.org
>>>Subject: Re: kernel 2.6.13 buffer strangeness
>>>
>>>Thanks David, but if you read my original post in full you'll 
>>>see that I've tried that, and while I can start the write out 
>>>sooner by lowering /proc/sys/vm/dirty_ratio , it makes no 
>>>difference to the results that I am getting. I still seem to 
>>>run out of steam after only 50 seconds where it should take 
>>>about 3 minutes.
>>>
>>>regards, Anthony
>>>
>>>--
>>>Anthony Wesley
>>>Director and IT/Network Consultant
>>>Smart Networks Pty Ltd
>>>Acquerra Pty Ltd
>>>
>>>Anthony.Wesley@acquerra.com.au
>>>Phone: (02) 62595404 or 0419409836
>>>
>>>-
>>>To unsubscribe from this list: send the line "unsubscribe 
>>>linux-kernel" in the body of a message to 
>>>majordomo@vger.kernel.org More majordomo info at  
>>>http://vger.kernel.org/majordomo-info.html
>>>Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
> 
> 

-- 
Anthony Wesley
Director and IT/Network Consultant
Smart Networks Pty Ltd
Acquerra Pty Ltd

Anthony.Wesley@acquerra.com.au
Phone: (02) 62595404 or 0419409836
