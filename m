Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWDXFNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWDXFNO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 01:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWDXFNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 01:13:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2786 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750728AbWDXFNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 01:13:14 -0400
Date: Sun, 23 Apr 2006 22:11:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] threads_max: Simple lockout prevention patch
Message-Id: <20060423221157.6a4b5c8e.akpm@osdl.org>
In-Reply-To: <200604240756.42483.a1426z@gawab.com>
References: <200511142327.18510.a1426z@gawab.com>
	<200601301621.11463.a1426z@gawab.com>
	<200604240756.42483.a1426z@gawab.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi <a1426z@gawab.com> wrote:
>
> This is a another resend, which was ignored before w/o comment.
> Andrew, can you at least comment on it?  Thanks!
> 

I don't have a clue what it's for.

> 
> Simple attempt to provide a backdoor in a process lockout situation.
> 
> echo $$ > /proc/sys/kernel/su-pid allows pid to exceed the threads_max limit.
> 
> Note that this patch incurs zero runtime-overhead.
> 
> Signed-off-by: Al Boldi <a1426z@gawab.com>
> 
> ---
> (patch against 2.6.14)
> 
> --- kernel/fork.c.orig  2005-11-14 20:55:33.000000000 +0300
> +++ kernel/fork.c       2005-11-14 20:58:25.000000000 +0300

Please prepare patches in `patch -p1' form.

> @@ -57,6 +57,7 @@
>  int nr_threads;                /* The idle threads do not count.. */
>  
>  int max_threads;               /* tunable limit on nr_threads */
> +int su_pid;		/* BackDoor pid to exceed limit on nr_threads */
>  
>  DEFINE_PER_CPU(unsigned long, process_counts) = 0;
>  
> @@ -926,6 +927,7 @@
>          * to stop root fork bombs.
>          */
>         if (nr_threads >= max_threads)
> +       if (p->pid != su_pid)
>                 goto bad_fork_cleanup_count;

We don't lay code out in that manner.  Not even vaguely.

This check comes after the RLIMIT_PROC check, which is supposed to
eliminate "process lockout situations", although you haven't really defined
that.

>         if (!try_module_get(p->thread_info->exec_domain->module))

Your email client replaces tabs with spaces.

>         KERN_SETUID_DUMPABLE=69, /* int: behaviour of dumps for setuid core 
> */

And it wordwraps.


