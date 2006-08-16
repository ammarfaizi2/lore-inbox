Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWHPQSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWHPQSy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWHPQSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:18:54 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30848 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751121AbWHPQSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:18:53 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       containers@lists.osdl.org
Subject: Re: [PATCH 5/7] pid: Implement pid_nr
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
	<1155666193751-git-send-email-ebiederm@xmission.com>
	<20060816181950.GA472@oleg>
Date: Wed, 16 Aug 2006 10:18:20 -0600
In-Reply-To: <20060816181950.GA472@oleg> (Oleg Nesterov's message of "Wed, 16
	Aug 2006 22:19:50 +0400")
Message-ID: <m1lkpo3b8z.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> On 08/15, Eric W. Biederman wrote:
>>
>> +static inline pid_t pid_nr(struct pid *pid)
>> +{
>> +	pid_t nr = 0;
>> +	if (pid)
>> +		nr = pid->nr;
>> +	return nr;
>> +}
>
> I think this is not safe, you need rcu locks here or the caller should
> do some locking.
>
> Let's look at f_getown() (PATCH 7/7). What if original task which was
> pointed by ->f_owner.pid has gone, another thread does fcntl(F_SETOWN),
> and pid_nr() takes a preemtion after 'if (pid)'? In this case 'pid->nr'
> may follow a freed memory.

This isn't an rcu reference.  I hold a hard reference count on
the pid entry.  So this should be safe.

What is an rcu reference is going from struct pid to the task
it points to.

Eric




