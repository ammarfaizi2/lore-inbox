Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbWD0GTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWD0GTD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 02:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbWD0GTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 02:19:03 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:41147 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964956AbWD0GTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 02:19:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=E7wiZCkV3mlurjVCE3aZUkcjB1Ee8+5ptWfFEweLztObHpq9mWab6aseAc+iTjtewAzvTe2/4io+iXt+cObH+Pguxayq7hcJbPdhddX8d/HbmLgw9CpDasdDDgWmCZPzJn15aBsYotJCQ5DsowfWjAuoAYD632+9uwK4I7CEq28=  ;
Message-ID: <44505FA6.70508@yahoo.com.au>
Date: Thu, 27 Apr 2006 16:07:34 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: "'Jens Axboe'" <axboe@suse.de>, linux-kernel@vger.kernel.org,
       "'Nick Piggin'" <npiggin@suse.de>, "'Andrew Morton'" <akpm@osdl.org>,
       linux-mm@kvack.org
Subject: Re: Lockless page cache test results
References: <4t153d$r2dpi@azsmga001.ch.intel.com>
In-Reply-To: <4t153d$r2dpi@azsmga001.ch.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
> Jens Axboe wrote on Wednesday, April 26, 2006 12:46 PM
> 
>>>It's interesting, single threaded performance is down a little. Is
>>>this significant? In some other results you showed me with 3 splices
>>>each running on their own file (ie. no tree_lock contention), lockless
>>>looked slightly faster on the same machine.
>>
>>I can do the same numbers on a 2-way em64t for comparison, that should
>>get us a little better coverage.
> 
> 
> 
> I throw the lockless patch and Jens splice-bench into our benchmark harness,
> here are the numbers I collected, on the following hardware:
> 
> (1) 2P Intel Xeon, 3.4 GHz/HT, 2M L2
> (2) 4P Intel Xeon, 3.0 GHz/HT, 8M L3
> (3) 4P Intel Xeon, 3.0 GHz/DC/HT, 2M L2 (per core)
> 
> Here are the graph:

Thanks a lot Ken.

So pagecache lookup performance goes up about 15-25% in single threaded
tests on your P4s. Phew, I wasn't dreaming it.

It is a pity that ipf hasn't improved similarly (and even slowed down a
bit, if Jens' numbers are significant to that range). Next time I spend
some cycles on lockless pagecache, I'll try to scrounge an ipf and see
if I can't improve it (I don't expect miracles).

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
