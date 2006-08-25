Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWHYNal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWHYNal (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 09:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWHYNal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 09:30:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:55222 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932100AbWHYNal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 09:30:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=f9cQWKvfObPSCRNnOEsPU9xVhkXP/1SV5N3ZdhpElJr6GV+P/oSfpmfgwvSQU3QDc1afzb7ZcjqzhFvZA+Qu5bd/cpTJ4HKm36HJgvspbH97phErIlOAoQqFkobfT6LWro+Eu9oA9zPNXor+ljabAX7MeLg2Z5MZziCYas5RzsI=
Date: Fri, 25 Aug 2006 17:30:34 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, mingo@elte.hu,
       akpm@osdl.org, jbarnes@virtuousgeek.org, dwalker@mvista.com,
       nickpiggin@yahoo.com.au
Subject: Re: [RFC] maximum latency tracking infrastructure (version 2)
Message-ID: <20060825133034.GC5205@martell.zuzino.mipt.ru>
References: <1156504939.3032.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156504939.3032.26.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 01:22:19PM +0200, Arjan van de Ven wrote:
> --- /dev/null
> +++ linux-2.6.18-rc4-latency/include/linux/latency.h

> +#ifdef __KERNEL__

Since you haven't added it to list of exported headers, this is
unneeded.

> +#ifndef _INCLUDE_GUARD_LATENCY_H_
> +#define _INCLUDE_GUARD_LATENCY_H_
> +
> +#include <linux/notifier.h>

Just
	struct notifier_block;

> +void set_acceptable_latency(char *identifier, int usecs);
> +void modify_acceptable_latency(char *identifier, int usecs);
> +void remove_acceptable_latency(char *identifier);
> +void synchronize_acceptable_latency(void);
> +int system_latency_constraint(void);
> +
> +int register_latency_notifier(struct notifier_block * nb);
> +int unregister_latency_notifier(struct notifier_block * nb);
> +
> +#define INFINITE_LATENCY 1000000
> +
> +#endif
> +#endif

> --- linux-2.6.18-rc4-latency.orig/kernel/Makefile
> +++ linux-2.6.18-rc4-latency/kernel/Makefile
> @@ -8,7 +8,7 @@ obj-y     = sched.o fork.o exec_domain.o
>  	    signal.o sys.o kmod.o workqueue.o pid.o \
>  	    rcupdate.o extable.o params.o posix-timers.o \
>  	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o mutex.o \
> -	    hrtimer.o rwsem.o
> +	    hrtimer.o rwsem.o latency.o

CONFIG_PM=n users aren't interested, right?

