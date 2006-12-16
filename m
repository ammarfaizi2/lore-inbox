Return-Path: <linux-kernel-owner+w=401wt.eu-S1422758AbWLPXKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422758AbWLPXKm (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 18:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422712AbWLPXKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 18:10:41 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46301 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422758AbWLPXKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 18:10:41 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kill_something_info: misc cleanups
References: <20061216200510.GA5535@tv-sign.ru>
Date: Sat, 16 Dec 2006 16:10:01 -0700
In-Reply-To: <20061216200510.GA5535@tv-sign.ru> (Oleg Nesterov's message of
	"Sat, 16 Dec 2006 23:05:10 +0300")
Message-ID: <m1psajtp2u.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> On top of
> 	signal-rewrite-kill_something_info-so-it-uses-newer-helpers.patch
>
> - Factor out sending PIDTYPE_PGID wide signals.
>
> - Use is_init(p) instead of "p->pid > 1". We don't hash idle threads anymore,
>   no need to worry about p->pid == 0.


I do not believe is_init is the proper function here.  In the presence
of multiple pid namespaces the intention is for is_init to catch all of
the special handling (except signal behavior) for the init process.

That way when we have multiple processes with pid == 1 we know which
one we care about.


> - Use "p != current->group_leader" instead of "p->tgid != current->tgid",
>   saves one dereference and kills yet another direct pid_t usage.

Makes sense as you have to be a group_leader to be on the task list.

> - Simplify return value calculation for "pid == -1" case, remove "retval"
>   variable.
>
> No functional changes.

Looks sane.

> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

Eric
