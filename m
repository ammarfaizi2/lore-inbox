Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWDKGZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWDKGZN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 02:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWDKGZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 02:25:12 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29314 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932231AbWDKGZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 02:25:11 -0400
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] de_thread: Don't confuse users do_each_thread.
References: <20060406220403.GA205@oleg>
	<m1acay1fbh.fsf@ebiederm.dsl.xmission.com>
	<20060407234653.GB11460@oleg> <20060407155113.37d6a3b3.akpm@osdl.org>
	<20060407155619.18f3c5ec.akpm@osdl.org>
	<m1d5fslcwx.fsf@ebiederm.dsl.xmission.com> <20060408172745.GA89@oleg>
	<m1y7yddo75.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u091dnry.fsf@ebiederm.dsl.xmission.com> <20060411100527.GA112@oleg>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 11 Apr 2006 00:23:57 -0600
In-Reply-To: <20060411100527.GA112@oleg> (Oleg Nesterov's message of "Tue,
 11 Apr 2006 14:05:27 +0400")
Message-ID: <m14q10eiki.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> On 04/10, Eric W. Biederman wrote:
>>
>> I believe this is 2.6.17 material as the bug is present in
>> 2.6.17-rc1 and the fix is simple.
>>
>> ...
>>
>> +		list_del_init(&leader->tasks);
>
> I beleive this is ok for 2.6.17-rc1, but this breaks lockless
> for_each_process/while_each_thread (I am talking about -mm tree).

Agreed.

> Andrew, could you please drop these ones:
>
> 	task-make-task-list-manipulations-rcu-safe-fix.patch
> 	task-make-task-list-manipulations-rcu-safe-fix-fix.patch
>
> Then we need this "patch" for de_thread:
>
> -		list_add_tail_rcu(&current->tasks, &init_task.tasks);
> +		list_replace_rcu(&leader->tasks, &current->tasks);
>  ...
> -		list_del_init(&leader->tasks);
>
> Currently I don't know how the code looks in -mm tree, I lost the plot.


Since the patches don't conflict on context I bet they are
all in there, at the moment.  I am just about to see if I can
sort that out.

Eric
