Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261876AbTCGXTc>; Fri, 7 Mar 2003 18:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261875AbTCGXTb>; Fri, 7 Mar 2003 18:19:31 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:2994 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261876AbTCGXSl>; Fri, 7 Mar 2003 18:18:41 -0500
Date: Fri, 7 Mar 2003 18:29:14 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: [PATCH] s390 (1/7): s390 arch fixes.
Message-ID: <20030307182914.D32569@devserv.devel.redhat.com>
References: <200303072001.h27K12V16864@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303072001.h27K12V16864@devserv.devel.redhat.com>; from zaitcev@redhat.com on Fri, Mar 07, 2003 at 03:01:02PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux-2.5.64/arch/s390/kernel/time.c	Wed Mar  5 04:28:53 2003
> +++ linux-2.5.64-s390/arch/s390/kernel/time.c	Fri Mar  7 11:40:12 2003
> @@ -202,14 +203,14 @@
>  	unsigned long cr0;
>  	__u64 timer;
>  
> +	timer = jiffies_timer_cc + jiffies_64 * CLK_TICKS_PER_JIFFY;
> +	S390_lowcore.jiffy_timer = timer;
> +	timer += CLK_TICKS_PER_JIFFY + CPU_DEVIATION;
> +	asm volatile ("SCKC %0" : : "m" (timer));
>          /* allow clock comparator timer interrupt */
>          asm volatile ("STCTL 0,0,%0" : "=m" (cr0) : : "memory");
>          cr0 |= 0x800;
>          asm volatile ("LCTL 0,0,%0" : : "m" (cr0) : "memory");
> -	timer = init_timer_cc + jiffies_64 * CLK_TICKS_PER_JIFFY;
> -	S390_lowcore.jiffy_timer = timer;
> -	timer += CLK_TICKS_PER_JIFFY + CPU_DEVIATION;
> -	asm volatile ("SCKC %0" : : "m" (timer));
>  }
>  
>  /*

This is a good fix, I confirm it fixing my booting problem ...
on 2.4! Seriously, I can't believe it worked before.
Please send it to Marcelo, too.

-- Pete
