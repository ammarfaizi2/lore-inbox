Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286661AbRLVD5v>; Fri, 21 Dec 2001 22:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286662AbRLVD5m>; Fri, 21 Dec 2001 22:57:42 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:17419 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S286661AbRLVD5b>; Fri, 21 Dec 2001 22:57:31 -0500
To: vic <zandy@cs.wisc.edu>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] ptrace on stopped processes (2.4)
In-Reply-To: <m3adwc9woz.fsf@localhost.localdomain>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 22 Dec 2001 12:56:01 +0900
In-Reply-To: <m3adwc9woz.fsf@localhost.localdomain>
Message-ID: <87adwblxgu.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vic <zandy@cs.wisc.edu> writes:

> --- linux-2.4.16/kernel/ptrace.c	Wed Nov 21 16:43:01 2001
> +++ linux-2.4.16.1/kernel/ptrace.c	Fri Dec 21 10:42:44 2001
> @@ -89,8 +89,10 @@
>  		SET_LINKS(task);
>  	}
>  	write_unlock_irq(&tasklist_lock);
> -
> -	send_sig(SIGSTOP, task, 1);
> +	if (task->state != TASK_STOPPED)
> +		send_sig(SIGSTOP, task, 1);
> +	else
> +		task->exit_code = SIGSTOP;
>  	return 0;
>  
>  bad:

It seems that trace is started in the place different from
usual. Then, I think PTRACE_KILL doesn't work.

If it need, I think it should wake up a task.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
