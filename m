Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWBJEqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWBJEqE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 23:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWBJEqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 23:46:04 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:44968 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751004AbWBJEqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 23:46:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=oHnlJCZYgmscRdhyM1+I0/iVxL/Y72C9ykC4lJ2gp3rm+u3vdWs/av8RffUxHzIN8bDPd0SRtih9vBFtY1q+dLhRlOcy63L8TDwi+15XuSPWywUDotMaIUCC+5z4uIbKwjNJ1zsHzrkVtQWFUMH/QF7jB7aVHr+UZgBnTrl5uMk=  ;
Message-ID: <43EC1A85.2000001@yahoo.com.au>
Date: Fri, 10 Feb 2006 15:45:57 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Con Kolivas <kernel@kolivas.org>, linux-mm@kvack.org, ck@vds.kolivas.org,
       pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Implement Swap Prefetching v23
References: <200602101355.41421.kernel@kolivas.org>	<200602101449.59486.kernel@kolivas.org>	<43EC1164.4000605@yahoo.com.au>	<200602101514.40140.kernel@kolivas.org> <20060209202507.26f66be0.akpm@osdl.org>
In-Reply-To: <20060209202507.26f66be0.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> 
>> Ok I see. We don't have a way to add to the tail of that list though?
> 
> 
> del_page_from_lru() + (new) add_page_to_inactive_list_tail().
> 
> 
>>Is that 
>> a worthwhile addition to this (ever growing) project? That would definitely 
>> have an impact on the other code if not all done within swap_prefetch.c.. 
>> which would also be quite a large open coded something.
> 
> 
> Do both of the above in a new function in swap.c.
> 

That'll require the caller to do lru locking.

I'd add an lru_cache_add_tail, use it instead of the current lru_cache_add
that Con's got now, and just implement it in a simple manner, without
pagevecs.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
