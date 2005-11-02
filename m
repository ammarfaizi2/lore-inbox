Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932633AbVKBHzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbVKBHzx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 02:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbVKBHzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 02:55:53 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:59001 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932633AbVKBHzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 02:55:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=55eu4EPRB3kUXdRGoaYP2SitsXSPolzRx1sqMdhV5sgSqZvBow6tWQYFG8PwCK4bENaxrXdg+ysPH3dLGmRb9Wz8X4KiEERXW0AMyqfYiD38g25qFYljIJ7vYTFEnUnOGRz73QoSMW1BcfoBQPab1y7VvGsvdCiSPb25ctojFWc=  ;
Message-ID: <43687173.5020702@yahoo.com.au>
Date: Wed, 02 Nov 2005 18:57:39 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Hansen <haveblue@us.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <4366C559.5090504@yahoo.com.au> <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au> <Pine.LNX.4.58.0511011014060.14884@skynet> <20051101135651.GA8502@elte.hu> <1130854224.14475.60.camel@localhost> <20051101142959.GA9272@elte.hu> <1130856555.14475.77.camel@localhost> <20051101150142.GA10636@elte.hu> <43679C69.6050107@jp.fujitsu.com> <20051102071943.GA1574@elte.hu>
In-Reply-To: <20051102071943.GA1574@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> 
> 
>>My own target is NUMA node hotplug, what NUMA node hotplug want is
>>- [remove the range of memory] For this approach, admin should define
>>  *core* node and removable node. Memory on removable node is removable.
>>  Dividing area into removable and not-removable is needed, because
>>  we cannot allocate any kernel's object on removable area.
>>  Removable area should be 100% removable. Customer can know the limitation 
>>  before using.
> 
> 
> that's a perfectly fine method, and is quite similar to the 'separate 
> zone' approach Nick mentioned too. It is also easily understandable for 
> users/customers.
> 

I agree - and I think it should be easy to configure out of the
kernel for those that don't want the functionality, and should
at very little complexity to core code (all without looking at
the patches so I could be very wrong!).

> 
> but what is a dangerous fallacy is that we will be able to support hot 
> memory unplug of generic kernel RAM in any reliable way!
> 

Very true.

> you really have to look at this from the conceptual angle: 'can an 
> approach ever lead to a satisfactory result'? If the answer is 'no', 
> then we _must not_ add a 90% solution that we _know_ will never be a 
> 100% solution.
> 
> for the separate-removable-zones approach we see the end of the tunnel.  
> Separate zones are well-understood.
> 

Yep, I don't see why this doesn't cover all the needs that the frag
patches attempt (hot unplug, hugepage dynamic reserves).

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
