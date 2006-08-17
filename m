Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWHQMCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWHQMCk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 08:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWHQMCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 08:02:40 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:52069 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751218AbWHQMCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 08:02:39 -0400
Message-ID: <44E45B6B.8080800@sw.ru>
Date: Thu, 17 Aug 2006 16:04:59 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: rohitseth@google.com
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 4/7] UBC: syscalls (user interface)
References: <44E33893.6020700@sw.ru>  <44E33C3F.3010509@sw.ru> <1155752277.22595.70.camel@galaxy.corp.google.com>
In-Reply-To: <1155752277.22595.70.camel@galaxy.corp.google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Add the following system calls for UB management:
>>  1. sys_getluid    - get current UB id
>>  2. sys_setluid    - changes exec_ and fork_ UBs on current
>>  3. sys_setublimit - set limits for resources consumtions
>>
> 
> 
> Why not have another system call for getting the current limits?
will add sys_getublimit().

> But as I said in previous mail, configfs seems like a better choice for
> user interface.  That way user has to go to one place to read/write
> limits, see the current usage and other stats.
Check another email about interfaces. I have arguments against it :/

>>Signed-Off-By: Pavel Emelianov <xemul@sw.ru>
>>Signed-Off-By: Kirill Korotaev <dev@sw.ru>
> 
> 
> 	...<snip>...
> 
>>+
>>+/*
>>+ *	The setbeanlimit syscall
>>+ */
>>+asmlinkage long sys_setublimit(uid_t uid, unsigned long resource,
>>+		unsigned long *limits)
>>+{
> 
> 
>>+	ub = beancounter_findcreate(uid, NULL, 0);
>>+	if (ub == NULL)
>>+		goto out;
>>+
>>+	spin_lock_irqsave(&ub->ub_lock, flags);
>>+	ub->ub_parms[resource].barrier = new_limits[0];
>>+	ub->ub_parms[resource].limit = new_limits[1];
>>+	spin_unlock_irqrestore(&ub->ub_lock, flags);
>>+
> 
> 
> I think there should be a check here for seeing if the new limits are
> lower than the current usage of a resource.  If so then take appropriate
> action.
any idea what exact action to add here?
Looks like can be added when needed, agree?

Thanks,
Kirill

