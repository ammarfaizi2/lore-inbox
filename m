Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262719AbUD2B3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbUD2B3t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 21:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbUD2B3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 21:29:48 -0400
Received: from mail.fastclick.com ([205.180.85.17]:64128 "EHLO
	mail.fastclick.net") by vger.kernel.org with ESMTP id S262719AbUD2B3K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 21:29:10 -0400
Message-ID: <40905A5E.5000807@fastclick.com>
Date: Wed, 28 Apr 2004 18:29:02 -0700
From: "Brett E." <brettspamacct@fastclick.com>
Reply-To: brettspamacct@fastclick.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <409021D3.4060305@fastclick.com>	<20040428170106.122fd94e.akpm@osdl.org>	<40904FD8.7020208@fastclick.com> <20040428181319.601decfc.akpm@osdl.org>
In-Reply-To: <20040428181319.601decfc.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> "Brett E." <brettspamacct@fastclick.com> wrote:
> 
>>>I see no swapout from the info which you sent.
>>
>> pgpgout/s gives the total number of blocks paged out to disk per second, 
>> it peaks at 13,000 and hovers around 3,000 per the attachment.
> 
> 
> Nope.  pgpgout is simply writes to disk, of all types.
That is what is confusing me.. From the sar man page:

pgpgin/s
     Total number of kilobytes the system paged in from disk per second.

pgpgout/s
     Total number of kilobytes the system paged out to disk per second.



> 
> swapout is accounted for under pswpout and your vmstat trace shows a little
> bit of (healthy) swapout with swappiness=100 and negligible swapout with
> swappiness=0.  In both cases, negligible swapin.  That's all just fine.
> 
> 
>> Swapping out is good, but when that's coupled with swapping in as is the 
>> case on my side, it creates a thrashing situation where we swap out to 
>> disk pages which are being used, we then immediately swap those pages 
>> back in, etc etc..
> 
> 
> Look at your "si" column in vmstat.  It's practically all zeroes.
> 
> 
>> The usage pattern by the way is on a server which continuously hits a 
>> database and reads files so I don't know what "swappiness" should be set 
>> to exactly.  Every hour or so it wants to untar tarballs and by then the 
>> cache is large. From here, the system swaps in and out more while cache 
>> decreases. Basically, it should do what I believe Solaris does... simply 
>> reclaim cache and not swap.  Capping cache would be good too but the 
>> best solution IMO is to simply reclaim the cache on an as-needed basis 
>> before thinking about swapping.
> 
> 
> swappiness=100: swaps a lot.  swappiness=0: doesn't swap much.
> 
> With a funny workload like that you might choose to set swappiness to 0
> just around the hourly tar operation, but as the machine seems to not be
> swapping there doesn't seem to be a need.

Yeah, it wouldn't help if paging isn't the problem. I'd like more 
clarificaton on sar before I throw out paging being the culprit.


