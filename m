Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965095AbWHOSpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbWHOSpc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbWHOSpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:45:32 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62671 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965095AbWHOSpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:45:30 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       containers@lists.osdl.org, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [PATCH 6/7] vt: Update spawnpid to be a struct pid_t
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
	<1155666193191-git-send-email-ebiederm@xmission.com>
	<1155667982.24077.307.camel@localhost.localdomain>
Date: Tue, 15 Aug 2006 12:45:09 -0600
In-Reply-To: <1155667982.24077.307.camel@localhost.localdomain> (Alan Cox's
	message of "Tue, 15 Aug 2006 19:53:02 +0100")
Message-ID: <m13bbx96tm.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Ar Maw, 2006-08-15 am 12:23 -0600, ysgrifennodd Eric W. Biederman:
>> This keeps the wrong process from being notified if the
>> daemon to spawn a new console dies.
>
> Not sure why we count pids not task structs but within the proposed
> implementation this appears correct so

Basically struct pid is relatively cheap, 64bytes or so.
struct task is expensive 10K or so, when all of the stacks
and everything are included.

Counting pids allows the task to exit in user space and free up
all of it's memory.

When /proc used to count the task struct it was fairly easy to
deliberately oom a 32bit machine just by open up directories in
/proc and then having the process exit.  rlimits didn't help because
we don't count processes that have exited.

>
> Acked-by: Alan Cox <alan@redhat.com>

Thanks.  When I get to the tty portion of this I think I am going
to have to synchronize with you as last I looked you were working in
this area as well.

Eric

