Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261366AbSIWSZy>; Mon, 23 Sep 2002 14:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261367AbSIWSZy>; Mon, 23 Sep 2002 14:25:54 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:56593
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261366AbSIWSZx>; Mon, 23 Sep 2002 14:25:53 -0400
Subject: Re: [PATCH] de-xchg fork.c
From: Robert Love <rml@tech9.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
       akpm@zip.com.au, ingo@redhat.com, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
In-Reply-To: <Pine.LNX.4.44.0209232026320.28863-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0209232026320.28863-100000@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1032805833.25756.17.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1 (Preview Release)
Date: 23 Sep 2002 14:30:34 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-23 at 14:31, Ingo Molnar wrote:

> the attached patch (against BK-curr) fixes all xchg()'s and a preemption
> bug.

Thanks, Ingo.

> --- linux/kernel/fork.c.orig	Mon Sep 23 20:28:36 2002
> +++ linux/kernel/fork.c	Mon Sep 23 20:30:02 2002
> @@ -64,11 +64,12 @@
>  	} else {
>  		int cpu = smp_processor_id();
>  
> -		tsk = xchg(task_cache + cpu, tsk);
> +		tsk = task_cache[cpu];
>  		if (tsk) {
>  			free_thread_info(tsk->thread_info);
>  			kmem_cache_free(task_struct_cachep,tsk);
>  		}
> +		task_cache[cpu] = current;
>  	}
>  }

I think you need get/put_cpu() here, too?

	Robert Love

