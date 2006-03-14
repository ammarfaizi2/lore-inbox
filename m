Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWCNURd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWCNURd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 15:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWCNURd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 15:17:33 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47817 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751452AbWCNURd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 15:17:33 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       William Irwin <wli@holomorphy.com>, Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH] task: Make task list manipulations RCU safe.
References: <m1bqwgx4za.fsf@ebiederm.dsl.xmission.com>
	<4416FF1F.5DA06CFB@tv-sign.ru>
	<m18xrcnbnn.fsf@ebiederm.dsl.xmission.com>
	<44170AD3.35031A67@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 14 Mar 2006 13:15:27 -0700
In-Reply-To: <44170AD3.35031A67@tv-sign.ru> (Oleg Nesterov's message of
 "Tue, 14 Mar 2006 21:26:27 +0300")
Message-ID: <m1mzfslr4w.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> "Eric W. Biederman" wrote:
>> 
>> Oleg Nesterov <oleg@tv-sign.ru> writes:
>> 
>> > Some questions.
>> >
>> > first_tgid:
>> >       ...
>> >       for (; pos && pid_alive(pos); pos = next_task(pos))
>> >
>> > I think this patch makes this 'pid_alive(pos)' unneeded?
>> 
>> Close.  The problem is that we could have slept with the
>> count elevated on start before we do rcu_read_lock().
>
> Yes, we could have slept. But (unlike next_tgid) this loop
> starts from pos=init_task or from pos=find_task_by_pid()
> and we are doing find_task_by_pid under rcu_read_lock() ?

Yes.  We are sorry. The bits of code blurred in the discussion.

Eric
