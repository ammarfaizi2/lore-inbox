Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVAGRbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVAGRbJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 12:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVAGRbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 12:31:09 -0500
Received: from relay01.pair.com ([209.68.5.15]:11281 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S261359AbVAGR3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 12:29:37 -0500
X-pair-Authenticated: 66.134.112.218
Subject: Re: Process blocking behaviour
From: Daniel Gryniewicz <dang@fprintf.net>
To: selvakumar nagendran <kernelselva@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050107065809.60035.qmail@web60604.mail.yahoo.com>
References: <20050107065809.60035.qmail@web60604.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jan 2005 12:29:36 -0500
Message-Id: <1105118976.25618.5.camel@athena.fprintf.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-06 at 22:58 -0800, selvakumar nagendran wrote:
> Hello linux-experts,
>    
>   I am intercepting system calls in Linux kernel
> 2.4.28.
>   
>   Pseudo-code:
>   ------------
>     saved_old_syscall =
> sys_call_table[sycallno(read)];
>     sys_call_table[read] = my_sys_call;
>     
>   my_sys_call(file descriptor)
>   -------------
>      Call saved_old_syscall(file descriptor).
>     
>      Now at this point, I want to determine whether
> the system call blocks waiting for the file descriptor
> resource. How can I do that? Should I modify the
> kernel code only for this?
> 
>    Can I check its state after the call as
>      if (task_current_state == INTERRUPTIBLE
>             || UNINTERRUPTIBLE) to do this?

No, you can't, because by the time the syscall returns to you, it's
blocked, scheduled, unblocked, and been rescheduled.  It's too late.  I
don't think you can do what you want, without modifying all the syscalls
directly.

Besides, most blocks are for data, not on something like a semaphore.
What you really want is priority-inheritance semaphores, not
modification of syscalls.  I seem to remember someone working on such a
beast, and the RTOS versions of Linux presumably have something like
this, so you could check around.

Daniel
