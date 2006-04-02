Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWDBJPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWDBJPP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 05:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWDBJPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 05:15:14 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:11104 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932175AbWDBJPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 05:15:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=6YKZGmiCi71+QCevmV8hPk6I9EdHZE7OE6OJuZ37NSiL5gOctE1ufs7KjCufi2z6KC3G7sNhAVIovKEioLHiDelFxm9/QBMuTwxQSCYZdbUJe7YANuY6GMA/FVTwtX4TJgFERlRNTn93nnsjbYHXqXyxk1+O3sKLFdTcZVcn/JM=  ;
Message-ID: <442F6307.7040602@yahoo.com.au>
Date: Sun, 02 Apr 2006 15:37:11 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: vatsa@in.ibm.com, mingo@elte.hu, suresh.b.siddha@intel.com,
       dino@in.ibm.com, pj@sgi.com, hawkes@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-mm2 1/4] sched_domain - handle kmalloc failure
References: <20060401185222.GA10591@in.ibm.com>	<442F2A79.1040903@yahoo.com.au> <20060401212533.61a02f9d.akpm@osdl.org>
In-Reply-To: <20060401212533.61a02f9d.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:

>>In that case, would it be simpler just
>>to add a __GFP_NOFAIL here and forget about it?
> 
> 
> No new __GFP_NOFAILs, please.

It isn't a new one as such. It would simply make explicit the fact
that this code really can't handle allocation failures, and it is
presently depending on the allocator implementation to work.

> The fact that the CPU addition will succeed, but it'll run forever more
> with load balancing disabled still seems Just Wrong to me.  We should
> either completely succeed or completely fail.
> 

Yes. But we shouldn't partially fail and leave the machine crippled.

Hence, __GFP_NOFAIL as a good marker for someone who gets keen and
comes along to fix it up properly. If it were trivial to fix it, I
wouldn't suggest adding the __GFP_NOFAIL.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
