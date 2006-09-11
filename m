Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWIKFAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWIKFAp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 01:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWIKFAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 01:00:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32931 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751152AbWIKFAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 01:00:44 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] introduce get_task_pid() to fix unsafe get_pid()
References: <20060911022535.GA7095@oleg>
	<m1venvawbi.fsf@ebiederm.dsl.xmission.com>
	<20060911043751.GA7320@oleg>
Date: Sun, 10 Sep 2006 22:59:37 -0600
In-Reply-To: <20060911043751.GA7320@oleg> (Oleg Nesterov's message of "Mon, 11
	Sep 2006 08:37:51 +0400")
Message-ID: <m1mz97athi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> On 09/10, Eric W. Biederman wrote:
>> 
>> As for the functions can we build them in all 4 varieties.
>> struct pid *get_task_pid(struct task *);
>> struct pid *get_task_tgid(struct task *);
>> struct pid *get_task_pgrp(struct task *);
>> struct pid *get_task_session(struct task *);
>
> Something like the patch below?

Yes something like that.  Although it doesn't provide for the 
get_task_tgid case, and your patch only get_task_pid.

>> Either that or we can just drop in some rcu_read_lock() rcu_read_unlock()
>> into the call sites.
>
> Possible. I don't have a strong opinion, please feel free to send
> a different patch.

I just might.  Coming up with an idiom that is hard to get wrong,
is desirable here, or at least with an idiom that is consistent.

I need to sleep on it before I can answer which way we handle that.
The pain with a new idiom is that I will have to update all of the
users so all of the examples in the kernel are consistent.

I might just need to do that anyway, but...


Eric
