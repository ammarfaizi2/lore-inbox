Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030678AbWKOQhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030678AbWKOQhx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030680AbWKOQhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:37:53 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:31674 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1030678AbWKOQhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:37:52 -0500
Message-ID: <455B4245.8000309@in.ibm.com>
Date: Wed, 15 Nov 2006 22:07:25 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: "Patrick.Le-Dot" <Patrick.Le-Dot@bull.net>
CC: dev@openvz.org, ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC][PATCH 5/8] RSS controller task migration	support
References: <20061115115937.B0A851B6A2@openx4.frec.bull.fr>
In-Reply-To: <20061115115937.B0A851B6A2@openx4.frec.bull.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick.Le-Dot wrote:
> Hi Balbir,
> 
> The get_task_mm()/mmput(mm) usage is not correct.
> With CONFIG_DEBUG_SPINLOCK_SLEEP=y :
> 
> BUG: sleeping function called from invalid context at kernel/fork.c:390
> in_atomic():1, irqs_disabled():0
>  [<c0116620>] __might_sleep+0x97/0x9c
>  [<c0116a2e>] mmput+0x15/0x8b
>  [<c01582f6>] install_arg_page+0x72/0xa9
>  [<c01584b1>] setup_arg_pages+0x184/0x1a5
>  ...
> 
> BUG: sleeping function called from invalid context at kernel/fork.c:390
> in_atomic():1, irqs_disabled():0
>  [<c0116620>] __might_sleep+0x97/0x9c
>  [<c0116a2e>] mmput+0x15/0x8b
>  [<c01468ee>] do_no_page+0x255/0x2bd
>  [<c0146b8d>] __handle_mm_fault+0xed/0x1ef
>  [<c0111884>] do_page_fault+0x247/0x506
>  [<c011163d>] do_page_fault+0x0/0x506
>  [<c0348f99>] error_code+0x39/0x40
> 
> 
> current->mm seems to be enough here.

Excellent, thanks for catching this!

> 
> 
> 
> In patch4, memctlr_dec_rss(page, mm) should be memctlr_dec_rss(page)
> to compile correctly.
> 
> and in patch0 :
>> 4. Disable cpuset's (to simply assignment of tasks to resource groups)
>>         cd /container
>>         echo 0 > cpuset_enabled
> 
> should be :
>         echo 0 > cpuacct_enabled
> 
> Note : cpuacct_enabled is 0 by default.
> 

Thanks for pointing this out.

> 
> Now the big question : to implement guarantee, the LRU needs to know
> if a page can be removed from memory or not.
> Any ideas to do that without any change in the struct page ?
> 

For implementing guarantees, we can use limits. Please see
http://wiki.openvz.org/Containers/Guarantees_for_resources.


Thanks for the feedback!

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
