Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932796AbVJ3Ca4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932796AbVJ3Ca4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 22:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932801AbVJ3Ca4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 22:30:56 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:51331 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932796AbVJ3Caz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 22:30:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=FSArln8LG2DFUYOlcQmo6FbBTfWzrZbHxynlnyW7ZsHIcNCXVYFUct0KRxzHPBPJmfx/SY7p0FqDrx5MYrX0eoqiouAAMJ3fXesKyki9sDSmC9ZtMFYqoxBVQZOKN4+m6v1cmntDyOaHiPiT5TGPp8O6tMVlTOcrlwsxL3blgT0=  ;
Message-ID: <436430BA.4010606@yahoo.com.au>
Date: Sun, 30 Oct 2005 13:32:26 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: rohit.seth@intel.com, akpm@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Clean up of __alloc_pages
References: <20051028183326.A28611@unix-os.sc.intel.com>	<20051029184728.100e3058.pj@sgi.com>	<4364296E.1080905@yahoo.com.au> <20051029191946.1832adaf.pj@sgi.com>
In-Reply-To: <20051029191946.1832adaf.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Nick, replying to pj:
> 
>>> 3) The "inline" you added to buffered_rmqueue() blew up my compile.
>>
>>How? Why? This should be solved because a future possible feature
>>(early allocation from pcp lists) will want inlining in order to
>>propogate the constant 'replenish' argument.
> 
> 
> 
> Perhaps "inline struct page *" would work better than "struct inline page *" ?
> ... yes ... that fixes my compiler complaints.
> 

Ah, yep.

> Also ... buffered_rmqueue() is a rather large function to be inlining.

It is, however there would only be 2 calls, and one I think would
also have a constant 0 for "order".

Though yeah, it may be better split another way. For this patch,
it shouldn't matter because it is static and will only have one
callsite so should be inlined anyway.

> And if it is inlined, then are you expecting to also have an out of
> line copy, for use by the call to it from mm/swap_prefetch.c
> prefetch_get_page()?
> 

No, that shouldn't be there though.

> Adding the 'inline' keyword increases my kernel text size by
> 1448 bytes, for the extra copy of this code used inline from
> the call to it from mm/page_alloc.c:get_page_from_freelist().
> Is that really worth it?
> 

Hmm, where is the other callsite? (sorry I don't have a copy
of -mm handy so I'm just looking at 2.6).

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
