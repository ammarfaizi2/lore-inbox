Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVBEAe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVBEAe1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 19:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265039AbVBDWtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 17:49:51 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:25021 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263197AbVBDWPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 17:15:52 -0500
Message-ID: <4203F40C.8040707@yahoo.com.au>
Date: Sat, 05 Feb 2005 09:15:40 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
CC: Roland Mc Grath <roland@redhat.com>, Jeff Dike <jdike@addtoit.com>,
       BlaisorBlade <blaisorblade_spam@yahoo.it>,
       user-mode-linux devel 
	<user-mode-linux-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Race condition in ptrace
References: <42021E35.8050601@fujitsu-siemens.com> <4202C18F.5010605@yahoo.com.au> <42036C2C.5040503@fujitsu-siemens.com>
In-Reply-To: <42036C2C.5040503@fujitsu-siemens.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Stroesser wrote:
> Nick Piggin wrote:
> 
>> Bodo Stroesser wrote:

>> I don't see how this could help because AFAIKS, child->saving is only
>> set and cleared while the runqueue is locked. And the same runqueue lock
>> is taken by wait_task_inactive.
>>
> 
> Sorry, that not right. There are some routines called by sched(), that 
> release
> and reacquire the runqueue lock.
> 

Oh yeah, it is the wake_sleeping_dependent / dependent_sleeper crap.
Sorry, you are right. And that's definitely a bug in sched.c, because
it breaks wait_task_inactive, as you've rightly observed.

Andrew, IMO this is another bug to hold 2.6.11 for.

