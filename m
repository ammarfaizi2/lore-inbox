Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbVHKXtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbVHKXtq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 19:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVHKXtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 19:49:46 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:15211 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932207AbVHKXtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 19:49:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=cuxOYAu/ZPgRQZb64Y6yDvrZrfi2ADyaC43ksH5y3+fo1howUCTnfHSDzCrSQmH9vGuPi2hV6w3+cXzYmWGB7fK2IfhOCSMBx5NXNlra4hI4J3ForaVhkOSG6aiD4+xr38RMmymQJp0IEMZ9T026kqW4rI5/FOMCEdyj3TK04MU=  ;
Message-ID: <42FBE410.9070809@yahoo.com.au>
Date: Fri, 12 Aug 2005 09:49:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, steiner@sgi.com, dvhltc@us.ibm.com,
       mbligh@mbligh.org
Subject: Re: allow the load to grow upto its cpu_power (was Re: [Patch] don't
 kick ALB in the presence of pinned task)
References: <20050801174221.B11610@unix-os.sc.intel.com> <20050802092717.GB20978@elte.hu> <20050809160813.B1938@unix-os.sc.intel.com> <42F94A00.3070504@yahoo.com.au> <20050809190352.D1938@unix-os.sc.intel.com> <1123729750.5188.13.camel@npiggin-nld.site> <20050811111411.A581@unix-os.sc.intel.com>
In-Reply-To: <20050811111411.A581@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Thu, Aug 11, 2005 at 01:09:10PM +1000, Nick Piggin wrote:
> 
>>I have a variation on the 2nd part of your patch which I think
>>I would prefer. IMO it kind of generalises the current imbalance
>>calculation to handle this case rather than introducing a new
>>special case.
> 
> 
> There is a difference between our changes. 
> 
> When the system is lightly loaded, my patch minimizes the number of 
> groups picking up that load. This will help in power savings for 
> example in the context of CMP. There are more changes required
> (user or kernel) for complete power savings, but this is a direction 
> towards that.
> 
> How about this patch?

Well, it is a departure from our current idea of balancing.
I would prefer to use my patch initially to fix the _bug_
you found, then we can think about changing policy for
power savings.

Main things I'm worried about:

Idle time regressions that pop up any time we put
restrictions on balancing.

This can tend to unbalance memory controllers (eg. on POWER5,
CMP Opteron) which can be a performance problem on those
systems.

Lastly, complexity in the calculation.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
