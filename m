Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWHUG0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWHUG0V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 02:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWHUG0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 02:26:21 -0400
Received: from brick.kernel.dk ([62.242.22.158]:45917 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1030205AbWHUG0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 02:26:20 -0400
Date: Mon, 21 Aug 2006 08:28:30 +0200
From: Jens Axboe <axboe@suse.de>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sys_ioprio_set: minor do_each_thread+break fix
Message-ID: <20060821062829.GG4290@suse.de>
References: <20060820150929.GA1577@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820150929.GA1577@oleg>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20 2006, Oleg Nesterov wrote:
> From include/linux/sched.h:
> 	/*
> 	 * Careful: do_each_thread/while_each_thread is a double loop so
> 	 *          'break' will not work as expected - use goto instead.
> 	 */
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- 2.6.18-rc4/fs/ioprio.c~2_break	2006-07-16 01:53:08.000000000 +0400
> +++ 2.6.18-rc4/fs/ioprio.c	2006-08-20 18:57:38.000000000 +0400
> @@ -111,9 +111,9 @@ asmlinkage long sys_ioprio_set(int which
>  					continue;
>  				ret = set_task_ioprio(p, ioprio);
>  				if (ret)
> -					break;
> +					goto free_uid;
>  			} while_each_thread(g, p);
> -
> +free_uid:
>  			if (who)
>  				free_uid(user);
>  			break;

Good catch, applied!

-- 
Jens Axboe

