Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWCFWTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWCFWTg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWCFWTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:19:36 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38095 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932382AbWCFWTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:19:35 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 01/23] tref: Implement task references.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
	<m1mzgidnr0.fsf@ebiederm.dsl.xmission.com>
	<44074479.15D306EB@tv-sign.ru>
	<m14q2gjxqo.fsf@ebiederm.dsl.xmission.com>
	<440CA459.6627024C@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Mar 2006 15:18:56 -0700
In-Reply-To: <440CA459.6627024C@tv-sign.ru> (Oleg Nesterov's message of
 "Tue, 07 Mar 2006 00:06:33 +0300")
Message-ID: <m1wtf76wtr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> I think I have a really good idea.
>
> Forget about task ref for a moment. I thinks we can greatly
> simplify the pids management. We don't PIDTYPE_MAX hash tables,
> we need only one.

I like it.  If we run top we wind of with the same number of dynamic
allocations, with task_refs (because /proc uses them).  The amount of
memory utilized is lower.  Probes for unused sessions and process
groups are a little more expensive but not noticeably so.

Unless we can implement do_each_task_pid/while_each_task_pid in terms
of for_each_task_pid.  I am nervous about making the conversion.

During fork is a very nice time to allocate these as it allows the
rest of the code to assume they are always available.

I think we had something similar several years ago, that's where
the name struct pid came from.  But it used a separate head for each
type of pid, and it used a separate structure for what we now embed
in struct task.

It completely breaks my patch for multiple pid spaces. Oh well it
isn't merged anyway. :)

> And noe we can inplement pid_ref almost for free, just add ->count
> to 'struct pid_head'.
>
> What do you think?

I will take a good hard look at it once I send off my patchs to shore
up task_refs in the -mm tree.

Eric
