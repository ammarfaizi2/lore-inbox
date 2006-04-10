Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWDJEzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWDJEzI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 00:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWDJEzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 00:55:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2726 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750876AbWDJEzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 00:55:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] coredump: kill ptrace related stuff
In-Reply-To: Oleg Nesterov's message of  Friday, 7 April 2006 02:06:31 +0400 <20060406220631.GA240@oleg>
Emacs: impress your (remaining) friends and neighbors.
Message-Id: <20060410045451.434ED1809D1@magilla.sf.frob.com>
Date: Sun,  9 Apr 2006 21:54:51 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With this patch zap_process() sets SIGNAL_GROUP_EXIT while sending
> SIGKILL to the thread group. 

do_coredump has already done this.  So you are addressing the case of other
thread groups sharing the mm, right?

> This means that a TASK_TRACED task
> 
> 	1. Will be awakened by signal_wake_up(1)

That should always happen regardless of signal->flags, so yes.

> 	2. Can't sleep again via ptrace_notify()

What makes this be so?  What if it's entering a notification event now?
What about exit tracing?

> 	3. Can't go to do_signal_stop() after return
> 	   from ptrace_stop() in get_signal_to_deliver()

This is only true because of the check in get_signal_to_deliver,
which I've said I think should be taken out for other reasons.

I guess I'm missing something here.


Thanks,
Roland
