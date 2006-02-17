Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030640AbWBQVcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030640AbWBQVcl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 16:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030650AbWBQVcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 16:32:41 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:26848 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030640AbWBQVcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 16:32:39 -0500
Message-ID: <43F640AC.6060600@austin.ibm.com>
Date: Fri, 17 Feb 2006 15:31:24 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Mel Gorman <mel@csn.ul.ie>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/7] ppc64 - Specify amount of kernel memory at boot	time
References: <20060217141552.7621.74444.sendpatchset@skynet.csn.ul.ie>	 <20060217141712.7621.49906.sendpatchset@skynet.csn.ul.ie> <1140196618.21383.112.camel@localhost.localdomain>
In-Reply-To: <1140196618.21383.112.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This patch adds the kernelcore= parameter for ppc64.
>>
>> The amount of memory will requested will not be reserved in all nodes. The
>> first node that is found that can accomodate the requested amount of memory
>> and have remaining more for ZONE_EASYRCLM is used. If a node has memory holes,
>> it also will not be used.
> 
> One thing I think we really need to see before these go into mainline is
> the ability to shrink the ZONE_EASYRCLM at runtime, and give the memory
> back to NORMAL/DMA.
> 
> Otherwise, any system starting off sufficiently small will end up having
> lowmem starvation issues.  Allowing resizing at least gives the admin a
> chance to avoid those issues.
> 

I'm not too keen on calling it resizing, because that term is 
misleading.  The resizing is one way.  You can't later resize back. It's 
like a window that you can only close but never reopen.  We should call 
it "runtime incremental disabling", or RID.

I don't think we need RID in order to merge these patches.  RID can be 
merged later if people decide they want a special easy reclaim zone that 
could disappear at any moment.  I personally fall in the camp of wanting 
my zones I explicitly enabled to stay put and am opposed to RID.

If only somebody had presented a solution that was flexible enough to 
dynamically resize reclaimable and non-reclaimable both ways.
http://sourceforge.net/mailarchive/message.php?msg_id=13864331




