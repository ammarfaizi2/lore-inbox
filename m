Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262963AbVBDXQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbVBDXQn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 18:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266388AbVBDXQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 18:16:41 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:50331 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266382AbVBDXPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 18:15:31 -0500
Message-ID: <4204020F.2000501@yahoo.com.au>
Date: Sat, 05 Feb 2005 10:15:27 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: bstroesser@fujitsu-siemens.com, roland@redhat.com, jdike@addtoit.com,
       blaisorblade_spam@yahoo.it, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Race condition in ptrace
References: <42021E35.8050601@fujitsu-siemens.com>	<4202C18F.5010605@yahoo.com.au>	<42036C2C.5040503@fujitsu-siemens.com>	<4203F40C.8040707@yahoo.com.au> <20050204143917.1f9507cb.akpm@osdl.org>
In-Reply-To: <20050204143917.1f9507cb.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>Bodo Stroesser wrote:
>>
>>>Nick Piggin wrote:
>>>
>>>
>>>>Bodo Stroesser wrote:
>>
>>>>I don't see how this could help because AFAIKS, child->saving is only
>>>>set and cleared while the runqueue is locked. And the same runqueue lock
>>>>is taken by wait_task_inactive.
>>>>
>>>
>>>Sorry, that not right. There are some routines called by sched(), that 
>>>release
>>>and reacquire the runqueue lock.
>>>
>>
>>Oh yeah, it is the wake_sleeping_dependent / dependent_sleeper crap.
>>Sorry, you are right. And that's definitely a bug in sched.c, because
>>it breaks wait_task_inactive, as you've rightly observed.
>>
>>Andrew, IMO this is another bug to hold 2.6.11 for.
> 
> 
> Sure.  I wouldn't consider Bodo's patch to be the one to use though..

No. Something similar could be done that works on all architectures
and all wait_task_inactive callers (and is confined to sched.c). That
would still be more or less a hack to work around smtnice's unfortunate
locking though.

