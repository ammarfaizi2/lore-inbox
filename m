Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVAAJNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVAAJNp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 04:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbVAAJNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 04:13:45 -0500
Received: from one.firstfloor.org ([213.235.205.2]:64436 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262202AbVAAJNn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 04:13:43 -0500
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5isms
References: <20041231230624.GA29411@andromeda> <41D60C35.9000503@yahoo.com.au>
From: Andi Kleen <ak@muc.de>
Date: Sat, 01 Jan 2005 10:13:41 +0100
In-Reply-To: <41D60C35.9000503@yahoo.com.au> (Nick Piggin's message of "Sat,
 01 Jan 2005 13:34:29 +1100")
Message-ID: <m1acrt7bqy.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> writes:

> Justin Pryzby wrote:
>> Hi all, I have more 2.5isms for the list.  ./fs/binfmt_elf.c:
>>   #ifdef CONFIG_X86_HT
>>                   /*
>>                    * In some cases (e.g. Hyper-Threading), we want to avoid L1
>>                    * evictions by the processes running on the same package. One
>>                    * thing we can do is to shuffle the initial stack for them.
>>                    *
>>                    * The conditionals here are unneeded, but kept in to make the
>>                    * code behaviour the same as pre change unless we have
>>                    * hyperthreaded processors. This should be cleaned up
>>                    * before 2.6
>>                    */
>>                   if (smp_num_siblings > 1)
>>                           STACK_ALLOC(p, ((current->pid % 64) << 7));
>>   #endif
>>
>
> Can we just kill it? Or do it unconditionally? Or maybe better yet, wrap
> it properly in arch code?

You can't kill it without ruining performance on older HT CPUs.
I would just keep it, it fixes the problem perhaps with a small amount of 
code. A more generalized #ifdef may be a good idea (NEED_STACK_RANDOM)
may be a good idea, but it is not really a pressing need. Enabling 
it unconditionally may be an option, although it will make it harder
to repeat test runs on non hyperthreaded CPUs.

-Andi

