Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965158AbWH2RIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbWH2RIY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 13:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbWH2RIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 13:08:24 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:33763 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965158AbWH2RIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 13:08:23 -0400
Message-ID: <44F4749D.9050403@in.ibm.com>
Date: Tue, 29 Aug 2006 22:38:45 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: [PATCH] BC: resource beancounters (v2)
References: <44EC31FB.2050002@sw.ru>	<20060823100532.459da50a.akpm@osdl.org>	<44EEE3BB.10303@sw.ru> <20060825073003.e6b5ae16.akpm@osdl.org> <44F45ED7.3050708@sw.ru>
In-Reply-To: <44F45ED7.3050708@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
>>> ------------- cut ----------------
>>> The task of limiting a container to 4.5GB of memory bottles down to the
>>> question: what to do when the container starts to use more than assigned
>>> 4.5GB of memory?
>>>
>>> At this moment there are only 3 viable alternatives.
>>>
>>> A) Have separate memory management for each container,
>>>   with separate buddy allocator, lru lists, page replacement mechanism.
>>>   That implies a considerable overhead, and the main challenge there
>>>   is sharing of pages between these separate memory managers.
>>>
>>> B) Return errors on extension of mappings, but not on page faults, where
>>>   memory is actually consumed.
>>>   In this case it makes sense to take into account not only the size 
>>> of used
>>>   memory, but the size of created mappings as well.
>>>   This is approximately what "privvmpages" accounting/limiting 
>>> provides in
>>>   UBC.
>>>
>>> C) Rely on OOM killer.
>>>   This is a fall-back method in UBC, for the case "privvmpages" limits
>>>   still leave the possibility to overload the system.
>>>
>>
>>
>> D) Virtual scan of mm's in the over-limit container
>>
>> E) Modify existing physical scanner to be able to skip pages which
>>    belong to not-over-limit containers.
>>
>> F) Something else ;)
> We fully agree that other possible algorithms can and should exist.
> My idea only is that any of them would need accounting anyway
> (which is the most part of beancounters).
> Throtling, modified scanners etc. can be implemented as a separate
> BC parameters. Thus, an administrator will be able to select
> which policy should be applied to the container which is near its limit.
> 
> So the patches I'm trying to send are a step-by-step accounting of all
> the resources and their simple limitations. More comprehensive limitation
> policy will be built on top of it later.
> 

One of the issues I see is that bean counters are not very flexible. Tasks 
cannot change bean counters dynamically after fork()/exec() that is - can they?


> BTW, UBC page beancounters allow to distinguish pages used by only one
> container and pages which are shared. So scanner can try to reclaim
> container private pages first, thus not influencing other containers.
> 

But can you select the specific container for which we intend to scan pages?

> Thanks,
> Kirill
> 

-- 
	Thanks,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
