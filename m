Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030405AbVKPQk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030405AbVKPQk1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 11:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030407AbVKPQk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 11:40:27 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:26254 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030406AbVKPQk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 11:40:26 -0500
Message-ID: <437B60DC.1000404@jp.fujitsu.com>
Date: Thu, 17 Nov 2005 01:39:56 +0900
From: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] Re: 2.6.14-mm2
References: <20051110203544.027e992c.akpm@osdl.org>	 <437B2C82.6020803@jp.fujitsu.com> <1132147036.7915.19.camel@localhost>	 <437B5801.4010204@jp.fujitsu.com> <1132158704.19290.3.camel@localhost>
In-Reply-To: <1132158704.19290.3.camel@localhost>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Thu, 2005-11-17 at 01:02 +0900, Kamezawa Hiroyuki wrote: 
> 
>>>Can you explain in a little bit more detail why this matters, and
>>>exactly how it fixes your problem.  I'm not sure it's correct.
>>>
>>
>>Ah, okay.
>>
>>It's just because free_area[] is not initaialized at all if this is not called.
>>It is list.next and list.prev has bad value.
>>Then, the first free_page(page) will cause panic.
> 
> 
> Hmmm.  I _think_ you're just trying to do some things at runtime that I
> didn't intend.  In the patch I pointed to in the last mail, look at what
> I did in hot_add_zone_init().  It does some of what
> free_area_init_core() does, but only the most minimal bits.  Basically:
> 
>        zone_wait_table_init(zone, size_pages);
>        init_currently_empty_zone(zone, phys_start_pfn, size_pages);
>        zone_pcp_init(zone);
> 
> Your way may also be valid, but I broke out init_currently_empty_zone()
> for a reason, and I think this was it.  I don't think we want to be
> calling free_area_init_core() itself at runtime.
> 
Okay... I'll read what you done more carefully and find another approach.
I guess what I need is that free_area[] is initialized before the first free_page[].

thanks,
-- Kame

