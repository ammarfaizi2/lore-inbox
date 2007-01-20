Return-Path: <linux-kernel-owner+w=401wt.eu-S932876AbXATCuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932876AbXATCuG (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 21:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbXATCuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 21:50:05 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:47439 "HELO
	smtp101.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932876AbXATCuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 21:50:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=MgNzvLYsj0jZk1wgFhlrAPf68xH4RilZBpxKn3ufaxNGb48gGFC9IHKc/DLQY4X/gCfAKrEHKc4VjVI1QnBm6WnRec/id9e0OznoDCvTwrfhflnRwvDc9NoBpvfhh9hkA1X6IX1QUsylXo5m5SaazRvqa+ZOxYa1GX0BwTbp5Oo=  ;
X-YMail-OSG: JCzNi9MVM1mKFwUsYnvbK4UsOR.KzygiOIsfan8mxoOEzY0tbaJAgFiu5pQW7k_tObcqkFTdzk8xJEhKt8ZeFB9qtINXvt2S7LkBgelqcFpKMgfCytM-
Message-ID: <45B18344.5020507@yahoo.com.au>
Date: Sat, 20 Jan 2007 13:49:40 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Frysinger <vapier.adi@gmail.com>
CC: Aubrey Li <aubreylee@gmail.com>,
       Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Robin Getz <rgetz@blackfin.uclinux.org>,
       "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [RPC][PATCH 2.6.20-rc5] limit total vfs page cache
References: <6d6a94c50701171923g48c8652ayd281a10d1cb5dd95@mail.gmail.com>	 <45B0DB45.4070004@linux.vnet.ibm.com>	 <6d6a94c50701190805saa0c7bbgbc59d2251bed8537@mail.gmail.com>	 <45B112B6.9060806@linux.vnet.ibm.com>	 <6d6a94c50701191804m79c70afdo1e664a072f928b9e@mail.gmail.com>	 <45B17D6D.2030004@yahoo.com.au> <8bd0f97a0701191835y49a61e7jb65a3b63f906ca56@mail.gmail.com>
In-Reply-To: <8bd0f97a0701191835y49a61e7jb65a3b63f906ca56@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Frysinger wrote:
> On 1/19/07, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>> Luckily, there are actually good, robust solutions for your higher
>> order allocation problem. Do higher order allocations at boot time,
>> modifiy userspace applications, or set up otherwise-unused, or easily
>> reclaimable reserve pools for higher order allocations. I don't
>> understand why you are so resistant to all of these approaches?
> 
> 
> in a nutshell ...
> 
> the idea is to try and generalize these things
> 
> your approach involves tweaking each end solution to maximize the 
> performance

Maybe, if you are talking about my advice to fix userspace... but you
*are* going to contribute those changes back for the nommu community
to use, right? So the end result of that is _not_ actually tweaking the
end solutions.

But actually, if you take the reserved pool approach, then that will
work fine, in-kernel, and it is something that already needs to be done
for dynamic hugepage allocations which is almost exactly the same
situation. And everybody can use this as well (I think most of the code
is written already, but not merged).

> our approach is to teach the kernel some more tricks so that each
> solution need not be tweaked
> 
> these are at obvious odds as they tackle the problem by going in
> pretty much opposite directions ... yours leads to a tighter system in
> the end, but ours leads to much more rapid development and deployment

OK that's fair enough, but considering that it doesn't actually fix
the problem properly; and that it does weird and wonderful things with
our already fragile page reclaim path, then it is not a good idea to
merge it upstream.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
