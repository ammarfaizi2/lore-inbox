Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbVKGKP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbVKGKP1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 05:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbVKGKP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 05:15:27 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:9330 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964810AbVKGKP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 05:15:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=CH5xu+2vC8wWpWoL4zmG4pWnaxrD2Y7kYCy52fI3voswaw1jM0LvMCxVNUabNPiJoOKRAXs9KAFyYn909EQUnQAJZN/WyuqsiKi7E9T84hjVZ6j3SGp/UE5FY3hYHdzp19JZKaCWetFf/sifshRPZDwZcwrlBiRrNqABRGFEFnQ=  ;
Message-ID: <436F29BF.3010804@yahoo.com.au>
Date: Mon, 07 Nov 2005 21:17:35 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: ak@suse.de, akpm@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Clean up of __alloc_pages
References: <20051028183326.A28611@unix-os.sc.intel.com>	<20051106124944.0b2ccca1.pj@sgi.com>	<436EC2AF.4020202@yahoo.com.au>	<200511070442.58876.ak@suse.de>	<20051106203717.58c3eed0.pj@sgi.com>	<436EEF43.2050403@yahoo.com.au> <20051107014659.14c2631b.pj@sgi.com>
In-Reply-To: <20051107014659.14c2631b.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Nick wrote:

>>>And is the pair of operators:
>>>  task_lock(current), task_unlock(current)
>>>really that much worse than the pair of operators
>>>  ...
>>>  preempt_disable, preempt_enable
> 
> 
> That part still surprises me a little.  Is there enough difference in
> the performance between:
> 
>   1) task_lock, which is a spinlock on current->alloc_lock and
>   2) rcu_read_lock, which is .preempt_count++; barrier()
> 
> to justify a separate slab cache for cpusets and a little more code?
> 
> For all I know (not much) the task_lock might actually be cheaper ;).
> 

But on a preempt kernel the spinlock must disable preempt as well!

Not to mention that a spinlock is an atomic op (though that is getting
cheaper these days) + 2 memory barriers (getting more expensive).

> The semaphore down means doing an atomic_dec_return(), which imposes
> a memory barrier, right?
> 

Yep.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
