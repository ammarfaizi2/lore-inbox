Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262804AbVBFHsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbVBFHsB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 02:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVBFHsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 02:48:00 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:15252 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263527AbVBFHrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 02:47:46 -0500
Message-ID: <4205CB9E.4000402@yahoo.com.au>
Date: Sun, 06 Feb 2005 18:47:42 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, bstroesser@fujitsu-siemens.com,
       roland@redhat.com, jdike@addtoit.com, blaisorblade_spam@yahoo.it,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix wait_task_inactive race (was Re: Race condition in
 ptrace)
References: <42021E35.8050601@fujitsu-siemens.com> <4202C18F.5010605@yahoo.com.au> <42036C2C.5040503@fujitsu-siemens.com> <4203F40C.8040707@yahoo.com.au> <20050204143917.1f9507cb.akpm@osdl.org> <4204020F.2000501@yahoo.com.au> <42044D17.5040703@yahoo.com.au> <42058E52.8030306@yahoo.com.au> <20050206071935.GA19991@elte.hu> <4205C8EF.2000604@yahoo.com.au>
In-Reply-To: <4205C8EF.2000604@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Ingo Molnar wrote:
> 
>> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>>
>>
>>> When a task is put to sleep, it is dequeued from the runqueue
>>> while it is still running. The problem is that the runqueue
>>> lock can be dropped and retaken in schedule() before the task
>>> actually schedules off, and wait_task_inactive did not account
>>> for this.
>>
>>
>>
>> ugh. This has been the Nth time we got bitten by the fundamental
>> unrobustness of non-atomic scheduling on some architectures ...
>> (And i'll say the N+1th time that this is not good.)
>>
> 
> This is actually due to wake_sleeping_dependent and
> dependent_sleeper dropping the runqueue lock.
> 

Hmph, *and* unlocked context switch architectures as you say.
In fact, I'm surprised those haven't been bitten by this problem
earlier.

So that makes us each half right! :)

