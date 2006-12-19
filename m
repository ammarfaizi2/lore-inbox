Return-Path: <linux-kernel-owner+w=401wt.eu-S1752654AbWLSGfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbWLSGfR (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 01:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752660AbWLSGfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 01:35:16 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:27027 "HELO
	smtp109.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752654AbWLSGfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 01:35:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=dRoDfXHKzaMG9UplyEdY9Wh1k4GiSkrecBXbEIEOdNG45GEAGsfqThLRjyCtwSj3eul9rCb/uuVMt0j4nAoX3e2H5dmWQ1OkgKRCe6O7ZN25/nJSDFcfq6mVxH4OljcLbwLxq7ugLj8kORtH1C7vbv4qYXy6QA971meU9Yz4UyY=  ;
X-YMail-OSG: ihVxA24VM1mcbvUyUpFTezmK3onu0Gly4EdX1ZCb3Ghv27rqCkIMUl7HSR.syzWTSeTCIX6F2_WXpmzCrhBPwDwoi6zrBYSCSxOIg_zGzOb3PYefd2Y0devX8CLhef2UpLm5j5q7nPLG6hI-
Message-ID: <458787FF.6080404@yahoo.com.au>
Date: Tue, 19 Dec 2006 17:34:39 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Aubrey <aubreylee@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] Fix area->nr_free-- went (-1) issue in buddy system
References: <6d6a94c50612181901m1bfd9d1bsc2d9496ab24eb3f8@mail.gmail.com>	 <458760B0.7090803@yahoo.com.au> <6d6a94c50612182216r15cd99a3p59bbe3d49cb482f0@mail.gmail.com>
In-Reply-To: <6d6a94c50612182216r15cd99a3p59bbe3d49cb482f0@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aubery!

Aubrey wrote:
> Hi Nick,
> 
> Thanks for your reply again, ;-).
> 
> On 12/19/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>
>> This should not happen because the pages are checked to ensure they are
>> from the same zone before merging.
> 
> 
> How? page_is_buddy() only check if the buddy has the buddy flag and
> has the same order.
> Where can I find the same zone is checked?

Ah OK, you're using 2.6.16? Later kernels have a check for this. I
guess you could backport it?

> 
>>
>> What kind of system do you have? What is the dmesg and the .config?
> 
> 
> I'm using the blackfin uclinux. dmesg and .config is attached.
> 
>> It could be that the zones are not properly aligned and 
>> CONFIG_HOLES_IN_ZONE
>> is not set.
> 
> 
> I changed the code in paging_init(), see below:
> -----------------------------------------
> #if 0
>                zones_size[ZONE_DMA] = (end_mem - PAGE_OFFSET) >> 
> PAGE_SHIFT;
>                zones_size[ZONE_NORMAL] = 0;
> #else
>                zones_size[ZONE_DMA] = (end_mem/2 - PAGE_OFFSET) >> 
> PAGE_SHIFT;
>                zones_size[ZONE_NORMAL] = (end_mem/2 - PAGE_OFFSET) >>
> PAGE_SHIFT;
> #endif
> -----------------------------------------
> This is only what I did the change. I also suspect the zones are not
> properly aligned, But how to align it? I think our system doesn't need
> CONFIG_HOLES_IN_ZONE.

That's right. I guess you can either align your zone sizes (must be
aligned to MAX_ORDER size), or add the zone check in page_is_buddy.

Hope that works.

Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
