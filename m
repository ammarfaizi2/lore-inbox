Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVFAXrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVFAXrv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 19:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVFAXrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 19:47:36 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:13928 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261505AbVFAXoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 19:44:08 -0400
Message-ID: <429E483D.8010106@yahoo.com.au>
Date: Thu, 02 Jun 2005 09:43:57 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
CC: jschopp@austin.ibm.com, Mel Gorman <mel@csn.ul.ie>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy Version
 12
References: <20050531112048.D2511E57A@skynet.csn.ul.ie> <429E20B6.2000907@austin.ibm.com> <429E4023.2010308@yahoo.com.au> <423970000.1117668514@flay>
In-Reply-To: <423970000.1117668514@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> --On Thursday, June 02, 2005 09:09:23 +1000 Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 

>>It adds a lot of complexity to the page allocator and while
>>it might be very good, the only improvement we've been shown
>>yet is allocating lots of MAX_ORDER allocations I think? (ie.
>>not very useful)
> 
> 
> I agree that MAX_ORDER allocs aren't interesting, but we can hit 
> frag problems easily at way less than max order. CIFS does it, NFS 
> does it, jumbo frame gigabit ethernet does it, to name a few. The 
> most common failure I see is order 3. 
> 

Still? We had a lot of problems with kswapd not doing its
job properly, and min_free_kbytes reserve was buggy...

But if you still trigger it, I would be interested to see
traces. I don't frequently test things like XFS, or heavy
gige+jumbo loads.

> Keep a machine up for a while, get it thoroughly fragmented, then 
> push it reasonably hard constant pressure, and try allocating anything
> large. 
> 
> Seems to me we're basically pointing a blunderbuss at memory, and 
> blowing away large portions, and *hoping* something falls out the
> bottom that's a big enough chunk?
> 

Yeah more or less. But with the fragmentation patch, it by
no means becomes an exact science ;) I wouldn't have thought
it would make it hugely easier to free an order 2 or 3 area
memory block on a loaded machine.

It does make MAX_ORDER allocations _possible_ when previously
they wouldn't have been, simply by virtue of trying to put all
memory that it knows is reclaimable in a MAX_ORDER area. When
memory fills up and you need an order 3 allocation, you're
more or less in the same boat AFAIKS.

Why not just have kernel allocations going from the bottom
up, and user allocations going from the top down. That would
get you most of the way there, wouldn't it? (disclaimer: I
could well be talking shit here).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
