Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbTDDGbr (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 01:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbTDDGbr (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 01:31:47 -0500
Received: from [12.47.58.55] ([12.47.58.55]:3278 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261366AbTDDGbf (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 01:31:35 -0500
Date: Thu, 3 Apr 2003 22:43:46 -0800
From: Andrew Morton <akpm@digeo.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch for show_task
Message-Id: <20030403224346.51d9680e.akpm@digeo.com>
In-Reply-To: <20030404013829.A30163@devserv.devel.redhat.com>
References: <20030404013829.A30163@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Apr 2003 06:42:56.0928 (UTC) FILETIME=[6D287200:01C2FA75]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev <zaitcev@redhat.com> wrote:
>
> Andrew, bkbits says you changed the line above to be p->thread_info.
> Unfortunately, there's another.
> 
> --- linux-2.5.66/kernel/sched.c	2003-03-24 14:01:16.000000000 -0800
> +++ linux-2.5.66-sparc/kernel/sched.c	2003-04-03 22:33:29.000000000 -0800
> @@ -2197,7 +2197,7 @@
>  		unsigned long * n = (unsigned long *) (p->thread_info+1);
>  		while (!*n)
>  			n++;
> -		free = (unsigned long) n - (unsigned long)(p+1);
> +		free = (unsigned long) n - (unsigned long) (p->thread_info+1);
>  	}
>  	printk("%5lu %5d %6d ", free, p->pid, p->parent->pid);
>  	if ((relative = eldest_child(p)))
> 

Yup.  But the whole thing's dead anyway - we do not clear the kernel stack
when it is allocated hence the attempt to work out how much was used cannot
work.

That's what

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.66/2.5.66-mm3/broken-out/show_task-free-stack-fix.patch

is about, but it needs finishing off.
