Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbTEOVis (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 17:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264273AbTEOVis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 17:38:48 -0400
Received: from aneto.able.es ([212.97.163.22]:57529 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S264271AbTEOViq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 17:38:46 -0400
Date: Thu, 15 May 2003 23:51:21 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Martin Hicks <mort@wildopensource.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: rename the ksoftirqd kernel thread.
Message-ID: <20030515215121.GC2669@werewolf.able.es>
References: <20030515211716.GV17021@bork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030515211716.GV17021@bork.org>; from mort@wildopensource.com on Thu, May 15, 2003 at 23:17:16 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.15, Martin Hicks wrote:
> 
> Marcelo,
> 
> Please consider this patch for 2.4.22-pre
> 
> It just renames the ksoftirqd kernel thread to be the same as in 2.5.
> 
> The side effect is that on machines with > 100 processors the last
> number in the thread name doesn't get truncated.  
> 
> The patch is against linux-2.4 bk.
> 
> thanks
> mh
> 
> -- 
> Wild Open Source Inc.                  mort@wildopensource.com
> 
> 
> # This is a BitKeeper generated patch for the following project:
> # Project Name: Linux kernel tree
> # This patch format is intended for GNU patch command version 2.5 or higher.
> # This patch includes the following deltas:
> #	           ChangeSet	1.1210  -> 1.1211 
> #	    kernel/softirq.c	1.11    -> 1.12   
> #
> # The following is the BitKeeper ChangeSet Log
> # --------------------------------------------
> # 03/05/15	mort@plato.i.bork.org	1.1211
> # Rename the ksoftirqd thread to be the same as in 2.5.
> # --------------------------------------------
> #
> diff -Nru a/kernel/softirq.c b/kernel/softirq.c
> --- a/kernel/softirq.c	Thu May 15 17:13:08 2003
> +++ b/kernel/softirq.c	Thu May 15 17:13:08 2003
> @@ -372,7 +372,7 @@
>  	while (smp_processor_id() != cpu)
>  		schedule();
>  
> -	sprintf(current->comm, "ksoftirqd_CPU%d", bind_cpu);
> +	sprintf(current->comm, "ksoftirqd/%d", bind_cpu);
>  
>  	__set_current_state(TASK_INTERRUPTIBLE);
>  	mb();

Standard Linux 2.4 only supports 32 CPUS (include/linux/threads.h).
Wouldn't be useful to format it as %0.2d ?
Even in -aa, that supports 64 in 64-bits arches, it would be enough and
you get rid of the jump from _CPU9 to _CPU10.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-rc2-jam1 (gcc 3.2.3 (Mandrake Linux 9.2 3.2.3-1mdk))
