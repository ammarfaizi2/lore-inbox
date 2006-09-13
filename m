Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030409AbWIMAHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030409AbWIMAHv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 20:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030416AbWIMAHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 20:07:51 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:30156 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030409AbWIMAHu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 20:07:50 -0400
Message-ID: <45074BD0.3060400@watson.ibm.com>
Date: Tue, 12 Sep 2006 20:07:44 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       rhim@cc.gateh.edu
Subject: Re: [patch 1/9] Guest page hinting: unused / free pages.
References: <20060901110908.GB15684@skybase> <45073901.8020906@redhat.com>
In-Reply-To: <45073901.8020906@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> Martin Schwidefsky wrote:
> 
>> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> From: Hubertus Franke <frankeh@watson.ibm.com>
>> From: Himanshu Raj <rhim@cc.gatech.edu>
>>
>> [patch 1/9] Guest page hinting: unused / free pages.
>>
>> A very simple but already quite effective improvement in the handling
>> of guest memory vs. host memory is to tell the host when pages are
>> free. 
> 
> 
> Would it be an idea to place this interface in-between the
> per-cpu free page lists and the buddy allocator, so we can
> move a batch of pages around at once and do the hinting in
> a batched fashion ?
> 
> That way the overhead will be acceptable not just on S390
> (where things are millicoded), but also on hypervisor based
> virtualization like Xen.
> 
> Easy enough to pass a vector of pages to the hypervisor.
> 

Rik, I thought that what we did.
Martin, I see the code actually does it when the page goes into the hot/cold
list. I can't remember conciously moving to that.
I thought we had a decent hit on the hot/cold, so that bulking makes sense.

Then the interface of bulking could be introduced and for s390 it could internally
be implemented as a sequence of ESSA instruction.
Do you remember the reason why we ended up putting it as part of hot/cold freeing?

-- Hubertus

