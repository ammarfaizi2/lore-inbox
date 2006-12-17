Return-Path: <linux-kernel-owner+w=401wt.eu-S1751417AbWLQAhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWLQAhc (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 19:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWLQAhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 19:37:32 -0500
Received: from mail.screens.ru ([213.234.233.54]:48502 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417AbWLQAhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 19:37:31 -0500
Date: Sun, 17 Dec 2006 03:37:19 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kill_something_info: misc cleanups
Message-ID: <20061217003719.GA10479@tv-sign.ru>
References: <20061216200510.GA5535@tv-sign.ru> <m1psajtp2u.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1psajtp2u.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@tv-sign.ru> writes:
> 
> > On top of
> > 	signal-rewrite-kill_something_info-so-it-uses-newer-helpers.patch
> >
> > - Factor out sending PIDTYPE_PGID wide signals.
> >
> > - Use is_init(p) instead of "p->pid > 1". We don't hash idle threads anymore,
> >   no need to worry about p->pid == 0.
> 
> 
> I do not believe is_init is the proper function here.

Ok. How about child_reaper() for now? "p->pid == 1" doesn't look good either.

>                                                        In the presence
> of multiple pid namespaces

In that case we should use something else than for_each_process() to filter
out task from different namespaces, no?

>                             the intention is for is_init to catch all of
> the special handling (except signal behavior) for the init process.
>
> That way when we have multiple processes with pid == 1 we know which
> one we care about.

I must admit, I don't understand what is the purpose of pid namespace.
The current implementation looks incomplete. For example, mk_pid()
takes pid_namespace into account, but find_pid() (and thus attach_pid())
does not. Shouldn't pid_hash[] live in the "struct pid_namespace" ?

Oleg.

