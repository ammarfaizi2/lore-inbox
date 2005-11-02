Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbVKBJfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbVKBJfu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 04:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbVKBJfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 04:35:50 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:60281 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964913AbVKBJft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 04:35:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=myXnFKOhNyIy2cqsu1iqFm7ngR1eh7C81Gpuh6lfkpXVvaNFGVPxZjRWQu1wlT7q2eQQi+AKV5qfP3ICGcUNV2M0j5acfcrGUHHdu+dmjMz30d2lEsbCTd2mT4gBHPHMNytnKhV2lCmWucLYI2n1yrLfSbOiuRnFQ2MQyYMmISQ=  ;
Message-ID: <436888E7.1060609@yahoo.com.au>
Date: Wed, 02 Nov 2005 20:37:43 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Gerrit Huizenga <gh@us.ibm.com>
CC: Ingo Molnar <mingo@elte.hu>,
       Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Hansen <haveblue@us.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com>
In-Reply-To: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerrit Huizenga wrote:
> On Wed, 02 Nov 2005 19:50:15 +1100, Nick Piggin wrote:

>>Isn't the solution for your hypervisor problem to dish out pages of
>>the same size that are used by the virtual machines. Doesn't this
>>provide you with a nice, 100% solution that doesn't add complexity
>>where it isn't needed?
> 
> 
> So do you see the problem with fragementation if the hypervisor is
> handing out, say, 1 MB pages?  Or, more likely, something like 64 MB
> pages?  What are the chances that an entire 64 MB page can be freed
> on a large system that has been up a while?
> 

I see the problem, but if you want to be able to shrink memory to a
given size, then you must either introduce a hard limit somewhere, or
have the hypervisor hand out guest sized pages. Use zones, or Xen?

> And, if you create zones, you run into all of the zone rebalancing
> problems of ZONE_DMA, ZONE_NORMAL, ZONE_HIGHMEM.  In that case, on
> any long running system, ZONE_HOTPLUGGABLE has been overwhelmed with
> random allocations, making almost none of it available.
> 

If there are zone rebalancing problems[*], then it would be great to
have more users of zones because then they will be more likely to get
fixed.

[*] and there are, sadly enough - see the recent patches I posted to
     lkml for example. But I'm fairly confident that once the particularly
     silly ones have been fixed, zone balancing will no longer be a
     derogatory term as has been thrown around (maybe rightly) in this
     thread!

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
