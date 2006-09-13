Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751506AbWIMCcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbWIMCcy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 22:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWIMCcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 22:32:54 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:34996 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751506AbWIMCcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 22:32:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=KLcIfWdA+99ZEisVUs1ssql/sC1lix9JMH2KidjvKrTf6rBAY6qc/W4EwM1xhsvX4CC65OrHhwyd7MBlcVC6X2tIw0Rla999qA0/Q5U9CTNcfer5P27A6nrhatyMTC2FABMEJNH/trUUiadaxHYSfPaSPQcsLBl+/SEkdSDoCIY=  ;
Message-ID: <45076DC9.2090404@yahoo.com.au>
Date: Wed, 13 Sep 2006 12:32:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Guennadi Liakhovetski <gl@dsa-ac.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.17.4] slabinfo.buffer_head increases
References: <Pine.LNX.4.63.0607101023450.27628@pcgl.dsa-ac.de> <Pine.LNX.4.63.0607101412250.27628@pcgl.dsa-ac.de> <Pine.LNX.4.63.0609061341150.1700@pcgl.dsa-ac.de> <45061FCB.1000402@yahoo.com.au> <Pine.LNX.4.63.0609120933450.1700@pcgl.dsa-ac.de>
In-Reply-To: <Pine.LNX.4.63.0609120933450.1700@pcgl.dsa-ac.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski wrote:
> On Tue, 12 Sep 2006, Nick Piggin wrote:
> 
>> Guennadi Liakhovetski wrote:
>>
>>>> On Mon, 10 Jul 2006, Guennadi Liakhovetski wrote:
>>>>
>>>>> I am obsering a steadily increasing buffer_head value in slabinfo 
>>>>> under
>>>>> 2.6.17.4. I searched the net / archives and didn't find anything
>>>>> directly relevant. Does anyone have an idea or how shall we debug it?
>>>>
>>>>
>>>
>>> The problem is still there under 2.6.18-rc2. I narrowed it down to 
>>> ext3 journal. To reproduce one just has to mount an ext3 partition 
>>> and perform (write) accesses to it. A loop { touch /mnt/foo; sleep 1; 
>>> } suffices - just let it run for a couple of minutes and monitor 
>>> buffer_head in /proc/slabinfo. If you mount it as ext2 the problem is 
>>> gone.
>>
>>
>>
>> What data mode is ext3 mounted with?
> 
> 
> Default, i.e., ordered, I guess.
> 
>> Is the memory reclaimable? If yes, is it a problem?
> 
> 
> Yes, that's why I later wrote that the problem is not real. It was hard 
> to see as we had a lot of free RAM on the system, the system was idle 
> apart from one script that only did "touch x" periodically with the same 
> "x" and the buffer_head slab was growing very steadily. Unlike with ext2 
> / reiserfs. That's why I decided it was not ok. But the memory is 
> reclaimable, so, seems like not a problem. Just a bit odd that such a 
> "harmless" operation causes a steady growth of buffer_heads...

OK. It is just a quirk in the way that ext3 ordered interacts with page freeing
and reclaim, I think. If it is causing you no performance problems then that's
good. Though it is counter intuitive.

Thanks for the report anyway.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
