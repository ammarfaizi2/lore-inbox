Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263892AbTCVVfm>; Sat, 22 Mar 2003 16:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263895AbTCVVfm>; Sat, 22 Mar 2003 16:35:42 -0500
Received: from packet.digeo.com ([12.110.80.53]:25067 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263892AbTCVVfl>;
	Sat, 22 Mar 2003 16:35:41 -0500
Date: Sat, 22 Mar 2003 13:46:34 -0800
From: Andrew Morton <akpm@digeo.com>
To: Dawson Engler <engler@csl.stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] race in 2.5.62/kernel/ptrace.c?
Message-Id: <20030322134634.5b159b8d.akpm@digeo.com>
In-Reply-To: <200303221947.h2MJlHA24028@csl.stanford.edu>
References: <200303221947.h2MJlHA24028@csl.stanford.edu>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Mar 2003 21:46:34.0894 (UTC) FILETIME=[8236C2E0:01C2F0BC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dawson Engler <engler@csl.stanford.edu> wrote:
>
> Is the following unlocked use of recalc_sigpending  a race?
> 
> // 2.5.62/kernel/ptrace.c:339:ptrace_notify:
> void ptrace_notify(int exit_code)
> {
>         BUG_ON (!(current->ptrace & PT_PTRACED));
> 
>         /* Let the debugger run.  */
>         current->exit_code = exit_code;
>         set_current_state(TASK_STOPPED);
>         notify_parent(current, SIGCHLD);
>         schedule();
> 
>         /*
>          * Signals sent while we were stopped might set TIF_SIGPENDING.
>          */
>         recalc_sigpending();
> }
> 

I think so.  To find out I shall send a patch to Linus and see if
I get shouted at.


