Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbVHaMYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbVHaMYK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 08:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbVHaMYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 08:24:10 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:15247 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932511AbVHaMYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 08:24:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=zd+uoFbGj2xkJeVYVgV4KNpO4tYWJkxRO3qK7GPkhs28hu8SpFUEUQX8FK/w5UyFzEnT+tZpJ5tzDgEEONxZIYY7ghsOVRWFx/JVDnQwzjBdA2nRBZjK5rQvkv22Ye/8PYsxRhTALWcVzhhtmi1n9vpiErcLiubL7Fgxc1MhbcM=  ;
Message-ID: <4315A179.8070102@yahoo.com.au>
Date: Wed, 31 Aug 2005 22:24:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Holger Kiehl <Holger.Kiehl@dwd.de>
CC: Jens Axboe <axboe@suse.de>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where is the performance bottleneck?
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de> <20050829202529.GA32214@midnight.suse.cz> <Pine.LNX.4.61.0508301919250.25574@diagnostix.dwd.de> <20050831071126.GA7502@midnight.ucw.cz> <20050831072644.GF4018@suse.de> <Pine.LNX.4.61.0508311029170.16574@diagnostix.dwd.de>
In-Reply-To: <Pine.LNX.4.61.0508311029170.16574@diagnostix.dwd.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holger Kiehl wrote:

> 3236497 total                                      1.4547
> 2507913 default_idle                             52248.1875
> 158752 shrink_zone                               43.3275
> 121584 copy_user_generic_c                      3199.5789
>  34271 __wake_up_bit                            713.9792
>  31131 __make_request                            23.1629
>  22096 scsi_request_fn                           18.4133
>  21915 rotate_reclaimable_page                   80.5699
            ^^^^^^^^^

I don't think this function should be here. This indicates that
lots of writeout is happening due to pages falling off the end
of the LRU.

There was a bug recently causing memory estimates to be wrong
on Opterons that could cause this I think.

Can you send in 2 dumps of /proc/vmstat taken 10 seconds apart
while you're writing at full speed (with 2.6.13 or the latest
-git tree).

A dump of /proc/zoneinfo and /proc/meminfo while the write is
going on would be helpful too.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
