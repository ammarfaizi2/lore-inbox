Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422910AbWBBEkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422910AbWBBEkV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 23:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422918AbWBBEkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 23:40:21 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58279 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422910AbWBBEkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 23:40:20 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc1-mm] simplify exec from init's subthread
References: <200601312208.k0VM8hT4002399@shell0.pdx.osdl.net>
	<43E10F5D.54A0B990@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 01 Feb 2006 21:39:41 -0700
In-Reply-To: <43E10F5D.54A0B990@tv-sign.ru> (Oleg Nesterov's message of
 "Wed, 01 Feb 2006 22:43:25 +0300")
Message-ID: <m1k6cewf02.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> [ On top of "exec: allow init to exec from any thread.",
>   filename exec-allow-init-to-exec-from-any-thread.patch ]
>
> I think it is enough to take tasklist_lock for reading while
> changing child_reaper:
>
> 	Reparenting needs write_lock(tasklist_lock)
>
> 	Only one thread in a thread group can do exec()
>
> 	sighand->siglock garantees that get_signal_to_deliver()
> 	will not see a stale value of child_reaper.
>
> This means that we can change child_reaper earlier, without
> calling zap_other_threads() twice.
>
> "child_reaper = current" is a NOOP when init does exec from
> main thread, we don't care.

Looks good.  I fat fingered my locking anyway, and this
looks like a good fix, as well as the more obvious place,
to do this.

Acked-by:  Eric Biederman <ebiederm@xmission.com>
