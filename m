Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265684AbUHOAzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265684AbUHOAzP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 20:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265789AbUHOAzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 20:55:15 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:62088 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265684AbUHOAzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 20:55:07 -0400
Message-ID: <411EB463.5090809@yahoo.com.au>
Date: Sun, 15 Aug 2004 10:54:59 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@engr.sgi.com>
CC: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       John Hawkes <hawkes@sgi.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] add scheduler domains for ia64
References: <200408131108.40502.jbarnes@engr.sgi.com> <411D85C3.4030808@yahoo.com.au> <200408141352.01486.jbarnes@engr.sgi.com>
In-Reply-To: <200408141352.01486.jbarnes@engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> On Friday, August 13, 2004 8:23 pm, Nick Piggin wrote:
> 
>>Andrew's latest tree should have a number of improvements and changes
>>to the sched domains code which you will need to synch up to.
> 
> 
> Yeah, I forgot about those.  I'll respin against your consolidation stuff.
> 

Thanks.

> 
>>One issue you may have is that Ingo removed the ability to have arch
>>code override the domain structure due to it being too hazardous for
>>architectures to use in this form (which I don't entirely disagree with).
>>
>>Now I guess your patch could go into the generic code because it is
>>pretty general - however are you guys going to want to do anything
>>more fancy with these things?
> 
> 
> Maybe, we haven't figured out the best way to schedule on a 512p yet, but most 
> or all of this code is generic.  In order for things to work at all though, 
> we'll need to change some of the SD_NODE_INIT values, maybe we can keep that 
> as per-arch?
> 

Yeah, all the SD_*_INIT values are overridable. We could even say, put
in an SD_NODE2_INIT for a 2nd level NUMA domain in the generic code,
for example.

I'd say your closest-node setup would probably get close to what you want.
The main thing you want is to not do huge amounts of balancing work in
interrupt context, and also not to move a task from one side of the
system to the other when one node is a little bit out of balance.

I guess if you want to do anything fancier then we can take a look at
re-exporting the domain setup.
