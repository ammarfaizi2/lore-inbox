Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266069AbUHaKAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266069AbUHaKAX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 06:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266895AbUHaKAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 06:00:23 -0400
Received: from zero.aec.at ([193.170.194.10]:23300 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266069AbUHaKAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 06:00:22 -0400
To: Roland McGrath <roland@redhat.com>
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: [PATCH] cleanup ptrace stops and remove notify_parent
References: <2z7vs-2F1-13@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 31 Aug 2004 12:00:02 +0200
In-Reply-To: <2z7vs-2F1-13@gated-at.bofh.it> (Roland McGrath's message of
 "Tue, 31 Aug 2004 05:30:10 +0200")
Message-ID: <m3hdqjk4pp.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> writes:

> This patch is against Linus's current tree.
>
> This adds a new state TASK_TRACED that is used in place of TASK_STOPPED
> when a thread stops because it is ptraced.  Now ptrace operations are only
> permitted when the target is in TASK_TRACED state, not in TASK_STOPPED.
> This means that if a process is stopped normally by a job control signal
> and then you PTRACE_ATTACH to it, you will have to send it a SIGCONT before
> you can do any ptrace operations on it.  (The SIGCONT will be reported to
> ptrace and then you can discard it instead of passing it through when you
> call PTRACE_CONT et al.)

Are you sure such a user visible semantic change is a good idea? 

I at least have written (not very important, but existing) user space
code in the past that assumed it can stop and single step without
SIGCONT. I wouldn't be surprised if other debuggers ran into 
the same issue.

And the Linux debugging world is not gdb only anymore, there are
a lot of other users of ptrace around these days ...

I don't think it is very good to change such behaviour in 2.6.
Please don't do it.

-Andi

