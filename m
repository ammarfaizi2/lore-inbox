Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbUB0LE5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 06:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUB0LE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 06:04:56 -0500
Received: from alt.aurema.com ([203.217.18.57]:13718 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261792AbUB0LEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 06:04:50 -0500
Message-ID: <403F243B.8030801@aurema.com>
Date: Fri, 27 Feb 2004 22:04:27 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, en-au, fr-fr, es-ar
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: Timothy Miller <miller@techsource.com>, Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <Pine.GSO.4.03.10402260834530.27582-100000@swag.sw.oz.au> <403D3E47.4080501@techsource.com> <403D576A.6030900@aurema.com> <403D5D32.4010007@matchmail.com> <403E1A7A.6030804@techsource.com> <403E788A.8090100@aurema.com> <403F1699.5090404@aitel.hist.no>
In-Reply-To: <403F1699.5090404@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> Peter Williams wrote:
> 
>> Timothy Miller wrote:
>>
>>> How about this:
>>>
>>> The kernel tracks CPU usage, time slice expiration, and numerous 
>>> other statistics, and exports them to userspace through /proc or 
>>> somesuch. Then a user-space daemon adjusts priority.
>>
>>
>>
>> Yes, the right statistics could allow these processes to be identified 
>> reasonably accurately.  The programs in question would have the 
>> following characteristics:
>>
>> 1. low CPU usage rate, and
>> 2. a very regular pattern of use i.e. the size of each CPU bursts 
>> would be approximately constant as would the size of the intervals 
>> between each burst.
> 
> 
> There is no need for the regularity.  When I use a word processor, I
> use it very irregularly.  Sometimes I type text, and wants each letter
> typed to appear instantly.  This fits well with "low cpu usage" and
> sudden short bursts.  There may be lots of long delays though while
> I think about stuff to write.  So the intervals are irregular, I still
> believe I should get the boosts as long as the bursts are small.
> Doing something big (such as invoking latex on a big document)
> is cpu-heavy, but then it is ok not to get the boost.
> Current schedulers based on io-waiting gets this right already.

I was describing programs such as xmms NOT normal interactive programs 
such as editors etc.

Normal interactive programs don't need special treatment with our EBS 
scheduler because their inherent low usage rate means that they are 
always well under their entitlement and consequently get given a high 
dynamic priority.

> 
>>
>> The appropriate statistic to identify the second of these would be 
>> variance or (equivalently but more expensively) standard deviation. 
>> Whether this problem is bad/important enough to warrant the extra 
>> overhead of gathering these statistics is a moot point.  We had to 
>> generate very high system loads on a single CPU system in order to 
>> cause one or two skips in xmms over a period of a couple of minutes.
> 
> 
> Well, perhaps you could give a slightly bigge boost to a very regular
> thing like xmms.  But even that might have some snags, the load
> might change a lot when doing midi in software, depending on how
> many instruments are active simultaneously. There goes the
> constant-size bursts.

I think the burst sizes and intervals would still be fairly constant but 
the usage rate would be higher.

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

