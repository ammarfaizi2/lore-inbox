Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262935AbVDAWst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262935AbVDAWst (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 17:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbVDAWst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 17:48:49 -0500
Received: from fire.osdl.org ([65.172.181.4]:65428 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262935AbVDAWsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 17:48:47 -0500
Date: Fri, 1 Apr 2005 14:48:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Show thread_info->flags in /proc/PID/status
Message-Id: <20050401144849.3c509daf.akpm@osdl.org>
In-Reply-To: <200504012239.j31Md7H3032185@magilla.sf.frob.com>
References: <200504012239.j31Md7H3032185@magilla.sf.frob.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> wrote:
>
> It comes up as useful in debugging to be able to see task->thread_info->flags
> along with signal information and such.  There is no way currently to
> elicit these bits from the kernel via sysrq or /proc (AFAIK).
> This patch adds the field to /proc/PID/status.
> 
> ...
> 
> --- linux-2.6/fs/proc/array.c
> +++ linux-2.6/fs/proc/array.c
> @@ -287,6 +287,12 @@ static inline char *task_cap(struct task
>  			    cap_t(p->cap_effective));
>  }
>  
> +static inline char *task_tif(struct task_struct *p, char *buffer)
> +{
> +	return buffer + sprintf(buffer, "ThreadInfoFlags:\t%lu\n",
> +				(unsigned long) p->thread_info->flags);
> +}

Alas, thread_info.flags is an arch-specific thing and m68k doesn't
implement it.  All other architectures do, though.

Maybe we should show thread_info->flags in the sysrq-t output instead?

