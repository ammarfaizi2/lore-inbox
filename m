Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267499AbTAXCXg>; Thu, 23 Jan 2003 21:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267500AbTAXCXg>; Thu, 23 Jan 2003 21:23:36 -0500
Received: from dial-ctb04185.webone.com.au ([210.9.244.185]:16909 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S267499AbTAXCXe>;
	Thu, 23 Jan 2003 21:23:34 -0500
Message-ID: <3E30A5E3.9060005@cyberone.com.au>
Date: Fri, 24 Jan 2003 13:33:07 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: rwhron@earthlink.net, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: big ext3 sequential write improvement in 2.5.51-mm1 gone in 2.5.53-mm1?
References: <20030124012618.GA12005@rushmore> <20030123181042.025fcbbf.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>rwhron@earthlink.net wrote:
>
>>Did you add a secret sauce to 2.5.59-mm2?
>>
>
>I have not been paying any attention to the I/O scheduler changes for a
>couple of months, so I can't say exactly what caused this.  Possibly Nick's
>batch expiry logic which causes the scheduler to alternate between reading
>and writing with fairly coarse granularity.
>
Yes, however tiobench doesn't mix the two. The batch_expire helps
probably by giving longer batches between servicing expired requests.
The deadline-np-42 patch also eliminates corner cases in which requests
could be starved for a long time. A large batch_expire as in mm2 is not
a good solution without my anticipatory scheduling stuff though as
writes really starve reads.

>
>
>> 10x sequential write improvement on ext3 for multiple tiobench threads.
>>
>
>OK...  
>
>I _have_ been paying attention to the IO scheduler for the past few days. 
>-mm5 will have the first draft of the anticipatory IO scheduler.  This of
>course is yielding tremendous improvements in bandwidth when there are
>competing reads and writes.
>
>I expect it will take another week or two to get the I/O scheduler changes
>really settled down.  Your assistance in thoroughly benching that would be
>appreciated.
>
>
>>2.4.20aa1     8.24  7.21%    28.587   449134.11  0.10395  0.07086    114
>>2.5.59        9.50  5.50%    36.703     4310.62  0.00000  0.00000    173
>>2.5.59-mm2   35.28 17.69%    10.173    18950.56  0.01010  0.00000    199
>>
>
>boggle.
>
I'm happy with that as long as they aren't too dependant on the phase of
the moon. The initial deadline scheduler had quite a lot of problems with
these workloads.

