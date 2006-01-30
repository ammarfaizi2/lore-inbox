Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbWA3Udn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWA3Udn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 15:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWA3Udn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 15:33:43 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41350 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964959AbWA3Udm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 15:33:42 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: Cleanup exec from a non thread group leader.
References: <43DDFDE3.58C01234@tv-sign.ru> <43DE2730.795468DC@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 30 Jan 2006 13:33:11 -0700
In-Reply-To: <43DE2730.795468DC@tv-sign.ru> (Oleg Nesterov's message of
 "Mon, 30 Jan 2006 17:48:16 +0300")
Message-ID: <m1vew15ud4.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> Oleg Nesterov wrote:
>> 
>> Eric W. Biederman wrote:
>> >
>> > -     list_add_tail(&thread->tasks, &init_task.tasks);
>> 
>> The last deletion is wrong, I beleive.
>
> Just to clarify, it looks like we can kill this line because
> de_thread() also does list_add_tail(current, &init_task.tasks).
>
> But please note that it (and probably __ptrace_link() above)
> does list_del(current->task) first, and current->task may have
> very stale values after old leader called dup_task_struct().
> SET_LINKS() in copy_process() does nothing with ->tasks in a
> CLONE_THREAD case.

Good point in that instance we need to remove the list_del
as well.

As for the other stale data that bears looking at.

Eric
