Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267475AbUIFXvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267475AbUIFXvw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 19:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267476AbUIFXvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 19:51:52 -0400
Received: from mail-02.iinet.net.au ([203.59.3.34]:8913 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S267475AbUIFXvt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 19:51:49 -0400
Message-ID: <413CF809.3010908@cyberone.com.au>
Date: Tue, 07 Sep 2004 09:51:37 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Ray Bryant <raybry@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com,
       kernel@kolivas.org
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
References: <413CB661.6030303@sgi.com> <20040906131027.227b99ac.akpm@osdl.org> <413CD4FF.8070408@sgi.com> <20040906223724.GH3106@holomorphy.com>
In-Reply-To: <20040906223724.GH3106@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:

>On Mon, Sep 06, 2004 at 04:22:07PM -0500, Ray Bryant wrote:
>
>>We were planning on suggesting that such users set swappiness=0 to give
>>user pages priority over the page cache pages.  But it doesn't look like 
>>that works very well in the more recent kernels.
>>One (perhaps) desirable feature would be for intermediate values of 
>>swappiness to have behavior in between the two extremes (mapped pages have 
>>higher priority vs page cache pages having priority over unreferenced 
>>mapped pages),
>>so that one would have finer grain control over the amount of swap used.  
>>I'm not sure how to achieve such a goal, however.  :-)
>>
>
>Priority paging again? A perennial suggestion.
>
>

I guess reclaim_mapped is effectively priority paging. But is reasonably
fragile I guess.

My mapped_page_cost stuff is possibly (I hope) more robust in theory, but
the change from never scanning mapped pages until some point, to always
scanning mapped pages slowly necessitated non trivial changes to things
like handling of use-once pages.


>
>On Mon, Sep 06, 2004 at 04:22:07PM -0500, Ray Bryant wrote:
>
>>On a separate issue, the response to my proposal for a mempolicy to control
>>allocation of page cache pages has been <ahem> underwhelming.
>>(See: http://marc.theaimsgroup.com/?l=linux-mm&m=109416852113561&w=2
>> and  http://marc.theaimsgroup.com/?l=linux-mm&m=109416852416997&w=2 )
>>I wonder if this is because I just posted it to linux-mm or its not fleshed 
>>out enough yet to be interesting?
>>
>
>It was very noncontroversial. Since it's apparently useful to someone
>and generally low-impact it should probably be merged.
>
>

Yeah, I couldn't see any reason to not go ahead with it, which is why I
didn't say anything :)

