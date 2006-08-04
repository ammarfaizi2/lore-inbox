Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161261AbWHDQHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161261AbWHDQHJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 12:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161276AbWHDQHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 12:07:09 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:43134 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1161261AbWHDQHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 12:07:07 -0400
Message-ID: <44D36FB5.3050002@sw.ru>
Date: Fri, 04 Aug 2006 20:03:01 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu
 controller
References: <20060804050753.GD27194@in.ibm.com> <20060803223650.423f2e6a.akpm@osdl.org> <20060803224253.49068b98.akpm@osdl.org> <1154684950.23655.178.camel@localhost.localdomain> <20060804114109.GA28988@in.ibm.com> <44D35F0B.5000801@sw.ru> <20060804153123.GB32412@in.ibm.com>
In-Reply-To: <20060804153123.GB32412@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>OpenVZ assumes that tasks can't move between task-groups for a single 
>>reason:
>>user shouldn't be able to escape from the container.
>>But this have no implication on the design/implementation.
> 
> 
> Doesnt the ability to move tasks between groups dynamically affect
> (atleast) memory controller design (in giving up ownership etc)?
we save object owner on the object. So if you change the container,
objects are still correctly charged to the creator and are uncharged
correctly on free.

> Also if we need to support this movement, we need to have some
> corresponding system call/file-system interface which supports this move 
> operation.
it can be done by the same syscall or whatever which sets your
container group.
we have the same syscall for creating/setting/entering to the container.
i.e. chaning the container dynamically doesn't change the interface.

>>BTW, do you see any practical use cases for tasks jumping between 
>>resource-containers?
> 
> 
> The use cases I have heard of which would benefit such a feature is
> (say) for database threads which want to change their "resource
> affinity" status depending on which customer query they are currently handling. 
> If they are handling a query for a "important" customer, they will want affinied
> to a high bandwidth resource container and later if they start handling
> a less important query they will want to give up this affinity and
> instead move to a low-bandwidth container.
this works mostly for CPU only. And OpenVZ design allows to change CPU
resource container  dynamically.

But such a trick works poorly for memory, because:
1. threads share lots of resources.
2. complex databases can have more complicated handling than a thread per request.
  e.g. one thread servers memory pools, another one caches, some for stored procedures, some for requests etc.

BTW, exactly this difference shows the reason to have different groups for different resources.

Thanks,
Kirill

