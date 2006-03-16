Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWCPQ2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWCPQ2v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 11:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWCPQ2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 11:28:51 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10722 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932406AbWCPQ2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 11:28:50 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org,
       Michael Kerrisk <michael.kerrisk@gmx.net>
Subject: Re: [PATCH] make fork() atomic wrt pgrp/session signals
References: <44198BC4.EE653B1@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 16 Mar 2006 09:27:31 -0700
In-Reply-To: <44198BC4.EE653B1@tv-sign.ru> (Oleg Nesterov's message of "Thu,
 16 Mar 2006 19:01:08 +0300")
Message-ID: <m164mebbik.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> Eric W. Biederman wrote:
>>
>> Ok. SUSV3/Posix is clear, fork is atomic with respect
>> to signals.  Either a signal comes before or after a
>> fork but not during. (See the rationale section).
>> http://www.opengroup.org/onlinepubs/000095399/functions/fork.html
>>
>> The tasklist_lock does not stop forks from adding to a process
>> group. The forks stall while the tasklist_lock is held, but a fork
>> that began before we grabbed the tasklist_lock simply completes
>> afterwards, and the child does not receive the signal.
>
> This also means that SIGSTOP or sig_kernel_coredump() signal can't
> be delivered to pgrp/session reliably.
>
> With this patch copy_process() returns -ERESTARTNOINTR when it
> detects a pending signal, fork() will be restarted transparently
> after handling the signals.
>
> This patch also deletes now unneeded "group_stop_count > 0" check,
> copy_process() can no longer succeed while group stop in progress.
>
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

Looks like what we discussed and I can't see any flaws with it.

Acked-By: Eric Biederman <ebiederm@xmission.com>
