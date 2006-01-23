Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWAWS0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWAWS0W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 13:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWAWS0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 13:26:22 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15499 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751427AbWAWS0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 13:26:21 -0500
To: Albert Cahalan <acahalan@gmail.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org
Subject: Re: anon unions are cool
References: <787b0d920601221636h7acbb891wd52b88e0aea75aaf@mail.gmail.com>
	<5AB1D65D-8F03-4CDF-9847-D75143EC0A9C@mac.com>
	<787b0d920601221717v460283eclc72380ae541d7fef@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 23 Jan 2006 11:25:56 -0700
In-Reply-To: <787b0d920601221717v460283eclc72380ae541d7fef@mail.gmail.com> (Albert
 Cahalan's message of "Sun, 22 Jan 2006 20:17:21 -0500")
Message-ID: <m1wtgqls23.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <acahalan@gmail.com> writes:

> This case is rather interesting. At more than one place I've worked,
> I found people assuming that the kernel's "pid" was a pid, when in
> fact it is a tid. (a "task ID" or "thread ID") The confusion probably
> leads to kernel bugs. I've seen many bugs related to this, though I
> can't be 100% sure that they don't all involve code that existed prior
> to the tgid concept.

Actually this is a really weird area.  A lot of it depends on your
perspective.  current->pid is more than just a thread group ID.

You can always use kill to send a signal to the ``pid'' of any
task.  However if that task is part of a thread group the signal
might go to one of that threads siblings.

If you were to follow the normal rules and send to a signal
to a thread group.  All threads would get it.  Although I
don't think the kernel has code for that.

So from a signal perspective current->pid is the pid.

However get_pid has been modified to return the thread group id.
Instead of the PID.  And a lot of times when you are exporting
information to user space you want the thread group id.

But in practice neither thread ID nor process ID map directly
to the kernels concept.

Then there is the other weird side where only the leaders of
thread groups are placed in sessions and process groups.

Eric


