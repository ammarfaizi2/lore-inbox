Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268368AbTAMWZN>; Mon, 13 Jan 2003 17:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268370AbTAMWZN>; Mon, 13 Jan 2003 17:25:13 -0500
Received: from sex.inr.ac.ru ([193.233.7.165]:59871 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S268368AbTAMWZM>;
	Mon, 13 Jan 2003 17:25:12 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200301132232.BAA09527@sex.inr.ac.ru>
Subject: Re: [RFC] Migrating net/sched to new module interface
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Tue, 14 Jan 2003 01:32:56 +0300 (MSK)
Cc: kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
In-Reply-To: <20030103051033.1A2AA2C003@lists.samba.org> from "Rusty Russell" at Jan 3, 3 04:10:19 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Hmm, I thought the sched stuff all runs under the network brlock?  If
> so, it doesn't need to be held in, since it's not preemptible.
> 
> I haven't checked, though...

It runs under semaphore.


Which does not matter at all, because the hole

void cleanup_module(void)
{
<an instance is cloned here>
        unregister_qdisc(&cbq_qdisc_ops);
}

remained in any case, be it under some preemptive, nonprepemtive lock or
not under a lock at all.

BTW, Rusty, a question... I do not understand, what is purpose of this "new"
module stuff at all? If we still need to query something in module.c to create
each instanse of something it smells exactly "old" broken approach. I just
do not see differences. It is not essential in this particular case,
but it would be funny to ask it each time when creating a tcp socket.

Alexey

