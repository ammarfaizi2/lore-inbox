Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWEPAcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWEPAcH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 20:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWEPAcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 20:32:07 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:60597 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750877AbWEPAcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 20:32:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=DHmkaOQcFdh0AkXQxLI0L7o7TIwT2TUrg3ZuwbseuTsKkTK1mJIKxcHvSJRpEg2BqJJFaNquBvhG+ebWH6sjMoP+Zp77kKxZ9F9VQsd1VbxBGlqzFAYEbEB30hCTlyTeCWC4jYEk8qRLmoLIjHbL6afSQRLdqy0T/5anj0P04Qs=  ;
Message-ID: <44691D7C.5060208@yahoo.com.au>
Date: Tue, 16 May 2006 10:31:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
CC: Andy Whitcroft <apw@shadowen.org>, akpm@osdl.org, mel@csn.ul.ie,
       davej@codemonkey.org.uk, tony.luck@intel.com,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, ak@suse.de,
       linux-mm@kvack.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/6] Have ia64 use add_active_range() and free_area_init_nodes
References: <20060508141030.26912.93090.sendpatchset@skynet>	<20060508141211.26912.48278.sendpatchset@skynet>	<20060514203158.216a966e.akpm@osdl.org>	<44683A09.2060404@shadowen.org>	<44685123.7040501@yahoo.com.au>	<446855AF.1090100@shadowen.org> <20060515192918.c3e2e895.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060515192918.c3e2e895.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki wrote:

>On Mon, 15 May 2006 11:19:27 +0100
>Andy Whitcroft <apw@shadowen.org> wrote:
>
>>>
>>>Recently arrived? Over a year ago with the no-buddy-bitmap patches,
>>>right? Just checking because I that's what I'm assuming broke it...
>>>
>>Yep, sorry I forget I was out of the game for 6 months!  And yes that
>>was when the requirements were altered.
>>
>>
>When no-bitmap-buddy patches was included,
>
>1. bad_range() is not covered by CONFIG_VM_DEBUG. It always worked.
>==
>static int bad_range(struct zone *zone, struct page *page)
>{
>        if (page_to_pfn(page) >= zone->zone_start_pfn + zone->spanned_pages)
>                return 1;
>        if (page_to_pfn(page) < zone->zone_start_pfn)
>                return 1;
>==
>And , this code
>==
>                buddy = __page_find_buddy(page, page_idx, order);
>
>                if (bad_range(zone, buddy))
>                        break;
>==
>
>checked whether buddy is in zone and guarantees it to have page struct.
>

Ah, my mistake indeed. Sorry.

>But clean-up/speed-up codes vanished these checks. (I don't know when this occurs)
>Sorry for misses these things.
>

I think if anything they should be moved into page_is_buddy, however 
page_to_pfn
is expensive on some architectures, so it is something we want to be 
able to opt
out of if we do the correct alignment.

--
Send instant messages to your online friends http://au.messenger.yahoo.com 
