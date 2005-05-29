Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVE2EFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVE2EFU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 00:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVE2EFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 00:05:20 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:5018 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261227AbVE2EFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 00:05:13 -0400
Message-ID: <42993F71.2080501@yahoo.com.au>
Date: Sun, 29 May 2005 14:05:05 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [patch] remove set_tsk_need_resched() from init_idle()
References: <20050524121541.GA17049@elte.hu> <20050524140623.GA3500@elte.hu> <4293420C.8080400@yahoo.com.au> <20050524150537.GA11829@elte.hu> <42934748.8020501@yahoo.com.au> <20050524152759.GA15411@elte.hu> <20050524154230.GA17814@elte.hu> <20050525052400.46bccf26.akpm@osdl.org> <20050525135130.GA27088@elte.hu> <20050528173241.C4711@flint.arm.linux.org.uk> <20050528185123.GA13961@elte.hu>
In-Reply-To: <20050528185123.GA13961@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[re-added Russell to the CC list]

Ingo Molnar wrote:
> * Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
> 
>>>The patch below should address this problem for all architectures, by 
>>>doing an explicit schedule() in the init code before calling into 
>>>cpu_idle().
>>
>>Yuck - wouldn't it be better just to fix all the architectures instead 
>>of applying band aid?
> 
> 
> it's not really a bug in any architecture - it's a scheduler setup 
> detail that i changed, and which i initially thought would be best 
> handled in cpu_idle(), but which is easier to do in rest_init().
> 

Hmm, what has changed is that secondary CPUs haven't got
need_resched set in their idle routines. Whether or not it
is possible to a task on their runqueue at that stage, I
didn't bother looking - I assume you did.

However, Ingo - instead of calling schedule() at the end of
rest_init(), why not just set need_resched instead?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
