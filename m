Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266619AbUFWTLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266619AbUFWTLR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 15:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266618AbUFWTLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 15:11:17 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:16146 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266613AbUFWTLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 15:11:15 -0400
Message-ID: <40D9DA4A.3070700@techsource.com>
Date: Wed, 23 Jun 2004 15:30:18 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Robert Love <rml@ximian.com>
CC: Marcus Hartig <m.f.h@web.de>, linux-kernel@vger.kernel.org
Subject: Re: status of Preemptible Kernel 2.6.7
References: <40D9B20A.4070409@web.de>  <40D9C48C.4060004@techsource.com> <1088017171.14159.2.camel@betsy>
In-Reply-To: <1088017171.14159.2.camel@betsy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Robert Love wrote:
> On Wed, 2004-06-23 at 13:57 -0400, Timothy Miller wrote:
> 
> 
>>I vaguely recall someone recently talking about eliminating preempt by 
>>improving low-latency.  See, if everything were ideal, we wouldn't need 
>>preempt, because all drivers would yield the CPU at appropriate times. 
> 
> 
> If everything held locks for only sane periods of time, we would not
> need gross explicit yielding all over the place.
> 
> To answer Marcus's question: go for it and use it.


I wasn't talking about locks.  I was talking about kernel functions 
taking long periods of time, cases where preempt has been useful to 
reduce kernel latency.

Holding locks for extended periods is something else entirely.

I presume there are sane cases where a kernel function will need to 
execute for a "long time", like when doing PIO disk access or COW, etc. 
  It would be good to have a way to limit the impact of those functions 
in terms of user-perceived latency, just as preempt has done, but 
without preempt.

At least, I thought that was the idea.

Now, the thing is, if you have explicit cooperative yields, then a slow 
CPU might not yield often enough, and a fast CPU would yield too often. 
    Preempt has the advantage of using real time so that CPUs can 
maximize throughput without affecting latency.


