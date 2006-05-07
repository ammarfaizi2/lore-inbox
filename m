Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWEGNSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWEGNSm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 09:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWEGNSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 09:18:42 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:39287 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932156AbWEGNSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 09:18:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=gB8tMKDGurKMi37CJLpmCOMcE164aBzD234yYWgcUWDK8YVfPJhDsFEaA2qv1N+v73AVHiOVrmkvRel/yraUz8tk1kjER39Vu9wnR/EA3CZFEZkh8NbCivMk0ZNaR3YRYzQH3cQlk/ZEJaq6sI1A0W/K6vd1UhsWbXytjiVg5C8=  ;
Message-ID: <445DF3AB.9000009@yahoo.com.au>
Date: Sun, 07 May 2006 23:18:35 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>
CC: Dave Hansen <haveblue@us.ibm.com>, Bob Picco <bob.picco@hp.com>,
       Ingo Molnar <mingo@elte.hu>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
References: <44576688.6050607@mbligh.org> <44576BF5.8070903@yahoo.com.au>	 <20060504013239.GG19859@localhost>	 <1146756066.22503.17.camel@localhost.localdomain>	 <20060504154652.GA4530@localhost> <20060504192528.GA26759@elte.hu>	 <20060504194334.GH19859@localhost> <445A7725.8030401@shadowen.org>	 <20060505135503.GA5708@localhost>	 <1146839590.22503.48.camel@localhost.localdomain>	 <20060505145018.GI19859@localhost> <1146841064.22503.53.camel@localhost.localdomain> <445C5F36.3030207@yahoo.com.au> <445DF114.4090708@shadowen.org>
In-Reply-To: <445DF114.4090708@shadowen.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft wrote:

> I agree that there is no need for these checks to leak out of
> page_is_buddy().  If its not there or in another zone, its not my buddy.
>  The allocator loop is nasty enough as it is.

OK, glad you agree.

> 
> I think we need to do a couple of things:
> 
> 1) check the alignment of the zones matches the implied alignment
> constraints and correct it as we go.

Yes. And preferably have checks in the generic page allocator setup
code, so we can do something sane if the arch code gets it wrong.

> 2) optionally allow an architecture to say its not aligning and doesn't
> want to have to align its zone -- providing a config option to add the
> zone index checks
> 
> I think the later is valuable for these test builds and potentially for
> the embedded side where megabytes mean something.

Yes. Depends whether we fold it under the HOLES_IN_ZONE config. I guess
HOLES_IN_ZONE is potentially quite a bit more expensive than the plain
zone check, so having 2 config options may not be unreasonable.

Also, if the architecture doesn't align the ends of zones, *and* they are
not adjacent to another zone, they need either CONFIG_HOLES_IN_ZONE or
they need to provide dummy 'struct page's that never have PageBuddy set.


> 
> I'm testing a patch for this at the moment and will drop it out when I'm
> done.

Great!

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
