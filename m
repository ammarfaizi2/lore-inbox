Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267425AbUHXCKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267425AbUHXCKA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 22:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269077AbUHXCI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 22:08:29 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:39329 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268194AbUHXCFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 22:05:48 -0400
Message-ID: <412AA25E.8060509@yahoo.com.au>
Date: Tue, 24 Aug 2004 12:05:18 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Massimo Cetra <mcetra@navynet.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: Production comparison between 2.4.27 and 2.6.8.1
References: <000001c48906$d70bf270$0600640a@guendalin>
In-Reply-To: <000001c48906$d70bf270$0600640a@guendalin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Massimo Cetra wrote:
> Nick Piggin wrote:
> 
>>>#**********************************************
>>>It is my first experience with 2.6 branch kernels, because 
>>
>>i am trying 
>>
>>>to figure out if the tree is performing well to switch 
>>
>>everithing in 
>>
>>>production, so my ideas may be wrong...
>>>
>>>Raid tests may be faked because of the overhead caused by 
>>
>>md sync (and 
>>
>>>probably raid is better on 2.6). However it seems that libsata has 
>>>better performance on 2.4 (hdparm) xfs tests shows that 2.4 
>>
>>has better 
>>
>>>performance if compared to 2.6 and the difference, in my 
>>
>>opinion, is 
>>
>>>not linked on libsata better performance.
>>>
>>>What is your opinion ?
>>>What can I try to improve performance ?
>>>
>>
>>I wouldn't worry too much about hdparm measurements. If you 
>>want to test the streaming throughput of the disk, run dd 
>>if=big-file of=/dev/null or a large write+sync.
>>
>>Regarding your worse non-RAID XFS database results, try 
>>booting 2.6 with elevator=deadline and test again. If yes, 
>>are you using queueing (TCQ) on your disks?
> 
> 
> 
> Tried even with 2.6.8.1-mm and 2.6.8.1-ck
> No performance improvement.
> 
>>From Documentation/block/as-iosched.txt i read:
> 
> #--------------------------------------
> Attention! Database servers, especially those using "TCQ" disks should
> investigate performance with the 'deadline' IO scheduler. Any system
> with high
> disk performance requirements should do so, in fact.
> 
> If you see unusual performance characteristics of your disk systems, or
> you
> see big performance regressions versus the deadline scheduler, please
> email
> me. Database users don't bother unless you're willing to test a lot of
> patches
> from me ;) its a known issue.
> #--------------------------------------
> 
> So it's probably known that 2.6 performance with databases and heavy HD
> access is an issue.
> I don't believe that 2.6.x tree is performing as well as 2.4.x(-lck) on
> server tasks.
> 
> Is this issue being analyzed ?
> Should we hope in an improvement sometime?
> Or I'll have to use 2.4 to have good performance ?
> 

You booted with elevator=deadline and things still didn't improve
though, correct? If so, then the problem should be found and fixed.
