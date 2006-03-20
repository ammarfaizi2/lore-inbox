Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWCTS5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWCTS5u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 13:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWCTS5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 13:57:49 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29607 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964860AbWCTS5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 13:57:48 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] simplify/fix first_tid()
References: <441DB045.87C4134C@tv-sign.ru>
	<m1fyldvvvo.fsf@ebiederm.dsl.xmission.com>
	<441EF4D7.AEC1AE8C@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 20 Mar 2006 11:56:56 -0700
In-Reply-To: <441EF4D7.AEC1AE8C@tv-sign.ru> (Oleg Nesterov's message of
 "Mon, 20 Mar 2006 21:30:47 +0300")
Message-ID: <m1y7z5uepz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> "Eric W. Biederman" wrote:
>> This is better however if I read this code correctly.  It modifies
>> the code so the last time user space goes trough this loop
>> with nr > nr_threads.  Then we will walk the entire threads
>> list to achieve nothing.
>
> This can happen only if the thread we stopped at has exited, and
> some other threads have exited too, so that nr >= ->signal->count.
>
> I think it's not worth optimizing this rare and anyway slow path.
> However, you are the code author, I'll send a trivial patch which
> restores this optimization if you don't change you mind.
>
>> So we really still need the nr_threads test in there so we don't
>> traverse the list twice everytime through readdir.
>
> How so? We don't do it twice?

In general user space does.  Because a read of 0 bytes signifies
the end of a directory.

So we have 2 trips through proc_task_readdir initiated by user
space.

Eric
