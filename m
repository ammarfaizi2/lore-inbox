Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263063AbVDMBOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263063AbVDMBOv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 21:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbVDMBOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 21:14:36 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:6785 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263033AbVDMBNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 21:13:32 -0400
Message-ID: <425C7239.6010608@yahoo.com.au>
Date: Wed, 13 Apr 2005 11:13:29 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: axboe@suse.de, linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: [patch 3/9] no PF_MEMALLOC tinkering
References: <425BC262.1070500@yahoo.com.au>	<425BC3D2.3020909@yahoo.com.au> <20050412125701.40fe5c70.akpm@osdl.org>
In-Reply-To: <20050412125701.40fe5c70.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>PF_MEMALLOC is really not a tool for tinkering. It is pretty specifically
>> used to prevent recursion into page reclaim, and to prevent low memory
>> deadlocks.
>>
>> The mm/swap_state.c code was the only legitimate tinkerer. Its concern
>> was addressed by the previous patch.
> 
> 
> What previous patch?  radix tree allocation doesn't use mempools, so this
> patch will cause add_to_swap() to oom the machine with radix tree node
> allocations.
> 

Sorry, just assumed they did fromt that comment.

> Now if we were to add __GFP_NOMEMALLOC in add_to_swap() then things would
> work as we want them to.
> 

That would be good.

> 
> The dm_crypt change looks OK.
> 
> 
> The code in mpage.c is saying "if we failed to allocate a correctly-sized
> bvec and if we're doing pageout then try to allocate a smaller-sized bvec
> instead".
> 
> It's probably fairly useless, but afaict there's nothing in any of the
> other patches here which makes it redundant.
> 

Well, I didn't like it because it uses mempools anyway, so it
might as well just wait for its allocation.

My motivation is to remove all external users of PF_MEMALLOC,
really.

But it looks like in this case, the code is dead anyway, because
mempool_alloc will never return NULL if it is passed __GFP_WAIT.

-- 
SUSE Labs, Novell Inc.

