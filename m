Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWERH0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWERH0N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 03:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWERH0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 03:26:13 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:40855 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750735AbWERH0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 03:26:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=aAJlokpW6E+Zk9P0WUpWXbV9Lnq75eUc6ImQo7KTKxOGIEtxJZpjQQjieDtRyIIpsO3E3pphSY+FE2roRIo2i48Ktyw96giEeVZUvWjbrpqxhqsx0vNQtVPdi7URy9JvWmIl8ARHJ5OXbTJ/hyVAhxB1uyPwkIj1W+XS7Rq4Alk=  ;
Message-ID: <446C2191.70300@yahoo.com.au>
Date: Thu, 18 May 2006 17:26:09 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, ck@vds.kolivas.org,
       linux list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: limit lowmem_reserve
References: <200604021401.13331.kernel@kolivas.org> <200605180011.43216.kernel@kolivas.org> <446C1E25.4080408@yahoo.com.au> <200605181721.38735.kernel@kolivas.org>
In-Reply-To: <200605181721.38735.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Thursday 18 May 2006 17:11, Nick Piggin wrote:
> 
>>If we're under memory pressure, kswapd will try to free up any candidate
>>zone, yes.
>>
>>
>>>On my test case this indeed happens and my ZONE_DMA never goes below 3000
>>>pages free. If I lower the reserve even further my pages free gets stuck
>>>at 3208 and can't free any more, and doesn't ever drop below that either.
>>>
>>>Here is the patch I was proposing
>>
>>What problem does that fix though?
> 
> 
> It's a generic concern and I honestly don't know how significant it is which 
> is why I'm asking if it needs attention. That concern being that any time 
> we're under any sort of memory pressure, ZONE_DMA will undergo intense 
> reclaim even though there may not really be anything specifically going on in 
> ZONE_DMA. It just seems a waste of cycles doing that.
> 

If it doesn't have any/much pagecache or slab cache in it, there won't be
intense reclaim; if it does then it can be reclaimed and the memory used.

reclaim / allocation could be slightly smarter about scaling watermarks,
however I don't think it is much of an issue at the moment.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
