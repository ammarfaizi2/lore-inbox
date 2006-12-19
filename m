Return-Path: <linux-kernel-owner+w=401wt.eu-S932866AbWLSSAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932866AbWLSSAy (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 13:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932871AbWLSSAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 13:00:54 -0500
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:48852 "EHLO
	liaag2ag.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932866AbWLSSAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 13:00:53 -0500
Date: Tue, 19 Dec 2006 12:55:06 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: problem with signal delivery SIGCHLD
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: linux-kernel@vger.kernel.org
Message-ID: <200612191259_MC3-1-D597-DE30@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <Pine.LNX.4.60.0612181924470.2560@rtl14.hofr.at>

On Mon, 18 Dec 2006 20:05:35 +0100, Nicholas Mc Guire wrote:

>   I have a phenomena that I don't quite understand. gdbserver forks and 
> after setting ptrace (PTRACE_TRACEME, 0, 0, 0); it then execv 
> (program, allargs); when this child process hits ptrace_stoped (breakpoint
> it does the following in kernel space:
> 
>                                      pid
>           1        559          5    1242 ptrace_stop
>           3          6          2    1242 |  do_notify_parent_cldstop
>           4          3          2    1242 |  |  __group_send_sig_info
>           5          1          1    1242 |  |  |  handle_stop_signal
>           7          0          0    1242 |  |  |  sig_ignored
>           8          1          0    1242 |  |  __wake_up_sync
>           8          1          1    1242 |  |  |  __wake_up_common
>          10        547        541    1242 |  schedule
>          10          2          2    1242 |  |  profile_hit
>          13          1          1    1242 |  |  sched_clock
>          15          1          0    1242 |  |  deactivate_task
>          15          1          1    1242 |  |  |  dequeue_task
>          19          2          2       0 |  |  __switch_to

>          24        574        574       0 default_idle

> So basically child signals -> delayed to next tick -> parent wakes up.

What do the first three columns represent?

Do you see __wake_up_common() calling default_wake_function()?

Can you trace through schedule() and see exactly how it decides to
run the idle task instead of the newly-woken parent?  Exactly what
path does it take?  (And which kernel version is this?)

-- 
MBTI: IXTP

