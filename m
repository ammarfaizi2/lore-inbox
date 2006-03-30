Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWC3TFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWC3TFe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 14:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWC3TFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 14:05:33 -0500
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:4215 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750749AbWC3TFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 14:05:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=OznYuoyiSZ9wsmQiLQ/mYlzoZG9TZqJbb33JW9yM+al+rtuf4aiMJ89rGnz6PQ1yz7Uw38uC6wPI33/BxYLwHQAqUTUAgGtxox82FWPr57fHQkGMwvmLLAG19iLTyFya/PQ2YPVb/coiUvwZdGQrpHKhSU8EtebhWWDzSbpLHGw=  ;
Message-ID: <442B9FC5.4040409@yahoo.com.au>
Date: Thu, 30 Mar 2006 19:07:17 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Luke Yang <luke.adi@gmail.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <npiggin@suse.de>
Subject: Re: [PATCH] nommu page refcount bug fixing
References: <489ecd0c0603291905m7ebffff2j83809cc3c93595f1@mail.gmail.com>	 <442B4EEB.6020407@yahoo.com.au>	 <489ecd0c0603300056t272b4d22g8501302f4f86fc85@mail.gmail.com> <489ecd0c0603300100o7e9293b4mbde4340b0129e5d5@mail.gmail.com>
In-Reply-To: <489ecd0c0603300100o7e9293b4mbde4340b0129e5d5@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Yang wrote:
>>>NOMMU special-casing in page refcounting. As a temporary fix, what I
>>>think should happen is simply for all slab allocations to ask for
>>>__GFP_COMP pages.
>>>
>>>Could you check that fixes your problem?
>>
>>  It works.  What's your plan to modify nommu mm? I would like to
>>help. And I am also interested in implementing the "non-power-of-2"
>>allocator in 2.6.
>>

I'll get it up to date and send it over to you, offline. It
would be great if you could help.

>>  New patch:
> 

Acked-by: Nick Piggin <npiggin@suse.de>

I'll write a changelog for you:

***
The earlier patch to consolidate mmu and nommu page allocation
and refcounting by using compound pages for nommu allocations
had a bug: kmalloc slabs who's pages were initially allocated
by a non-__GFP_COMP allocator could be passed into mm/nommu.c
kmalloc allocations which really wanted __GFP_COMP underlying
pages.

Fix that by having nommu pass __GFP_COMP to all higher order
slab allocations
***

Sound OK? Can you do it next time? ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
