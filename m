Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWCNS32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWCNS32 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 13:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbWCNS32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 13:29:28 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:29369 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750937AbWCNS31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 13:29:27 -0500
Message-ID: <44170AD3.35031A67@tv-sign.ru>
Date: Tue, 14 Mar 2006 21:26:27 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       William Irwin <wli@holomorphy.com>, Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH] task: Make task list manipulations RCU safe.
References: <m1bqwgx4za.fsf@ebiederm.dsl.xmission.com>
		<4416FF1F.5DA06CFB@tv-sign.ru> <m18xrcnbnn.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> Oleg Nesterov <oleg@tv-sign.ru> writes:
> 
> > Some questions.
> >
> > first_tgid:
> >       ...
> >       for (; pos && pid_alive(pos); pos = next_task(pos))
> >
> > I think this patch makes this 'pid_alive(pos)' unneeded?
> 
> Close.  The problem is that we could have slept with the
> count elevated on start before we do rcu_read_lock().

Yes, we could have slept. But (unlike next_tgid) this loop
starts from pos=init_task or from pos=find_task_by_pid()
and we are doing find_task_by_pid under rcu_read_lock() ?

Oleg.
