Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbUBZWwN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 17:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbUBZWwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 17:52:13 -0500
Received: from alt.aurema.com ([203.217.18.57]:48562 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261200AbUBZWwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 17:52:07 -0500
Message-ID: <403E788A.8090100@aurema.com>
Date: Fri, 27 Feb 2004 09:51:54 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <Pine.GSO.4.03.10402260834530.27582-100000@swag.sw.oz.au> <403D3E47.4080501@techsource.com> <403D576A.6030900@aurema.com> <403D5D32.4010007@matchmail.com> <403E1A7A.6030804@techsource.com>
In-Reply-To: <403E1A7A.6030804@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
> How about this:
> 
> The kernel tracks CPU usage, time slice expiration, and numerous other 
> statistics, and exports them to userspace through /proc or somesuch. 
> Then a user-space daemon adjusts priority.

Yes, the right statistics could allow these processes to be identified 
reasonably accurately.  The programs in question would have the 
following characteristics:

1. low CPU usage rate, and
2. a very regular pattern of use i.e. the size of each CPU bursts would 
be approximately constant as would the size of the intervals between 
each burst.

The appropriate statistic to identify the second of these would be 
variance or (equivalently but more expensively) standard deviation. 
Whether this problem is bad/important enough to warrant the extra 
overhead of gathering these statistics is a moot point.  We had to 
generate very high system loads on a single CPU system in order to cause 
one or two skips in xmms over a period of a couple of minutes.

It should be noted that these are the type of task characteristics for 
which the real time scheduler classes are designed and I think that 
someone mentioned that if run with sufficient privileges xmms tries to 
make itself SCHED_RR.

>  This could work, but it 
> would be sluggish in adjusting priorities.
> 
> I still like Nick and Con's solutions better.
> 

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

