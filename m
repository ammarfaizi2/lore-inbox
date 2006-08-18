Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWHRIrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWHRIrD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 04:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWHRIrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 04:47:02 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:40886 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751243AbWHRIrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 04:47:00 -0400
Message-ID: <44E57F15.204@sw.ru>
Date: Fri, 18 Aug 2006 12:49:25 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: rohitseth@google.com
CC: Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting	(core)
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>	<1155754029.9274.21.camel@localhost.localdomain>	<1155755729.22595.101.camel@galaxy.corp.google.com>	<44E470B5.4020706@sw.ru> <1155834791.14617.42.camel@galaxy.corp.google.com>
In-Reply-To: <1155834791.14617.42.camel@galaxy.corp.google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth wrote:
> On Thu, 2006-08-17 at 17:35 +0400, Kirill Korotaev wrote:
> 
> 
>>>My preference would be to have container (I keep on saying container,
>>>but resource beancounter) pointer embeded in task, mm(not sure),
>>>address_space and anon_vma structures.  This should allow us to track
>>>user land pages optimally.  But for tracking kernel usage on behalf of
>>>user, we will have to use an additional field (unless we can re-use
>>>mapping).  Please correct me if I'm wrong, though all the kernel
>>>resources will be allocated/freed in context of a user process.  And at
>>>that time we know if a allocation should succeed or not.  So we may
>>>actually not need to track kernel pages that closely.  We are not going
>>>to run reclaim on any of them anyways.  
>>
>>objects are really allocated in process context
>>(except for TCP/IP and other softirqs which are done in arbitrary
>>process context!)
> 
> 
> Can these pages be tagged using mapping field of the page struct.
kernel pages can be taged with mapping field.
User pages - not. So we introduce 2 pointers in the unoin:
union {
  page_ub		// for kernel pages
  page_pb		// for user pages
}

> 
> 
>>And objects are not always freed in correct context (!).
>>
> 
> You mean beyond Networking and softirq.
> 
> 
>>Note, page_ub is not for _user_ pages. user pages accounting will be added
>>in next patch set. page_ub is added to track kernel allocations.
>>
> 
> 
> But will the page_ub be used for some purpose for user land pages?
yes. see above.

Kirill

