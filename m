Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbVDEXmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVDEXmb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 19:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbVDEXmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 19:42:31 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:12932 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261989AbVDEXmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 19:42:23 -0400
Message-ID: <4253225C.60203@yahoo.com.au>
Date: Wed, 06 Apr 2005 09:42:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
References: <20050405000524.592fc125.akpm@osdl.org> <42523F5D.7020201@yahoo.com.au> <20050405115113.A17809@unix-os.sc.intel.com>
In-Reply-To: <20050405115113.A17809@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Tue, Apr 05, 2005 at 05:33:49PM +1000, Nick Piggin wrote:

>>Suresh's underlying problem with the unnecessary sched domains
>>is a failing of sched-balance-exec and sched-balance-fork, which
> 
> 
> That wasn't the only motivation. For example, on non-HT cpu's we shouldn't
> be setting up SMT sched-domain, same with NUMA domains on non-NUMA systems.
> 

Yep, sure. It is a good, if slight, optimisation. And I've also just
slightly extended your patch, so we don't have any domains if booting
with maxcpus=1

> 
>>I am working on now.
>>
>>Removing unnecessary domains is a nice optimisation, but just
>>needs to account for a few more flags before declaring that a
> 
> 
> Can you elaborate when we require a domain with special flags but has
> no or only one group in it.
> 

The SD_WAKE_* flags do not use groups, so it would be legitimate to
have a domain that has one of these set, with no groups.

> 
>>domain is unnecessary (not to mention this probably breaks if
>>isolcpus= is used). I have made some modifications to the patch
> 
> 
> I have tested my patch with "ioslcpus=" and it works just fine.
> 

OK, my apologies ;)

> 
>>to fix these problems.
>>
>>Lastly, I'd like to be a bit less intrusive with pinned task
>>handling improvements. I think we can do this while still being
>>effective in preventing livelocks.
> 
> 
> We want to see this fixed. Please post your patch and I can let you know
> the test results.
> 

I will try to get it working and tested tonight for you.

> 
>>I will keep you posted with regards to the various scheduler
>>patches.
> 
> 
> Nick, Can you post the patches you sent me earlier to this list?
> 

Yep, I'll post them.


-- 
SUSE Labs, Novell Inc.

