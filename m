Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbUB0KJp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 05:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbUB0KJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 05:09:44 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:44555 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261766AbUB0KGo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 05:06:44 -0500
Message-ID: <403F1699.5090404@aitel.hist.no>
Date: Fri, 27 Feb 2004 11:06:17 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Peter Williams <peterw@aurema.com>
CC: Timothy Miller <miller@techsource.com>, Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <Pine.GSO.4.03.10402260834530.27582-100000@swag.sw.oz.au> <403D3E47.4080501@techsource.com> <403D576A.6030900@aurema.com> <403D5D32.4010007@matchmail.com> <403E1A7A.6030804@techsource.com> <403E788A.8090100@aurema.com>
In-Reply-To: <403E788A.8090100@aurema.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Timothy Miller wrote:
> 
>> How about this:
>>
>> The kernel tracks CPU usage, time slice expiration, and numerous other 
>> statistics, and exports them to userspace through /proc or somesuch. 
>> Then a user-space daemon adjusts priority.
> 
> 
> Yes, the right statistics could allow these processes to be identified 
> reasonably accurately.  The programs in question would have the 
> following characteristics:
> 
> 1. low CPU usage rate, and
> 2. a very regular pattern of use i.e. the size of each CPU bursts would 
> be approximately constant as would the size of the intervals between 
> each burst.

There is no need for the regularity.  When I use a word processor, I
use it very irregularly.  Sometimes I type text, and wants each letter
typed to appear instantly.  This fits well with "low cpu usage" and
sudden short bursts.  There may be lots of long delays though while
I think about stuff to write.  So the intervals are irregular, I still
believe I should get the boosts as long as the bursts are small.
Doing something big (such as invoking latex on a big document)
is cpu-heavy, but then it is ok not to get the boost.
Current schedulers based on io-waiting gets this right already.
> 
> The appropriate statistic to identify the second of these would be 
> variance or (equivalently but more expensively) standard deviation. 
> Whether this problem is bad/important enough to warrant the extra 
> overhead of gathering these statistics is a moot point.  We had to 
> generate very high system loads on a single CPU system in order to cause 
> one or two skips in xmms over a period of a couple of minutes.

Well, perhaps you could give a slightly bigge boost to a very regular
thing like xmms.  But even that might have some snags, the load
might change a lot when doing midi in software, depending on how
many instruments are active simultaneously. There goes the
constant-size bursts.

Helge Hafting

