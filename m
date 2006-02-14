Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWBNRCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWBNRCF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 12:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbWBNRCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 12:02:05 -0500
Received: from mailserver.applegatebroadband.net ([207.55.227.3]:58640 "EHLO
	apbb.net") by vger.kernel.org with ESMTP id S964854AbWBNRCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 12:02:03 -0500
Message-ID: <43F20CCA.6010105@wildturkeyranch.net>
Date: Tue, 14 Feb 2006 09:00:58 -0800
From: George Anzinger <george@wildturkeyranch.net>
Reply-To: george@wildturkeyranch.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu
Subject: Re: [PATCH 08/12] hrtimer: completely remove it_real_value
References: <Pine.LNX.4.61.0602141111270.3731@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0602141111270.3731@scrub.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Remove the it_real_value from /proc/*/stat, during 1.2.x was the last
> time it returned useful data (as it was directly maintained by the
> scheduler), now it's only a waste of time to calculate it.

This may be true but this changes the order of items presented making any 
"code" looking for items after it_real_value in the list look at the wrong 
thing.  If we are going to change this, I think we need some sort of version 
in the output.  Something that changes when ever the output format or content 
is modified in any way.

George

> 
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
> Acked-by: Ingo Molnar <mingo@elte.hu>
> 
> ---
> 
>  fs/proc/array.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> Index: linux-2.6-git/fs/proc/array.c
> ===================================================================
> --- linux-2.6-git.orig/fs/proc/array.c	2006-02-13 22:29:44.000000000 +0100
> +++ linux-2.6-git/fs/proc/array.c	2006-02-13 22:30:08.000000000 +0100
> @@ -330,7 +330,6 @@ static int do_task_stat(struct task_stru
>  	unsigned long  min_flt = 0,  maj_flt = 0;
>  	cputime_t cutime, cstime, utime, stime;
>  	unsigned long rsslim = 0;
> -	DEFINE_KTIME(it_real_value);
>  	struct task_struct *t;
>  	char tcomm[sizeof(task->comm)];
>  
> @@ -386,7 +385,6 @@ static int do_task_stat(struct task_stru
>  			utime = cputime_add(utime, task->signal->utime);
>  			stime = cputime_add(stime, task->signal->stime);
>  		}
> -		it_real_value = task->signal->real_timer.expires;
>  	}
>  	ppid = pid_alive(task) ? task->group_leader->real_parent->tgid : 0;
>  	read_unlock(&tasklist_lock);
> @@ -413,7 +411,7 @@ static int do_task_stat(struct task_stru
>  	start_time = nsec_to_clock_t(start_time);
>  
>  	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
> -%lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \
> +%lu %lu %lu %lu %lu %ld %ld %ld %ld %d 0 %llu %lu %ld %lu %lu %lu %lu %lu \
>  %lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
>  		task->pid,
>  		tcomm,
> @@ -435,7 +433,6 @@ static int do_task_stat(struct task_stru
>  		priority,
>  		nice,
>  		num_threads,
> -		(long) ktime_to_clock_t(it_real_value),
>  		start_time,
>  		vsize,
>  		mm ? get_mm_rss(mm) : 0,
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@wildturkeyranch.net
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

