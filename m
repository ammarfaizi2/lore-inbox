Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265228AbTIJQg6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 12:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbTIJQg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 12:36:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:13780 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265228AbTIJQg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 12:36:56 -0400
Message-Id: <200309101636.h8AGam212478@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Con Kolivas <kernel@kolivas.org>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH]O20.1int 
In-Reply-To: Message from Con Kolivas <kernel@kolivas.org> 
   of "Wed, 10 Sep 2003 13:00:20 +1000." <200309101300.20634.kernel@kolivas.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Sep 2003 09:36:48 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Should be the last of the O1int patches.
> 
> Tiny tweak to keep top two interactive levels round robin at the fastest 
> (10ms) which keeps X smooth when another interactive task is also using 
> bursts of cpu (eg web browser).
> 
> Credit. Is this too bold?

Con,
Patch is in STP PLM as # 2120. 
One request - would you mind uploading future patches into PLM, since
you're already an associate? (http://www.osdl.org/plm-cgi/plm) 
It's a real simple Web form, and would get the code on the test machines
a bunch quicker. 
thanks
cliffw

> 
> Con
> 
> --- linux-2.6.0-test5-mm1-O20/kernel/sched.c	2003-09-10 11:15:45.000000000 +1000
> +++ linux-2.6.0-test5-mm1/kernel/sched.c	2003-09-10 11:51:38.000000000 +1000
> @@ -14,6 +14,7 @@
>   *		an array-switch method of distributing timeslices
>   *		and per-CPU runqueues.  Cleanups and useful suggestions
>   *		by Davide Libenzi, preemptible kernel bits by Robert Love.
> + *  2003-09-03	Interactivity tuning by Con Kolivas.
>   */
>  
>  #include <linux/mm.h>
> @@ -122,12 +123,12 @@
>  		MAX_SLEEP_AVG)
>  
>  #ifdef CONFIG_SMP
> -#define TIMESLICE_GRANULARITY(p) \
> -	(MIN_TIMESLICE * (1 << (MAX_BONUS - CURRENT_BONUS(p))) * \
> -		num_online_cpus())
> +#define TIMESLICE_GRANULARITY(p)	(MIN_TIMESLICE * \
> +		(1 << (((MAX_BONUS - CURRENT_BONUS(p)) ? : 1) - 1)) * \
> +			num_online_cpus())
>  #else
> -#define TIMESLICE_GRANULARITY(p) \
> -	(MIN_TIMESLICE * (1 << (MAX_BONUS - CURRENT_BONUS(p))))
> +#define TIMESLICE_GRANULARITY(p)	(MIN_TIMESLICE * \
> +		(1 << (((MAX_BONUS - CURRENT_BONUS(p)) ? : 1) - 1)))
>  #endif
>  
>  #define SCALE(v1,v1_max,v2_max) \
> 


