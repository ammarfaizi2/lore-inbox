Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293518AbSCAS5x>; Fri, 1 Mar 2002 13:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293527AbSCAS5m>; Fri, 1 Mar 2002 13:57:42 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:9463
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293518AbSCAS5f>; Fri, 1 Mar 2002 13:57:35 -0500
Date: Fri, 1 Mar 2002 10:58:25 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Dan Chen <crimsun@email.unc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] #define yield() for 2.4 scheduler (anticipating O(1))
Message-ID: <20020301185825.GK2711@matchmail.com>
Mail-Followup-To: Dan Chen <crimsun@email.unc.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020301163237.GC16716@opeth.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020301163237.GC16716@opeth.ath.cx>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 11:32:37AM -0500, Dan Chen wrote:
> In response to Rik's post concerning a #define yield(), I've done a
> quick egrep over the 2.4.19-pre2 tree and modified as necessary. This is
> a strict search and replace. Thanks to Rik and Davide for assistance.
> Please correct me if I erred.
> 
> -- 
> Dan Chen                 crimsun@email.unc.edu
> GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc

> diff -uNr linux.orig/fs/buffer.c linux/fs/buffer.c
> --- linux.orig/fs/buffer.c	Thu Feb 28 22:00:02 2002
> +++ linux/fs/buffer.c	Fri Mar  1 10:29:52 2002
> @@ -735,9 +735,8 @@
>  	wakeup_bdflush();
>  	try_to_free_pages(zone, GFP_NOFS, 0);
>  	run_task_queue(&tq_disk);
> -	current->policy |= SCHED_YIELD;
>  	__set_current_state(TASK_RUNNING);
> -	schedule();
> +	yield();
>  }
>  
>  void init_buffer(struct buffer_head *bh, bh_end_io_t *handler, void *private)

is __set_current_state(TASK_RUNNING) compatible with the new scheduler?
