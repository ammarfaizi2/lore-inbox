Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161322AbWHDRDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161322AbWHDRDG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 13:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161325AbWHDRDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 13:03:06 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:41896 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161322AbWHDRDE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 13:03:04 -0400
Message-ID: <44D37DC3.4000604@watson.ibm.com>
Date: Fri, 04 Aug 2006 13:02:59 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: vatsa@in.ibm.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, mingo@elte.hu, nickpiggin@yahoo.com.au,
       sam@vilain.net, linux-kernel@vger.kernel.org, dev@openvz.org,
       efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [ProbableSpam] Re: [RFC, PATCH 0/5] Going forward with Resource
 Management - A cpu  controller
References: <20060804050753.GD27194@in.ibm.com> <20060803223650.423f2e6a.akpm@osdl.org> <20060803224253.49068b98.akpm@osdl.org> <1154684950.23655.178.camel@localhost.localdomain> <20060804114109.GA28988@in.ibm.com> <44D35F0B.5000801@sw.ru> <20060804153123.GB32412@in.ibm.com> <44D36FB5.3050002@sw.ru>
In-Reply-To: <44D36FB5.3050002@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:

>> The use cases I have heard of which would benefit such a feature is
>> (say) for database threads which want to change their "resource
>> affinity" status depending on which customer query they are currently
>> handling. If they are handling a query for a "important" customer,
>> they will want affinied
>> to a high bandwidth resource container and later if they start handling
>> a less important query they will want to give up this affinity and
>> instead move to a low-bandwidth container.
> 
> this works mostly for CPU only. 

And for block I/O bandwidth control since the priority of I/O requests can
also be changed dynamically pretty easily.


> And OpenVZ design allows to change CPU
> resource container  dynamically.
> 
> But such a trick works poorly for memory, because:
> 1. threads share lots of resources.
> 2. complex databases can have more complicated handling than a thread
> per request.
>  e.g. one thread servers memory pools, another one caches, some for
> stored procedures, some for requests etc.
> 

True. Stuff like memory, open files etc. are harder to control since
you can't take back allocations that easily and sharing with other tasks is
possible.

> BTW, exactly this difference shows the reason to have different groups
> for different resources.
> 

Good point.

> Thanks,
> Kirill
> 

